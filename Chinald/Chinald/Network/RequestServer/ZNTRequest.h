//
//  ZNTRequest.h
//  ICOCShipper
//
//  Created by shichuang on 2017/8/31.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNTURLPathManager.h"
#import "XMNetworking.h"

#define NetFailureErrorMsg @"当前网络不可用，请检查网络设置"

typedef XMRequestConfigBlock ZNTRequestConfigBlock;
typedef XMSuccessBlock ZNTSuccessBlock;
typedef XMFailureBlock ZNTFailureBlock;
typedef void (^ZLZFinishBlock)(BOOL success, id _Nullable responseObject, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface ZNTRequest : NSObject

+ (void)setupConfig;
+ (void)setServerUrl:(NSString *)serverUrl;
+ (void)setOpenToken:(NSString *)token;

+ (NSString *)sendRequest:(ZNTRequestConfigBlock)configBlock
                onSuccess:(nullable ZNTSuccessBlock)successBlock
                onFailure:(nullable ZNTFailureBlock)failureBlock;

+ (NSString *)sendPostJsonRequest:(ZNTRequestConfigBlock)configBlock
                        onSuccess:(nullable ZNTSuccessBlock)successBlock
                        onFailure:(nullable ZNTFailureBlock)failureBlock;

@end
NS_ASSUME_NONNULL_END
