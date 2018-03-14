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

static NSString *const phoneInputPlaceholder = @"请输入手机号码";
static NSString *const passwordInputPlaceholder = @"请输入登录密码";
static NSString *const registBtnTitle = @"新用户注册";
static NSString *const forgetPasswordBtnTitle = @"忘记密码";
static NSString *const loginBtnTitle = @"登录";


@interface ZNTLoginVC ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (nonatomic, strong) KDInputView *phoneInputView;
@property (nonatomic, strong) KDInputView *passwordInpuView;
@property (nonatomic, strong) ZNTThemeButton *loginBtn;

@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UIButton *forgetPswBtn;

@end

@implementation ZNTLoginVC

INSTANCE_XIB_M(@"Login", ZNTLoginVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    
    [self initUI];
    
}

- (void)initUI {
    
    self.title = @"登录";
    
    [self setupViews];
    [self make_mas];
}

- (void)setupViews {
    
    [self.view addSubview:self.phoneInputView];
    [self.view addSubview:self.passwordInpuView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registBtn];
    [self.view addSubview:self.forgetPswBtn];
    
}

- (void)make_mas {
    [self.phoneInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.mas_equalTo(145);
        make.height.mas_equalTo(45);
    }];
    
    // inputViewPassword
    [self.passwordInpuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.phoneInputView.mas_bottom).with.offset(8);
        make.height.mas_equalTo(45);
    }];
    
    // buttonLogin
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.passwordInpuView.mas_bottom).with.offset(74);
        make.height.mas_equalTo(44);
    }];
    
    // registBtn
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3] + 9);
        make.top.equalTo(self.passwordInpuView.mas_bottom).with.offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    // forgetPswBtn
    [self.forgetPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3] - 9);
        make.top.equalTo(self.passwordInpuView.mas_bottom).with.offset(15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
}

- (void)initDataInfo {
    
}

- (void)loginClick:(UIButton *)sender {
    [self.view znt_showHUD:@"请稍候..."];
    
    [[ZNTLoginManager sharedManager] userLoginWithPhone:self.phoneInputView.textFieldMain.text password:self.passwordInpuView.textFieldMain.text completed:^(BOOL success, NSUInteger errorCode, NSString *error, id userInfo) {
        [self.view znt_hideHUD];
        if (!success) {
            [self.view znt_showToast:error];
        }
        
    }];
    
}

- (void)registAction:(UIButton *)sender {
    ZNTRegisterVC *registVC = [ZNTRegisterVC instanceFromXib];
    if (self.passwordInpuView.textFieldMain.text.length > 0) {
        registVC.user = [[ZNTUser alloc] init];
        registVC.user.phone = self.passwordInpuView.textFieldMain.text;
    }
    [self.navigationController pushViewController:registVC animated:YES];
}

- (void)forgetAction:(UIButton *)sender {
    ZNTGetCodeVC *forgetPswVC = [ZNTGetCodeVC instanceFromXib];
    if (self.passwordInpuView.textFieldMain.text.length > 0) {
        forgetPswVC.user = [[ZNTUser alloc] init];
        forgetPswVC.user.phone = self.passwordInpuView.textFieldMain.text;
    }
    [self.navigationController pushViewController:forgetPswVC animated:YES];
}

- (void)textChanged:(UITextField *)textField {
    NSString * strPhoneNum = self.phoneInputView.textFieldMain.text;
    BOOL hasText = (self.passwordInpuView.textFieldMain.text.length > 0 && self.phoneInputView.textFieldMain.text.length > 0);
    BOOL phoneIsFit = [strPhoneNum isNumText] && strPhoneNum.length == 11;
    if (hasText && phoneIsFit) {
        [self.loginBtn enableTouch];
    }
    else {
        [self.loginBtn disableTouch];
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
        if ([ZNTDataConfig sharedConfig].user.phone.length > 0) {
            _phoneInputView.textFieldMain.text = [ZNTDataConfig sharedConfig].user.phone;
        }
    }
    
    return  _phoneInputView;
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

- (ZNTThemeButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[ZNTThemeButton alloc] init];
        [_loginBtn disableTouch];
        [_loginBtn setTitle:loginBtnTitle forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [UIButton new];
        NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:registBtnTitle];
        [mas dz_setFont:Font12];
        [mas dz_setUnderlineWithRange:NSMakeRange(0, registBtnTitle.length)];
        [mas dz_setTextColor:ZNTBtnColor1 range:NSMakeRange(0, registBtnTitle.length)];
        [_registBtn setAttributedTitle:mas forState:UIControlStateNormal];
        [_registBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _registBtn;
}

- (UIButton *)forgetPswBtn {
    if (!_forgetPswBtn) {
        _forgetPswBtn = [UIButton new];
        NSMutableAttributedString *mas = [[NSMutableAttributedString alloc] initWithString:forgetPasswordBtnTitle];
        [mas dz_setFont:Font12];
        [mas dz_setUnderlineWithRange:NSMakeRange(0, forgetPasswordBtnTitle.length)];
        [mas dz_setTextColor:ZNTBtnColor1 range:NSMakeRange(0, forgetPasswordBtnTitle.length)];
        [_forgetPswBtn setAttributedTitle:mas forState:UIControlStateNormal];
        [_forgetPswBtn addTarget:self action:@selector(forgetAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return  _forgetPswBtn;
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
