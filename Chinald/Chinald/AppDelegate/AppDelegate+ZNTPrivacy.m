//
//  AppDelegate+ZNTPrivacy.m
//  ZNTDriver
//
//  Created by shichuang on 2017/10/12.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "AppDelegate+ZNTPrivacy.h"

@implementation AppDelegate (ZNTPrivacy)


- (void)getLocationPrivacy
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    BOOL locationInit = [[NSUserDefaults standardUserDefaults] boolForKey:@"kInitLocationPrivacy"];
    
    if (!locationInit) {
        
        [self.locationManager requestAlwaysAuthorization];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kInitLocationPrivacy"];
        
    }
    else {
        //定位服务是否可用
        BOOL enable = [CLLocationManager locationServicesEnabled];
        
        //是否具有定位权限
        int status = [CLLocationManager authorizationStatus];
        
        if(!enable || status<3)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法获取你的位置信息"
                                                                message:@"请进入系统的［设置］->［隐私］->［定位服务］中打开定位服务,并允许应用使用定位服务。"
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"立即开启", nil];
            alertView.tag = 1000;
            [alertView show];
            
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
}

@end
