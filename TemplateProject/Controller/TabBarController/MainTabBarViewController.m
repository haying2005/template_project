//
//  MainTabBarViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/11/30.
//
//

#import "MainTabBarViewController.h"
#import "LoginViewController.h"
#import "TestViewController.h"
#import "User.h"
#import "MineViewController.h"

@interface MainTabBarViewController () <UITabBarControllerDelegate>

{
    
}

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initTabBar];
    self.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)initTabBar {
    
    
    UIViewController *ctrl1 = [[UIViewController alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:ctrl1];
    ctrl1.navigationItem.title = @"消息";
    [self addChildCtrl:nav1 title:@"消息" icon:[UIImage imageNamed:@"tab_me_sel"]];
    
    UIViewController *ctrl2 = [[UIViewController alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:ctrl2];
    ctrl2.navigationItem.title = @"附近";
    [self addChildCtrl:nav2 title:@"附近" icon:[UIImage imageNamed:@"tab_me_sel"]];
    
    UIViewController *ctrl3 = [[UIViewController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:ctrl3];
    ctrl3.navigationItem.title = @"发现";
    [self addChildCtrl:nav3 title:@"发现" icon:[UIImage imageNamed:@"tab_me_sel"]];
    
    MineViewController *ctrl4 = [[MineViewController alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:ctrl4];
    ctrl4.navigationItem.title = @"我的";
    [self addChildCtrl:nav4 title:@"我的" icon:[UIImage imageNamed:@"tab_me_sel"]];
    
}

- (void)addChildCtrl:(UIViewController *)ctrl title:(NSString *)title icon:(UIImage *)icon {
    
    UITabBarItem *item = [[UITabBarItem alloc]init];
    [item setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateSelected];
    item.title = title;
    item.image = icon;
    ctrl.tabBarItem = item;
    [self addChildViewController:ctrl];
}

- (void)showLoginView {
    LoginViewController *loginViewController = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [self presentViewController:nav animated:YES completion:^{
        //
    }];
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([[viewController tabBarItem].title isEqualToString:@"我的"]) {
        if (![[User shareInstance] isLogin]) {
            [self showLoginView];
            return NO;
        }
        return YES;
    }
    return YES;
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}


@end
