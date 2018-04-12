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
                                                       @"addressId": @"address_id",
                                                       @"name": @"name",
                                                       @"phone": @"phone",
                                                       @"province": @"province",
                                                       @"city": @"city",
                                                       @"area": @"area",
                                                       @"provinceCode": @"province_code",
                                                       @"cityCode": @"city_code",
                                                       @"areCode": @"area_code",
                                                       @"detail": @"detail",
                                                       @"isDefault": @"is_default"
                                                       }];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return true;
}
@end
