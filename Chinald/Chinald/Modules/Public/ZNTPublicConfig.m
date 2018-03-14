//
//  ZNTPublicConfig.m
//  ICOCShipper
//
//  Created by shichuang on 2017/9/3.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTPublicConfig.h"

NSString * const WECHAT_APPID = @"";

#ifdef DEBUG
NSString * const kGtAppID = @"";
NSString * const kGtAppSecret = @"";
NSString * const kGtAppKey = @"";
NSString * const kGtMasterSecret = @"";
#else
NSString * const kGtAppID = @"";
NSString * const kGtAppSecret = @"";
NSString * const kGtAppKey = @"";
NSString * const kGtMasterSecret = @"";
#endif

// 七牛空间上传
NSString *const  qiNiuAccountSpace = @"account";
NSString *const  qiNiuDeafultSpace = @"default";
NSString *const  qiNiuOrderSpace = @"order";

NSString * const kPushClientId = @"kPushClientId";

NSString * const ZNT_APPNAME = @"华婴圣纸";
#pragma mark - APP BUNDLEID -
NSString *const kAppBundleIdProduct = @"com.HuaYing.Chinald";

#pragma mark - NotificationKey
NSString *const kNFRefreshNotiMsg = @"kNFRefreshNotiMsg";

@implementation ZNTPublicConfig

+ (NSString *)gaodeMapKey {
    return @"";
}

+ (BOOL)isProductMode {
    return [[NSBundle mainBundle].bundleIdentifier isEqualToString:kAppBundleIdProduct];
}

static NSString *version = nil;
+ (NSString *)visibleClientVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)clientVersion {
    if (version == nil) {
        NSArray *array = [[self visibleClientVersion] componentsSeparatedByString:@"."];
        __block NSString *versionString = @"";
        
        for (int i = 0; i < 3; i++) {
            if (i < [array count]) {
                NSString *v = array[i];
                
                if (v.length > 0) {
                    versionString = [versionString stringByAppendingFormat:@"%@.", v];
                    continue;
                }
            }
            versionString = [versionString stringByAppendingFormat:@"%@.", @"0"];
        }
        
        versionString = [versionString substringToIndex:versionString.length - 1];
        
        version = versionString;
    }
    
    return version;
}

+ (NSString *)userAgent {
    NSString *userAgent = [NSString stringWithFormat:@"%@/%@ (%@; %@ %@)", @"kdweibo", [ZNTPublicConfig clientVersion],
                           [[UIDevice currentDevice] model],
                           [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
    
    return userAgent;
}

BOOL validEmail(NSString *email) {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)hasChinese:(NSString *)string {
    BOOL hasChineseOrNot = NO;
    
    for (NSInteger i = 0; i < [string length]; i++) {
        NSInteger a = [string characterAtIndex:i];
        
        if (a > 0x4e00 && a < 0x9fff) {
            hasChineseOrNot = YES;
            break;
        }
    }
    
    return hasChineseOrNot;
}

+ (BOOL)isPhoneNumber:(NSString *)word {
    for (int i = 0; i < [word length]; i++)
    {
        char c = [word characterAtIndex:i];
        if (c >= '0' && c <= '9')
        {
            continue;
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

+ (void)setExtraCellLineHiden:(UITableView *)tableView
{
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end

