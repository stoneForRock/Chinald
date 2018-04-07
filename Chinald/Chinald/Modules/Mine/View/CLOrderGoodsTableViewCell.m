//
//  CLOrderGoodsTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/4/3.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLOrderGoodsTableViewCell.h"
@interface CLOrderGoodsTableViewCell()
@property(nonatomic, weak)UIImageView *goodsImageView;  //!<商品图片
@property(nonatomic, weak)UILabel *goodsNameLabel;  //!<商品名称
@property(nonatomic, weak)UILabel *goodsNumberLabel;  //!<商品数量
@property(nonatomic, weak)UILabel *goodsAmountLabel;  //!<商品单价
@end
@implementation CLOrderGoodsTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *goodsImageView = [[UIImageView alloc]init];

        [self.contentView addSubview:goodsImageView];
        [goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.left.mas_offset(12);
            make.width.mas_offset(80);
            make.height.mas_offset(80);
        }];
        self.goodsImageView = goodsImageView;
        
        UILabel *goodsNameLabel = [[UILabel alloc]init];
        goodsNameLabel.font = [UIFont zntFont14];
        goodsNameLabel.textColor = Color5;

        [self.contentView addSubview:goodsNameLabel];
        self.goodsNameLabel = goodsNameLabel;
        [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsImageView.mas_top).with.offset(4);
            make.left.equalTo(goodsImageView.mas_right).with.offset(13);
            make.right.mas_offset(-12);
            make.height.mas_offset(16);
        }];
        
        UILabel *goodsNumberLabel = [[UILabel alloc]init];
        goodsNumberLabel.font = [UIFont zntFont14];
        goodsNumberLabel.textColor = Color7;

        [self.contentView addSubview:goodsNumberLabel];
        self.goodsNumberLabel = goodsNumberLabel;
        [goodsNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(goodsNameLabel.mas_bottom).with.offset(15);
            make.left.equalTo(goodsImageView.mas_right).with.offset(13);
            make.right.mas_offset(-12);
            make.height.mas_offset(13);
        }];
        
        UILabel *goodsAmountLabel = [[UILabel alloc]init];
        goodsAmountLabel.font = [UIFont zntFont12];
        goodsAmountLabel.textColor = Color5;


        [self.contentView addSubview:goodsAmountLabel];
        self.goodsAmountLabel = goodsAmountLabel;
        
        [goodsAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(goodsImageView.mas_right).with.offset(13);
            make.right.mas_offset(-12);
            make.height.mas_offset(14);
            make.bottom.equalTo(goodsImageView.mas_bottom).with.offset(-4);

        }];
    }
    return self;
}
//刷新数据
-(void)layoutSubviews{
    [super layoutSubviews];
    self.goodsImageView.image = [UIImage imageNamed:@"icon_aft_call"];
    self.goodsNameLabel.text = @"Chinald圣纸抽纸（20包/箱）";
    self.goodsNumberLabel.text = @"x1";
    self.goodsAmountLabel.text = @"109.00";
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
