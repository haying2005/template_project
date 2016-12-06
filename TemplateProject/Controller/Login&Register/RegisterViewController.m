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
    UIButton *btnLogin;
    UILabel *lblTip;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    
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
    [btnLogin setTitle:@"提交" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
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

}

- (void)submit {
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
    
    User *user = [[User alloc] init];
    user.userName = txtUsername.text;
    user.password = txtPassword.text;
    user.userNick = [NSString stringWithFormat:@"用户:%@", txtUsername.text];
    user.headUrl = @"http://";
    NSDictionary *result = [User registerUser:user];
    if (!([[result valueForKey:@"code"] integerValue] == 0)) {
        [self showError:result[@"errMsg"]];
    }
    else {
        [self showError:@"注册成功"];
    }
    //NSLog(@"%@", result);
    
}

- (void)showError:(NSString *)text {
    [lblTip setText:text];
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
