//
//  UIButton+ZNTStyle.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZNTStyle)

+ (UIButton *)whiteBtnWithTitle:(NSString *)title;

+ (UIButton *)backBtnInWhiteNavWithTitle:(NSString *)title;
+ (UIButton *)backBtnInWhiteNavWithTitle:(NSString *)title inNav:(BOOL)inNav;
+ (UIButton *)backBtnInBlueNavWithTitle:(NSString *)title;
+ (UIButton *)backBtnInBlueNavWithTitle:(NSString *)title inNav:(BOOL)inNav;
+ (UIButton *)btnInNavWithImage:(UIImage *)image
               highlightedImage:(UIImage *)highlightedImage;

+ (UIButton *)cancelButtonInPresentedVC;

@end
