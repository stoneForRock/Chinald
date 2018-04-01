//
//  UIView+CLShadowView.h
//  Chinald
//
//  Created by WPFBob on 2018/3/28.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CLShadowView)

/**
 View周边加阴影，并且同时圆角

 @param view 需要加圆角阴影的View
 @param shadowOpacity 透明度
 @param shadowRadius 阴影的宽度
 @param cornerRadius 圆角弧度
 @param viewWidth View的总宽度（有些情况下获取到的View的尺寸不准确）
 */
+ (void)clAddShadowToView:(UIView *)view
               withOpacity:(float)shadowOpacity
              shadowRadius:(CGFloat)shadowRadius
           andCornerRadius:(CGFloat)cornerRadius width:(float)viewWidth;

@end
