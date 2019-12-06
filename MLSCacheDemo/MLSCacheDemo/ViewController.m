//
//  ViewController.m
//  MLSCacheDemo
//
//  Created by yuanhang on 2019/8/20.
//  Copyright © 2019 minlison. All rights reserved.
//

#import "ViewController.h"
#import <MLSCache/MLSCache.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 10; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MLSCacheManuallyManager setObject:@"123" forKey:[NSString stringWithFormat:@"key-%d",i]];
            id res = [MLSCacheManuallyManager objectForKey:[NSString stringWithFormat:@"key-%d",i]];
            NSLog(@"%@",res);
        });
    }
}
@end
