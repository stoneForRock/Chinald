//
//  UIView+ZNTHud.h
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHudDefaultDuration 1.2
#define kHudDefaultFont [UIFont systemFontOfSize:14]

@interface UIView (ZNTHud)

- (void)znt_showHUD:(NSString *)text;
- (void)znt_hideHUD;

- (void)znt_showToast:(NSString *)text;
- (void)znt_showToast:(NSString *)text afterDelay:(NSTimeInterval)delay;

- (void)znt_showImageToast:(NSString *)text imageName:(NSString *)imageName;
- (void)znt_showImageToast:(NSString *)text imageName:(NSString *)imageName afterDelay:(NSTimeInterval)delay;

@end
