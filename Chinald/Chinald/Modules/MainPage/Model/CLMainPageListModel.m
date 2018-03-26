//
//  CLMainPageListModel.m
//  Chinald
//
//  Created by dachen on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMainPageListModel.h"

@implementation CLMainPageListModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"goods_id": @"goodsId",
                                                       @"title": @"goodsTitle",
                                                       @"desc": @"desc",
                                                       @"price": @"price",
                                                       @"comment_count": @"commentCount"
                                                       }];
}

@end

@implementation CLBannerModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"bannerId",
                                                       @"url": @"bannerUrl",
                                                       }];
}

@end
