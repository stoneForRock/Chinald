//
//  CLCommentRequest.m
//  Chinald
//
//  Created by shichuang on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLCommentRequest.h"

@implementation CLCommentRequest

+ (void)getCommentListWithGoodsId:(NSString *)goodsId
                        onSuccess:(ZNTSuccessBlock)successBlock
                        onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/feedback/index";
        request.parameters = @{@"goods_id":goodsId};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)getCommentDetialWithCommentId:(NSString *)commentId
                            onSuccess:(ZNTSuccessBlock)successBlock
                            onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/feedback/detail";
        request.parameters = @{@"comment_id":commentId};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)replyCommentWithCommentId:(NSString *)commentId
                          content:(NSString *)content
                        onSuccess:(ZNTSuccessBlock)successBlock
                        onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/feedback/reply";
        request.parameters = @{@"comment_id":commentId};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)deleteCommentWithCommentId:(NSString *)commentId
                         onSuccess:(ZNTSuccessBlock)successBlock
                         onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/feedback/delete";
        request.parameters = @{@"comment_id":commentId};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)likeCommentWithCommentId:(NSString *)commentId
                       onSuccess:(ZNTSuccessBlock)successBlock
                       onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/feedback/like";
        request.parameters = @{@"comment_id":commentId};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

@end
