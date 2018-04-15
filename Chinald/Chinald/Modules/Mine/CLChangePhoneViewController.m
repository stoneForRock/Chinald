//
//  CLChangePhoneViewController.m
//  Chinald
//
//  Created by WPFBob on 2018/3/31.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLChangePhoneViewController.h"
#import "NSString+DZCategory.h"
#import "CLLoginRequest.h"
#import "CLMineNetworking.h"
#define KWeakSelf(type)  __weak typeof(type) weak##type = type

@interface CLChangePhoneViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) IBOutlet UIButton *sendCodeButton;

@end

@implementation CLChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextChange)name:UITextFieldTextDidChangeNotification object:nil];
    _sendCodeButton.layer.borderColor = [UIColor clDividingLineColor].CGColor;

}
- (IBAction)sendCodeButtonClick:(id)sender {
    [self textFieldResginFirstResponder];
    KWeakSelf(self);
    if ([NSString clCheckPhoneNumberLength:_phoneTextField.text]) {
        
        [CLLoginRequest userCode:@{@"phone":_phoneTextField.text,@"type":@"1"} complete:^(NSDictionary *resultsObj) {
            NSLog(@"获取验证码===%@",resultsObj);
            [weakself startTime];
        } theFailure:^(NSString *errorCode) {
            [self.view znt_showToast:errorCode];
        }];
    }else{
        [self.view znt_showToast:@"请输入正确的手机号"];
        
    }

}
-(void)startTime{
    KWeakSelf(self);
    __block int timeOut = 119;//倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            //倒计时关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.sendCodeButton.userInteractionEnabled = YES;
                [weakself.sendCodeButton setTitleColor:[UIColor zntThemeTintColor] forState:0];
                [weakself.sendCodeButton setTitle:@"获取短信验证码" forState:0];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.sendCodeButton.userInteractionEnabled = NO;
                [weakself.sendCodeButton setTitleColor:Color7 forState:0];
                [weakself.sendCodeButton setTitle:[NSString stringWithFormat:@"等待(%ds)",timeOut] forState:0];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}
- (IBAction)savePhoneButtonClick:(id)sender {
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
    [CLMineNetworking userChangePhone:@{@"phone":_phoneTextField.text,@"code":_codeTextField.text} complete:^(NSMutableDictionary *resultsObj) {
        
        [weakself.navigationController popViewControllerAnimated:YES];
    } theFailure:^(NSString *errorCode) {
        [weakself.view znt_showToast:errorCode];
    }];
}

-(void)textFieldTextChange{
    _codeTextField.text = [_codeTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    _phoneTextField.text = [_phoneTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [NSString restrictionInputTextField:_phoneTextField maxNumber:11];
    [NSString restrictionInputTextField:_codeTextField maxNumber:6];
    if (_phoneTextField.text.length == 0 || [_phoneTextField.text isEqualToString:@""]|| _phoneTextField.text == nil) {
        _sendCodeButton.userInteractionEnabled = NO;
        _sendCodeButton.layer.borderColor = [UIColor clDividingLineColor].CGColor;
        [_sendCodeButton setTitleColor:Color6 forState:0];
    }else{
        _sendCodeButton.userInteractionEnabled = YES;
        _sendCodeButton.layer.borderColor = [UIColor zntThemeTintColor].CGColor;
        [_sendCodeButton setTitleColor:[UIColor zntThemeTintColor] forState:0];
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

-(void)textFieldResginFirstResponder{
    [_phoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self textFieldResginFirstResponder];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
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
