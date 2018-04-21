//
//  CLMessageNetworking.m
//  Chinald
//
//  Created by WPFBob on 2018/4/19.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMessageNetworking.h"
#import "ZNTURLPathManager.h"
#import "CLUserModel.h"
#import <JSONModel.h>


@implementation CLMessageNetworking
/**
 消息列表
 
 @param parameters 参数 token
 @param complete 成功
 @param theFailure 错误
 */
+(void)messageIndex:(NSDictionary *)parameters complete:(void(^)(NSMutableArray *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSString *urlString = [NSString stringWithFormat:@"%@/message/index",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    CLUserModel *userModel = [CLUserModel sharedUserModel];
    [self clPostRequestTheURL:urlString parameters:@{@"token":userModel.token} theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        NSMutableArray *resultsArrat = [CLMessageModel arrayOfModelsFromDictionaries:resultsObj[@"data"] error:nil];
        complete(resultsArrat);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}
/**
 消息详情列表
 
 @param parameters 参数 page页码、pagesize每页数量 type通知类型 token
 @param complete 成功响应结果
 @param theFailure 错误
 */
+(void)messageNotice:(CLMessageDetailRequsetModel *)parameters complete:(void(^)(NSMutableArray *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSString *urlString = [NSString stringWithFormat:@"%@/message/notice",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [self clPostRequestTheURL:urlString parameters:[parameters toDictionary] theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        NSMutableArray *resultsArrat = [CLMessageDetailModel arrayOfModelsFromDictionaries:resultsObj[@"data"] error:nil];
        complete(resultsArrat);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}
@end
