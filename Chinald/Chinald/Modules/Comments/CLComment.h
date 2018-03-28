//
//  CLComment.h
//  Chinald
//
//  Created by shichuang on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CLComment : JSONModel

@property (nonatomic, copy) NSString<Optional> *headIcon;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *number;
@property (nonatomic, copy) NSString<Optional> *commentContent;
@property (nonatomic, copy) NSString<Optional> *commentTime;
@property (nonatomic, copy) NSString<Optional> *isLike;
@property (nonatomic, copy) NSString<Optional> *commentId;
@property (nonatomic, strong) NSDictionary<Optional> *childComment;

@end
