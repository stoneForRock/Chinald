//
//  CLAddressPickerView.h
//  Chinald
//
//  Created by WPFBob on 2018/4/18.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CLAddressPickerView : UIView
@property(nonatomic, copy)NSString *province;  //!<省份
@property(nonatomic, copy)NSString *city;  //!<市
@property(nonatomic, copy)NSString *area;  //!<区
@property(nonatomic, copy)NSString *provinceCode;  //!<省份编码
@property(nonatomic, copy)NSString *cityCode;  //!<市编码
@property(nonatomic, copy)NSString *areaCode;  //!<区编码
@property (copy, nonatomic)void(^selectAddressClickBlock)(void);//!<待发货的回调

-(instancetype)initWithFrame:(CGRect)frame;
-(void)addressPickerView;
@end
