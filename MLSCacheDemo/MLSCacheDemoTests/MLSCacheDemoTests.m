//
//  MLSCacheDemoTests.m
//  MLSCacheDemoTests
//
//  Created by yuanhang on 2019/8/20.
//  Copyright © 2019 minlison. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MLSCache/MLSCache.h>

@interface MLSCacheDemoTests : XCTestCase

@end

@implementation MLSCacheDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testAutoClean {
    NSLog(@"%@", NSHomeDirectory());
    [MLSCacheAutoManager setObject:@"auto" forKey:@"auto_key"];
    [MLSCacheManuallyManager setObject:@"manually" forKey:@"manually_key"];
    NSLog(@"%@", MLSCacheAutoManager.cacheSizeHumanString);
    NSLog(@"%@", MLSCacheManuallyManager.cacheSizeHumanString);
    NSLog(@"%@", MLSCacheManager.cacheSizeHumanString);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
