//
//  CLLoginRequest.h
//  Chinald
//
//  Created by WPFBob on 2018/4/14.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLNetworkingRequestBase.h"
@class CLUserModel;
@interface CLLoginRequest : CLNetworkingRequestBase

/**
 登录

 @param parameters 登录的参数
 @param complete 登录成功userModel
 @param theFailure 错误信息msg
 */
+(void)userLogin:(NSDictionary *)parameters complete:(void(^)(CLUserModel *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;

/**
 获取验证码
 
 @param parameters 获取验证码的参数
 @param complete 获取验证码成功
 @param theFailure 错误信息msg
 */
+(void)userCode:(NSDictionary *)parameters complete:(void(^)(NSDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;

@end
