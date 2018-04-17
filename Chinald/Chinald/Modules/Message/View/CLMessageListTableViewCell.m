//
//  CLMessageListTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/4/17.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMessageListTableViewCell.h"
@interface CLMessageListTableViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *messageTItleImage;
@property (strong, nonatomic) IBOutlet UILabel *messageTypeTitle;
@property (strong, nonatomic) IBOutlet UILabel *messageTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageContentLabel;

@end
@implementation CLMessageListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
