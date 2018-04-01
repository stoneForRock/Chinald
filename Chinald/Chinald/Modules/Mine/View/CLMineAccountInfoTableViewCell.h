//
//  CLMineAccountInfoTableViewCell.h
//  Chinald
//
//  Created by WPFBob on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MineAccountSelectType) {
    CL_MINE_CHANGE_HEADICON = 0,//!<更换头像
    CL_MINE_ACCOUNT_MANAGEMENT,//!<账户管理
    CL_MINE_AMOUNT,//!<<营业额
    CL_MINE_SAVE_TREE//!<拯救树
};
@interface CLMineAccountInfoTableViewCell : UITableViewCell
@property(nonatomic, strong)void(^selectMineAccountCellBlock)(MineAccountSelectType accountCellSelectType);  //!<
@end
