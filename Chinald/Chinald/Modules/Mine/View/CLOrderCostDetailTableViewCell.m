//
//  CLOrderCostDetailTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/4/3.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLOrderCostDetailTableViewCell.h"
@interface CLOrderCostDetailTableViewCell()
@property(nonatomic, weak) UILabel *goodsAmountLabel; //!<商品金额
@property(nonatomic, weak) UILabel *discountCouponsLabel; //!<折扣卷
@property(nonatomic, weak) UILabel *freightLabel; //!<运费
@property(nonatomic, weak) UILabel *payLabel; //!<实付款
@end
@implementation CLOrderCostDetailTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *goodsAmountTitleLabel = [[UILabel alloc]init];
        goodsAmountTitleLabel.font = [UIFont zntFont14];
        goodsAmountTitleLabel.textColor = Color6;
        goodsAmountTitleLabel.text = @"商品金额";
        [self.contentView addSubview:goodsAmountTitleLabel];
        [goodsAmountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(4);
            make.left.mas_offset(12);
            make.width.mas_offset(100);
            make.height.mas_offset(15);
        }];
        
        UILabel *discountCouponsTitleLabel = [[UILabel alloc]init];
        discountCouponsTitleLabel.font = [UIFont zntFont14];
        discountCouponsTitleLabel.textColor = Color6;
        discountCouponsTitleLabel.text = @"折扣卷";

        [self.contentView addSubview:discountCouponsTitleLabel];
        [discountCouponsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsAmountTitleLabel.mas_bottom).with.offset(14);
            make.left.mas_offset(12);
            make.width.mas_offset(100);
            make.height.mas_offset(15);
        }];
        
        UILabel *freightTitleLabel = [[UILabel alloc]init];
        freightTitleLabel.font = [UIFont zntFont14];
        freightTitleLabel.textColor = Color6;
        freightTitleLabel.text = @"运费";

        [self.contentView addSubview:freightTitleLabel];
        [freightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(discountCouponsTitleLabel.mas_bottom).with.offset(14);
            make.left.mas_offset(12);
            make.width.mas_offset(100);
            make.height.mas_offset(15);
        }];
        

        
        //费用明细数据
        UILabel *goodsAmountLabel = [[UILabel alloc]init];
        goodsAmountLabel.font = [UIFont zntFont14];
        goodsAmountLabel.textColor = Color6;
        goodsAmountLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:goodsAmountLabel];
        self.goodsAmountLabel = goodsAmountLabel;
        [goodsAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(4);
            make.right.mas_offset(-11);
            make.width.mas_offset(200);
            make.height.mas_offset(15);
        }];
        
        UILabel *discountCouponsLabel = [[UILabel alloc]init];
        discountCouponsLabel.font = [UIFont zntFont14];
        discountCouponsLabel.textAlignment = NSTextAlignmentRight;
        discountCouponsLabel.textColor = Color6;
        [self.contentView addSubview:discountCouponsLabel];
        self.discountCouponsLabel = discountCouponsLabel;
        [discountCouponsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsAmountLabel.mas_bottom).with.offset(14);
            make.right.mas_offset(-11);
            make.width.mas_offset(200);
            make.height.mas_offset(15);
        }];
        
        UILabel *freightLabel = [[UILabel alloc]init];
        freightLabel.font = [UIFont zntFont14];
        freightLabel.textAlignment = NSTextAlignmentRight;
        freightLabel.textColor = Color6;
        [self.contentView addSubview:freightLabel];
        self.freightLabel = freightLabel;
        [freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(discountCouponsLabel.mas_bottom).with.offset(14);
            make.right.mas_offset(-11);
            make.width.mas_offset(200);
            make.height.mas_offset(15);
        }];
        
        UIView *vLineView = [[UIView alloc]init];
        vLineView.backgroundColor = CLLineColor;
        [self.contentView addSubview:vLineView];
        [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(freightLabel.mas_bottom).with.offset(14);
            make.left.mas_offset(12);
            make.right.mas_offset(-12);
            make.height.mas_offset(0.5);
        }];
        
        UILabel *payLabel = [[UILabel alloc]init];
        payLabel.font = [UIFont zntFont15];
        payLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:payLabel];
        self.payLabel = payLabel;
        [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(vLineView.mas_bottom).with.offset(0);
            make.left.mas_offset(24);
            make.right.mas_offset(-24);
            make.bottom.mas_offset(0);
        }];
    }
    return self;
}
//刷新数据
-(void)layoutSubviews{
    [super layoutSubviews];
    self.payLabel.text = @"实付款：￥89.00";
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
