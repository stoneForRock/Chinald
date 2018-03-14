//
//  ZNTURLPathManager.h
//  ICOCShipper
//
//  Created by shichuang on 2017/8/31.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const ZNTURLChangeNotification;

typedef NS_ENUM(NSUInteger, ZNTURLType) {
    ZNTURLTypeProduction = 1,//正式环境
    ZNTURLTypeTest = 2,      //测试环境
    ZNTURLTypeDev = 3,       //开发环境
};

#define ZNT_URLPathManager [ZNTURLPathManager sharedURLPathManager]

@interface ZNTURLPathManager : NSObject

@property (assign, nonatomic) ZNTURLType urlType;

+ (instancetype)sharedURLPathManager;

- (NSString *)baseUrl;
- (NSString *)baseUrlWithoutTLS;
- (NSString *)snsapiBaseUrl;
- (NSString *)snsapiBaseUrlWithoutTLS;
@end
