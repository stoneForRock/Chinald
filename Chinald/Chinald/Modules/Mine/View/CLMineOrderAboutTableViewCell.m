//
//  CLMineOrderAboutTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMineOrderAboutTableViewCell.h"
#import "UIButton+CLButton.h"
@interface CLMineOrderAboutTableViewCell()
@property (strong, nonatomic) IBOutlet UIButton *obligationButton;
@property (strong, nonatomic) IBOutlet UIButton *noReceiveButton;
@property (strong, nonatomic) IBOutlet UIButton *noEvaluateOrderButton;
@property (strong, nonatomic) IBOutlet UIButton *saleServiceButton;

@end
@implementation CLMineOrderAboutTableViewCell
-(void)layoutSubviews{
    [super layoutSubviews];
    [UIButton imageUpTextDownWithButton:self.obligationButton TextFont:13];
    [UIButton imageUpTextDownWithButton:self.noReceiveButton TextFont:13];
    [UIButton imageUpTextDownWithButton:self.noEvaluateOrderButton TextFont:13];
    [UIButton imageUpTextDownWithButton:self.saleServiceButton TextFont:13];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
