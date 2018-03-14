//
//  ZNTLaunchManager.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNTLaunchManager : NSObject

+ (void)didFinishLaunching;

+ (CGFloat)afterTime;
+ (void)setAfterTime:(CGFloat)afterTime;

@end
