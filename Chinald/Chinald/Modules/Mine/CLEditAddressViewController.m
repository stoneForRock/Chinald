//
//  CLEditAddressViewController.m
//  Chinald
//
//  Created by WPFBob on 2018/4/11.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLEditAddressViewController.h"
#import "NSString+DZCategory.h"
#import "CLTheGoodsAddressModel.h"
#import "CLMineNetworking.h"
#import "UIView+ZNTHud.h"
#define KWeakSelf(type)  __weak typeof(type) weak##type = type

@interface CLEditAddressViewController ()
@property (strong, nonatomic) IBOutlet UITextField *forGoodsUserNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *forGoodsUserPhoneTextField;
@property (strong, nonatomic) IBOutlet UIButton *selectCityButton;
@property (strong, nonatomic) IBOutlet UITextView *detailAddressTextView;
@property (strong, nonatomic) IBOutlet UIButton *changeDefaultButton;

@end

@implementation CLEditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewChange) name:UITextViewTextDidChangeNotification object:nil];
    self.navigationItem.title = @"编辑收货地址";

    if (_addressOperationType == CL_EDIT_ADDRESS_ADD) {
        _addressModel = [[CLTheGoodsAddressModel alloc]init];
    }

}
#pragma mark =========== 输入textField、textView内容改变监听 ===========
-(void)textFieldChange{
    NSCharacterSet  *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    [NSString restrictionInputTextField:_forGoodsUserNameTextField maxNumber:30];
    [NSString restrictionInputTextField:_forGoodsUserPhoneTextField maxNumber:11];
    _addressModel.name = _forGoodsUserNameTextField.text;
    _addressModel.name = [_addressModel.name stringByTrimmingCharactersInSet:set];
    _addressModel.phone = _forGoodsUserPhoneTextField.text;
}

-(void)textViewChange{
    NSCharacterSet  *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];

    [NSString restrictionInputTextView:_detailAddressTextView maxNumber:100];
    _addressModel.detail = _detailAddressTextView.text;
    _addressModel.detail = [_addressModel.detail stringByTrimmingCharactersInSet:set];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length == 1 && string.length == 0) {
        return YES;
    }else{
        if (textField == _forGoodsUserNameTextField) {
            [NSString restrictionInputTextField:_forGoodsUserNameTextField maxNumber:30];
        }
        if (textField == _forGoodsUserPhoneTextField) {
            if (![NSString clCheckNumberInput:_forGoodsUserPhoneTextField.text]) {
                return NO;
            }

        }
    }
    return YES;
}
- (IBAction)selectCityButtonClick:(id)sender {
}
- (IBAction)changeDefaultButtonClick:(id)sender {
    _addressModel.isDefault = !_addressModel.isDefault;
}
- (IBAction)saveAddressButtonClick:(id)sender {
    if (_addressModel.name == nil || _addressModel.name.length == 0) {
        [self.view znt_showToast:@"请输入收货人真实姓名"];
        return;
    }
    if (![NSString clCheckPhoneNumberLength:_addressModel.phone]) {
        [self.view znt_showToast:@"请输入11位手机号"];
        return;
    }
    if (_addressModel.detail == nil || _addressModel.detail.length == 0) {
        [self.view znt_showToast:@"请填写详细地址"];
        return;
    }
    KWeakSelf(self);
    [CLMineNetworking addressAdd:_addressModel complete:^(NSMutableDictionary *resultsObj) {
        [weakself.navigationController popViewControllerAnimated:YES];
    } theFailure:^(NSString *errorCode) {
        [weakself.view znt_showToast:errorCode];
    }];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
