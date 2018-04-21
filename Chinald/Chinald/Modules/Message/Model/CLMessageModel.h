//
//  CLMesageModel.h
//  Chinald
//
//  Created by WPFBob on 2018/4/17.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <JSONModel/JSONModel.h>

typedef NS_ENUM(NSInteger, CLMessageType){
    CL_MESSAGE_VIP = 1, //!<会员通知
    CL_MESSAGE_ORDER, //!<订单通知
    CL_MESSAGE_SYSTEM,//!<系统通知
    CL_MESSAGE_EVA//!<我的评价
};


@interface CLMessageModel : JSONModel
@property(nonatomic, assign)CLMessageType type;   //!<通知类型（1：会员通知，2：订单通知，3：系统通知，4：我的评价默认为1）
@property(nonatomic, copy)NSString *lastTime;  //!<最新通知的时间
@property(nonatomic, copy)NSString *content;  //!<通知内容，过长的时候需要客户端自行根据屏幕宽度裁剪
@end

@interface CLMessageDetailModel : JSONModel
@property(nonatomic, copy)NSString *content;  //!<
@property(nonatomic, copy)NSString *addTime;  //!<
@end
@interface CLMessageDetailRequsetModel : JSONModel
@property(nonatomic, assign)int page;  //!<
@property(nonatomic, assign)int pagesize;  //!<
@property(nonatomic, assign)CLMessageType type;   //!<
@property(nonatomic, copy)NSString *token;
@end
