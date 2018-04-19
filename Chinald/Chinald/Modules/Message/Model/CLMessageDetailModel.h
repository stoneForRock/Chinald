//
//  CLMessageDetailModel.h
//  Chinald
//
//  Created by WPFBob on 2018/4/17.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CLMessageDetailModel : JSONModel
@property(nonatomic, copy)NSString *content;  //!<
@property(nonatomic, copy)NSString *addTime;  //!<
@end
