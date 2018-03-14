//
//  UIViewController+NavigationStyle.m
//  kdweibo
//
//  Created by sevli on 16/9/8.
//  Copyright © 2016年 www.kingdee.com. All rights reserved.
//

#import "UIViewController+NavigationStyle.h"
#import "UIView+Responder.h"

@interface UIViewController()

@property (nonatomic, assign) ZNTNavigationStyle style;
@property (nonatomic, strong) UIColor *customColor;

@end

@implementation UIViewController (NavigationStyle)

#pragma mark - Method Swizzling
+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        void (^__instanceMethod_swizzling)(Class, SEL, SEL) = ^(Class cls, SEL orgSEL, SEL swizzlingSEL){
            Method orgMethod = class_getInstanceMethod(cls, orgSEL);
            Method swizzlingMethod = class_getInstanceMethod(cls, swizzlingSEL);
            if (class_addMethod(cls, orgSEL, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod))) {

                class_replaceMethod(cls, orgSEL, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
            }
            else
            {
                method_exchangeImplementations(orgMethod, swizzlingMethod);
            }

        };

        {
            __instanceMethod_swizzling([self class], @selector(viewDidLoad), @selector(___viewDidLoad));
        }
        {
            __instanceMethod_swizzling([self class], @selector(viewWillAppear:), @selector(___viewWillAppear:));
        }
    });
}

- (void)___viewDidLoad{


    [self ___viewDidLoad];
    [self setNavigationStyle:ZNTNavigationStyleBlue];
    if([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        if (self.navigationController) {
            [self.navigationController.navigationBar setTranslucent:NO];
        }
    }
}

- (void)___viewWillAppear:(BOOL)animated {

   
    [self ___viewWillAppear:animated];
    [self setNavigationStyle:self.style];
}


#pragma mark - Navigation Style

- (void)setNavigationStyle:(ZNTNavigationStyle)style {

    self.style = style;
    
    if ([NSStringFromClass([self class]) isEqualToString:@"_UIRemoteInputViewController"]
        || self.view.parentController != self
        || [self isKindOfClass:[RTContainerController class]]
        || [self isKindOfClass:[AppWindow.rootViewController class]]
        || [self isKindOfClass:[UINavigationController class]]
        || [self isKindOfClass:NSClassFromString(@"UICompatibilityInputViewController")]) {
        return;
    }
    
    switch (style) {
        case ZNTNavigationStyleNormal:
        {
            [self.navigationController.navigationBar setBarTintColor:ThemeNavBacgroundColor];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeTextColor, NSFontAttributeName : Font16}];
            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeTextColor, NSFontAttributeName : Font16} forState:UIControlStateNormal];
            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeTextColor, NSFontAttributeName : Font16} forState:UIControlStateHighlighted];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeTextColor, NSFontAttributeName : Font16} forState:UIControlStateNormal];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeTextColor, NSFontAttributeName : Font16} forState:UIControlStateHighlighted];
        }
            break;
        case ZNTNavigationStyleBlue:
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [self.navigationController.navigationBar setBarTintColor:ThemeColor];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16}];
            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16} forState:UIControlStateNormal];
            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16} forState:UIControlStateHighlighted];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16} forState:UIControlStateNormal];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16} forState:UIControlStateHighlighted];
        }
            break;
        case ZNTNavigationStyleYellow:
        {
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//            [self.navigationController.navigationBar setBarTintColor:[UIColor kdNavYellowColor]];
//            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS1}];
//            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS3} forState:UIControlStateNormal];
//            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS3} forState:UIControlStateHighlighted];
//            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS3} forState:UIControlStateNormal];
//            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS3} forState:UIControlStateHighlighted];
        }
            break;
        case ZNTNavigationStyleClear:
        {
//            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//            [self.navigationController.navigationBar setTranslucent:YES];
//            [self.navigationController.navigationBar setKD_navigationBarBackgroundAlpha:0.f];
//            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS1}];
//            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS3} forState:UIControlStateNormal];
//            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS3} forState:UIControlStateHighlighted];
//            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS3} forState:UIControlStateNormal];
//            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : FC6, NSFontAttributeName : FS3} forState:UIControlStateHighlighted];
        }
            break;
        case ZNTNavigationStyleCustom:
        {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [self.navigationController.navigationBar setBarTintColor:self.customColor];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16}];
            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16} forState:UIControlStateNormal];
            [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16} forState:UIControlStateHighlighted];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16} forState:UIControlStateNormal];
            [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeNavBacgroundColor, NSFontAttributeName : Font16} forState:UIControlStateHighlighted];
        }
            break;

        default:
            break;
    }
    
    if (kiOS7Later) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
}

- (void)setNavigationCustomStyleWithColorStr:(NSString *)colorStr {

    if (colorStr && colorStr.length == 7) {
        NSString *trueColor = [colorStr substringWithRange:NSMakeRange(1, colorStr.length - 1)];
        if (![[trueColor lowercaseString] isEqualToString:@"ffffff"]) {
            self.customColor = [UIColor colorWithHexRGB:trueColor];
            [self setNavigationStyle:ZNTNavigationStyleCustom];
        }
    }
}

- (void)setNavigationCustomStyleWithColor:(UIColor *)color {

    if (color && !CGColorEqualToColor(color.CGColor, Color1.CGColor)) {
        self.customColor = color;
        [self setNavigationStyle:ZNTNavigationStyleCustom];
    }
}

#pragma mark - setter && getter

- (ZNTNavigationStyle)style {

   return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setStyle:(ZNTNavigationStyle)style {

    objc_setAssociatedObject(self, @selector(style), @(style), OBJC_ASSOCIATION_ASSIGN);
}


- (UIColor *)customColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCustomColor:(UIColor *)customColor {
        objc_setAssociatedObject(self, @selector(customColor), customColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
