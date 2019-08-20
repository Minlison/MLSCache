# MLSCacheManager Class Reference

&nbsp;&nbsp;**Inherits from** NSObject  
&nbsp;&nbsp;**Conforms to** <a href="../Protocols/MLSCacheManagerCacheProtocol.html">MLSCacheManagerCacheProtocol</a>  
&nbsp;&nbsp;**Declared in** MLSCacheManager.h  

## Tasks

### 

[&nbsp;&nbsp;diskCostLimit](#//api/name/diskCostLimit) *property* 

[&nbsp;&nbsp;diskCountLimit](#//api/name/diskCountLimit) *property* 

[&nbsp;&nbsp;diskAutoTrimInterval](#//api/name/diskAutoTrimInterval) *property* 

[&nbsp;&nbsp;diskAgeLimit](#//api/name/diskAgeLimit) *property* 

[&nbsp;&nbsp;memoryCostLimit](#//api/name/memoryCostLimit) *property* 

[&nbsp;&nbsp;memoryCountLimit](#//api/name/memoryCountLimit) *property* 

[&nbsp;&nbsp;memoryAutoTrimInterval](#//api/name/memoryAutoTrimInterval) *property* 

[&nbsp;&nbsp;memoryAgeLimit](#//api/name/memoryAgeLimit) *property* 

[+&nbsp;cacheWithType:](#//api/name/cacheWithType:)  

[&ndash;&nbsp;clearAllCache:completion:](#//api/name/clearAllCache:completion:)  

[+&nbsp;clearCookieStorageSinceDate:](#//api/name/clearCookieStorageSinceDate:)  

[+&nbsp;deleteCookieForURL:](#//api/name/deleteCookieForURL:)  

[+&nbsp;cookiesForURL:](#//api/name/cookiesForURL:)  

[+&nbsp;resetStandardUserDefaults](#//api/name/resetStandardUserDefaults)  

[+&nbsp;clearWebViewCache](#//api/name/clearWebViewCache)  

[&ndash;&nbsp;cacheSize](#//api/name/cacheSize)  

[&ndash;&nbsp;cacheSizeHumanString](#//api/name/cacheSizeHumanString)  

[+&nbsp;cacheSize](#//api/name/cacheSize)  

[+&nbsp;cacheSizeHumanString](#//api/name/cacheSizeHumanString)  

## Properties

<a name="//api/name/diskAgeLimit" title="diskAgeLimit"></a>
### diskAgeLimit

磁盘文件保存时长
MLSCacheTypeAutoClean Default 1800s  30分钟
MLSCacheTypeManuallyClean Default CGFLOAT_MAX

`@property (nonatomic, assign) NSTimeInterval diskAgeLimit`

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/diskAutoTrimInterval" title="diskAutoTrimInterval"></a>
### diskAutoTrimInterval

磁盘过期文件检测间隔(单位s)
MLSCacheTypeAutoClean Default 60s 1分钟
MLSCacheTypeManuallyClean Default CGFLOAT_MAX

`@property (nonatomic, assign) NSTimeInterval diskAutoTrimInterval`

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/diskCostLimit" title="diskCostLimit"></a>
### diskCostLimit

磁盘缓存最大值 bytes
MLSCacheTypeAutoClean Default 30720 30MB
MLSCacheTypeManuallyClean Default NSUIntegerMax

`@property (nonatomic, assign) NSUInteger diskCostLimit`

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/diskCountLimit" title="diskCountLimit"></a>
### diskCountLimit

磁盘缓存最大个数 缓存 obj 的个数
MLSCacheTypeAutoClean Default 10000
MLSCacheTypeManuallyClean Default NSUIntegerMax

`@property (nonatomic, assign) NSUInteger diskCountLimit`

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/memoryAgeLimit" title="memoryAgeLimit"></a>
### memoryAgeLimit

内存保存时长
MLSCacheTypeAutoClean Default 300s 5分钟
MLSCacheTypeManuallyClean Default CGFLOAT_MAX

`@property (nonatomic, assign) NSTimeInterval memoryAgeLimit`

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/memoryAutoTrimInterval" title="memoryAutoTrimInterval"></a>
### memoryAutoTrimInterval

内存过期文件检测间隔
MLSCacheTypeAutoClean Default 30s
MLSCacheTypeManuallyClean Default CGFLOAT_MAX

`@property (nonatomic, assign) NSTimeInterval memoryAutoTrimInterval`

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/memoryCostLimit" title="memoryCostLimit"></a>
### memoryCostLimit

内存缓存最大值 bytes
在收到内存警告的时候，会清除所有内存缓存

`@property (nonatomic, assign) NSUInteger memoryCostLimit`

#### Discussion
MLSCacheTypeAutoClean Default 10240 10MB
MLSCacheTypeManuallyClean Default NSUIntegerMax

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/memoryCountLimit" title="memoryCountLimit"></a>
### memoryCountLimit

内存缓存最大个数 缓存 obj 的个数
MLSCacheTypeAutoClean Default 10000
MLSCacheTypeManuallyClean Default NSUIntegerMax

`@property (nonatomic, assign) NSUInteger memoryCountLimit`

#### Declared In
* `MLSCacheManager.h`

<a title="Class Methods" name="class_methods"></a>
## Class Methods

<a name="//api/name/cacheSize" title="cacheSize"></a>
### cacheSize

总缓存大小, 所有缓存类型缓存大小

`+ (NSUInteger)cacheSize`

#### Return Value
缓存大小 (字节)

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/cacheSizeHumanString" title="cacheSizeHumanString"></a>
### cacheSizeHumanString

总缓存大小, 字符串, 后面拼接 B/KB/MB/GB
KB 以后保留两位小数

`+ (NSString *)cacheSizeHumanString`

#### Return Value
字符串

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/cacheWithType:" title="cacheWithType:"></a>
### cacheWithType:

创建缓存管理类

`+ (instancetype)cacheWithType:(MLSCacheType)*cacheType*`

#### Parameters

*cacheType*  
&nbsp;&nbsp;&nbsp;缓存类型  

#### Return Value
缓存管理类，单利

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/clearCookieStorageSinceDate:" title="clearCookieStorageSinceDate:"></a>
### clearCookieStorageSinceDate:

清理 cookie 缓存

`+ (void)clearCookieStorageSinceDate:(NSDate *)*date*`

#### Parameters

*date*  
&nbsp;&nbsp;&nbsp;清理哪个时间段以后的 cookie 数据  

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/clearWebViewCache" title="clearWebViewCache"></a>
### clearWebViewCache

清理 webview 的缓存

`+ (void)clearWebViewCache`

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/cookiesForURL:" title="cookiesForURL:"></a>
### cookiesForURL:

获取指定 URL 对应的 cookie

`+ (nullable NSArray&lt;NSHTTPCookie*&gt; *)cookiesForURL:(NSURL *)*URL*`

#### Parameters

*URL*  
&nbsp;&nbsp;&nbsp;URL  

#### Return Value
Cookie

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/deleteCookieForURL:" title="deleteCookieForURL:"></a>
### deleteCookieForURL:

删除指定 cookie

`+ (void)deleteCookieForURL:(NSURL *)*URL*`

#### Parameters

*URL*  
&nbsp;&nbsp;&nbsp;缓存 url 的地址  

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/resetStandardUserDefaults" title="resetStandardUserDefaults"></a>
### resetStandardUserDefaults

清理 NSUserDefaluts
只会清理 [NSUserDefaults standardUserDefaults] 的数据

`+ (void)resetStandardUserDefaults`

#### Declared In
* `MLSCacheManager.h`

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/cacheSize" title="cacheSize"></a>
### cacheSize

缓存大小, 当前类型缓存大小

`- (NSUInteger)cacheSize`

#### Return Value
缓存大小 (字节)

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/cacheSizeHumanString" title="cacheSizeHumanString"></a>
### cacheSizeHumanString

缓存大小, 字符串, 后面拼接 B/KB/MB/GB
KB 以后保留两位小数

`- (NSString *)cacheSizeHumanString`

#### Return Value
字符串

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/clearAllCache:completion:" title="clearAllCache:completion:"></a>
### clearAllCache:completion:

清理缓存

`- (void)clearAllCache:(BOOL)*async* completion:(void ( ^ ) ( BOOL success ))*completion*`

#### Parameters

*async*  
&nbsp;&nbsp;&nbsp;是否异步  

*completion*  
&nbsp;&nbsp;&nbsp;完成回调  

#### Declared In
* `MLSCacheManager.h`

