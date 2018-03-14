//
//  ZNTLoginManager+ZNTLogout.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTLoginManager+ZNTLogout.h"
#import "ZNTLoginManager+ZNTEnter.h"

@implementation ZNTLoginManager (ZNTLogout)

- (void)signOut {
    
    [ZNTLoginRequest logoutWithAccountNum:ZNTData_Config.user.phone userType:kUserType onSuccess:^(id  _Nullable responseObject) {
    } onFailure:^(NSError * _Nullable error) {
    }];
    
    [ZNTData_Config clearConfig];
    
    [self enterLoginWithGuideVC:NO];
}

@end
