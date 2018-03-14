//
//  AppDelegate+PushNotificcation.h
//  ICOCDriver
//
//  Created by shichuang on 2017/4/8.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "AppDelegate.h"

#import "GeTuiSdk.h"     // GetuiSdk头文件应用

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate (PushNotificcation)<GeTuiSdkDelegate, UNUserNotificationCenterDelegate>

/** 注册 APNs */
- (void)registerRemoteNotification;

@end
