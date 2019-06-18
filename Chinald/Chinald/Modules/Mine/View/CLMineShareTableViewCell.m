//
//  CLMineShareTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMineShareTableViewCell.h"

@implementation CLMineShareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)myQrcodeClick:(id)sender {
    if (self.selectShareOrMyQrcodeBlock) {
        self.selectShareOrMyQrcodeBlock(CL_MINE_QRCODE);
    }
}
- (IBAction)shareButtonClick:(id)sender {
    if (self.selectShareOrMyQrcodeBlock) {
        self.selectShareOrMyQrcodeBlock(CL_MINE_SHARE);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
