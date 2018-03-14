//
//  ZNTDataConfig.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNTUser.h"

#define ZNTData_Config [ZNTDataConfig sharedConfig]

/**
 数据配置，包括当前登录用户信息配置
 */
@interface ZNTDataConfig : NSObject

//只要本地保存过就不是第一次登陆应用
@property (nonatomic, strong) ZNTUser *user;

//ZNTDataConfig初始化的时候数据是否可用
@property (assign, nonatomic) BOOL firstProtectedDataAvailable;

+ (ZNTDataConfig *)sharedConfig;

- (void)loadConfig;
- (void)clearConfig;
- (BOOL)saveConfig;

@end
