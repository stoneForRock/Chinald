//
//  UIViewController+NavigationStyle.h
//  kdweibo
//
//  Created by sevli on 16/9/8.
//  Copyright © 2016年 www.kingdee.com. All rights reserved.
//  Navigation 样式 --- NavigationStyle支持扩展

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZNTNavigationStyleNormal = 0,        // 白底蓝字
    ZNTNavigationStyleBlue,              // 蓝底白字
    ZNTNavigationStyleYellow,            // 黄底白字
    ZNTNavigationStyleClear,             // 透明底白字
    ZNTNavigationStyleCustom             // 自定义颜色
} ZNTNavigationStyle;



@interface UIViewController (NavigationStyle)

/**
 *  设置barTitle & item 样式
 *
 *  @param style style可扩展
 */
- (void)setNavigationStyle:(ZNTNavigationStyle)style;

/**
 *  设置bar颜色
 *
 *  @param NSString
 */
- (void)setNavigationCustomStyleWithColorStr:(NSString *)colorStr;

/**
 *  设置bar颜色
 *
 *  @param UIColor
 */
- (void)setNavigationCustomStyleWithColor:(UIColor *)color;


@end
