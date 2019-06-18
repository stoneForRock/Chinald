//
//  CLMineAccountInfoTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMineAccountInfoTableViewCell.h"
#import "UIView+CLShadowView.h"
#import "CLUserModel.h"
#import <QuartzCore/QuartzCore.h>
@interface CLMineAccountInfoTableViewCell()
@property (assign, nonatomic)BOOL isLayerAdd;
@property(nonatomic, strong)UIView *amountBackgroundView;  //!<
@property(nonatomic, strong)UILabel *vipNumberLabel;  //!<会员号
@property(nonatomic, strong)UILabel *nicknameLabel;  //!<昵称
@property(nonatomic, strong)UIButton *amountButton;  //!<营业额
@property(nonatomic, strong)UIButton *saveTreeButton;  //!<拯救树
@property(nonatomic, strong)UIImageView *userHeadIcon;  //!<用户头像
@end
@implementation CLMineAccountInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *backgroundImageView = [[UIImageView alloc]init];
        backgroundImageView.image = [UIImage imageNamed:@"bg_indent"];
        [self.contentView addSubview:backgroundImageView];
        [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.left.mas_offset(0);
            make.right.mas_offset(0);
            make.height.mas_offset(160);
        }];
        self.amountBackgroundView = [[UIView alloc]init];
        self.amountBackgroundView.backgroundColor = ThemeBacgroundColor;
        [self.contentView addSubview:self.amountBackgroundView];
        [self.amountBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
            make.left.equalTo(self.contentView.mas_left).with.offset(12);
            make.right.equalTo(self.contentView.mas_right).with.offset(-12);
            make.height.mas_equalTo(64);
        }];
        
        self.amountButton = [[UIButton alloc]init];
        
        [self.amountButton setTitleColor:Color1 forState:0];
        self.amountButton.titleLabel.numberOfLines = 0;
        self.amountButton.titleLabel.font = [UIFont zntFont13];
        [self.amountButton addTarget:self action:@selector(amountButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.amountBackgroundView addSubview:self.amountButton];
        [self.amountButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.amountBackgroundView.mas_top).with.offset(0);
            make.left.equalTo(self.amountBackgroundView.mas_left).with.offset(0);
            make.bottom.equalTo(self.amountBackgroundView.mas_bottom).with.offset(0);
            make.width.mas_equalTo((ScreenFullWidth - 24) / 2.0);
        }];
        [UIView clAddShadowToView:self.amountBackgroundView withOpacity:1 shadowRadius:10 andCornerRadius:12 width:ScreenFullWidth - 24];
        
        self.saveTreeButton = [[UIButton alloc]init];
        [self.saveTreeButton setTitleColor:Color1 forState:0];
        [self.saveTreeButton addTarget:self action:@selector(saveTreeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.saveTreeButton.titleLabel.numberOfLines = 0;
        self.saveTreeButton.titleLabel.font = [UIFont zntFont13];
        [self.amountBackgroundView addSubview:self.saveTreeButton];
        [self.saveTreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.amountBackgroundView.mas_top).with.offset(0);
            make.right.equalTo(self.amountBackgroundView.mas_right).with.offset(0);
            make.bottom.equalTo(self.amountBackgroundView.mas_bottom).with.offset(0);
            make.width.mas_equalTo((ScreenFullWidth - 24) / 2.0);
        }];
        UIView *vLineView = [[UIView alloc]init];
        vLineView.backgroundColor = Color2;
        [self.amountBackgroundView addSubview:vLineView];
        [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.amountBackgroundView.mas_top).with.offset(12);
            make.left.equalTo(self.amountButton.mas_right).with.offset(-0.25);
            make.bottom.equalTo(self.amountBackgroundView.mas_bottom).with.offset(-12);
            make.width.mas_equalTo(0.5);
        }];
        self.userHeadIcon = [[UIImageView alloc]init];
        self.userHeadIcon.layer.cornerRadius = 28;
        self.userHeadIcon.layer.masksToBounds = YES;
        //    self.userHeadIcon.imageView.image = [UIImage imageNamed:@"bg_indent"];
        //    [self.userHeadIcon addTarget:self action:@selector(userHeadIconClick) forControlEvents:UIControlEventTouchUpInside];
        
        //    self.userHeadIcon.backgroundColor = ThemeBacgroundColor;
        [self.contentView addSubview:self.userHeadIcon];
        [self.userHeadIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(17);
            make.top.equalTo(self.contentView.mas_top).with.offset(48);
            make.width.mas_offset(56);
            make.height.mas_offset(56);
        }];
        self.vipNumberLabel = [[UILabel alloc]init];
        self.vipNumberLabel.textColor = ThemeBacgroundColor;
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
        self.nicknameLabel.font = [UIFont zntFont14];
        [self.contentView addSubview:self.nicknameLabel];
        [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).with.offset(85);
            make.top.equalTo(self.contentView.mas_top).with.offset(80);
            make.width.mas_offset(170);
            make.height.mas_offset(15);
        }];
        
        UIView *buttonBackgroundView = [[UIView alloc]init];
        buttonBackgroundView.backgroundColor = [UIColor colorWithHexRGB:@"0xFFFFFF" alpha:0.2];
        //
        
        [self.contentView addSubview:buttonBackgroundView];
        [buttonBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(10);
            make.top.equalTo(self.contentView.mas_top).with.offset(64);
            make.width.mas_offset(95);
            make.height.mas_offset(22);
        }];
        buttonBackgroundView.layer.cornerRadius = 11;
        buttonBackgroundView.layer.borderColor = [UIColor whiteColor].CGColor;
        buttonBackgroundView.layer.borderWidth = 1;
        buttonBackgroundView.layer.masksToBounds = YES;
        
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"icon_more_white"];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-3);
            make.top.equalTo(self.contentView.mas_top).with.offset(68);
            make.width.mas_offset(15);
            make.height.mas_offset(15);
        }];
        UIButton *managementButton = [[UIButton alloc]init];
        managementButton.titleLabel.font = [UIFont zntFont12];
        [managementButton addTarget:self action:@selector(managementButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [managementButton setTitleColor:ThemeBacgroundColor forState:0];
        [managementButton setTitle:@"账户管理" forState:0];
        //        [managementButton setImage:[UIImage imageNamed:@"icon_more_white"] forState:0];
        managementButton.backgroundColor = [UIColor clearColor];
        managementButton.layer.opaque = YES;
        
        [self.contentView addSubview:managementButton];
        [managementButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
            make.top.equalTo(self.contentView.mas_top).with.offset(60);
            make.width.mas_offset(90);
            make.height.mas_offset(31);
        }];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    
    
    CLUserModel *userModel = [CLUserModel sharedUserModel];
    [self.userHeadIcon sd_setImageWithURL:[NSURL URLWithString:userModel.headIcon]];
    self.vipNumberLabel.text = userModel.number;
    self.nicknameLabel.text = userModel.name;
    [self.amountButton setTitle:[NSString stringWithFormat:@"%.2f元\n营业额",userModel.haveSale] forState:0];
    [self.saveTreeButton setTitle:[NSString stringWithFormat:@"%.2f棵\n拯救树",userModel.saveTree] forState:0];
    
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
-(void)userHeadIconClick{
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
    if (!_isLayerAdd) {
        [UIView clAddShadowToView:self.amountBackgroundView withOpacity:1 shadowRadius:10 andCornerRadius:12 width:ScreenFullWidth - 24];
        _isLayerAdd = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
