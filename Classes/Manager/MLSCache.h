//
//  MLSCache.h
//  MLSCache
//
//  Created by minlison on 2018/5/8.
//
/// 组件化中缓存组件, 在App中, 除非需要多 App 共享数据, 不建议使用 NSUserDefaults 来存储数据.

#import <Foundation/Foundation.h>

#if __has_include(<MLSCache/MLSCache.h>)
#import <MLSCache/MLSCacheManager.h>
#else
#import "MLSCacheManager.h"
#endif

#define MLSCacheAutoManager [MLSCacheManager cacheWithType:MLSCacheTypeAutoClean]
#define MLSCacheManuallyManager [MLSCacheManager cacheWithType:MLSCacheTypeManuallyClean]
