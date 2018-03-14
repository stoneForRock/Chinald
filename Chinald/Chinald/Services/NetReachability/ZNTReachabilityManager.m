//
//  ZNTReachabilityManager.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTReachabilityManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

NSString *const ZNTReachabilityDidChangeNotification = @"ZNTReachabilityDidChangeNotification";
NSString *const ZNTReachabilityStatusKey = @"ZNTReachabilityStatusKey";
NSString *const ZNTReachabilityStatusDescriptionKey = @"ZNTReachabilityStatusDescriptionKey";

static NSString *const ZNTDReachabilityStatusUnknownDescription = @"UNKNOWN";
static NSString *const ZNTReachabilityStatusNotReachableDescription = @"NONE";
static NSString *const ZNTReachabilityStatusWiFiDescription = @"WIFI";
static NSString *const ZNTReachabilityStatus4GDescription = @"4G";
static NSString *const ZNTReachabilityStatus3GDescription = @"3G";
static NSString *const ZNTReachabilityStatus2GDescription = @"2G";
static NSString *const ZNTReachabilityStatusGPRSDescription = @"GPRS";

@interface ZNTReachabilityManager()

@end

@implementation ZNTReachabilityManager

+ (instancetype)sharedManager {
    static dispatch_once_t pred;
    static ZNTReachabilityManager *instance = nil;
    
    dispatch_once(&pred, ^{
        instance = [[ZNTReachabilityManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    
    if (self) {}
    return self;
}

- (ZNTReachabilityStatus)reachabilityStatus {
    
    ZNTReachabilityStatus reachabilityStatus = ZNTReachabilityStatusUnknown;
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    AFNetworkReachabilityStatus networkStatus = manager.networkReachabilityStatus;
    
    if (networkStatus == AFNetworkReachabilityStatusReachableViaWiFi) {
        reachabilityStatus = ZNTReachabilityStatusReachableViaWiFi;
    }
    else if (networkStatus == AFNetworkReachabilityStatusReachableViaWWAN) {
        reachabilityStatus = ZNTReachabilityStatusReachableViaWWAN;
    }
    else if (networkStatus == AFNetworkReachabilityStatusNotReachable) {
        reachabilityStatus = ZNTReachabilityStatusNotReachable;
    }
    
    return reachabilityStatus;
}

- (NSString *)reachabilityStatusDescription {
    NSString *reachabilityStatusDescription = ZNTDReachabilityStatusUnknownDescription;
    
    switch (self.reachabilityStatus) {
        case ZNTReachabilityStatusNotReachable:
            reachabilityStatusDescription = ZNTReachabilityStatusNotReachableDescription;
            break;
            
        case ZNTReachabilityStatusReachableViaWWAN:
        {
            CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
            
            if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
                reachabilityStatusDescription = ZNTReachabilityStatusGPRSDescription;
            }
            else if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]) {
                reachabilityStatusDescription = ZNTReachabilityStatus2GDescription;
            }
            else if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                reachabilityStatusDescription = ZNTReachabilityStatus4GDescription;
            }
            else {
                reachabilityStatusDescription = ZNTReachabilityStatus3GDescription;
            }
        }
            break;
            
        case ZNTReachabilityStatusReachableViaWiFi:
            reachabilityStatusDescription = ZNTReachabilityStatusWiFiDescription;
            break;
            
        default:
            break;
    }
    return reachabilityStatusDescription;
}

- (void)startMonitoring {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    __weak __typeof(self) weakSelf = self;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZNTReachabilityDidChangeNotification object:nil userInfo:@{ZNTReachabilityStatusKey : @(weakSelf.reachabilityStatus), ZNTReachabilityStatusDescriptionKey : weakSelf.reachabilityStatusDescription}];
    }];
    
    [manager startMonitoring];
}

- (void)stopMonitoring {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager stopMonitoring];
}

- (BOOL)isReachable {
    return self.reachabilityStatus == ZNTReachabilityStatusReachableViaWWAN || self.reachabilityStatus == ZNTReachabilityStatusReachableViaWiFi;
}

@end
