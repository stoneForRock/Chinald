//
//  ZNTLoginVC.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/6.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTLoginVC.h"
#import "NSString+DZCategory.h"
#import "UIView+ZNTHud.h"
#import "CLNetworkingRequestBase.h"
#import "CLLoginRequest.h"

#import <MBProgressHUD.h>
#import "CLUserModel.h"

#define KWeakSelf(type)  __weak typeof(type) weak##type = type

@interface ZNTLoginVC ()
@property (strong, nonatomic) IBOutlet UIButton *codeButton;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) IBOutlet UIButton *voiceCodeButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property(nonatomic, strong)MBProgressHUD *HUD;  //!<
@end

@implementation ZNTLoginVC

INSTANCE_XIB_M(@"Login", ZNTLoginVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginButton.layer.cornerRadius = 22;

    _codeButton.layer.cornerRadius = 3;
    _codeButton.layer.borderColor = [UIColor clDividingLineColor].CGColor;
    _codeButton.layer.borderWidth = 1;
//    _codeButton.layer.opaque = YES;
//    _codeButton.layer.borderColor = [UIColor zntThemeTintColor].CGColor;
    //监听输入框内容变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextChange)name:UITextFieldTextDidChangeNotification object:nil];
//    [self initDataInfo];
//    
//    [self initUI];
    _phoneTextField.text = @"18872830987";
    _codeTextField.text = @"4078";
    
}
- (IBAction)codeButtonClick:(id)sender {
    [self textFieldResginFirstResponder];
    __block UIButton *button = (UIButton *)sender;
    KWeakSelf(self);
    if ([NSString clCheckPhoneNumberLength:_phoneTextField.text]) {
        button.enabled = NO;
        [self.view znt_showHUD:nil];
        [CLLoginRequest userCode:@{@"phone":_phoneTextField.text,@"type":@"0"} complete:^(NSDictionary *resultsObj) {
            button.enabled = YES;

            NSLog(@"获取验证码===%@",resultsObj);
            [self.view znt_hideHUD];
            [weakself startTime];
        } theFailure:^(NSString *errorCode) {
            button.enabled = YES;
            [self.view znt_hideHUD];
            [self.view znt_showToast:errorCode];
        }];
    }else{
        [self.view znt_showToast:@"请输入正确的手机号"];

    }

}

-(void)startTime{
    __block int timeOut = 119;//倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            //倒计时关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                _codeButton.userInteractionEnabled = YES;
                [_codeButton setTitleColor:[UIColor zntThemeTintColor] forState:0];
                [_codeButton setTitle:@"获取短信验证码" forState:0];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                _codeButton.userInteractionEnabled = NO;
                [_codeButton setTitleColor:Color7 forState:0];
                [_codeButton setTitle:[NSString stringWithFormat:@"等待(%ds)",timeOut] forState:0];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}
#pragma mark----------------监听textfield的值的变化
- (void)textFieldTextChange
{
    _codeTextField.text = [_codeTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _phoneTextField.text = [_phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [NSString restrictionInputTextField:_phoneTextField maxNumber:11];
    [NSString restrictionInputTextField:_codeTextField maxNumber:6];
    if (_phoneTextField.text.length == 0 || [_phoneTextField.text isEqualToString:@""]|| _phoneTextField.text == nil) {
        _codeButton.userInteractionEnabled = NO;
        _codeButton.layer.borderColor = [UIColor clDividingLineColor].CGColor;
        [_codeButton setTitleColor:Color6 forState:0];
    }else{
        _codeButton.userInteractionEnabled = YES;
        _codeButton.layer.borderColor = [UIColor zntThemeTintColor].CGColor;
        [_codeButton setTitleColor:[UIColor zntThemeTintColor] forState:0];
    }

}
#pragma mark =========== textField deleget ===========
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.length == 1 && string.length == 0) {
        return YES;
    }else{
        if (textField == _phoneTextField) {
            if (![NSString clCheckNumberInput:string]) {
                return NO;
            }
            if ( textField.text.length >= 11  || textField.text.length + string.length > 11) {
                return NO;
            }
            
        }
        if (textField == _codeTextField){
            if (![NSString clCheckNumberInput:string]) {
                return NO;
            }
            if ( textField.text.length >= 6  || textField.text.length + string.length > 6) {
                return NO;
            }
        }
    }
    return YES;
}
- (IBAction)voiceCodeButtonClick:(id)sender {
    [self textFieldResginFirstResponder];
    UIButton *button = (UIButton *)sender;
    if ([button.titleLabel.text isEqualToString:@"切换语音验证码"]) {
        [button setTitle:@"切换短信验证码" forState:0];
        [_codeButton setTitle:@"获取语音验证码" forState:0];
    }else{
        [button setTitle:@"切换语音验证码" forState:0];
        [_codeButton setTitle:@"获取短信验证码" forState:0];
    }
    
}
- (IBAction)loginButtonClick:(id)sender {
    [self textFieldResginFirstResponder];
    KWeakSelf(self);
    if (![NSString clCheckPhoneNumberLength:_phoneTextField.text]) {
        [self.view znt_showToast:@"请输入正确的手机号"];
        return;
    }
    
        if (_codeTextField.text == nil || _codeTextField.text.length == 0) {
            [self.view znt_showToast:@"请输入验证码"];
            return;
        }
    [self.view znt_showHUD:nil];
    __block UIButton *button = (UIButton *)sender;
    button.enabled = NO;
        [CLLoginRequest userLogin:@{@"phone":_phoneTextField.text,@"code":_codeTextField.text} complete:^(CLUserModel *resultsObj) {
            [self.view znt_hideHUD];
            button.enabled = YES;


            [weakself dismissViewControllerAnimated:YES completion:nil];
            CLUserModel *userModel = [CLUserModel sharedUserModel];
            NSLog(@"userModel.userId是%@",userModel.userId);
            NSLog(@"userModel是%@",userModel.token);
        } theFailure:^(NSString *errorCode) {
            button.enabled = YES;

            [self.view znt_hideHUD];

           [self.view znt_showToast:errorCode];
        }];

}
- (IBAction)tap:(id)sender {
    [self textFieldResginFirstResponder];
}
-(void)textFieldResginFirstResponder{
    [_phoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [self textFieldResginFirstResponder];

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
