//
//  CLNetworkingRequestBase.h
//  taxinvoicebox
//
//  Created by WPFBob on 2017/7/27.
//  Copyright © 2017年 vanvy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLNetworkingRequestBase : NSObject

/**
 获取网络状态

 @return 有无网络
 */
+(BOOL)clTheNetworkStates;

/**
 get 请求
 @param urlStr  请求的URL
 @param parameters 请求的参数数据 用来获取加密验证
 @param have 是需要包含请求头token
 @param complete 时数据正确返回正确结果.
 @param theFailure  请求失败、服务器内部错误返回内容 请求返回的code等于998（登录验证错误）、999（未登录）通知弹出错误提醒，重新登录.
 */

+(void)clGetRequestTheURL:(NSString *)urlStr parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress * uploadProgress))progress theRequsetHeader:(BOOL)have complete:(void(^)(NSMutableDictionary *  resultsObj))complete theFailure:(void(^)(NSString *  errorStr))theFailure;

/**
 post 请求 有进度的
 @param urlStr  请求的URL
 @param parameters 请求的参数数据 用来获取加密验证

 @param progress 数据上传进度
 @param have 是需要包含请求头token
 @param complete 时数据正确返回正确结果.
 @param theFailure  请求失败、服务器内部错误返回内容 请求返回的code等于998（登录验证错误）、999（未登录）通知弹出错误提醒，重新登录.
 */
+(void)clPostRequestTheURL:(NSString *)urlStr parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress * uploadProgress))progress  theRequsetHeader:(BOOL)have complete:(void(^)(NSMutableDictionary * resultsObj))complete theFailure:(void(^)(NSString *errorStr))theFailure;


/**
 post 请求
 @param urlStr  请求的URL
 @param parameters 请求的参数数据 用来获取加密验证
 @param have 是需要包含请求头token
 @param complete 时数据正确返回正确结果.
 @param theFailure  请求失败、服务器内部错误返回内容 请求返回的code等于998（登录验证错误）、999（未登录）通知弹出错误提醒，重新登录.
 */
+(void)clPostRequestTheURL:(NSString *)urlStr parameters:(NSDictionary *)parameters theRequsetHeader:(BOOL)have complete:(void(^)(NSMutableDictionary * resultsObj))complete theFailure:(void(^)(NSString *errorStr))theFailure;

/**
 post 请求  请求的数据类型是list
 @param urlStr  请求的URL
 @param parameters 请求的参数数据 用来获取加密验证
 @param have 是需要包含请求头token
 @param complete 时数据正确返回正确结果.
 @param theFailure  请求失败、服务器内部错误返回内容 请求返回的code等于998（登录验证错误）、999（未登录）通知弹出错误提醒，重新登录.
 */
+(void)clPostRequestTheURL:(NSString *)urlStr parametersArray:(NSMutableArray *)parameters theRequsetHeader:(BOOL)have complete:(void(^)(NSMutableDictionary * resultsObj))complete theFailure:(void(^)(NSString *errorStr))theFailure;



+ (void)eipUploadFileDataByFormURL:(NSString *)urlStr parameters:(NSMutableDictionary *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;


/**
 刷新token  如果成功（1000）则重新发生最后一次数据请求，如果失败（1003）提示在其他设备登录 其他错误码（1001）
 @param urlStr 最后一次的请求链接
 @param parameters 最后一次请求要发送的数据
 @param complete 最后一次请求的数据结果
 @param theFailure 错误信息
 */
+(void)eipRefreshTokenLastRequestURL:(NSString *)urlStr parameters:(NSDictionary *)parameters Complete:(void(^)(NSMutableDictionary * resultsObj))complete theFailure:(void(^)(NSString *errorStr))theFailure;

/**
 取消所有请求
 */
+(void)eipCancelAllOperations;
@end
