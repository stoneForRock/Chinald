//
//  ZNTLoginManager.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNTLoginRequest.h"

//000:账号相关
//004:货主
//005:车主
//006:司机
#define kUserType @"005"
#define LOGIN_MANAGER [ZNTLoginManager sharedManager]

@interface ZNTLoginManager : NSObject

+ (id)sharedManager;

/**
 自动登录

 @param completedBlock completedBlock
 */
- (void)autoLoginCompleted:(void (^)(BOOL success, NSUInteger errorCode, NSString *error, id userInfo))completedBlock;

/**
 账号密码登录

 @param telephone 账号
 @param password 密码
 @param completedBlock completedBlock
 */
- (void)userLoginWithPhone:(NSString *)telephone
                  password:(NSString *)password
                 completed:(void (^)(BOOL success, NSUInteger errorCode, NSString *error, id userInfo))completedBlock;

@end
