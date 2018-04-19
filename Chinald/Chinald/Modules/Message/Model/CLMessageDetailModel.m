//
//  CLMessageDetailModel.m
//  Chinald
//
//  Created by WPFBob on 2018/4/17.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMessageDetailModel.h"

@implementation CLMessageDetailModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"content": @"content",
                                                                  @"addTime": @"add_time"
                                                                  }];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return true;
}
@end
