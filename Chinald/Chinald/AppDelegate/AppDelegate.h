//
//  AppDelegate.h
//  Chinald
//
//  Created by shichuang on 2018/3/13.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define ZNTAppDelegate [AppDelegate getAppDelegate]

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) CLLocationManager *locationManager;

+ (AppDelegate *)getAppDelegate;

// 进入新版指引页
- (void)showGuideVC;
- (void)setupMainViewControllers;

@end

