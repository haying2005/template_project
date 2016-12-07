//
//  LoginViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/11/30.
//
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "MainTabBarViewController.h"
#import "User.h"
#import "Validate.h"
#import "FMDatabase.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
{
    UITextField *txtUsername;
    UITextField *txtPassword;
    UIButton *btnLogin;
    UILabel *lblTip;
}


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    @weakify(self);
    
    RACSignal *validUser = [txtUsername.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
         return @([Validate validateUserName:value]);
     }];
    
    RACSignal *validPass = [txtPassword.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([Validate validatePassword:value]);
    }];
    
    RAC(txtUsername, backgroundColor) = [validUser map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(txtPassword, backgroundColor) = [validPass map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUser, validPass] reduce:^id _Nullable(NSNumber *user, NSNumber *pass){
        return @([user boolValue] && [pass boolValue]);
    }];
    RAC(btnLogin, enabled) = signUpActiveSignal;
    
    [[[btnLogin rac_signalForControlEvents:UIControlEventTouchUpInside]
     doNext:^(__kindof UIControl * _Nullable x) {
         btnLogin.enabled = NO;
         [self showError:@""];
    }]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self login];
    }];
    
}
    
- (void)initUI {
    self.navigationItem.title = @"登录";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *superV = self.view;
    
    txtUsername = [UITextField new];
    txtUsername.borderStyle = UITextBorderStyleRoundedRect;
    [superV addSubview:txtUsername];
    [txtUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superV.mas_top).with.offset(100);
        make.left.equalTo(superV.mas_left).with.offset(30);
        make.right.equalTo(superV.mas_right).with.offset(-30);
        make.height.equalTo(@(44));
    }];
    
    txtPassword = [UITextField new];
    txtPassword.borderStyle = UITextBorderStyleRoundedRect;
    [superV addSubview:txtPassword];
    [txtPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(txtUsername.mas_bottom).with.offset(30);
        make.left.equalTo(txtUsername);
        make.width.equalTo(txtUsername);
        make.height.equalTo(txtUsername);
    }];
    
    btnLogin = [UIButton new];
    [superV addSubview:btnLogin];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(txtPassword.mas_bottom).with.offset(30);
        make.right.equalTo(txtPassword.mas_right).with.offset(-30);
    }];
    
    lblTip = [UILabel new];
    lblTip.textColor = [UIColor redColor];
    lblTip.font = [UIFont systemFontOfSize:12];
    [superV addSubview:lblTip];
    [lblTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnLogin);
        make.left.equalTo(txtPassword);
        make.right.equalTo(btnLogin.mas_left).with.offset(30);
    }];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnRight setTitle:@"注册" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnRight sizeToFit];
    [btnRight addTarget:self action:@selector(toRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"忘记密码" style:UIBarButtonItemStylePlain target:self action:@selector(forgetPass)];
    
}


- (void)login {
    if (![Validate validateMobile:txtUsername.text]) {
        return [self showError:@"请正确填写手机号"];
    }
    if (txtPassword.text.length < 6) {
        return [self showError:@"密码不能小于6位"];
    }
    if (txtPassword.text.length > 20) {
        return [self showError:@"密码不能大于20位"];
    }

    if (![Validate validatePassword:txtPassword.text]) {
        return [self showError:@"密码只能由数字跟字母组成"];
    }
    [self showError:@"登录中..."];
    
    WEAKSELF;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *result = [User login:txtUsername.text pass:txtPassword.text];
        btnLogin.enabled = YES;
        if (!([[result valueForKey:@"code"] integerValue] == 0)) {
            [weakSelf showError:result[@"errMsg"]];
        }
        else {
            [weakSelf showError:@"登录成功"];
            [[User shareInstance] updateInfo:@{@"login" : @(YES)}];
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                //
            }];
        }
    });
    
}

- (void)showError:(NSString *)text {
    [lblTip setText:text];
}

- (void)toRegister:(id)sender {
    RegisterViewController *ctrl = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)dealloc {
    ZNLog();
}
    


@end
