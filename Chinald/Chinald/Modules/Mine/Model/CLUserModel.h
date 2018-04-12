//
//  CLUserModel.h
//  Chinald
//
//  Created by WPFBob on 2018/4/11.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CLUserModel : JSONModel
@property(nonatomic, copy)NSString *userId;  //!<用户id
@property(nonatomic, copy)NSString *number;  //!<会员号
@property(nonatomic, copy)NSString *phone;  //!<手机号
@property(nonatomic, copy)NSString *headIcon;  //!<头像
@property(nonatomic, copy)NSString *name;  //!<昵称
@property(nonatomic, assign)BOOL *openPhone;  //!<是否公开手机号码
@property(nonatomic, copy)NSString *addTime;  //!<关注时间
@property(nonatomic, copy)NSString *token;  //!<登录token
@property(nonatomic, copy)NSString *recommendName;  //!<推荐人
@property(nonatomic, copy)NSString *haveSale;  //!<营业额
@property(nonatomic, copy)NSString *saveTree;  //!<拯救树
@end
