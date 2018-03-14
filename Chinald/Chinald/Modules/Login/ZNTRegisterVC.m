//
//  ZNTRegisterVC.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/6.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTRegisterVC.h"
#import "KDInputView.h"
#import "ZNTThemeButton.h"
#import "ZNTLoginRequest.h"
#import "ZNTCompleteUserInfoVC.h"

static NSString *const phoneInputPlaceholder = @"请输入手机号码";
static NSString *const verifiCodeInputPlaceholder = @"请输入验证码";
static NSString *const verifiCodeRightBtnTitle = @"发送验证码";
static NSString *const passwordInputPlaceholder = @"请输入密码";
static NSString *const passwordConfimInputPlaceholder = @"请再次输入密码";
static NSString *const nextStepBtnTitle = @"下一步";

#define kSendMinTime (int)61       //61 = 60 + 1

typedef enum : NSUInteger {
    kRegisterRightBtnType_send,
    kRegisterRightBtnType_sending,
    kRegisterRightBtnType_resend,
} kRegisterRightBtnType;

@interface ZNTRegisterVC ()

@property (nonatomic, strong) KDInputView *phoneInputView;
@property (nonatomic, strong) KDInputView *verifiCodeInputView;
@property (nonatomic, strong) KDInputView *passwordInpuView;
@property (nonatomic, strong) KDInputView *passwordConfimInpuView;

@property (nonatomic, strong) ZNTThemeButton *nextStepBtn;

@property (nonatomic, copy) NSString *smsId;
@property (nonatomic, assign) kRegisterRightBtnType rightBtnType;
@property (nonatomic, assign) NSInteger sendTime;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *flagResend;

@end

@implementation ZNTRegisterVC

INSTANCE_XIB_M(@"Login", ZNTRegisterVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"物流商注册";
    [self setupViews];
    [self make_mas];
}

- (void)setupViews {
    
    [self.view addSubview:self.phoneInputView];
    [self.view addSubview:self.verifiCodeInputView];
    [self.view addSubview:self.passwordInpuView];
    [self.view addSubview:self.passwordConfimInpuView];
    [self.view addSubview:self.nextStepBtn];
    
}

- (void)make_mas {
    [self.phoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo(45);
    }];
    
    // verifiCodeInputView
    [self.verifiCodeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.phoneInputView.mas_bottom).with.offset(8);
        make.height.mas_equalTo(45);
    }];
    
    // inputViewPassword
    [self.passwordInpuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.verifiCodeInputView.mas_bottom).with.offset(8);
        make.height.mas_equalTo(45);
    }];
    
    // passwordConfimInpuView
    [self.passwordConfimInpuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.passwordInpuView.mas_bottom).with.offset(8);
        make.height.mas_equalTo(45);
    }];
    
    
    // nextStepBtn
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.passwordConfimInpuView.mas_bottom).with.offset(74);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)initDataInfo {
    if (!self.user) {
        self.user = [[ZNTUser alloc] init];
    }
    
    self.smsId = @"";
}

//获取验证码
- (void)getCodeButtonClick {
    
    if (self.phoneInputView.textFieldMain.text.length > 0 && self.phoneInputView.textFieldMain.text.length == 11) {
        
        if (self.rightBtnType == kRegisterRightBtnType_send) {
            [self getCodeToken];
        }
        
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
        [self.verifiCodeInputView.textFieldMain becomeFirstResponder];
    }
    else {
        [self.view znt_showToast:@"请输入正确的手机号码"];
    }
}

- (void)getCodeToken {
    [self.view znt_showHUD:@"请稍候..."];
    [ZNTLoginRequest sendCodeWithPhone:self.phoneInputView.textFieldMain.text onSuccess:^(id  _Nullable responseObject) {
        [self.view znt_hideHUD];
        self.smsId = responseObject[@"id"]?responseObject[@"id"]:@"";
        self.flagResend = @"1";
        [self resetTimer];
        
    } onFailure:^(NSError * _Nullable error) {
        [self.view znt_hideHUD];
        [self.view znt_showToast:error.domain];
    }];
}

- (void)timerSchedule
{
    _sendTime--;
    if (_sendTime > 0) {
        
        NSString *btnTitle = [NSString stringWithFormat:@"%lds 后重发",(long)_sendTime];
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:btnTitle];
        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
        
        [self.verifiCodeInputView.buttonRight setAttributedTitle:attributePlaceholder forState:UIControlStateNormal];
        [self.verifiCodeInputView.buttonRight setNeedsDisplay];
    }
    else {
        [self.timer invalidate];
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:@"重新发送"];
        [attributePlaceholder dz_setTextColor:ZNTBtnColor1];
        [self.verifiCodeInputView.buttonRight setAttributedTitle:attributePlaceholder forState:UIControlStateNormal];
        
        self.rightBtnType = kRegisterRightBtnType_resend;
        self.verifiCodeInputView.buttonRight.enabled = YES;
    }
}

- (void)resetTimer
{
    if (self.rightBtnType == kRegisterRightBtnType_sending) {   // 正在发送中
        return;
    }
    
    self.rightBtnType = kRegisterRightBtnType_sending;
    self.verifiCodeInputView.buttonRight.enabled = NO;
    _sendTime = kSendMinTime;
    [self timerSchedule];
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];
    self.timer = [NSTimer timerWithTimeInterval:1.f target:self selector:@selector(timerSchedule) userInfo:nil repeats:YES];
    [myRunLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
}

//下一步
- (void)nextStepAction:(UIButton *)sender {
    if (![self.passwordInpuView.textFieldMain.text isEqualToString:self.passwordConfimInpuView.textFieldMain.text]) {
        [self.view znt_showToast:@"输入密码不一致，请重新输入"];
        
        return;
    }
    
    [self.view znt_showHUD:@"请稍候..."];
    ZNTWeak(self)
    [ZNTLoginRequest verifyCodeWithSmsId:self.smsId phone:self.phoneInputView.textFieldMain.text code:self.verifiCodeInputView.textFieldMain.text onSuccess:^(id  _Nullable responseObject) {
        ZNTStrong(self)
        [self.view znt_hideHUD];
        
        if ([responseObject integerValue] == 1) {
            self.user.phone = self.phoneInputView.textFieldMain.text;
            self.user.password = self.passwordInpuView.textFieldMain.text;
            
            ZNTCompleteUserInfoVC *completeUserInfoVC = [ZNTCompleteUserInfoVC instanceFromXib];
            completeUserInfoVC.code = self.verifiCodeInputView.textFieldMain.text;
            completeUserInfoVC.user = self.user;
            [self.navigationController pushViewController:completeUserInfoVC animated:YES];
        } else {
            [self.view znt_showToast:@"验证码错误"];
        }
        
    } onFailure:^(NSError * _Nullable error) {
        ZNTStrong(self)
        [self.view znt_hideHUD];
        [self.view znt_showToast:error.domain];
    }];
}

- (void)textChanged:(UITextField *)textField {
    NSString * strPhoneNum = self.phoneInputView.textFieldMain.text;
    BOOL hasPswText = (self.passwordInpuView.textFieldMain.text.length > 0 && self.passwordInpuView.textFieldMain.text.length > 0);
    BOOL hasPswConText = (self.passwordConfimInpuView.textFieldMain.text.length > 0 && self.passwordConfimInpuView.textFieldMain.text.length > 0);
    BOOL hasCodeText = (self.verifiCodeInputView.textFieldMain.text.length > 0 && self.verifiCodeInputView.textFieldMain.text.length > 0);
    BOOL phoneIsFit = [strPhoneNum isNumText] && strPhoneNum.length == 11;
    
    if (phoneIsFit && hasPswConText && hasCodeText && hasPswText) {
        [self.nextStepBtn enableTouch];
    }
    else {
        [self.nextStepBtn disableTouch];
    }
}

- (KDInputView *)phoneInputView {
    if (!_phoneInputView) {
        _phoneInputView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementImageViewLeft|KDInputViewElementZLZInputView shouldFormatPhoneNumber:NO];
        _phoneInputView.imageViewLeft.image = [UIImage imageNamed:@"tf_phone"];
        _phoneInputView.textFieldMain.keyboardType = UIKeyboardTypeNumberPad;
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:phoneInputPlaceholder];
        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
        [_phoneInputView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
        [_phoneInputView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        if (self.user && self.user.phone.length > 0) {
            _phoneInputView.textFieldMain.text = self.user.phone;
        }
    }
    
    return  _phoneInputView;
}

- (KDInputView *)verifiCodeInputView {
    if (!_verifiCodeInputView) {
        _verifiCodeInputView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementImageViewLeft|KDInputViewElementButtonRight shouldFormatPhoneNumber:NO];
        _verifiCodeInputView.imageViewLeft.image = [UIImage imageNamed:@"tf_verifi"];
        _verifiCodeInputView.textFieldMain.keyboardType = UIKeyboardTypeNumberPad;
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:verifiCodeInputPlaceholder];
        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
        [_verifiCodeInputView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
        [_verifiCodeInputView.buttonRight setTitle:verifiCodeRightBtnTitle forState:UIControlStateNormal];
        _verifiCodeInputView.fButtonRightWidth = 90;
        __weak __typeof(self) weakSelf = self;
        _verifiCodeInputView.blockButtonRightPressed = ^(UIButton *button) {
            [weakSelf getCodeButtonClick];
        };
        
        [_verifiCodeInputView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return  _verifiCodeInputView;
}

- (KDInputView *)passwordInpuView {
    if (!_passwordInpuView) {
        _passwordInpuView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementImageViewLeft|KDInputViewElementZLZInputView shouldFormatPhoneNumber:NO];
        _passwordInpuView.imageViewLeft.image = [UIImage imageNamed:@"tf_password"];
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:passwordInputPlaceholder];
        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
        [_passwordInpuView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
        [_passwordInpuView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        _passwordInpuView.textFieldMain.secureTextEntry = YES;
        //        [_passwordInpuView changeToZLZStyle];
    }
    
    return _passwordInpuView;
}

- (KDInputView *)passwordConfimInpuView {
    if (!_passwordConfimInpuView) {
        _passwordConfimInpuView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementImageViewLeft|KDInputViewElementZLZInputView shouldFormatPhoneNumber:NO];
        _passwordConfimInpuView.imageViewLeft.image = [UIImage imageNamed:@"tf_password"];
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:passwordConfimInputPlaceholder];
        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
        [_passwordConfimInpuView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
        [_passwordConfimInpuView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        _passwordConfimInpuView.textFieldMain.secureTextEntry = YES;
        //        [_passwordConfimInpuView changeToZLZStyle];
    }
    
    return _passwordConfimInpuView;
}

- (ZNTThemeButton *)nextStepBtn {
    if (!_nextStepBtn) {
        _nextStepBtn = [[ZNTThemeButton alloc] init];
        [_nextStepBtn disableTouch];
        [_nextStepBtn setTitle:nextStepBtnTitle forState:UIControlStateNormal];
        [_nextStepBtn addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepBtn;
}

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
