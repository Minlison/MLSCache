//
//  MLSCacheManager.m
//  MLSCache
//
//  Created by minlison on 2018/5/8.
//

#import "MLSCacheManager.h"
#import  <objc/runtime.h>
#import "MLSYYCache.h"
#import "MLSCache.h"

/** 从服务器读取数据在本地数据库保存时间 */
#define LOCAL_CACHE_TIME (5 * 60)      // 5 * 60

/** 从服务器读取数据在内存中 */
#define LOCAL_DIC_TIME (1 * 60)         // 1 * 60

/**内存检测时间*/
#define LOCAL_AUTO_TIME     (30)    // 10

#define CUSTOM_CACHE_COUNT (10000)

BOOL selector_belongsToProtocol(SEL selector, Protocol * protocol);
@interface MLSCacheManager ()
@property (nonatomic, strong) MLSCacheManager *autoCacheManager;
@property (nonatomic, strong) MLSCacheManager *manullyCacheManager;
@property(nonatomic, strong) MLSYYCache *cacheManager;
@property (nonatomic, assign) MLSCacheType cacheType;
@property (nonatomic, copy) NSString *cacheName;
@end
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
@implementation MLSCacheManager
#pragma clang diagnostic pop

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static MLSCacheManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (instancetype)cacheWithType:(MLSCacheType)cacheType {
    // 加锁, 多线程中使用 manager
    @synchronized (self) {
        switch (cacheType) {
            case MLSCacheTypeAutoClean: return [MLSCacheManager sharedInstance].autoCacheManager;
            case MLSCacheTypeManuallyClean: return [MLSCacheManager sharedInstance].manullyCacheManager;
            default:
                break;
        }
        return [MLSCacheManager sharedInstance].autoCacheManager;
    }
}

- (void)_InitDefaultValuesWithType:(MLSCacheType)cacheType {
    switch (cacheType) {
        case MLSCacheTypeAutoClean: {
            self.diskCostLimit = 30720;
            self.diskCountLimit = 10000;
            self.diskAutoTrimInterval = 60.0f;
            self.diskAgeLimit = 1800.0f;
            self.memoryCostLimit = 10240;
            self.memoryCountLimit = 10000;
            self.memoryAutoTrimInterval = 30.0f;
            self.memoryAgeLimit = 300.0f;
            self.cacheName = @"cn.minlison.cache.autoclean";
        }
            break;
        case MLSCacheTypeManuallyClean: {
            self.diskCostLimit = NSUIntegerMax;
            self.diskCountLimit = NSUIntegerMax;
            self.diskAutoTrimInterval = CGFLOAT_MAX;
            self.diskAgeLimit = CGFLOAT_MAX;
            self.memoryCostLimit = NSUIntegerMax;
            self.memoryCountLimit = NSUIntegerMax;
            self.memoryAutoTrimInterval = CGFLOAT_MAX;
            self.memoryAgeLimit = CGFLOAT_MAX;
            self.cacheName = @"cn.minlison.cache.manuallyclean";
        }
            
        default:
            break;
    }
}

- (void)clearAllCache:(BOOL)async completion:(void (^)(BOOL success))completion {
    if (async) {
        [self.cacheManager removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
            
        } endBlock:^(BOOL error) {
            if (completion) {
                completion(!error);
            }
        }];
    } else {
        [self.cacheManager removeAllObjects];
        if (completion) {
            completion(YES);
        }
    }
}

+ (void)clearCookieStorageSinceDate:(NSDate *)date {
    @try {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] removeCookiesSinceDate:date];
    } @catch (NSException *exception) {
    } @finally {
    }
}

+ (void)deleteCookieForURL:(NSURL *)URL {
    @try {
        [[self cookiesForURL:URL] enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:obj];
        }];
    } @catch (NSException *exception) {
    } @finally {
    }
    
}

+ (nullable NSArray<NSHTTPCookie *> *)cookiesForURL:(NSURL *)URL {
    @try {
       return [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:URL];
    } @catch (NSException *exception) {
        return nil;
    } @finally {
    }
}

+ (void)resetStandardUserDefaults {
    [NSUserDefaults resetStandardUserDefaults];
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clearWebViewCache {
    // 清理webView的内存缓存
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSUInteger)cacheSize {
    return self.cacheManager.diskCache.totalCost;
}

- (NSString *)cacheSizeHumanString {
    return [self.class getHumanStringForBytes:self.cacheSize];
}

+ (NSUInteger)cacheSize {
    return MLSCacheAutoManager.cacheSize + MLSCacheManuallyManager.cacheSize;
}

+ (NSString *)cacheSizeHumanString {
    return [self getHumanStringForBytes:[self cacheSize]];
}

+ (NSString *)getHumanStringForBytes:(NSUInteger)bytes {
    if (bytes < (((NSUInteger)1) << 10)) {
        return [NSString stringWithFormat:@"%dB",(int)bytes];
    } else if (bytes < (((NSUInteger)1) << 20)) {
        return [NSString stringWithFormat:@"%.0fKB", (bytes * 1.0 / (((NSUInteger)1) << 10))];
    } else if (bytes < (((NSUInteger)1) << 30)) {
        return [NSString stringWithFormat:@"%.2fMB", (bytes * 1.0 / (((NSUInteger)1) << 20))];
    } else {
        return [NSString stringWithFormat:@"%.2fGB", (bytes * 1.0 / (((NSUInteger)1) << 30))];
    }
}

- (MLSYYCache *)cacheManager {
    if (!_cacheManager) {
        _cacheManager = [[MLSYYCache alloc] initWithName:self.cacheName];
        
        _cacheManager.diskCache.autoTrimInterval = self.diskAutoTrimInterval;
        _cacheManager.diskCache.ageLimit = self.diskAgeLimit;
        _cacheManager.diskCache.costLimit = self.diskCostLimit;
        
        _cacheManager.memoryCache.autoTrimInterval = self.memoryAutoTrimInterval;
        _cacheManager.memoryCache.ageLimit = self.memoryAgeLimit;
        _cacheManager.memoryCache.costLimit = self.memoryCostLimit;
    }
    return _cacheManager;
}

- (MLSCacheManager *)autoCacheManager {
    if (!_autoCacheManager) {
        _autoCacheManager = [[MLSCacheManager alloc] init];
        [_autoCacheManager _InitDefaultValuesWithType:MLSCacheTypeAutoClean];
    }
    return _autoCacheManager;
}

- (MLSCacheManager *)manullyCacheManager {
    if (!_manullyCacheManager) {
        _manullyCacheManager = [[MLSCacheManager alloc] init];
        [_manullyCacheManager _InitDefaultValuesWithType:MLSCacheTypeManuallyClean];
    }
    return _manullyCacheManager;
}

/// forwarding target

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.cacheManager respondsToSelector:aSelector] &&
        [self isSelectorContainedInInterceptedProtocols:aSelector]) {
        return self.cacheManager;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([self.cacheManager respondsToSelector:aSelector] &&
        [self isSelectorContainedInInterceptedProtocols:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}
- (BOOL)isSelectorContainedInInterceptedProtocols:(SEL)aSelector
{
    return selector_belongsToProtocol(aSelector, @protocol(MLSCacheManagerCacheProtocol));;
}

@end


BOOL selector_belongsToProtocol(SEL selector, Protocol * protocol)
{
    // Reference: https://gist.github.com/numist/3838169
    for (int optionbits = 0; optionbits < (1 << 2); optionbits++) {
        BOOL required = optionbits & 1;
        BOOL instance = !(optionbits & (1 << 1));
        
        struct objc_method_description hasMethod = protocol_getMethodDescription(protocol, selector, required, instance);
        if (hasMethod.name || hasMethod.types) {
            return YES;
        }
    }
    
    return NO;
}
