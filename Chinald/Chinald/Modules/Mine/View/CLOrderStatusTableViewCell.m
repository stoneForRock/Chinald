//
//  CLOrderStatusTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLOrderStatusTableViewCell.h"
@interface CLOrderStatusTableViewCell()
@property(nonatomic, weak)UIImageView *orderStatusImageView;  //!<
@property(nonatomic, weak)UILabel *orderStatusLabel;  //!<订单状态（待付款、待发货、待收货、待评价、售后）
@property(nonatomic, weak)UILabel *orderStatusDetailLabel;  //!<订单状态详情
@property(nonatomic, weak)UILabel *recipientAndPhoneLabel;  //!<收货人及电话
@property(nonatomic, weak)UILabel *recipinetAddressLabel;  //!<收货地址
@end
@implementation CLOrderStatusTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *backgroundImageView = [[UIImageView alloc]init];
        backgroundImageView.image = [UIImage imageNamed:@"bg_indent"];
        [self.contentView addSubview:backgroundImageView];
        [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_offset(0);
            make.right.mas_offset(0);
            make.height.mas_offset(70);
        }];
        //订单状态的图标
        UIImageView *orderStatusImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:orderStatusImageView];
        self.orderStatusImageView = orderStatusImageView;
        [orderStatusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.left.mas_offset(12);
            make.width.mas_offset(19);
            make.height.mas_offset(19);
        }];
        //订单状态的Label
        UILabel *orderStatusLabel = [[UILabel alloc]init];
        orderStatusLabel.font = [UIFont zntFont15];
        orderStatusLabel.textColor = [UIColor zntSubtitleColor];
        [self.contentView addSubview:orderStatusLabel];
        self.orderStatusLabel = orderStatusLabel;
        [orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderStatusImageView.mas_top).with.offset(0);
            make.left.equalTo(orderStatusImageView.mas_right).with.offset(10);
            make.right.mas_offset(-12);
            make.bottom.equalTo(orderStatusImageView.mas_bottom).with.offset(0);
        }];
        
        //订单状态详情的Label
        UILabel *orderStatusDetailLabel = [[UILabel alloc]init];
        orderStatusDetailLabel.font = [UIFont zntFont12];
        orderStatusDetailLabel.textColor = [UIColor zntSubtitleColor];
        [self.contentView addSubview:orderStatusDetailLabel];
        self.orderStatusDetailLabel = orderStatusDetailLabel;
        [orderStatusDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderStatusImageView.mas_bottom).with.offset(11);
            make.left.equalTo(orderStatusImageView.mas_left).with.offset(0);
            make.right.mas_offset(-12);
            make.bottom.equalTo(backgroundImageView.mas_bottom).with.offset(-15);
        }];
        
        //收货人及电话
        UILabel *recipientAndPhoneLabel = [[UILabel alloc]init];
        recipientAndPhoneLabel.font = [UIFont zntFont14];
        recipientAndPhoneLabel.textColor = Color5;
        [self.contentView addSubview:recipientAndPhoneLabel];
        self.recipientAndPhoneLabel = recipientAndPhoneLabel;
        [recipientAndPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backgroundImageView.mas_bottom).with.offset(14);
            make.left.mas_offset(13);
            make.right.mas_offset(-12);
            make.height.mas_offset(15);
        }];
        
        //收货地址
        UILabel *recipinetAddressLabel = [[UILabel alloc]init];
        recipinetAddressLabel.font = [UIFont zntFont13];
        recipinetAddressLabel.textColor = Color6;
        [self.contentView addSubview:recipinetAddressLabel];
        self.recipinetAddressLabel = recipinetAddressLabel;
        [recipinetAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(recipientAndPhoneLabel.mas_bottom).with.offset(12);
            make.left.mas_offset(13);
            make.right.mas_offset(-12);
            make.height.mas_offset(13);
        }];
        
    }
    return self;
}
//刷新数据
-(void)layoutSubviews{
    [super layoutSubviews];
    self.orderStatusImageView.image = [UIImage imageNamed:@"icon_indent_dfk"];
    self.orderStatusLabel.text = @"待付款";
    self.orderStatusDetailLabel.text = @"请在11：59完成支付";
    self.recipientAndPhoneLabel.text = @"他大爷";
    self.recipinetAddressLabel.text = @"广东，广州，天河区，圆圆路8号方方大厦502";
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
