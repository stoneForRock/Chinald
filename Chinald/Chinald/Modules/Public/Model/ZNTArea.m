//
//  ZNTArea.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/10.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTArea.h"

@implementation ZNTArea

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"areaId",
                                                       @"name": @"areaName"
                                                       }];
}

@end
