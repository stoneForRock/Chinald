//
//  UIBarButtonItem+Custom.m
//  kdweibo
//
//  Created by sevli on 16/9/9.
//  Copyright © 2016年 www.kingdee.com. All rights reserved.
//

#import "UIBarButtonItem+Custom.h"
#import "UIButton+ZNTStyle.h"

@implementation UIBarButtonItem (Custom)

+ (UIBarButtonItem * _Nullable)znt_makeDefaultBackItemTarget:(nullable id)target
                                                     action:(nullable SEL)action {

    UIButton *backBtn = [UIButton backBtnInWhiteNavWithTitle:@""];
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    backItem.tintColor = Color5;
    return backItem;
}




+ (UIBarButtonItem * _Nullable)znt_makeItemWithImageName:(nullable NSString *)imageName
                                          highlightName:(nullable NSString *)highlightName
                                                offsetX:(CGFloat)offsetX
                                                 target:(nullable id)target
                                                 action:(nullable SEL)action {

    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, offsetX, 0, -offsetX)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

+ (UIBarButtonItem * _Nullable)znt_makeLeftItemWithCustomView:(nullable UIView *)customView {

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    customView.bounds = CGRectOffset(customView.bounds, -[[self class] znt_customViewDistance], 0);
    return item;
}

+ (UIBarButtonItem * _Nullable)znt_makeRightItemWithCustomView:(nullable UIView *)customView {

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    customView.bounds = CGRectOffset(customView.bounds, [[self class] znt_customViewDistance], 0);
    return item;
}


+ (UIBarButtonItem * _Nullable)znt_makeLeftItemWithImageName:(nullable NSString *)imageName
                                              highlightName:(nullable NSString *)highlightName
                                                     target:(nullable id)target
                                                     action:(nullable SEL)action {


    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[self class] znt_makeLeftItemWithCustomView:button];
    return item;
}

+ (UIBarButtonItem * _Nullable)znt_makeRightItemWithImageName:(nullable NSString *)imageName
                                               highlightName:(nullable NSString *)highlightName
                                                      target:(nullable id)target
                                                      action:(nullable SEL)action {


    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, [NSNumber zntRightItemDistance], 0, -[NSNumber zntRightItemDistance])];
    UIBarButtonItem *item = [[self class] znt_makeRightItemWithCustomView:button];
    return item;
}


+ (UIBarButtonItem * _Nullable)znt_makeLeftItemWithTitle:(nullable NSString *)title
                                                  color:(nullable UIColor *)color
                                                 target:(nullable id)target
                                                 action:(nullable SEL)action {

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName : color, NSFontAttributeName : ThemeTextColor};
    [item setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    [item setTitleTextAttributes:titleTextAttributes forState:UIControlStateHighlighted];
    [item setTitlePositionAdjustment:UIOffsetMake([[self class] znt_marginDistance], 0) forBarMetrics:UIBarMetricsDefault];
    return item;
}

+ (UIBarButtonItem * _Nullable)znt_makeRightItemWithTitle:(nullable NSString *)title
                                                  color:(nullable UIColor *)color
                                                 target:(nullable id)target
                                                 action:(nullable SEL)action {


    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName : color, NSFontAttributeName : Font14};
    [item setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    [item setTitleTextAttributes:titleTextAttributes forState:UIControlStateHighlighted];
    [item setTitlePositionAdjustment:UIOffsetMake(-[[self class] znt_marginDistance], 0) forBarMetrics:UIBarMetricsDefault];
    return item;
}

+ (CGFloat)znt_leftSecondItemOffsetX {
    
    CGFloat offsetX;
    if (isiPhone6Plus) {
        offsetX = 14;
    }
    else {
        offsetX = 8;
        if (isAboveiOS9) {
            offsetX = 8;
        }
        else {
            offsetX = 9;
        }
    }
    return offsetX;
}

+ (CGFloat)znt_leftSecondImageOffsetX {
    
    CGFloat offsetX;
    if (isiPhone6Plus) {
        offsetX = 14;
    }
    else {
        offsetX = 8;
        if (isAboveiOS9) {
            offsetX = 8;
        }
        else {
            offsetX = 9;
        }
    }
    return offsetX;
}

+ (CGFloat)znt_titleWidth {
    
    if (isAboveiPhone6) { //plus
        if (isiPhone6) {  //6
            return 585.f/2;
        }
        else {
            return 925.f/3;
        }
    }
    else {
        return 485.f/2;  // 5
    }
}


// 文字边距
+ (CGFloat)znt_marginDistance {
    
    if (isAboveiPhone6) { //plus
        if (isiPhone6) {  //6
            return -4.f;
        }
        else {
            return -9.f;
        }
    }
    else {
        return 4.f;  // 5
    }
    
}

// customDistance
+ (CGFloat)znt_customViewDistance {
    
    if (isAboveiPhone6) { //plus
        if (isiPhone6) {  //6
            return -4.f;
        }
        else {
            return -8.5f;
        }
    }
    else {
        return -4.f;  // 5
    }
    
}


@end
