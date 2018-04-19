//
//  CLMesageModel.m
//  Chinald
//
//  Created by WPFBob on 2018/4/17.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMessageModel.h"

@implementation CLMessageModel
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"content": @"content",
                                                                  @"lastTime": @"last_time",
                                                                  @"type":@"type"
                                                                  }];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return true;
}
@end
