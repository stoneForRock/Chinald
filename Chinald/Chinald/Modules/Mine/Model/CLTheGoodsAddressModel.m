//
//  CLTheGoodsAddressModel.m
//  Chinald
//
//  Created by WPFBob on 2018/4/10.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLTheGoodsAddressModel.h"

@implementation CLTheGoodsAddressModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"address_id": @"address_id",
                                                       @"name": @"name",
                                                       @"phone": @"phone",
                                                       @"province": @"province",
                                                       @"city": @"city",
                                                       @"area": @"area",
                                                       @"province_code": @"province_code",
                                                       @"city_code": @"city_code",
                                                       @"area_code": @"area_code",
                                                       @"detail": @"detail",
                                                       @"is_default": @"is_default"
                                                       }];
}
@end
