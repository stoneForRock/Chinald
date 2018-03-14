//
//  ZNTThemeButton.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/6.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTThemeButton.h"

@implementation ZNTThemeButton

- (id)init
{
    if(self = [super init])
    {
        [self updateStyle];
    }
    return self;
}

- (void)updateStyle
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:Font15];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.backgroundColor = ThemeColor;
    //    self.layer.borderColor = [UIColor colorWithHexRGB:@"91d8ff"].CGColor;
    //    self.layer.borderWidth = 1.f;
}

- (void)updateCancelStyle {
    [self setTitleColor:ThemeTextColor forState:UIControlStateNormal];
    [self.titleLabel setFont:Font15];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = ThemeTextColor.CGColor;
    self.layer.borderWidth = 0.5;
}

- (void)enableTouch
{
    self.enabled = YES;
    self.alpha = 1.f;
}

- (void)blueEnableTouch {
    self.enabled = YES;
    self.backgroundColor = ThemeColor;
}

- (void)orangeEnableTouch {
    self.enabled = YES;
    self.backgroundColor = OrangeColor;
}

- (void)grayDisableTouch {
    self.enabled = NO;
    self.backgroundColor = ThemePlaceholderColor;
}

- (void)disableTouch
{
    self.enabled = NO;
    self.alpha = 0.5f;
}

- (void)setHighlighted:(BOOL)highlighted {
    self.alpha = highlighted?.5f:1.f;
}

- (void)unSeleted {
    [self setTitleColor:ThemeTextColor forState:UIControlStateNormal];
    self.backgroundColor = ZNTVCBacgroundColor;
}


@end
