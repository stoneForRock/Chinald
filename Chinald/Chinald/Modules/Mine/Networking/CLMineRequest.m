//
//  CLMineRequest.m
//  Chinald
//
//  Created by WPFBob on 2018/4/17.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMineRequest.h"

@implementation CLMineRequest
/**
 修改用户信息
 
 @param parameters 参数  head_icon 头像url、name昵称 、open_phone是否公开手机号码 （1公开0不公开）都可选但不能为空
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)userEditInfo:(NSDictionary *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/user/editinfo";
        request.parameters = parameters;
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        complete(responseObject);

    } onFailure:^(NSError * _Nullable error) {
        theFailure(error.localizedDescription);
    }];
}
@end
