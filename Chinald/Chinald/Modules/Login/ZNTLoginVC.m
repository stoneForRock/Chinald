//
//  ZNTLoginVC.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/6.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTLoginVC.h"
#import "KDInputView.h"
#import "ZNTThemeButton.h"
#import "ZNTLoginManager.h"
#import "ZNTRegisterVC.h"
#import "ZNTGetCodeVC.h"
#import "NSString+DZCategory.h"



@interface ZNTLoginVC ()
@property (strong, nonatomic) IBOutlet UIButton *codeButton;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) IBOutlet UIButton *voiceCodeButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;

@property (strong, nonatomic) IBOutlet UIButton *loginButton;

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
    
}
- (IBAction)codeButtonClick:(id)sender {
    [self textFieldResginFirstResponder];
    if ([NSString clCheckPhoneNumberLength:_phoneTextField.text]) {
        
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
    if ([NSString clCheckPhoneNumberLength:_phoneTextField.text]) {
        
    }
}
- (IBAction)tap:(id)sender {
    [self textFieldResginFirstResponder];
}
-(void)textFieldResginFirstResponder{
    [_phoneTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
}
//- (void)initUI {
//    
//    self.title = @"登录";
//    
//    [self setupViews];
//    [self make_mas];
//}
//
//- (void)setupViews {
//    
//    [self.view addSubview:self.phoneInputView];
//    [self.view addSubview:self.passwordInpuView];
//    [self.view addSubview:self.loginBtn];
//    [self.view addSubview:self.registBtn];
//    [self.view addSubview:self.forgetPswBtn];
//    
//}
//
//- (void)make_mas {
//    [self.phoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
//        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
//        make.top.mas_equalTo(145);
//        make.height.mas_equalTo(45);
//    }];
//    
//    // inputViewPassword
//    [self.passwordInpuView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
//        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
//        make.top.equalTo(self.phoneInputView.mas_bottom).with.offset(8);
//        make.height.mas_equalTo(45);
//    }];
//    
//    // buttonLogin
//    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
//        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
//        make.top.equalTo(self.passwordInpuView.mas_bottom).with.offset(74);
//        make.height.mas_equalTo(44);
//    }];
//    
//    // registBtn
//    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3] + 9);
//        make.top.equalTo(self.passwordInpuView.mas_bottom).with.offset(15);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(80);
//    }];
//    
//    // forgetPswBtn
//    [self.forgetPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3] - 9);
//        make.top.equalTo(self.passwordInpuView.mas_bottom).with.offset(15);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(60);
//    }];
//    
//}
//
//- (void)initDataInfo {
//    
//}
//
//- (void)loginClick:(UIButton *)sender {
//    [self.view znt_showHUD:@"请稍候..."];
//    
//    [[ZNTLoginManager sharedManager] userLoginWithPhone:self.phoneInputView.textFieldMain.text password:self.passwordInpuView.textFieldMain.text completed:^(BOOL success, NSUInteger errorCode, NSString *error, id userInfo) {
//        [self.view znt_hideHUD];
//        if (!success) {
//            [self.view znt_showToast:error];
//        }
//        
//    }];
//    
//}
//
//- (void)registAction:(UIButton *)sender {
//    ZNTRegisterVC *registVC = [ZNTRegisterVC instanceFromXib];
//    if (self.passwordInpuView.textFieldMain.text.length > 0) {
//        registVC.user = [[ZNTUser alloc] init];
//        registVC.user.phone = self.passwordInpuView.textFieldMain.text;
//    }
//    [self.navigationController pushViewController:registVC animated:YES];
//}
//
//- (void)forgetAction:(UIButton *)sender {
//    ZNTGetCodeVC *forgetPswVC = [ZNTGetCodeVC instanceFromXib];
//    if (self.passwordInpuView.textFieldMain.text.length > 0) {
//        forgetPswVC.user = [[ZNTUser alloc] init];
//        forgetPswVC.user.phone = self.passwordInpuView.textFieldMain.text;
//    }
//    [self.navigationController pushViewController:forgetPswVC animated:YES];
//}
//
//- (void)textChanged:(UITextField *)textField {
//    NSString * strPhoneNum = self.phoneInputView.textFieldMain.text;
//    BOOL hasText = (self.passwordInpuView.textFieldMain.text.length > 0 && self.phoneInputView.textFieldMain.text.length > 0);
//    BOOL phoneIsFit = [strPhoneNum isNumText] && strPhoneNum.length == 11;
//    if (hasText && phoneIsFit) {
//        [self.loginBtn enableTouch];
//    }
//    else {
//        [self.loginBtn disableTouch];
//    }
//}
//
//- (KDInputView *)phoneInputView {
//    if (!_phoneInputView) {
//        _phoneInputView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementImageViewLeft|KDInputViewElementZLZInputView shouldFormatPhoneNumber:NO];
//        _phoneInputView.imageViewLeft.image = [UIImage imageNamed:@"tf_phone"];
//        _phoneInputView.textFieldMain.keyboardType = UIKeyboardTypeNumberPad;
//        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:phoneInputPlaceholder];
//        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
//        [_phoneInputView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
//        [_phoneInputView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
//        if ([ZNTDataConfig sharedConfig].user.phone.length > 0) {
//            _phoneInputView.textFieldMain.text = [ZNTDataConfig sharedConfig].user.phone;
//        }
//    }
//    
//    return  _phoneInputView;
//}
//
//- (KDInputView *)passwordInpuView {
//    if (!_passwordInpuView) {
//        _passwordInpuView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementImageViewLeft|KDInputViewElementZLZInputView shouldFormatPhoneNumber:NO];
//        _passwordInpuView.imageViewLeft.image = [UIImage imageNamed:@"tf_password"];
//        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:passwordInputPlaceholder];
//        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
//        [_passwordInpuView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
//        [_passwordInpuView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
//        _passwordInpuView.textFieldMain.secureTextEntry = YES;
//        //        [_passwordInpuView changeToZLZStyle];
//    }
//    
//    return _passwordInpuView;
//}
//
//- (ZNTThemeButton *)loginBtn {
//    if (!_loginBtn) {
//        _loginBtn = [[ZNTThemeButton alloc] init];
//        [_loginBtn disableTouch];
//        [_loginBtn setTitle:loginBtnTitle forState:UIControlStateNormal];
//        [_loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _loginBtn;
//}
//
//- (UIButton *)registBtn {
//    if (!_registBtn) {
//        _registBtn = [UIButton new];
//        NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:registBtnTitle];
//        [mas dz_setFont:Font12];
//        [mas dz_setUnderlineWithRange:NSMakeRange(0, registBtnTitle.length)];
//        [mas dz_setTextColor:ZNTBtnColor1 range:NSMakeRange(0, registBtnTitle.length)];
//        [_registBtn setAttributedTitle:mas forState:UIControlStateNormal];
//        [_registBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    return _registBtn;
//}
//
//- (UIButton *)forgetPswBtn {
//    if (!_forgetPswBtn) {
//        _forgetPswBtn = [UIButton new];
//        NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:forgetPasswordBtnTitle];
//        [mas dz_setFont:Font12];
//        [mas dz_setUnderlineWithRange:NSMakeRange(0, forgetPasswordBtnTitle.length)];
//        [mas dz_setTextColor:ZNTBtnColor1 range:NSMakeRange(0, forgetPasswordBtnTitle.length)];
//        [_forgetPswBtn setAttributedTitle:mas forState:UIControlStateNormal];
//        [_forgetPswBtn addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    return  _forgetPswBtn;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
