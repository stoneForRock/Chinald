//
//  CLFeedbackRequest.m
//  Chinald
//
//  Created by WPFBob on 2019/5/23.
//  Copyright © 2019 HuaYing. All rights reserved.
//

#import "CLFeedbackRequest.h"

@implementation CLFeedbackRequest
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"content": @"content",
                                                                  @"images": @"images",
                                                                  @"mobile": @"mobile"
                                                                  }];
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return true;
}
@end
