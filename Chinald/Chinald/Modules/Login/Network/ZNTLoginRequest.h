//
//  ZNTLoginRequest.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTRequest.h"

@interface ZNTLoginRequest : ZNTRequest

/**
 登录

 @param telephone 手机号
 @param password 密码
 @param userType 用户类型
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)loginWithPhone:(NSString *)telephone
              password:(NSString *)password
              userType:(NSString *)userType
             onSuccess:(ZNTSuccessBlock)successBlock
             onFailure:(ZNTFailureBlock)failureBlock;

/**
 自动登录 自动登录主要是替换新token

 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)loginAutoZNTOnSuccess:(ZNTSuccessBlock)successBlock
                    onFailure:(ZNTFailureBlock)failureBlock;

/**
 发送验证码

 @param phone 手机号
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)sendCodeWithPhone:(NSString *)phone
                onSuccess:(ZNTSuccessBlock)successBlock
                onFailure:(ZNTFailureBlock)failureBlock;

/**
 验证验证码

 @param smsId 验证码id
 @param phone 手机号
 @param code 验证码
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)verifyCodeWithSmsId:(NSString *)smsId
                      phone:(NSString *)phone
                       code:(NSString *)code
                  onSuccess:(ZNTSuccessBlock)successBlock
                  onFailure:(ZNTFailureBlock)failureBlock;

/**
 修改密码

 @param phone 手机号
 @param type 用户类型
 @param pwd 新密码
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)updatePasswordWithPhone:(NSString *)phone
                           type:(NSString *)type
                            psw:(NSString *)pwd
                      onSuccess:(ZNTSuccessBlock)successBlock
                      onFailure:(ZNTFailureBlock)failureBlock;

/**
 注册

 @param ownerType 运输公司类型 * 0:运输公司；1:个人车辆
 @param phone 手机号
 @param password 密码
 @param name 客户名称
 @param card 证件号码
 @param cardPic 证件图片
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)registCustomWithOwnerType:(NSString *)ownerType
                            phone:(NSString *)phone
                         password:(NSString *)password
                             name:(NSString *)name
                             card:(NSString *)card
                          cardPic:(NSString *)cardPic
                        onSuccess:(ZNTSuccessBlock)successBlock
                        onFailure:(ZNTFailureBlock)failureBlock;

/**
 退出登录

 @param accountNum 账号
 @param userType 用户类型
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)logoutWithAccountNum:(NSString *)accountNum
                    userType:(NSString *)userType
                   onSuccess:(ZNTSuccessBlock)successBlock
                   onFailure:(ZNTFailureBlock)failureBlock;

/**
 修改头像

 @param avatarUrl 头像地址
 @param accountId 账户id
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)updateAvatar:(NSString *)avatarUrl
           accountId:(NSString *)accountId
           onSuccess:(ZNTSuccessBlock)successBlock
           onFailure:(ZNTFailureBlock)failureBlock;

@end
