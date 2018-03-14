//
//  ZNTReachabilityManager.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, ZNTReachabilityStatus) {
    ZNTReachabilityStatusUnknown = -1,
    ZNTReachabilityStatusNotReachable = 0,
    ZNTReachabilityStatusReachableViaWWAN = 1,
    ZNTReachabilityStatusReachableViaWiFi = 2,
};

/**
 *  [notification userInfo] =
 *
 *  {
 *      ZNTReachabilityStatusKey : reachabilityStatus,
 *      ZNTReachabilityStatusDescriptionKey : reachabilityStatusDescription
 *  }
 *
 */
FOUNDATION_EXPORT NSString *const ZNTReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString *const ZNTReachabilityStatusKey;
FOUNDATION_EXPORT NSString *const ZNTReachabilityStatusDescriptionKey;

@interface ZNTReachabilityManager : NSObject

@property (assign, nonatomic, readonly) ZNTReachabilityStatus reachabilityStatus;
//return WIFI、4G、3G、2G、GPRS、NONE、UNKNOWN
@property (strong, nonatomic, readonly) NSString *reachabilityStatusDescription;

+ (instancetype)sharedManager;

- (void)startMonitoring;
- (void)stopMonitoring;
- (BOOL)isReachable;

@end
