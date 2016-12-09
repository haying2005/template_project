//
//  RegisterViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import "RegisterViewController.h"
#import "Validate.h"

@interface RegisterViewController ()
{
    UITextField *txtUsername;
    UITextField *txtPassword;
    UITextField *txtCheckcode;
    UIButton *btnGetCheckcode;
    UIButton *btnLogin;
    UILabel *lblTip;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
    
    RACSignal *validPhoneSignal = [txtUsername.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([Validate validateMobile:value]);
    }];
    RACSignal *validPassSignal = [txtPassword.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([Validate validatePassword:value]);
    }];
    RACSignal *validCodeSignal = [txtCheckcode.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(txtCheckcode.text.length > 0);
    }];
    RACSignal *enableSubmitSignal = [RACSignal combineLatest:@[validPhoneSignal, validPassSignal, validCodeSignal] reduce:^id _Nullable(NSNumber *bool1, NSNumber *bool2, NSNumber *bool3){
        return @([bool1 boolValue] && [bool2 boolValue] && [bool3 boolValue]);
    }];
    
    RAC(btnGetCheckcode, enabled) = validPhoneSignal;
    RAC(btnLogin, enabled) = enableSubmitSignal;
    

}

- (void)submit {
    [[HttpClient shareInstance] requestWithParameters:[HttpParametersUtility registerParammetersWithPhone:txtUsername.text pass:txtPassword.text code:txtCheckcode.text inviter:nil] success:^(id data) {
        ZNLog(@"%@", data);
    } failure:^(NSString *errorDescription) {
        ZNLog(@"%@", errorDescription);
    }];
    
}

- (void)getCheckCode {
    [[HttpClient shareInstance] requestWithParameters:[HttpParametersUtility sendCheckCodeParammetersWithPhone:txtUsername.text type:1] success:^(id data) {
        //ZNLog(@"success : %@", data);
    } failure:^(NSString *errorDescription) {
        ZNLog(@"error : %@", errorDescription);
    }];
}


- (void)showError:(NSString *)text {
    [lblTip setText:text];
}

- (void)initUI {
    UIView *superV = self.view;
    
    txtUsername = [UITextField new];
    txtUsername.borderStyle = UITextBorderStyleRoundedRect;
    txtUsername.placeholder = @"请填写手机号";
    [superV addSubview:txtUsername];
    [txtUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superV.mas_top).with.offset(100);
        make.left.equalTo(superV.mas_left).with.offset(30);
        make.right.equalTo(superV.mas_right).with.offset(-30);
        make.height.equalTo(@(44));
    }];
    
    txtPassword = [UITextField new];
    txtPassword.borderStyle = UITextBorderStyleRoundedRect;
    txtPassword.placeholder = @"请填写密码";
    [superV addSubview:txtPassword];
    [txtPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(txtUsername.mas_bottom).with.offset(30);
        make.left.equalTo(txtUsername);
        make.width.equalTo(txtUsername);
        make.height.equalTo(txtUsername);
    }];
    
    txtCheckcode = [UITextField new];
    txtCheckcode.borderStyle = UITextBorderStyleRoundedRect;
    txtCheckcode.placeholder = @"验证码";
    [superV addSubview:txtCheckcode];
    [txtCheckcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(txtPassword.mas_bottom).offset(30);
        make.left.equalTo(txtPassword);
        make.height.mas_equalTo(44);
    }];
    
    btnGetCheckcode = [UIButton new];
    [superV addSubview:btnGetCheckcode];
    [btnGetCheckcode setTitle:@"获取" forState:UIControlStateNormal];
    [btnGetCheckcode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnGetCheckcode setBackgroundColor:[UIColor lightGrayColor]];
    [btnGetCheckcode addTarget:self action:@selector(getCheckCode) forControlEvents:UIControlEventTouchUpInside];
    [btnGetCheckcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(txtCheckcode);
        make.right.equalTo(txtPassword);
        make.height.mas_equalTo(txtCheckcode);
        make.width.equalTo(txtCheckcode).offset(- 100);
        make.left.equalTo(txtCheckcode.mas_right).offset(20);
    }];
    
    btnLogin = [UIButton new];
    [superV addSubview:btnLogin];
    btnLogin.backgroundColor = [UIColor greenColor];
    [btnLogin setTitle:@"提交" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(txtCheckcode.mas_bottom).with.offset(30);
        make.width.equalTo(txtPassword);
        make.height.mas_equalTo(44);
        make.left.equalTo(txtPassword);
    }];
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
