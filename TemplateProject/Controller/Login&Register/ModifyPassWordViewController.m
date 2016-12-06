//
//  ModifyPassWordViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/5.
//
//

#import "ModifyPassWordViewController.h"
#import "Validate.h"

@interface ModifyPassWordViewController ()
{
    UITextField *_txtOldpass;
    UITextField *_txtNewpass;
    UIButton *_btnSubmit;
    UILabel *_lblTip;
}

@end

@implementation ModifyPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *superV = self.view;
    
    _txtOldpass = [UITextField new];
    _txtOldpass.borderStyle = UITextBorderStyleRoundedRect;
    [superV addSubview:_txtOldpass];
    [_txtOldpass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superV.mas_top).with.offset(100);
        make.left.equalTo(superV.mas_left).with.offset(30);
        make.right.equalTo(superV.mas_right).with.offset(-30);
        make.height.equalTo(@(44));
    }];
    
    _txtNewpass = [UITextField new];
    _txtNewpass.borderStyle = UITextBorderStyleRoundedRect;
    [superV addSubview:_txtNewpass];
    [_txtNewpass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_txtOldpass.mas_bottom).with.offset(30);
        make.left.equalTo(_txtOldpass);
        make.width.equalTo(_txtOldpass);
        make.height.equalTo(_txtOldpass);
    }];
    
    _btnSubmit = [UIButton new];
    [superV addSubview:_btnSubmit];
    [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    [_btnSubmit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnSubmit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [_btnSubmit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_txtNewpass.mas_bottom).with.offset(30);
        make.right.equalTo(_txtNewpass.mas_right).with.offset(-30);
    }];
    
    _lblTip = [UILabel new];
    _lblTip.textColor = [UIColor redColor];
    _lblTip.font = [UIFont systemFontOfSize:12];
    [superV addSubview:_lblTip];
    [_lblTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_btnSubmit);
        make.left.equalTo(_txtNewpass);
        make.right.equalTo(_btnSubmit.mas_left).with.offset(30);
    }];
}

- (void)submit {
    ZNLog();
    if (!_txtOldpass.text) {
        return [self showError:@"请填写旧密码"];
    }
    
    if (_txtNewpass.text.length < 6) {
        return [self showError:@"密码不能小于6位"];
    }
    if (_txtNewpass.text.length > 20) {
        return [self showError:@"密码不能大于20位"];
    }
    
    if (![Validate validatePassword:_txtNewpass.text]) {
        return [self showError:@"密码只能由数字跟字母组成"];
    }
    
    if (![[User shareInstance].password isEqualToString:_txtOldpass.text]) {
        return [self showError:@"旧密码错误"];
    }
    
    [self showError:@""];
    
    if ([[User shareInstance] updateInfo:@{@"password" : _txtNewpass.text}]) {
        [self showError:@"修改密码成功！"];
    }
}
- (void)showError:(NSString *)text {
    [_lblTip setText:text];
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
