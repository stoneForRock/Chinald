//
//  CLAddressTableViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/4/10.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLAddressTableViewCell.h"
#import "NSString+DZCategory.h"
@interface CLAddressTableViewCell()
@property (strong, nonatomic) IBOutlet UILabel *forGoodsUserNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *forGoodsUserPhoneLabel;
@property (strong, nonatomic) IBOutlet UILabel *forGoodsAddressLabel;
@property (strong, nonatomic) IBOutlet UIButton *setDefaultButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *forGoodsAddressLabelHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *forGoodsUserNameLabelWidth;

@end
@implementation CLAddressTableViewCell
-(void)layoutSubviews{
    [super layoutSubviews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CGSize forGoodsUserNameLabeSize = [self.goodsAddressModel.name kd_sizeForMaxWidth:ScreenFullWidth - 100 font:[UIFont zntFont14] numberOfLines:1];
    self.forGoodsUserNameLabelWidth.constant = forGoodsUserNameLabeSize.width;
    self.forGoodsUserNameLabel.text = self.goodsAddressModel.name;
    self.forGoodsUserPhoneLabel.text = self.goodsAddressModel.phone;
    
    NSString *forGoodsAddressDetailString = [NSString stringWithFormat:@"%@,%@,%@,%@",self.goodsAddressModel.province,self.goodsAddressModel.city,self.goodsAddressModel.area,self.goodsAddressModel.detail];
    
    CGSize forGoodsAddressLabelSize = [forGoodsAddressDetailString kd_sizeForMaxWidth:ScreenFullWidth - 26 font:[UIFont zntFont13]];
    self.forGoodsAddressLabelHeight.constant = forGoodsAddressLabelSize.height;
    self.forGoodsAddressLabel.text = forGoodsAddressDetailString;
    //是否是默认的收货地址
    if (self.goodsAddressModel.isDefault) {
        [self.setDefaultButton setImage:[UIImage imageNamed:@"icon_address_default"] forState:0];
    }else{
        [self.setDefaultButton setImage:[UIImage imageNamed:@"icon_address_no_default"] forState:0];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//
- (IBAction)setAddressDefaultButtonClick:(id)sender {
    if (self.selectForGoodsAddresCellBlock) {
        self.selectForGoodsAddresCellBlock(CL_ADDRESS_DEFAULT, self.goodsAddressModel);
    }
}
- (IBAction)editAddressButtonClick:(id)sender {
    if (self.selectForGoodsAddresCellBlock) {
        self.selectForGoodsAddresCellBlock(CL_ADDRESS_EDIT, self.goodsAddressModel);
    }
}
- (IBAction)deleteAddressButtonClick:(id)sender {
    if (self.selectForGoodsAddresCellBlock) {
        self.selectForGoodsAddresCellBlock(CL_ADDRESS_DELETE, self.goodsAddressModel);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
