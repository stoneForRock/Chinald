//
//  UIDevice+ZNTAdd.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "UIDevice+ZNTAdd.h"

#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice (ZNTAdd)


+ (UIDeviceType)currentDeviceType {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //iPad
        if ([self isHighResolutionDevice]) {
            return UIDeviceType_iPadRetina;
        }
        return UIDeviceType_iPadStandard;
    }
    else {
        //iPhone
        if ([self isHighResolutionDevice]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            if (result.height > 1334.0f) {
                return UIDeviceType_iPhone6Plus;//2208
            }
            else if (result.height > 1136.0f) {
                return UIDeviceType_iPhone6;//1334
            }
            else if (result.height > 960.0f) {
                return UIDeviceType_iPhone5;//1136
            }
            else {
                return UIDeviceType_iPhoneRetina;//960
            }
        }
        
        return UIDeviceType_iPhoneStandard;
    }
    
}

+ (BOOL)isRunningOveriPhone5 {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] >= UIDeviceType_iPhone5;
    }
    return NO;
}

+ (BOOL)isRunningOveriPhone6 {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] >= UIDeviceType_iPhone6;
    }
    return NO;
}

+ (BOOL)isRunningAtiPhone6Plus {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] == UIDeviceType_iPhone6Plus;
    }
    return NO;
}

+ (BOOL)isRunningAtiPhone6 {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return [self currentDeviceType] == UIDeviceType_iPhone6;
    }
    return NO;
}


+ (BOOL)isiPadDevice {
    return UIUserInterfaceIdiomPad == [UIDevice currentDevice].userInterfaceIdiom;
}

+ (BOOL)isiPhoneDevice {
    return UIUserInterfaceIdiomPhone == [UIDevice currentDevice].userInterfaceIdiom;
}

+ (BOOL)isHighResolutionDevice {
    return ([UIScreen mainScreen].scale + 0.01) > 2.0;
}

+ (BOOL)isAboveiOSVersion:(float)version
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= version;
}

+ (NSString *)platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

/**
 *得到本机现在用的语言
 * en-CN 或en  英文  zh-Hans-CN或zh-Hans  简体中文   zh-Hant-CN或zh-Hant  繁体中文    ja-CN或ja  日本  ......
 */
+ (NSString*)getPreferredLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}


@end
