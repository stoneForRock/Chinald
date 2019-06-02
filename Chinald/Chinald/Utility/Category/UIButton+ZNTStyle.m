//
//  UIButton+ZNTStyle.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "UIButton+ZNTStyle.h"

@implementation UIButton (ZNTStyle)


+ (UIButton *)whiteBtnWithTitle:(NSString *)title {
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    float width = MAX(title.length, 3) * 14.0 + 8.0;
    [btn setFrame:CGRectMake(0.0, 0.0, width, 27.0)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:Font14];
    [btn setTitleColor:Color2 forState:UIControlStateNormal];
    [btn setBackgroundColor:Color2];
    //	[btn setTitleColor:FC7 forState:UIControlStateHighlighted];
    //	[btn setBackgroundImage:[UIImage kd_imageWithColor:FC6] forState:UIControlStateNormal];
    //	[btn setBackgroundImage:[UIImage kd_imageWithColor:[UIColor kdBackgroundColor3]] forState:UIControlStateHighlighted];
    btn.layer.borderColor = ThemeColor.CGColor;
    btn.layer.borderWidth = 1;
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 3;
    
    return btn;
}




+ (UIButton *)backBtnInWhiteNavWithTitle:(NSString *)title {
    return [self backBtnInWhiteNavWithTitle:title inNav:YES];
}

+ (UIButton *)backBtnInWhiteNavWithTitle:(NSString *)title inNav:(BOOL)inNav {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([title isEqualToString:@"返回"]) {
        title = @"";
    }
    
    [btn.titleLabel setFont:Font15];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel sizeToFit];
    
    float width = 8.0;
    width += 16;
    [btn setFrame:CGRectMake(0.0, 0.0, width, 27)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:Font13];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];
    [btn setImage:[[UIImage imageNamed:@"icon_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 0)] forState:UIControlStateNormal];
    [btn setImage:[[UIImage imageNamed:@"icon_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 0)] forState:UIControlStateHighlighted];
    //这块逻辑好坑爹，没啥好的办法
    if (inNav) {
        if (isiPhone6Plus) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0.667, -14, -0.667, 14)];
            if (isAboveiOS9) {
                CGFloat space = 6;
                if (title.length > 1) {
                    space = 0;
                }
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.667, -7+space, -0.667, 7-space)];
            }
            else {
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.667, -7, -0.667, 7)];
            }
        }
        else {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0.5, -12 , -0.5, 12)];
            if (isAboveiOS9) {
                CGFloat space = 5;
                if (title.length > 1) {
                    space = 1;
                }
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(1, -9+space , -1, 9-space)];
            }
            else {
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(1, -9 , -1, 9)];
            }
        }
    }
    else {
        if (isiPhone6Plus) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-0.333, 0, 0.333, 0)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(-0.333, 6, 0.333, -6)];
        }
        else {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-0.5, -4, 0.5, 4)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 2)];
        }
    }
    return btn;
}

+ (UIButton *)cancelButtonInPresentedVC
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *strTitle = @"取消";
    [btn setFrame:CGRectMake(0.0, 0.0, 40, 27)];
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn.titleLabel setFont:Font14];
    [btn setTitleColor:Color2 forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRGB:0xDFEBF2] forState:UIControlStateHighlighted];
    CGFloat space = 0;
    if (isiPhone6Plus) {
        space = 2;
    }
    return btn;
}

+ (UIButton *)backBtnInBlueNavWithTitle:(NSString *)title {
    return [self backBtnInBlueNavWithTitle:title inNav:YES];
}

+ (UIButton *)backBtnInBlueNavWithTitle:(NSString *)title inNav:(BOOL)inNav {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([title isEqualToString:@"返回"]) {
        title = @"";
    }
    
    [btn.titleLabel setFont:Font14];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel sizeToFit];
    
    float width = 8.0;
    width += 16;
    [btn setFrame:CGRectMake(0.0, 0.0, width, 27)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:Font14];
    [btn setTitleColor:ThemeColor forState:UIControlStateNormal];
    [btn setTitleColor:[ThemeColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [btn setImage:[[UIImage imageNamed:@"icon_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 0)] forState:UIControlStateNormal];
    [btn setImage:[[UIImage imageNamed:@"icon_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 0)] forState:UIControlStateHighlighted];
    //这块逻辑好坑爹，没啥好的办法
    if (inNav) {
        if (isiPhone6Plus) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0.667, -8, -0.667, 14)];
            if (isAboveiOS9) {
                CGFloat space = 6;
                if (title.length > 1) {
                    space = 0;
                }
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.667, -1+space, -0.667, 7-space)];
            }
            else {
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.667, -1, -0.667, 7)];
            }
        }
        else {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0.5, -6 , -0.5, 12)];
            if (isAboveiOS9) {
                CGFloat space = 5;
                if (title.length > 1) {
                    space = 1;
                }
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(1, -3+space , -1, 9-space)];
            }
            else {
                [btn setTitleEdgeInsets:UIEdgeInsetsMake(1, -3 , -1, 9)];
            }
        }
    }
    else {
        if (isiPhone6Plus) {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-0.333, 0, 0.333, 0)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(-0.333, 0, 0.333, -6)];
        }
        else {
            [btn setImageEdgeInsets:UIEdgeInsetsMake(-0.5, -4, 0.5, 4)];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 2)];
        }
    }
    return btn;
}

+ (UIButton *)btnInNavWithImage:(UIImage *)image
               highlightedImage:(UIImage *)highlightedImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
        [btn setBounds:CGRectMake(0, 0, image.size.width, image.size.height)];
    }
    if (highlightedImage) {
        [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    if (isiPhone6Plus) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 8, 0, -8)];
    }
    else {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 4, 0, -4)];
    }
    return btn;
}


@end
