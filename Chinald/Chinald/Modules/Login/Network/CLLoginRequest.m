//
//  CLLoginRequest.m
//  Chinald
//
//  Created by WPFBob on 2018/4/14.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLLoginRequest.h"
#import "ZNTURLPathManager.h"
#import "CLUserModel.h"
@implementation CLLoginRequest
+(void)userLogin:(NSDictionary *)parameters complete:(void(^)(CLUserModel *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSString *urlString = [NSString stringWithFormat:@"%@/user/login",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [CLNetworkingRequestBase clPostRequestTheURL:urlString parameters:parameters theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        CLUserModel *userModel = [CLUserModel sharedUserModel];
        CLUserModel *user = [[CLUserModel alloc]initWithDictionary:resultsObj[@"data"] error:nil];
        userModel = user;
        complete(userModel);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];

}

/**
 获取验证码
 
 @param parameters 获取验证码的参数
 @param complete 获取验证码成功
 @param theFailure 错误信息msg
 */
+(void)userCode:(NSDictionary *)parameters complete:(void(^)(NSDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSString *urlString = [NSString stringWithFormat:@"%@/user/code",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [CLNetworkingRequestBase clPostRequestTheURL:urlString parameters:parameters theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        complete(resultsObj);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}
@end
