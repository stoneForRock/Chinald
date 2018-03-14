//
//  ZNTTabBarController.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZNTTabBarControllerDelegate <NSObject>
@optional
- (void)tabBarSelectedOnce;
- (void)tabBarSelectedTwice;
@end

@interface ZNTTabBarController : UITabBarController

@end


@interface UITabBar (ZNTAdd)
- (void)setBadgeValue:(int)badgeValue atIndex:(NSInteger)index;
- (void)setDotHidden:(BOOL)hidden atIndex:(NSInteger)index;
@end
