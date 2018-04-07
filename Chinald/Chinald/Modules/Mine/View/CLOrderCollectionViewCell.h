//
//  CLOrderCollectionViewCell.h
//  Chinald
//
//  Created by WPFBob on 2018/4/1.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLOrderCollectionViewCell : UICollectionViewCell
@property (copy, nonatomic)void(^orderCellClickBlock)(id orderInfo);

@property(nonatomic, strong) NSMutableArray *ordersArray; //!<订单数据
@end
