//
//  ZNTDataConfig.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTDataConfig.h"

#define kConfigUser @"config_user"

@implementation ZNTDataConfig

+ (ZNTDataConfig *)sharedConfig {
    static dispatch_once_t once;
    static ZNTDataConfig *shareConfig;
    dispatch_once(&once, ^{
        shareConfig = [[self alloc] init];
    });
    return shareConfig;
}

- (id)init {
    self = [super init];
    if (self) {
        self.firstProtectedDataAvailable = [UIApplication sharedApplication].protectedDataAvailable;
        [self loadConfig];
    }
    return self;
}

- (void)loadConfig {
    NSData *user = [[NSUserDefaults standardUserDefaults] objectForKey:kConfigUser];
    if (user) {
        self.user = [NSKeyedUnarchiver unarchiveObjectWithData:user];
        self.firstProtectedDataAvailable = YES;
    }
}

- (void)clearConfig {
    self.user.token = @"";
    self.user = nil;
    [self saveConfig];
}

- (BOOL)saveConfig {
    if (self.user != nil) {
        NSData *user = [NSKeyedArchiver archivedDataWithRootObject:self.user];
        [[NSUserDefaults standardUserDefaults] setObject:user forKey:kConfigUser];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kConfigUser];
    }
    BOOL result = [[NSUserDefaults standardUserDefaults] synchronize];
    
    return result;
}

@end
