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
@property (strong, nonatomic) IBOutlet UIButton *forPayButton;
@property (strong, nonatomic) IBOutlet UIButton *noReceiveButton;
@property (strong, nonatomic) IBOutlet UIButton *noEvaluateOrderButton;
@property (strong, nonatomic) IBOutlet UIButton *saleServiceButton;

@end
@implementation CLMineOrderAboutTableViewCell
-(void)layoutSubviews{
    [super layoutSubviews];
    [UIButton imageUpTextDownWithButton:self.forPayButton TextFont:13];
    [UIButton imageUpTextDownWithButton:self.noReceiveButton TextFont:13];
    [UIButton imageUpTextDownWithButton:self.noEvaluateOrderButton TextFont:13];
    [UIButton imageUpTextDownWithButton:self.saleServiceButton TextFont:13];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)forPayButtonClick:(id)sender {
    if (self.selectOrderTypeBlock) {
        self.selectOrderTypeBlock(1);
    }
}
- (IBAction)forReceiveButtonClick:(id)sender {
    if (self.selectOrderTypeBlock) {
        self.selectOrderTypeBlock(2);
    }

}
- (IBAction)forEvaluateButtonClick:(id)sender {
    if (self.selectOrderTypeBlock) {
        self.selectOrderTypeBlock(3);
    }

}
- (IBAction)saleServiceButtonClick:(id)sender {
    if (self.selectOrderTypeBlock) {
        self.selectOrderTypeBlock(4);
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
