//
//  CLMineOrderAboutTableViewCell.h
//  Chinald
//
//  Created by WPFBob on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLOrderOperationItem.h"
@interface CLMineOrderAboutTableViewCell : UITableViewCell
@property(nonatomic, strong)void(^selectOrderTypeBlock)(NSInteger orderType);  //!<

@end
