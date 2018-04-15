//
//  CLMineNetworking.h
//  Chinald
//
//  Created by WPFBob on 2018/4/15.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLNetworkingRequestBase.h"
@class CLTheGoodsAddressModel;
@interface CLMineNetworking : CLNetworkingRequestBase

/**
 上传图片

 @param images 图片集
 @param parameters 上传的业务参数
 @param complete 上传结果
 @param theFailure 错误
 */
+ (void)clUploadImages:(NSArray *)images witheType:(NSDictionary *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;


/**
 修改用户信息

 @param parameters 参数 head_icon 头像url、name昵称 、open_phone是否公开手机号码 （1公开0不公开）
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)userEditInfo:(NSDictionary *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;
/**
 修改手机号码
 
 @param parameters 参数 code 验证码 phone手机号
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)userChangePhone:(NSDictionary *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;

/**
 获取收货地址列表
 
 @param complete 成功
 @param theFailure 失败
 */
+ (void)addressIndexComplete:(void(^)(NSMutableArray *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;


/**
添加收货地址
 @param parameters 收货地址信息
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)addressAdd:(CLTheGoodsAddressModel *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;

/**
 编辑收货地址
 @param parameters 收货地址信息
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)addressEdit:(CLTheGoodsAddressModel *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;

/**
 删除收货地址
 @param parameters 收货地址信息
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)addressDelete:(CLTheGoodsAddressModel *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;

/**
 设置为默认收货地址
 @param parameters 收货地址信息
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)addressDefault:(CLTheGoodsAddressModel *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;
@end
