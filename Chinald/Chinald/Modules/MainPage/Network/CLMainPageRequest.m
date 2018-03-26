//
//  CLMainPageRequest.m
//  Chinald
//
//  Created by dachen on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMainPageRequest.h"

@implementation CLMainPageRequest

+ (void)getMainPageGoodListOnSuccess:(ZNTSuccessBlock)successBlock
                           onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/index/index";
//        request.parameters = @{@"ownerId":customId};
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)getMainBannerListOnSuccess:(ZNTSuccessBlock)successBlock
                         onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/index/banner";
        //        request.parameters = @{@"ownerId":customId};
        request.httpMethod = kXMHTTPMethodGET;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)getGoodsDetailWithGoodsId:(NSString *)goodsId
                        onSuccess:(ZNTSuccessBlock)successBlock
                        onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/goods/detail";
        request.parameters = @{@"goods_id":goodsId};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

@end
