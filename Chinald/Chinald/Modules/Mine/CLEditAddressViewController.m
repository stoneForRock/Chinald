//
//  CLEditAddressViewController.m
//  Chinald
//
//  Created by WPFBob on 2018/4/11.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLEditAddressViewController.h"
#import "NSString+DZCategory.h"
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


}
#pragma mark =========== 输入textField、textView内容改变监听 ===========
-(void)textFieldChange{
    [NSString restrictionInputTextField:_forGoodsUserNameTextField maxNumber:11];
    [NSString restrictionInputTextField:_forGoodsUserNameTextField maxNumber:30];
    _addressModel.name = _forGoodsUserNameTextField.text;
    _addressModel.phone = _forGoodsUserNameTextField.text;
}

-(void)textViewChange{
    [NSString restrictionInputTextView:_detailAddressTextView maxNumber:100];
    _addressModel.detail = _detailAddressTextView.text;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length == 1 && string.length == 0) {
        return YES;
    }else{
        if (textField == _forGoodsUserNameTextField) {
            [NSString restrictionInputTextField:_forGoodsUserNameTextField maxNumber:30];
        }
        if (textField == _forGoodsUserPhoneTextField) {
            if (![NSString clCheckPhoneNumberLength:_forGoodsUserPhoneTextField.text]) {
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
