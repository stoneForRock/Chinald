//
//  CLMessageNetworking.h
//  Chinald
//
//  Created by WPFBob on 2018/4/19.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLNetworkingRequestBase.h"
@interface CLMessageNoticeRequestModel : JSONModel
@property(nonatomic, assign)int type;  //!<通知类型
@property(nonatomic, assign)int page;  //!<页码
@property(nonatomic, assign)int pagesize;  //!<每页数量
@property(nonatomic, copy) NSString *token; //!<
@end
@interface CLMessageNetworking : CLNetworkingRequestBase

/**
 消息列表

 @param parameters 参数 token
 @param complete 成功
 @param theFailure 错误
 */
+(void)messageIndex:(NSDictionary *)parameters complete:(void(^)(NSMutableArray *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;

/**
 消息详情列表

 @param parameters 参数 page页码、pagesize每页数量 type通知类型 token
 @param complete 成功响应结果
 @param theFailure 错误
 */
+(void)messageNotice:(CLMessageNoticeRequestModel *)parameters complete:(void(^)(NSMutableArray *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure;
@end
