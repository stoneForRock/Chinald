//
//  ZNTLoginManager+ZNTEnter.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTLoginManager+ZNTEnter.h"
#import "ZNTLoginVC.h"
#import "AppDelegate.h"

@implementation ZNTLoginManager (ZNTEnter)

- (void)enterMainViewController {
    [[AppDelegate getAppDelegate] setupMainViewControllers];
}

- (void)enterLoginWithGuideVC:(BOOL)bShowGuideVC {
    
    [self directEnterZNT];
    return;
    
    //如果已经登陆过，就直接进入主页
    if ([ZNTDataConfig sharedConfig].user.token.length > 0) {
        [self directEnterZNT];
        return;
    }
    
    //未登陆过，跳转到登陆页面
    ZNTLoginVC *loginVC = [ZNTLoginVC instanceFromXib];
    RTRootNavigationController *loginNav = [[RTRootNavigationController alloc] initWithRootViewController:loginVC];
    [AppDelegate getAppDelegate].window.rootViewController = loginNav;
}

- (void)directEnterZNT {
    //执行进入应用主页面之前的逻辑，比如数据库的初始化
    
    //自动登录接口
    [self autoLoginCompleted:^(BOOL success, NSUInteger errorCode, NSString *error, id userInfo) {
    }];
    [self enterMainViewController];
}

@end
