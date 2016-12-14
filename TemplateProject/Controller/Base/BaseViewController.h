//
//  BaseViewController.h
//  TemplateProject
//
//  Created by tan on 2016/12/7.
//
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

// 页面跳转
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)popToPreviousViewControllerAnimated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

// 提示
- (void)showPrompt:(NSString *)string;

// 加载等待视图，在当前页面上
- (void)showLoadingView;
- (void)showLoadingViewWithPrompt:(NSString *)prompt;
- (void)hideLoadingView;
- (BOOL)loadingViewIsShow;

// 加载等待视图，在应用窗口上
+ (void)showLoadingView;
+ (void)showLoadingViewWithPrompt:(NSString *)prompt;
+ (void)hideLoadingView;

// 取消键盘tap手势
- (void)addKeyboardHideTapGestureRecoginzer;
- (void)hideKeyboardTapGestureHandle:(UITapGestureRecognizer *)tapGestureRecognizer;

// 加载出错视图
- (UIView *)loadingErrorView;
- (void)showLoadingErrorView;
- (void)hideLoadingErrorView;
- (BOOL)loadingErrorViewIsShow;
- (void)reload;

// 导航栏配置
- (void)configureDefaultLeftItem;
- (void)configureLeftItem:(UIBarButtonItem *)barButtonItem;
- (void)configureTitle:(NSString *)title;
- (void)configureRightItem:(UIBarButtonItem *)barButtonItem;
- (void)backButtonAction:(id)sender;

// 输入时自动键盘管理
- (void)enableIQ:(BOOL)enableIQ enableAutoToolbar:(BOOL)enableAutoToolbar;

// 多语言
- (void)observeLanguageChangeNotification;
- (void)handleLanguageChangeNotification:(NSNotification *)notification;

@end
