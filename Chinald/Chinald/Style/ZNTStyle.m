//
//  ZNTStyle.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTStyle.h"
#import "IQKeyboardManager.h"

@implementation ZNTStyle

+ (void)setupStyple {
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
    //setup status bar
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    //setup nav
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeTextColor, NSFontAttributeName : Font14} forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName : [ThemeTextColor colorWithAlphaComponent:0.5], NSFontAttributeName : Font14} forState:UIControlStateHighlighted];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackButtonTitlePositionAdjustment:UIOffsetMake(3, 0) forBarMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil] setBackButtonTitlePositionAdjustment:UIOffsetMake(KDBARBUTTON_OFFSET_DEFAULT, 0) forBarMetrics:UIBarMetricsDefault];
    
    UIImage *image = [UIImage imageNamed:@"nav_btn_back_light_normal"];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil] setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav_btn_back_light_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width-1, image.size.height/2-1, image.size.width)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil] setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav_btn_back_light_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width-1, image.size.height/2-1, image.size.width)] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    //setup tabbar
    // 去除黑线
    //    if ([[UITabBar appearance] respondsToSelector:@selector(setClipsToBounds:)]) {
    //        [UITabBar appearance].clipsToBounds = YES;//iOS7 下会crash :tip:iOS7 以上也不会走到这里
    //    }
    //    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];
    //    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    //    [[UITabBar appearance] setBackgroundImage:[UIImage kd_imageWithColor:FC6]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [ThemeTextColor colorWithAlphaComponent:0.5], NSFontAttributeName : Font10} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeTextColor, NSFontAttributeName : Font10} forState:UIControlStateSelected];
    //setup searchbar
    [[UISearchBar appearance] setBarTintColor:[UIColor zntThemeBackgroundColor]];
    [[UISearchBar appearance] setBarStyle:UIBarStyleBlack];
    [[UISearchBar appearance] setBackgroundImage:[UIImage znt_imageWithColor:ThemeColor] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"search_bar_btn_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"search_bar_btn_search_highlight"]forSearchBarIcon:UISearchBarIconSearch state:UIControlStateHighlighted];
    [[UISearchBar appearance] setImage:[UIImage imageNamed:@"search_bar_btn_clear"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    UIImage *backgroundImage = [UIImage imageNamed:@"search_bar_textfield"];
    backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:backgroundImage.size.width * 0.5 topCapHeight:backgroundImage.size.height * 0.5];
    [[UISearchBar appearance] setSearchFieldBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [[UISearchBar appearance] setSearchTextPositionAdjustment:UIOffsetMake([NSNumber zntDistance2], 0)];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSFontAttributeName : Font14, NSForegroundColorAttributeName : Color1}];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeColor} forState:UIControlStateNormal];
    
    //UITextField的光标颜色可以用这个控制
    [[UITextField appearance] setTintColor:ThemeColor];
    
}


@end
