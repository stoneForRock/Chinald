//
//  CLTheGoodsAddressModel.h
//  Chinald
//
//  Created by WPFBob on 2018/4/10.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CLTheGoodsAddressModel : JSONModel
@property(nonatomic, copy)NSString *address_id;  //!<收货地址id
@property(nonatomic, copy)NSString *name;  //!<收件人姓名
@property(nonatomic, copy)NSString *phone;  //!<收件人电话
@property(nonatomic, copy)NSString *province;  //!<省份
@property(nonatomic, copy)NSString *city;  //!<市
@property(nonatomic, copy)NSString *area;  //!<区
@property(nonatomic, copy)NSString *province_code;  //!<省份编码
@property(nonatomic, copy)NSString *city_code;  //!<市编码
@property(nonatomic, copy)NSString *area_code;  //!<区编码
@property(nonatomic, copy)NSString *detail;  //!<详细地址
@property(nonatomic, copy)NSString *is_default;  //!<是否是默认地址
@end
