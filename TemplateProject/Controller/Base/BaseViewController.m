//
//  BaseViewController.m
//  TemplateProject
//
//  Created by tan on 2016/12/7.
//
//

#import "BaseViewController.h"
#import "SDImageCache.h"
#import "MBProgressHUD.h"
#import "UIViewAdditions.h"
#import "AppDelegate.h"
#import "IQKeyboardManager.h"

@interface BaseViewController ()
{
    UIView *_loadingErrorView;
    
    BOOL _hasChangedIQKeyboard;
    BOOL _iqKeyboardEnableBackup;
    BOOL _iqKeyboardEnableAutoToolbarBackup;
}
@end

@implementation BaseViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_hasChangedIQKeyboard) {
        [[IQKeyboardManager sharedManager] setEnable:_iqKeyboardEnableBackup];
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:_iqKeyboardEnableAutoToolbarBackup];
    }
}

#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    [[SDImageCache sharedImageCache] clearMemory];
}

#pragma mark - Public Utility

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)popToPreviousViewControllerAnimated:(BOOL)animated
{
    [self.navigationController popViewControllerAnimated:animated];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:animated];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.navigationController popToViewController:viewController animated:animated];
}

- (void)showPrompt:(NSString *)string
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:NO];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    [hud hide:YES afterDelay:2.];
}

- (void)showLoadingView
{
    MBProgressHUD *progressHud=(MBProgressHUD *)[self.view subviewWithClassName:NSStringFromClass([MBProgressHUD class])];
    if (progressHud) {
        [self.view bringSubviewToFront:progressHud];
        return ;
    }
    
    progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    progressHud.mode = MBProgressHUDModeIndeterminate;
    progressHud.labelText = @"加载中...";
    progressHud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:progressHud];
    [self.view bringSubviewToFront:progressHud];
    [progressHud show:YES];
}

- (void)showLoadingViewWithPrompt:(NSString *)prompt
{
    if ([self.view subviewWithClassName:NSStringFromClass([MBProgressHUD class])])
        return ;
    
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    progressHud.mode = MBProgressHUDModeIndeterminate;
    progressHud.labelText = prompt;
    progressHud.removeFromSuperViewOnHide = YES;
    [self.view addSubview:progressHud];
    [self.view bringSubviewToFront:progressHud];
    [progressHud show:YES];
}

- (void)hideLoadingView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (BOOL)loadingViewIsShow
{
    return [self.view subviewWithClassName:NSStringFromClass([MBProgressHUD class])] != nil;
}

+ (void)showLoadingView
{
    if ([[AppDelegate appDelegate].window subviewWithClassName:NSStringFromClass([MBProgressHUD class])])
        return ;
    
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:[AppDelegate appDelegate].window];
    progressHud.mode = MBProgressHUDModeIndeterminate;
    progressHud.removeFromSuperViewOnHide = YES;
    [[AppDelegate appDelegate].window addSubview:progressHud];
    [[AppDelegate appDelegate].window bringSubviewToFront:progressHud];
    [progressHud show:YES];
}

+ (void)showLoadingViewWithPrompt:(NSString *)prompt
{
    MBProgressHUD *progressHud = [[MBProgressHUD alloc] initWithView:[AppDelegate appDelegate].window];
    progressHud.mode = MBProgressHUDModeIndeterminate;
    progressHud.labelText = prompt;
    progressHud.removeFromSuperViewOnHide = YES;
    [[AppDelegate appDelegate].window addSubview:progressHud];
    [[AppDelegate appDelegate].window bringSubviewToFront:progressHud];
    [progressHud show:YES];
}

+ (void)hideLoadingView
{
    [MBProgressHUD hideHUDForView:[AppDelegate appDelegate].window animated:YES];
}

- (void)addKeyboardHideTapGestureRecoginzer
{
    UITapGestureRecognizer *hideKeyboardTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardTapGestureHandle:)];
    hideKeyboardTapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:hideKeyboardTapGesture];
}

- (void)hideKeyboardTapGestureHandle:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self.view endEditing:YES];
    }
}

- (UIView *)loadingErrorView
{
    if (!_loadingErrorView) {
        _loadingErrorView = [[UIView alloc] initWithFrame:self.view.bounds];
        _loadingErrorView.backgroundColor = [UIColor colorWithIntegerRed:231 green:231 blue:231 alpha:1.];
        _loadingErrorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UITapGestureRecognizer *reloadTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadTapGestureHandle:)];
        reloadTapGesture.cancelsTouchesInView = NO;
        [_loadingErrorView addGestureRecognizer:reloadTapGesture];
        
        UIImage *errorImage = [UIImage imageNamed:@"loadingerror"];
        UIImageView *loadingErrorImageView = [UIImageView new];
        loadingErrorImageView.image = errorImage;
        loadingErrorImageView.frame = CGRectMake(_loadingErrorView.width / 2. - errorImage.size.width / 2., _loadingErrorView.height / 2. - errorImage.size.height / 2. - 50, errorImage.size.width, errorImage.size.height);
        [_loadingErrorView addSubview:loadingErrorImageView];

        UILabel *_loadingErrorHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _loadingErrorHintLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _loadingErrorHintLabel.textColor = [UIColor colorWithIntegerRed:156 green:156 blue:156 alpha:1.];
        _loadingErrorHintLabel.textAlignment = NSTextAlignmentCenter;
        _loadingErrorHintLabel.numberOfLines = NSIntegerMax;
        _loadingErrorHintLabel.font = [UIFont systemFontOfSize:12.];
        _loadingErrorHintLabel.text = @"加载失败，点击重新加载";
        _loadingErrorHintLabel.frame = CGRectMake(0, loadingErrorImageView.bottom + 10, _loadingErrorView.width, 20);
        [_loadingErrorView addSubview:_loadingErrorHintLabel];
    }
    return _loadingErrorView;
}

- (void)showLoadingErrorView
{
    [self.view addSubview:[self loadingErrorView]];
    [self.view bringSubviewToFront:[self loadingErrorView]];
    [self loadingErrorView].hidden = NO;
}

- (void)hideLoadingErrorView
{
    [self loadingErrorView].hidden = YES;
    [self.view sendSubviewToBack:_loadingErrorView];
    [[self loadingErrorView] removeFromSuperview];
}

- (BOOL)loadingErrorViewIsShow
{
    return _loadingErrorView && _loadingErrorView.hidden == NO;
}

- (void)reloadTapGestureHandle:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self reload];
    }
}

- (void)reload
{
    ZNLog();
}

- (void)configureDefaultLeftItem
{
    UIImage *normalImage = [UIImage imageNamed:@"navigation_bar_back"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, normalImage.size.width, 44);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setImage:normalImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)configureLeftItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

- (void)configureTitle:(NSString *)title
{
    self.title = title;
}

- (void)configureRightItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)backButtonAction:(id)sender;
{
    [self popToPreviousViewControllerAnimated:YES];
}

- (void)enableIQ:(BOOL)enableIQ enableAutoToolbar:(BOOL)enableAutoToolbar
{
    _hasChangedIQKeyboard = YES;
    _iqKeyboardEnableBackup = [[IQKeyboardManager sharedManager] isEnabled];
    _iqKeyboardEnableAutoToolbarBackup = [[IQKeyboardManager sharedManager] isEnableAutoToolbar];
}

- (void)observeLanguageChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLanguageChangeNotification:) name:NOTIFICATION_LANGUAGE_CHANGE object:nil];
}

- (void)handleLanguageChangeNotification:(NSNotification *)notification
{
    ZNLog();
}

@end
