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
#import "MapViewController.h"
#import "DownloaderViewController.h"

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
    
    //[User loadCurrentUser];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLanguageChangeNotification:) name:NOTIFICATION_LANGUAGE_CHANGE object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)initTabBar {
    
    
//    UIViewController *ctrl1 = [[UIViewController alloc]init];
//    DownloaderViewController *ctrl1 = [[DownloaderViewController alloc] init];
    LoginViewController *ctrl1 = [[LoginViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:ctrl1];
    ctrl1.navigationItem.title = Localized(@"message");
    [self addChildCtrl:nav1 title:ctrl1.navigationItem.title icon:[UIImage imageNamed:@"tab_me_sel"]];
    
    //UIViewController *ctrl2 = [[UIViewController alloc]init];
    MapViewController *ctrl2 = [[MapViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:ctrl2];
    ctrl2.navigationItem.title = Localized(@"nearby");
    [self addChildCtrl:nav2 title:ctrl2.navigationItem.title icon:[UIImage imageNamed:@"tab_me_sel"]];
    
    TestViewController *ctrl3 = [[TestViewController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:ctrl3];
    ctrl3.navigationItem.title = Localized(@"test");
    [self addChildCtrl:nav3 title:ctrl3.navigationItem.title icon:[UIImage imageNamed:@"tab_me_sel"]];
    
    MineViewController *ctrl4 = [[MineViewController alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:ctrl4];
    ctrl4.navigationItem.title = Localized(@"mine");
    [self addChildCtrl:nav4 title:ctrl4.navigationItem.title icon:[UIImage imageNamed:@"tab_me_sel"]];
    
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
        if (![[User shareInstance] loginStatus]) {
            [self showLoginView];
            return NO;
        }
        return YES;
    }
    return YES;
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

#pragma mark - Notification Handle

- (void)handleLanguageChangeNotification:(NSNotification *)notification
{
    for (int i = 0; i < self.viewControllers.count; i++) {
        UINavigationController *navigationController = self.viewControllers[i];
        
        NSString *localizedTitle = nil;
        switch (i) {
            case 0:
            {
                localizedTitle = Localized(@"message");
            }
                break;
            case 1:
            {
                localizedTitle = Localized(@"nearby");
            }
                break;
            case 2:
            {
                localizedTitle = Localized(@"test");
            }
                break;
            case 3:
            {
                localizedTitle = Localized(@"mine");
            }
                break;
            default:
                break;
        }
        
        ((UIViewController *)[navigationController.viewControllers firstObject]).navigationItem.title = localizedTitle;
        navigationController.tabBarItem.title = localizedTitle;
    }
}

@end
