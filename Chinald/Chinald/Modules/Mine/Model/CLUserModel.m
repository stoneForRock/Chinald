//
//  CLUserModel.m
//  Chinald
//
//  Created by WPFBob on 2018/4/11.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLUserModel.h"
static CLUserModel *_userModel;
@implementation CLUserModel
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_userModel == nil) {
            _userModel = [super allocWithZone:zone];
        }
    });
    return _userModel;
}
+ (instancetype)sharedUserModel
{
    return [[self alloc]init];;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                       @"userId": @"user_id",
                                                       @"number": @"number",
                                                       @"phone": @"phone",
                                                       @"headIcon": @"head_icon",
                                                       @"name": @"name",
                                                       @"openPhone": @"open_phone",
                                                       @"addTime": @"add_time",
                                                       @"token": @"token",
                                                       @"recommendName": @"recommend_name",
                                                       @"haveSale": @"have_sale",
                                                       @"saveTree": @"save_tree"
                                                       }];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return true;
}

-(void)setUserInfo:(CLUserModel *)userModel{
    self.userId = userModel.userId;
    self.number = userModel.number;
    self.phone = userModel.headIcon;
    self.name = userModel.name;
    self.openPhone = userModel.openPhone;
    self.addTime = userModel.addTime;
    self.token = userModel.token;
    self.recommendName = userModel.recommendName;
    self.haveSale = userModel.haveSale;
    self.saveTree = userModel.saveTree;
}
@end
