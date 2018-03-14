//
//  ZNTUser.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ZNTUser : JSONModel<NSCoding>

@property (nonatomic, copy) NSString<Optional> *userId;
@property (nonatomic, copy) NSString<Optional> *token;
@property (nonatomic, copy) NSString<Optional> *phone;
@property (nonatomic, copy) NSString<Optional> *password;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *avatar;
@property (nonatomic, copy) NSString<Optional> *accountType;
@property (nonatomic, copy) NSString<Optional> *createBy;
@property (nonatomic, copy) NSString<Optional> *createTime;
@property (nonatomic, copy) NSString<Optional> *area;
@property (nonatomic, copy) NSString<Optional> *areaCode;
@property (nonatomic, copy) NSString<Optional> *areaCodePic;
@property (nonatomic, copy) NSString<Optional> *card;
@property (nonatomic, copy) NSString<Optional> *cardPic;
@property (nonatomic, copy) NSString<Optional> *ownerType;
@property (nonatomic, copy) NSString<Optional> *serial;
@property (nonatomic, copy) NSString<Optional> *status;
@end
