//
//  ZNTURLPathManager.m
//  ICOCShipper
//
//  Created by shichuang on 2017/8/31.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTURLPathManager.h"

//正式环境
//static NSString *const ZNTURL = @"http://www.chinald.cc";
static NSString *const ZNTURL = @"http://www.yizhimin.com";

//Test
//static NSString *const ZNTURL_TEST = @"http://www.chinald.cc";
static NSString *const ZNTURL_TEST = @"http://www.yizhimin.com";

////Dev
//static NSString *const ZNTURL_Dev = @"http://www.chinald.cc";

static NSString *const ZNTURL_Dev = @"http://www.yizhimin.com";


NSString *const ZNTURLChangeNotification = @"ZNTURLChangeNotification";

//当前环境类型
#define kUrlType @"kUrlType"

@interface ZNTURLPathManager()
@property (strong, nonatomic) NSString *serverBaseUrl;
@end

@implementation ZNTURLPathManager

+ (instancetype)sharedURLPathManager
{
    static dispatch_once_t pred;
    static ZNTURLPathManager *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[ZNTURLPathManager alloc] init];
    });
    return instance;
}

- (NSString *)serverBaseUrl {
    
    if (_serverBaseUrl == nil) {
        switch ([self urlType]) {
            case ZNTURLTypeProduction:
                _serverBaseUrl = ZNTURL;
                break;
                
            case ZNTURLTypeTest:
                _serverBaseUrl = ZNTURL_TEST;
                break;
                
            case ZNTURLTypeDev:
                _serverBaseUrl = ZNTURL_Dev;
                break;
            default:
                _serverBaseUrl = ZNTURL;
                break;
        }
    }
    
    return _serverBaseUrl;
}

- (NSString *)baseUrl {
    return self.serverBaseUrl;
}

- (NSString *)baseUrlWithoutTLS {
    NSString *baseUrl = [self baseUrl];
    if ([baseUrl hasPrefix:@"https"]) {
        return [baseUrl stringByReplacingOccurrencesOfString:@"https" withString:@"http" options:NSAnchoredSearch range:NSMakeRange(0, baseUrl.length)];
    }
    return baseUrl;
}

- (NSString *)snsapiBaseUrl {
    return [self baseUrl];
}

- (NSString *)snsapiBaseUrlWithoutTLS {
    NSString *baseUrl = [self snsapiBaseUrl];
    if ([baseUrl hasPrefix:@"https"]) {
        return [baseUrl stringByReplacingOccurrencesOfString:@"https" withString:@"http" options:NSAnchoredSearch range:NSMakeRange(0, baseUrl.length)];
    }
    return baseUrl;
}

- (ZNTURLType)urlType {
    int type = (int)[[NSUserDefaults standardUserDefaults] integerForKey:kUrlType];
    if (type == 0) {
        //设置默认值
        type = ZNTURLTypeProduction;
        [[NSUserDefaults standardUserDefaults] setInteger:type forKey:kUrlType];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return type;
}

- (void)setUrlType:(ZNTURLType)urlType {
    if (urlType != [self urlType]) {
        _serverBaseUrl = nil;
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:urlType forKey:kUrlType];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ZNTURLChangeNotification object:nil];
}
@end
