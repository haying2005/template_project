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
#import "ThirdOpenPlatformManager.h"

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
    @weakify(btnLogin);

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
    
    [signUpActiveSignal subscribeNext:^(id  _Nullable x) {
        btnLogin_weak_.enabled = [x boolValue];
    }];
    
    
    RAC(btnLogin, enabled) = signUpActiveSignal;
    
    [[[btnLogin rac_signalForControlEvents:UIControlEventTouchUpInside]
     doNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self);
         btnLogin_weak_.enabled = NO;
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
    @weakify(txtUsername);
    txtUsername.borderStyle = UITextBorderStyleRoundedRect;
    [superV addSubview:txtUsername];
    [txtUsername mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superV.mas_top).with.offset(100);
        make.left.equalTo(superV.mas_left).with.offset(30);
        make.right.equalTo(superV.mas_right).with.offset(-30);
        make.height.equalTo(@(44));
    }];
    
    txtPassword = [UITextField new];
    @weakify(txtPassword);
    txtPassword.borderStyle = UITextBorderStyleRoundedRect;
    [superV addSubview:txtPassword];
    [txtPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(txtUsername_weak_.mas_bottom).with.offset(30);
        make.left.equalTo(txtUsername_weak_);
        make.width.equalTo(txtUsername_weak_);
        make.height.equalTo(txtUsername_weak_);
    }];
    
    btnLogin = [UIButton new];
    @weakify(btnLogin);
    
    [superV addSubview:btnLogin];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(txtPassword_weak_.mas_bottom).with.offset(30);
        make.right.equalTo(txtPassword_weak_.mas_right).with.offset(-30);
    }];
    
    lblTip = [UILabel new];
    //@weakify(lblTip);
    
    lblTip.textColor = [UIColor redColor];
    lblTip.font = [UIFont systemFontOfSize:12];
    [superV addSubview:lblTip];
    [lblTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnLogin_weak_);
        make.left.equalTo(txtPassword_weak_);
        make.right.equalTo(btnLogin_weak_.mas_left).with.offset(30);
    }];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnRight setTitle:@"注册" forState:UIControlStateNormal];
    [btnRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnRight sizeToFit];
    [btnRight addTarget:self action:@selector(toRegister:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"忘记密码" style:UIBarButtonItemStylePlain target:self action:@selector(forgetPass)];
    
    
    [self setupLoginView];
    [self setupShareView];
}

- (void)setupLoginView
{
#define BUTTON_MARGIN   10
#define BUTTON_WIDTH    63
#define BUTTON_HEIGHT   30
    
    UIButton *qqButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [qqButton setTitle:@"QQ登录" forState:UIControlStateNormal];
    [qqButton setTag:0];
    [qqButton setFrame:CGRectMake(self.view.width / 2. - BUTTON_WIDTH / 2. - (BUTTON_WIDTH + BUTTON_MARGIN) * 2, self.view.height - 230, BUTTON_WIDTH, BUTTON_HEIGHT)];
    qqButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [qqButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqButton];
    
    UIButton *weChatButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [weChatButton setTitle:@"微信登录" forState:UIControlStateNormal];
    [weChatButton setTag:1];
    [weChatButton setFrame:CGRectMake(self.view.width / 2. - BUTTON_WIDTH / 2. - (BUTTON_WIDTH + BUTTON_MARGIN) * 1, qqButton.top, BUTTON_WIDTH, BUTTON_HEIGHT)];
    weChatButton.titleLabel.font = qqButton.titleLabel.font;
    [weChatButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weChatButton];
    
    UIButton *sinaWeiBoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sinaWeiBoButton setTitle:@"微博登录" forState:UIControlStateNormal];
    [sinaWeiBoButton setTag:2];
    [sinaWeiBoButton setFrame:CGRectMake(self.view.width / 2. - BUTTON_WIDTH / 2., qqButton.top, BUTTON_WIDTH, BUTTON_HEIGHT)];
    sinaWeiBoButton.titleLabel.font = qqButton.titleLabel.font;
    [sinaWeiBoButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaWeiBoButton];
    
    UIButton *faceBookButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [faceBookButton setTitle:@"FaceBook登录" forState:UIControlStateNormal];
    [faceBookButton setTag:3];
    [faceBookButton setFrame:CGRectMake(self.view.width / 2. + BUTTON_WIDTH / 2. + BUTTON_MARGIN, qqButton.top, BUTTON_WIDTH, BUTTON_HEIGHT)];
    faceBookButton.titleLabel.font = qqButton.titleLabel.font;
    [faceBookButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:faceBookButton];
    
    UIButton *twitterButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [twitterButton setTitle:@"Twitter登录" forState:UIControlStateNormal];
    [twitterButton setTag:4];
    [twitterButton setFrame:CGRectMake(self.view.width / 2. + BUTTON_WIDTH / 2. + BUTTON_MARGIN + (BUTTON_WIDTH + BUTTON_MARGIN) * 1, qqButton.top, BUTTON_WIDTH, BUTTON_HEIGHT)];
    twitterButton.titleLabel.font = qqButton.titleLabel.font;
    [twitterButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterButton];
    
    qqButton.backgroundColor = [UIColor brownColor];
    weChatButton.backgroundColor = [UIColor brownColor];
    sinaWeiBoButton.backgroundColor = [UIColor brownColor];
    faceBookButton.backgroundColor = [UIColor brownColor];
    twitterButton.backgroundColor = [UIColor brownColor];
}

- (void)setupShareView
{
#undef BUTTON_MARGIN
#define BUTTON_MARGIN   10
    
#undef BUTTON_WIDTH
#define BUTTON_WIDTH    63
    
#define BUTTON_HEIGHT   30
    
    UIButton *qqFriendButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [qqFriendButton setTitle:@"QQ好友" forState:UIControlStateNormal];
    [qqFriendButton setTag:0];
    [qqFriendButton setFrame:CGRectMake(self.view.width / 2. - BUTTON_WIDTH / 2. - (BUTTON_WIDTH + BUTTON_MARGIN) * 2, self.view.height - 150, BUTTON_WIDTH, BUTTON_HEIGHT)];
    qqFriendButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [qqFriendButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqFriendButton];
    
    UIButton *qqZoneButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [qqZoneButton setTitle:@"QQ空间" forState:UIControlStateNormal];
    [qqZoneButton setTag:1];
    [qqZoneButton setFrame:CGRectMake(self.view.width / 2. - BUTTON_WIDTH / 2. - (BUTTON_WIDTH + BUTTON_MARGIN) * 1, qqFriendButton.top, BUTTON_WIDTH, BUTTON_HEIGHT)];
    qqZoneButton.titleLabel.font = qqFriendButton.titleLabel.font;
    [qqZoneButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqZoneButton];
    
    UIButton *weChatFriendButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [weChatFriendButton setTitle:@"微信好友" forState:UIControlStateNormal];
    [weChatFriendButton setTag:2];
    [weChatFriendButton setFrame:CGRectMake(self.view.width / 2. - BUTTON_WIDTH / 2., qqFriendButton.top, BUTTON_WIDTH, BUTTON_HEIGHT)];
    weChatFriendButton.titleLabel.font = qqFriendButton.titleLabel.font;
    [weChatFriendButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weChatFriendButton];
    
    UIButton *weChatCircleButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [weChatCircleButton setTitle:@"微信朋友圈" forState:UIControlStateNormal];
    [weChatCircleButton setTag:3];
    [weChatCircleButton setFrame:CGRectMake(self.view.width / 2. + BUTTON_WIDTH / 2. + BUTTON_MARGIN, qqFriendButton.top, BUTTON_WIDTH, BUTTON_HEIGHT)];
    weChatCircleButton.titleLabel.font = qqFriendButton.titleLabel.font;
    [weChatCircleButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weChatCircleButton];
    
    UIButton *sinaWeiBoButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sinaWeiBoButton setTitle:@"微博" forState:UIControlStateNormal];
    [sinaWeiBoButton setTag:4];
    [sinaWeiBoButton setFrame:CGRectMake(self.view.width / 2. + BUTTON_WIDTH / 2. + BUTTON_MARGIN + (BUTTON_WIDTH + BUTTON_MARGIN) * 1, qqFriendButton.top, BUTTON_WIDTH, BUTTON_HEIGHT)];
    sinaWeiBoButton.titleLabel.font = qqFriendButton.titleLabel.font;
    [sinaWeiBoButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaWeiBoButton];
    
    UIButton *faceBookButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [faceBookButton setTitle:@"FaceBook" forState:UIControlStateNormal];
    [faceBookButton setTag:5];
    [faceBookButton setFrame:CGRectMake(self.view.width / 2. - BUTTON_WIDTH / 2. - (BUTTON_WIDTH + BUTTON_MARGIN) * 2, self.view.height - 100, BUTTON_WIDTH, BUTTON_HEIGHT)];
    faceBookButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [faceBookButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:faceBookButton];
    
    UIButton *twitterButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [twitterButton setTitle:@"Twitter" forState:UIControlStateNormal];
    [twitterButton setTag:6];
    [twitterButton setFrame:CGRectMake(self.view.width / 2. - BUTTON_WIDTH / 2. - (BUTTON_WIDTH + BUTTON_MARGIN) * 1, faceBookButton.top, BUTTON_WIDTH, BUTTON_HEIGHT)];
    twitterButton.titleLabel.font = faceBookButton.titleLabel.font;
    [twitterButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterButton];

    qqFriendButton.backgroundColor = [UIColor brownColor];
    qqZoneButton.backgroundColor = [UIColor brownColor];
    weChatFriendButton.backgroundColor = [UIColor brownColor];
    weChatCircleButton.backgroundColor = [UIColor brownColor];
    sinaWeiBoButton.backgroundColor = [UIColor brownColor];
    faceBookButton.backgroundColor = [UIColor brownColor];
    twitterButton.backgroundColor = [UIColor brownColor];
    
}

- (void)loginButtonAction:(UIButton *)sender
{
    int index = (int)sender.tag;
    
    WEAKSELF
    [[ThirdOpenPlatformManager shareManager] thirdOpenPlatformLoginWithType:index
                                                             viewController:self
                                                           completeCallback:^(BOOL success, id info) {
                                                               if (success) {
                                                                   [weakSelf handleThirdOpenPlatformLogin:(NSDictionary *)info];
                                                               }
                                                               else {
                                                                   [weakSelf showPrompt:info ? info : @"登录失败"];
                                                               }
                                                           }];
}

- (void)shareButtonAction:(UIButton *)sender
{
    int index = (int)sender.tag;

    ShareModel *shareModel = [ShareModel new];
    shareModel.shareTitle = @"分享标题";
    shareModel.shareDescription = @"我在XXXXX，极致美食，一网打尽，一起做个资深吃货吧 !";
    shareModel.shareImage = [UIImage imageNamed:@"tab_me_sel"];
    shareModel.shareImageUrl = @"https://www.baidu.com/img/bd_logo1.png";
    shareModel.shareUrl = @"https://www.baidu.com";
    
    WEAKSELF
    [[ThirdOpenPlatformManager shareManager] thirdOpenPlatformShareWithType:index
                                                                    content:shareModel
                                                             viewController:self
                                                           completeCallback:^(BOOL success, id info) {
                                                               if (success) {
                                                                   [weakSelf showPrompt:@"分享成功"];
                                                               }
                                                               else {
                                                                   [weakSelf showPrompt:info ? info : @"分享失败"];
                                                               }
                                                           }];
}

- (void)handleThirdOpenPlatformLogin:(NSDictionary *)info {
    NSString *userID = info[@"userID"];
    NSString *accessToken = info[@"accessToken"];
    HttpParametersModel *httpParametersModel = nil;
    switch ([ThirdOpenPlatformManager shareManager].loginType) {
        case ThirdOpenPlatformLoginType_QQ: {
            httpParametersModel = [HttpParametersUtility qqLoginParametersWithOpenid:userID access_token:accessToken];
            break;
        }
        case ThirdOpenPlatformLoginType_WeChat: {
            httpParametersModel = [HttpParametersUtility weixinLoginParametersWithOpenid:userID access_token:accessToken];
            break;
        }
        case ThirdOpenPlatformLoginType_SinaWeibo: {
            httpParametersModel = [HttpParametersUtility weiboLoginParametersWithOpenid:userID access_token:accessToken];
            break;
        }
        case ThirdOpenPlatformLoginType_FaceBook: {
            httpParametersModel = [HttpParametersUtility faceBookLoginParametersWithOpenid:userID access_token:accessToken];
            break;
        }
        case ThirdOpenPlatformLoginType_Twitter: {
            httpParametersModel = [HttpParametersUtility twitterLoginParametersWithOpenid:userID access_token:accessToken];
            break;
        }
    }
    
    WEAKSELF
    [[HttpClient shareInstance] requestWithParameters:httpParametersModel success:^(id data) {
        [[User shareInstance] setUserFromDictionary:data];
        [[NSNotificationCenter defaultCenter]postNotificationName:USERINFO_UPDATE_NOTIFICATION object:nil];
    } failure:^(NSString *errorDescription) {
        [weakSelf showPrompt:errorDescription];
    }];
}

- (void)forgetPass {
    ZNLog();
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
    
    [self showLoadingView];
    
    @weakify(self);
    
    [[HttpClient shareInstance] requestWithParameters:[HttpParametersUtility loginParammetersWithPhone:txtUsername.text pass:txtPassword.text] success:^(id data) {
        @strongify(self);
        
        [[User shareInstance] setUserFromDictionary:data];
        ZNLog(@"%@", [User shareInstance]);
        [self hideLoadingView];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSString *errorDescription) {
        @strongify(self);
        
        ZNLog(@"%@", errorDescription);
        [self hideLoadingView];
    }];
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
