//
//  CLAddressModel.h
//  Chinald
//
//  Created by WPFBob on 2018/4/18.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CLAddressModel : JSONModel
@property(nonatomic, copy)NSString *name;  //!<地址名称
@property(nonatomic, copy)NSString *code;  //!<地址代码
@end
