//
//  ZNTLaunchManager.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTLaunchManager.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
//踢出登陆延时
static CGFloat afterTime = 0;

@implementation ZNTLaunchManager

+ (void)didFinishLaunching
{
    [self showHubLaunchImage];
}

+ (void)showHubLaunchImage
{
    NSString *launchImageName = @"LaunchImage";
    __block UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    launchImageView.userInteractionEnabled = YES;
    launchImageView.image = [UIImage imageNamed:launchImageName];
    [[AppDelegate getAppDelegate].window addSubview:launchImageView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [launchImageView removeFromSuperview];
        launchImageView = nil;
    });
}


+ (CGFloat)afterTime
{
    return afterTime;
}

+ (void)setAfterTime:(CGFloat)nAfterTime
{
    afterTime = nAfterTime;
}


@end
