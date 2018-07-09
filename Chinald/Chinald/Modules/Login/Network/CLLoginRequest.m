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
    [self clPostRequestTheURL:urlString parameters:parameters theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
//        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo"];
//        if ([fileManager fileExistsAtPath:path]) {
//            [fileManager removeItemAtPath:path error:nil];
//        }
        NSDictionary *userDic = resultsObj[@"data"];
//        dispatch_queue_t queue = dispatch_queue_create([path UTF8String], NULL);
//        dispatch_async(queue, ^{
            [userDic writeToFile:path atomically:YES];
//        });
        
        CLUserModel *userModel = [CLUserModel sharedUserModel];
        CLUserModel *user = [[CLUserModel alloc]initWithDictionary:userDic error:nil];
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
