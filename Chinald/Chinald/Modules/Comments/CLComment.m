//
//  CLComment.m
//  Chinald
//
//  Created by shichuang on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLComment.h"

@implementation CLComment

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"head_icon": @"headIcon",
                                                       @"name": @"name",
                                                       @"number": @"number",
                                                       @"comment_content": @"commentContent",
                                                       @"comment_time": @"commentTime",
                                                       @"is_like": @"isLike",
                                                       @"comment_id": @"commentId",
                                                       @"child_comment": @"childComment"
                                                       }];
}

@end
