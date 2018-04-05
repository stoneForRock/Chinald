//
//  CLOrderInfoTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/4/3.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLOrderInfoTableViewCell.h"
@interface CLOrderInfoTableViewCell()
@property(nonatomic, weak) UILabel *orderNumberLabel; //!<商品金额
@property(nonatomic, weak) UILabel *orderDateLabel; //!<折扣卷
@property(nonatomic, weak) UILabel *orderStatusLabel; //!<运费
@property(nonatomic, weak) UILabel *payLabel; //!<实付款
@property(nonatomic, weak) UILabel *payTypeLabel; //!<实付款

@end
@implementation CLOrderInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *orderNumberTitleLabel = [[UILabel alloc]init];
        orderNumberTitleLabel.font = [UIFont zntFont14];
        orderNumberTitleLabel.textColor = Color6;
        orderNumberTitleLabel.text = @"订单编号";
        [self.contentView addSubview:orderNumberTitleLabel];
        [orderNumberTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(4);
            make.left.mas_offset(12);
            make.width.mas_offset(100);
            make.height.mas_offset(15);
        }];
        
        UILabel *orderDateTitleLabel = [[UILabel alloc]init];
        orderDateTitleLabel.font = [UIFont zntFont14];
        orderDateTitleLabel.textColor = Color6;
        orderDateTitleLabel.text = @"下单时间";
        [self.contentView addSubview:orderDateTitleLabel];
        [orderDateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderNumberTitleLabel.mas_bottom).with.offset(14);
            make.left.mas_offset(12);
            make.width.mas_offset(100);
            make.height.mas_offset(15);
        }];
        
        UILabel *orderStatusTitleLabel = [[UILabel alloc]init];
        orderStatusTitleLabel.font = [UIFont zntFont14];
        orderStatusTitleLabel.textColor = Color6;
        orderStatusTitleLabel.text = @"订单状态";
        [self.contentView addSubview:orderStatusTitleLabel];
        [orderStatusTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderDateTitleLabel.mas_bottom).with.offset(14);
            make.left.mas_offset(12);
            make.width.mas_offset(100);
            make.height.mas_offset(15);
        }];
        
        UILabel *payTypeTitleLabel = [[UILabel alloc]init];
        payTypeTitleLabel.font = [UIFont zntFont14];
        payTypeTitleLabel.textColor = Color6;
        payTypeTitleLabel.text = @"支付方式";
        [self.contentView addSubview:payTypeTitleLabel];
        [payTypeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderStatusTitleLabel.mas_bottom).with.offset(14);
            make.left.mas_offset(12);
            make.width.mas_offset(100);
            make.height.mas_offset(15);
        }];
        
        //订单信息数据
        UILabel *orderNumberLabel = [[UILabel alloc]init];
        orderNumberLabel.font = [UIFont zntFont14];
        orderNumberLabel.textColor = Color6;
        orderNumberLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:orderNumberLabel];
        self.orderNumberLabel = orderNumberLabel;
        [orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(4);
            make.right.mas_offset(-11);
            make.width.mas_offset(200);
            make.height.mas_offset(15);
        }];
        
        UILabel *orderDateLabel = [[UILabel alloc]init];
        orderDateLabel.font = [UIFont zntFont14];
        orderDateLabel.textAlignment = NSTextAlignmentRight;
        orderDateLabel.textColor = Color6;
        [self.contentView addSubview:orderDateLabel];
        self.orderDateLabel = orderDateLabel;
        [orderDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderNumberLabel.mas_bottom).with.offset(14);
            make.right.mas_offset(-11);
            make.width.mas_offset(200);
            make.height.mas_offset(15);
        }];
        
        UILabel *orderStatusLabel = [[UILabel alloc]init];
        orderStatusLabel.font = [UIFont zntFont14];
        orderStatusLabel.textAlignment = NSTextAlignmentRight;
        orderStatusLabel.textColor = Color6;
        [self.contentView addSubview:orderStatusLabel];
        self.orderStatusLabel = orderStatusLabel;
        [orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderDateLabel.mas_bottom).with.offset(14);
            make.right.mas_offset(-11);
            make.width.mas_offset(200);
            make.height.mas_offset(15);
        }];
        
        UILabel *payTypeLabel = [[UILabel alloc]init];
        payTypeLabel.font = [UIFont zntFont14];
        payTypeLabel.textAlignment = NSTextAlignmentRight;
        payTypeLabel.textColor = Color6;
        [self.contentView addSubview:payTypeLabel];
        self.payTypeLabel = payTypeLabel;
        [payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(orderStatusLabel.mas_bottom).with.offset(14);
            make.right.mas_offset(-11);
            make.width.mas_offset(200);
            make.height.mas_offset(15);
        }];
    }
    return self;
}
//刷新数据
-(void)layoutSubviews{
    [super layoutSubviews];
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
