//
//  CLMessageDetailTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/4/17.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMessageDetailTableViewCell.h"
@interface CLMessageDetailTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *messageContentLabel;

@end
@implementation CLMessageDetailTableViewCell
-(void)layoutSubviews{
    [super layoutSubviews];
    _messageContentLabel.text = _messageDetailModel.content;
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
