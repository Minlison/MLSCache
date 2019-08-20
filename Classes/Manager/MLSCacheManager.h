//
//  MLSCacheManager.h
//  MLSCache
//
//  Created by minlison on 2018/5/8.
//

#import <UIKit/UIKit.h>

/**
 缓存类型

 - MLSCacheTypeAutoClean: 自动清理
 - MLSCacheTypeManuallyClean: 手动清理
 */
typedef NS_ENUM(NSInteger, MLSCacheType) {
    MLSCacheTypeAutoClean,
    MLSCacheTypeManuallyClean,
};

NS_ASSUME_NONNULL_BEGIN
@protocol MLSCacheManagerCacheProtocol <NSObject>

/**
 是否有 key 对应的缓存
 阻塞当前线程
 @param  key 标识键值
 @return 是否具有缓存
 */
- (BOOL)containsObjectForKey:(NSString *)key;

/**
 是否有 key 对应的缓存
 block 在查询完成后异步线程中回调
 
 @param key 标识键值
 @param block 回调 block
 */
- (void)containsObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, BOOL contains))block;

/**
 获取缓存
 阻塞当前线程
 @param key 标识键值
 @return 缓存，如果过期，或者没有查询到，返回 nil
 */
- (nullable id<NSCoding>)objectForKey:(NSString *)key;

/**
 获取缓存
 block 异步线程回调
 
 @param key 标识键值
 @param block 查询到异步回调 block，如果过期，或者没有查询到，返回 nil
 */
- (void)objectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block;

/**
 设置缓存
 阻塞当前线程
 @param object 如果设置为 nil， 则移除 key 对应的缓存
 @param key    标识键值
 */
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;

/**
 设置缓存
 会在异步线程中缓存到本地磁盘， block 在完成后回调
 @param object 需要缓存的 obj， 如果为 nil 则移除本地缓存和内存缓存
 @param block  异步回调 block
 */
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block;

/**
 移除缓存
 阻塞当前线程
 @param key 标识键值
 */
- (void)removeObjectForKey:(NSString *)key;

/**
 移除缓存
 异步回调 block，通知缓存移除成功
 
 @param key 标识键值.
 @param block  异步回调 block
 */
- (void)removeObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key))block;

/**
 移除所有缓存
 阻塞当前线程
 */
- (void)removeAllObjects;

/**
 异步移除所有缓存
 
 @param block  异步回调 block
 */
- (void)removeAllObjectsWithBlock:(void(^)(void))block;

/**
 异步移除所有缓存，并通知进度
 
 @warning 在 block 回调过程中，不要有任何操作
 @param progress 移除进度
 @param end      完成回调
 */
- (void)removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount, int totalCount))progress
                                 endBlock:(nullable void(^)(BOOL error))end;

@end


@interface MLSCacheManager : NSObject <MLSCacheManagerCacheProtocol>

/**
 磁盘缓存最大值 bytes
 MLSCacheTypeAutoClean Default 30720 30MB
 MLSCacheTypeManuallyClean Default NSUIntegerMax
 */
@property (nonatomic, assign) NSUInteger diskCostLimit;

/**
 磁盘缓存最大个数 缓存 obj 的个数
 MLSCacheTypeAutoClean Default 10000
 MLSCacheTypeManuallyClean Default NSUIntegerMax
 */
@property (nonatomic, assign) NSUInteger diskCountLimit;

/**
 磁盘过期文件检测间隔(单位s)
 MLSCacheTypeAutoClean Default 60s 1分钟
 MLSCacheTypeManuallyClean Default CGFLOAT_MAX
 */
@property (nonatomic, assign) NSTimeInterval diskAutoTrimInterval;

/**
 磁盘文件保存时长
 MLSCacheTypeAutoClean Default 1800s  30分钟
 MLSCacheTypeManuallyClean Default CGFLOAT_MAX
 */
@property (nonatomic, assign) NSTimeInterval diskAgeLimit;

/**
 内存缓存最大值 bytes
 在收到内存警告的时候，会清除所有内存缓存
 
 MLSCacheTypeAutoClean Default 10240 10MB
 MLSCacheTypeManuallyClean Default NSUIntegerMax
 */
@property (nonatomic, assign) NSUInteger memoryCostLimit;

/**
 内存缓存最大个数 缓存 obj 的个数
 MLSCacheTypeAutoClean Default 10000
 MLSCacheTypeManuallyClean Default NSUIntegerMax
 */
@property (nonatomic, assign) NSUInteger memoryCountLimit;

/**
 内存过期文件检测间隔
 MLSCacheTypeAutoClean Default 30s
 MLSCacheTypeManuallyClean Default CGFLOAT_MAX
 */
@property (nonatomic, assign) NSTimeInterval memoryAutoTrimInterval;

/**
 内存保存时长
 MLSCacheTypeAutoClean Default 300s 5分钟
 MLSCacheTypeManuallyClean Default CGFLOAT_MAX
 */
@property (nonatomic, assign) NSTimeInterval memoryAgeLimit;

/**
 创建缓存管理类

 @param cacheType 缓存类型
 @return 缓存管理类，单利
 */
+ (instancetype)cacheWithType:(MLSCacheType)cacheType;

/**
 清理缓存
 @param async 是否异步
 @param completion 完成回调
 */
- (void)clearAllCache:(BOOL)async completion:(void (^)(BOOL success))completion;

/**
 清理 cookie 缓存

 @param date 清理哪个时间段以后的 cookie 数据
 */
+ (void)clearCookieStorageSinceDate:(NSDate *)date;

/**
 删除指定 cookie

 @param URL  缓存 url 的地址
 */
+ (void)deleteCookieForURL:(NSURL *)URL;

/**
 获取指定 URL 对应的 cookie

 @param URL URL
 @return Cookie
 */
+ (nullable NSArray<NSHTTPCookie *> *)cookiesForURL:(NSURL *)URL;

/**
 清理 NSUserDefaluts
 只会清理 [NSUserDefaults standardUserDefaults] 的数据
 */
+ (void)resetStandardUserDefaults;

/**
 清理 webview 的缓存
 */
+ (void)clearWebViewCache;

/**
 缓存大小, 当前类型缓存大小
 @return 缓存大小 (字节)
 */
- (NSUInteger)cacheSize;

/**
 缓存大小, 字符串, 后面拼接 B/KB/MB/GB
 KB 以后保留两位小数
 @return 字符串
 */
- (NSString *)cacheSizeHumanString;


/**
 总缓存大小, 所有缓存类型缓存大小

 @return 缓存大小 (字节)
 */
+ (NSUInteger)cacheSize;

/**
 总缓存大小, 字符串, 后面拼接 B/KB/MB/GB
 KB 以后保留两位小数
 @return 字符串
 */
+ (NSString *)cacheSizeHumanString;
@end
NS_ASSUME_NONNULL_END
