//
//  CLCommentRequest.h
//  Chinald
//
//  Created by shichuang on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "ZNTRequest.h"

@interface CLCommentRequest : ZNTRequest

/**
 获取商品的评论列表

 @param goodsId 商品id
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)getCommentListWithGoodsId:(NSString *)goodsId
                        onSuccess:(ZNTSuccessBlock)successBlock
                        onFailure:(ZNTFailureBlock)failureBlock;

/**
 获取评论详情

 @param commentId 评论id
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)getCommentDetialWithCommentId:(NSString *)commentId
                            onSuccess:(ZNTSuccessBlock)successBlock
                            onFailure:(ZNTFailureBlock)failureBlock;

/**
 回复评论

 @param commentId 评论id
 @param content 评论内容
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)replyCommentWithCommentId:(NSString *)commentId
                          content:(NSString *)content
                        onSuccess:(ZNTSuccessBlock)successBlock
                        onFailure:(ZNTFailureBlock)failureBlock;

/**
 删除评论

 @param commentId 评论id
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)deleteCommentWithCommentId:(NSString *)commentId
                         onSuccess:(ZNTSuccessBlock)successBlock
                         onFailure:(ZNTFailureBlock)failureBlock;

/**
 评论点赞

 @param commentId 评论id
 @param successBlock successBlock
 @param failureBlock failureBlock
 */
+ (void)likeCommentWithCommentId:(NSString *)commentId
                       onSuccess:(ZNTSuccessBlock)successBlock
                       onFailure:(ZNTFailureBlock)failureBlock;

@end
