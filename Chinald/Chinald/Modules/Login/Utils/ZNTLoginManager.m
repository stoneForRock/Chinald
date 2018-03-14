//
//  ZNTLoginManager.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTLoginManager.h"
#import "ZNTLoginManager+ZNTEnter.h"

@implementation ZNTLoginManager

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (id)sharedManager {
    
    static ZNTLoginManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ZNTLoginManager alloc] init];
    });
    return sharedInstance;
}

- (void)autoLoginCompleted:(void (^)(BOOL success, NSUInteger errorCode, NSString *error, id userInfo))completedBlock {
//    [ZNTLoginRequest loginAutoZNTOnSuccess:^(id  _Nullable responseObject) {
//        
//        //自动登录成功，更新用户token
//        ZNTUser *user = [ZNTDataConfig sharedConfig].user;
//        user.token = responseObject[@"token"];
//        [ZNTDataConfig sharedConfig].user = user;
//        [[ZNTDataConfig sharedConfig] saveConfig];
//        
//        //更新请求token
//        [ZNTRequest setOpenToken:user.token];
//        
//        [self enterMainViewController];
//        
//        if (completedBlock) {
//            completedBlock(YES,0,nil,nil);
//        }
//        
//    } onFailure:^(NSError * _Nullable error) {
//        if (completedBlock) {
//            completedBlock(NO,1,error.domain,nil);
//        }
//    }];
}

- (void)userLoginWithPhone:(NSString *)telephone
                  password:(NSString *)password
                 completed:(void (^)(BOOL success, NSUInteger errorCode, NSString *error, id userInfo))completedBlock {
    [ZNTLoginRequest loginWithPhone:telephone password:password userType:kUserType onSuccess:^(id  _Nullable responseObject) {
        
        if (completedBlock) {
            completedBlock(YES,0,nil,nil);
        }
        //登录成功，存储用户信息
        ZNTUser *user = [[ZNTUser alloc] initWithDictionary:responseObject error:nil];
        [ZNTDataConfig sharedConfig].user = user;
        [[ZNTDataConfig sharedConfig] saveConfig];
        
        //更新请求token
        [ZNTRequest setOpenToken:user.token];
        
        [self enterMainViewController];
        
    } onFailure:^(NSError * _Nullable error) {
        if (completedBlock) {
            completedBlock(NO,1,error.domain,nil);
        }
    }];
}

@end
