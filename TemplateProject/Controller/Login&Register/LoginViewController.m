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
    [btnLogin addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
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
    [self showError:@""];

    NSDictionary *result = [User login:txtUsername.text pass:txtPassword.text];
    if (!([[result valueForKey:@"code"] integerValue] == 0)) {
        [self showError:result[@"errMsg"]];
    }
    else {
        [self showError:@"登录成功"];
        [[User shareInstance] updateInfo:@{@"login" : @(YES)}];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            //
        }];
    }
    
    
}

- (void)showError:(NSString *)text {
    [lblTip setText:text];
}
- (void)toRegister:(id)sender {
    RegisterViewController *ctrl = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:ctrl animated:YES];
}

@end
