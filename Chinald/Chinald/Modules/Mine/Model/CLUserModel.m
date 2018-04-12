//
//  CLUserModel.m
//  Chinald
//
//  Created by WPFBob on 2018/4/11.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLUserModel.h"
@implementation CLUserModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
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
@end
