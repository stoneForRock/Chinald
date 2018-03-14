//
//  ZNTUser.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTUser.h"

@implementation ZNTUser

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"object.id": @"userId",
                                                       @"token": @"token",
                                                       @"object.phone": @"phone",
                                                       @"object.accountPwd": @"password",
                                                       @"object.name": @"name",
                                                       @"object.pic": @"avatar",
                                                       @"object.accountType": @"accountType",
                                                       @"object.createBy": @"createBy",
                                                       @"object.createTime": @"createTime",
                                                       @"object.custom.area": @"area",
                                                       @"object.custom.code": @"areaCode",
                                                       @"object.custom.codePic": @"areaCodePic",
                                                       @"object.custom.card": @"card",
                                                       @"object.custom.cardPic": @"cardPic",
                                                       @"object.custom.ownerType": @"ownerType",
                                                       @"object.serial": @"serial",
                                                       @"object.status": @"status"
                                                       }];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.accountType forKey:@"accountType"];
    [aCoder encodeObject:self.createBy forKey:@"createBy"];
    [aCoder encodeObject:self.createTime forKey:@"lastUpdateTime"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.area forKey:@"area"];
    [aCoder encodeObject:self.areaCode forKey:@"areaCode"];
    [aCoder encodeObject:self.areaCodePic forKey:@"areaCodePic"];
    [aCoder encodeObject:self.serial forKey:@"serial"];
    [aCoder encodeObject:self.status forKey:@"status"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.userId = [aDecoder decodeObjectForKey:@"userId"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.accountType = [aDecoder decodeObjectForKey:@"accountType"];
        self.createBy = [aDecoder decodeObjectForKey:@"createBy"];
        self.createTime = [aDecoder decodeObjectForKey:@"createTime"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.area = [aDecoder decodeObjectForKey:@"area"];
        self.areaCode = [aDecoder decodeObjectForKey:@"areaCode"];
        self.areaCodePic = [aDecoder decodeObjectForKey:@"areaCodePic"];
        self.serial = [aDecoder decodeObjectForKey:@"serial"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
    }
    return self;
}


@end
