//
//  CLMainPageRequest.h
//  Chinald
//
//  Created by dachen on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "ZNTRequest.h"

@interface CLMainPageRequest : ZNTRequest

/**
 获取首页商品列表

 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)getMainPageGoodListOnSuccess:(ZNTSuccessBlock)successBlock
                           onFailure:(ZNTFailureBlock)failureBlock;

/**
 获取首页banner广告

 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)getMainBannerListOnSuccess:(ZNTSuccessBlock)successBlock
                         onFailure:(ZNTFailureBlock)failureBlock;

/**
 获取商品详情

 @param goodsId 商品id
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)getGoodsDetailWithGoodsId:(NSString *)goodsId
                        onSuccess:(ZNTSuccessBlock)successBlock
                        onFailure:(ZNTFailureBlock)failureBlock;

@end
