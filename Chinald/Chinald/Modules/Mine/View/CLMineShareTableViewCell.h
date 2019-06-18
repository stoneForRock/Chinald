//
//  CLMineShareTableViewCell.h
//  Chinald
//
//  Created by WPFBob on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLMineShareTableViewCell : UITableViewCell
typedef NS_ENUM(NSInteger, ShareQrcodeItemType) {
    CL_MINE_QRCODE = 0,//!<我的二维码
    CL_MINE_SHARE//!<分享给好友
};
@property(nonatomic, strong)void(^selectShareOrMyQrcodeBlock)(ShareQrcodeItemType orderType);  //!<
@end
