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
-(void)layoutSubviews{
    [super layoutSubviews];
    NSArray *imageArray = @[@"icon_news_mem",@"icon_news_ind",@"icon_news_sys",@"img_none_eva"];
    NSArray *messageName = @[@"会员通知",@"订单通知",@"系统通知",@"我的评价"];

    self.messageTItleImage.image = [UIImage imageNamed:imageArray[self.messageModel.type - 1]];
    self.messageTypeTitle.text = messageName[self.messageModel.type - 1];
    self.messageTimeLabel.text = self.messageModel.lastTime;
    self.messageContentLabel.text = self.messageModel.content;
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
