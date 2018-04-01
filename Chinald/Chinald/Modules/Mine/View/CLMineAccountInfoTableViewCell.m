//
//  CLMineAccountInfoTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMineAccountInfoTableViewCell.h"
#import "UIView+CLShadowView.h"
@interface CLMineAccountInfoTableViewCell()
@property(nonatomic, strong)UILabel *vipNumberLabel;  //!<会员号
@property(nonatomic, strong)UILabel *nicknameLabel;  //!<昵称
@property(nonatomic, strong)UIButton *amountButton;  //!<营业额
@property(nonatomic, strong)UIButton *saveTreeButton;  //!<拯救树
@property(nonatomic, strong)UIButton *userHeadIconButton;  //!<用户头像
@end
@implementation CLMineAccountInfoTableViewCell
-(void)layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIImageView *backgroundImageView = [[UIImageView alloc]init];
    backgroundImageView.image = [UIImage imageNamed:@"bg_indent"];
    [self.contentView addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(160);
    }];
    
    UIView *amountBackgroundView = [[UIView alloc]init];
    amountBackgroundView.backgroundColor = ThemeBacgroundColor;
    [self.contentView addSubview:amountBackgroundView];
    [amountBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
        make.left.equalTo(self.contentView.mas_left).with.offset(12);
        make.right.equalTo(self.contentView.mas_right).with.offset(-12);
        make.height.mas_equalTo(64);
    }];
    [UIView clAddShadowToView:amountBackgroundView withOpacity:1 shadowRadius:10 andCornerRadius:12 width:ScreenFullWidth - 24];
    
    self.amountButton = [[UIButton alloc]init];
    [self.amountButton setTitle:@"0.00元\n营业额" forState:0];
    [self.amountButton setTitleColor:Color1 forState:0];
    self.amountButton.titleLabel.numberOfLines = 0;
    self.amountButton.titleLabel.font = [UIFont zntFont13];
    [self.amountButton addTarget:self action:@selector(amountButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [amountBackgroundView addSubview:self.amountButton];
    [self.amountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(amountBackgroundView.mas_top).with.offset(0);
        make.left.equalTo(amountBackgroundView.mas_left).with.offset(0);
        make.bottom.equalTo(amountBackgroundView.mas_bottom).with.offset(0);
        make.width.mas_equalTo((ScreenFullWidth - 24) / 2.0);
    }];
    
    self.saveTreeButton = [[UIButton alloc]init];
    [self.saveTreeButton setTitle:@"0.00棵\n拯救树" forState:0];
    [self.saveTreeButton setTitleColor:Color1 forState:0];
    [self.saveTreeButton addTarget:self action:@selector(saveTreeButtonClick) forControlEvents:UIControlEventTouchUpInside];

    self.saveTreeButton.titleLabel.numberOfLines = 0;
    self.saveTreeButton.titleLabel.font = [UIFont zntFont13];
    [amountBackgroundView addSubview:self.saveTreeButton];
    [self.saveTreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(amountBackgroundView.mas_top).with.offset(0);
        make.right.equalTo(amountBackgroundView.mas_right).with.offset(0);
        make.bottom.equalTo(amountBackgroundView.mas_bottom).with.offset(0);
        make.width.mas_equalTo((ScreenFullWidth - 24) / 2.0);
    }];
    UIView *vLineView = [[UIView alloc]init];
    vLineView.backgroundColor = Color2;
    [amountBackgroundView addSubview:vLineView];
    [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(amountBackgroundView.mas_top).with.offset(12);
        make.left.equalTo(self.amountButton.mas_right).with.offset(-0.25);
        make.bottom.equalTo(amountBackgroundView.mas_bottom).with.offset(-12);
        make.width.mas_equalTo(0.5);
    }];
    self.userHeadIconButton = [[UIButton alloc]init];
    self.userHeadIconButton.layer.cornerRadius = 28;
    self.userHeadIconButton.layer.masksToBounds = YES;
    self.userHeadIconButton.imageView.image = [UIImage imageNamed:@"bg_indent"];
    [self.userHeadIconButton addTarget:self action:@selector(userHeadIconButtonClick) forControlEvents:UIControlEventTouchUpInside];

    self.userHeadIconButton.backgroundColor = ThemeBacgroundColor;
    [self.contentView addSubview:self.userHeadIconButton];
    [self.userHeadIconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(17);
        make.top.equalTo(self.contentView.mas_top).with.offset(48);
        make.width.mas_offset(56);
        make.height.mas_offset(56);
    }];
    self.vipNumberLabel = [[UILabel alloc]init];
    self.vipNumberLabel.textColor = ThemeBacgroundColor;
    self.vipNumberLabel.text = @"会员号：020202";
    self.vipNumberLabel.font = [UIFont zntFont14];
    [self.contentView addSubview:self.vipNumberLabel];
    [self.vipNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(85);
        make.top.equalTo(self.contentView.mas_top).with.offset(55);
        make.width.mas_offset(170);
        make.height.mas_offset(15);
    }];
    
    self.nicknameLabel = [[UILabel alloc]init];
    self.nicknameLabel.textColor = ThemeBacgroundColor;
    self.nicknameLabel.text = @"hahahahha";
    self.nicknameLabel.font = [UIFont zntFont14];
    [self.contentView addSubview:self.nicknameLabel];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(85);
        make.top.equalTo(self.contentView.mas_top).with.offset(80);
        make.width.mas_offset(170);
        make.height.mas_offset(15);
    }];
    
    UIButton *managementButton = [[UIButton alloc]init];
    managementButton.titleLabel.font = [UIFont zntFont12];
    [managementButton addTarget:self action:@selector(managementButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [managementButton setTitleColor:ThemeBacgroundColor forState:0];
    [managementButton setTitle:@"账户管理" forState:0];
    managementButton.backgroundColor = Color5;
    [self.contentView addSubview:managementButton];
    [managementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(60);
        make.width.mas_offset(70);
        make.height.mas_offset(31);
    }];
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:managementButton.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(27, 27)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
////    maskLayer.backgroundColor = ThemeBacgroundColor.CGColor;
//    maskLayer.frame = managementButton.bounds;
//    CGRectMake(managementButton.frame.origin.x - 1.5, managementButton.frame.origin.y - 1.5, managementButton.bounds.size.width + 1.5, managementButton.bounds.size.height + 1.5);
    
//    maskLayer.path = maskPath.CGPath;
//    managementButton.layer.mask = maskLayer;
}
-(void)amountButtonClick{
    if (self.selectMineAccountCellBlock) {
        self.selectMineAccountCellBlock(CL_MINE_AMOUNT);
    }
}
-(void)saveTreeButtonClick{
    if (self.selectMineAccountCellBlock) {
        self.selectMineAccountCellBlock(CL_MINE_SAVE_TREE);
    }
}
-(void)userHeadIconButtonClick{
    if (self.selectMineAccountCellBlock) {
        self.selectMineAccountCellBlock(CL_MINE_CHANGE_HEADICON);
    }
}
-(void)managementButtonClick{
    if (self.selectMineAccountCellBlock) {
        self.selectMineAccountCellBlock(CL_MINE_ACCOUNT_MANAGEMENT);
    }
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
