# MLSCacheManagerCacheProtocol Protocol Reference

&nbsp;&nbsp;**Conforms to** NSObject  
&nbsp;&nbsp;**Declared in** MLSCacheManager.h  

## Tasks

### 

[&ndash;&nbsp;containsObjectForKey:](#//api/name/containsObjectForKey:)  *required method*

[&ndash;&nbsp;containsObjectForKey:withBlock:](#//api/name/containsObjectForKey:withBlock:)  *required method*

[&ndash;&nbsp;objectForKey:](#//api/name/objectForKey:)  *required method*

[&ndash;&nbsp;objectForKey:withBlock:](#//api/name/objectForKey:withBlock:)  *required method*

[&ndash;&nbsp;setObject:forKey:](#//api/name/setObject:forKey:)  *required method*

[&ndash;&nbsp;setObject:forKey:withBlock:](#//api/name/setObject:forKey:withBlock:)  *required method*

[&ndash;&nbsp;removeObjectForKey:](#//api/name/removeObjectForKey:)  *required method*

[&ndash;&nbsp;removeObjectForKey:withBlock:](#//api/name/removeObjectForKey:withBlock:)  *required method*

[&ndash;&nbsp;removeAllObjects](#//api/name/removeAllObjects)  *required method*

[&ndash;&nbsp;removeAllObjectsWithBlock:](#//api/name/removeAllObjectsWithBlock:)  *required method*

[&ndash;&nbsp;removeAllObjectsWithProgressBlock:endBlock:](#//api/name/removeAllObjectsWithProgressBlock:endBlock:)  *required method*

<a title="Instance Methods" name="instance_methods"></a>
## Instance Methods

<a name="//api/name/containsObjectForKey:" title="containsObjectForKey:"></a>
### containsObjectForKey:

是否有 key 对应的缓存
阻塞当前线程

`- (BOOL)containsObjectForKey:(NSString *)*key*`

#### Parameters

*key*  
&nbsp;&nbsp;&nbsp;标识键值  

#### Return Value
是否具有缓存

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/containsObjectForKey:withBlock:" title="containsObjectForKey:withBlock:"></a>
### containsObjectForKey:withBlock:

是否有 key 对应的缓存
block 在查询完成后异步线程中回调

`- (void)containsObjectForKey:(NSString *)*key* withBlock:(nullable void ( ^ ) ( NSString *key , BOOL contains ))*block*`

#### Parameters

*key*  
&nbsp;&nbsp;&nbsp;标识键值  

*block*  
&nbsp;&nbsp;&nbsp;回调 block  

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/objectForKey:" title="objectForKey:"></a>
### objectForKey:

获取缓存
阻塞当前线程

`- (nullable id&lt;NSCoding&gt;)objectForKey:(NSString *)*key*`

#### Parameters

*key*  
&nbsp;&nbsp;&nbsp;标识键值  

#### Return Value
缓存，如果过期，或者没有查询到，返回 nil

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/objectForKey:withBlock:" title="objectForKey:withBlock:"></a>
### objectForKey:withBlock:

获取缓存
block 异步线程回调

`- (void)objectForKey:(NSString *)*key* withBlock:(nullable void ( ^ ) ( NSString *key , id&lt;NSCoding&gt; object ))*block*`

#### Parameters

*key*  
&nbsp;&nbsp;&nbsp;标识键值  

*block*  
&nbsp;&nbsp;&nbsp;查询到异步回调 block，如果过期，或者没有查询到，返回 nil  

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/removeAllObjects" title="removeAllObjects"></a>
### removeAllObjects

移除所有缓存
阻塞当前线程

`- (void)removeAllObjects`

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/removeAllObjectsWithBlock:" title="removeAllObjectsWithBlock:"></a>
### removeAllObjectsWithBlock:

异步移除所有缓存

`- (void)removeAllObjectsWithBlock:(void ( ^ ) ( void ))*block*`

#### Parameters

*block*  
&nbsp;&nbsp;&nbsp;异步回调 block  

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/removeAllObjectsWithProgressBlock:endBlock:" title="removeAllObjectsWithProgressBlock:endBlock:"></a>
### removeAllObjectsWithProgressBlock:endBlock:

异步移除所有缓存，并通知进度

`- (void)removeAllObjectsWithProgressBlock:(nullable void ( ^ ) ( int removedCount , int totalCount ))*progress* endBlock:(nullable void ( ^ ) ( BOOL error ))*end*`

#### Parameters

*progress*  
&nbsp;&nbsp;&nbsp;移除进度  

*end*  
&nbsp;&nbsp;&nbsp;完成回调  

#### Discussion


<strong>Warning:</strong> 在 block 回调过程中，不要有任何操作

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/removeObjectForKey:" title="removeObjectForKey:"></a>
### removeObjectForKey:

移除缓存
阻塞当前线程

`- (void)removeObjectForKey:(NSString *)*key*`

#### Parameters

*key*  
&nbsp;&nbsp;&nbsp;标识键值  

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/removeObjectForKey:withBlock:" title="removeObjectForKey:withBlock:"></a>
### removeObjectForKey:withBlock:

移除缓存
异步回调 block，通知缓存移除成功

`- (void)removeObjectForKey:(NSString *)*key* withBlock:(nullable void ( ^ ) ( NSString *key ))*block*`

#### Parameters

*key*  
&nbsp;&nbsp;&nbsp;标识键值.  

*block*  
&nbsp;&nbsp;&nbsp;异步回调 block  

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/setObject:forKey:" title="setObject:forKey:"></a>
### setObject:forKey:

设置缓存
阻塞当前线程

`- (void)setObject:(nullable id&lt;NSCoding&gt;)*object* forKey:(NSString *)*key*`

#### Parameters

*object*  
&nbsp;&nbsp;&nbsp;如果设置为 nil， 则移除 key 对应的缓存  

*key*  
&nbsp;&nbsp;&nbsp;标识键值  

#### Declared In
* `MLSCacheManager.h`

<a name="//api/name/setObject:forKey:withBlock:" title="setObject:forKey:withBlock:"></a>
### setObject:forKey:withBlock:

设置缓存
会在异步线程中缓存到本地磁盘， block 在完成后回调

`- (void)setObject:(nullable id&lt;NSCoding&gt;)*object* forKey:(NSString *)*key* withBlock:(nullable void ( ^ ) ( void ))*block*`

#### Parameters

*object*  
&nbsp;&nbsp;&nbsp;需要缓存的 obj， 如果为 nil 则移除本地缓存和内存缓存  

*block*  
&nbsp;&nbsp;&nbsp;异步回调 block  

#### Declared In
* `MLSCacheManager.h`

