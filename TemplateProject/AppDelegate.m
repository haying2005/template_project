//
//  AppDelegate.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/11/30.
//
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "LoginViewController.h"
#import "HotFixEngine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 启动热修复
    [HotFixEngine startHotFixEngine];
    
    // 初始化语言设置
    [LanguageTool shareInstance];
    
    // 初始化TabBarController
    MainTabBarViewController *tabBarCtrl = [[MainTabBarViewController alloc]init];
    [self.window setRootViewController:tabBarCtrl];
    
    [self.window makeKeyAndVisible];
    
    [self testLanguage];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Test Language

- (void)testLanguage {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChangeNotificationHandle:) name:NOTIFICATION_LANGUAGE_CHANGE object:nil];
    
    ZNLog(@"%@", [[LanguageTool shareInstance] performSelector:sel_getUid("language")]);
    
    NSString *sendString = Localized(@"Send");
    NSString *cancelString = Localized(@"Cancel");
    NSString *sinaWeiboString = Localized(@"Sina Weibo");
    
    ZNLog(@"%@ %@ %@", sendString, cancelString, sinaWeiboString);
    
    [[LanguageTool shareInstance] setNewLanguage:CN_S];
    
    ZNLog(@"%@", [[LanguageTool shareInstance] performSelector:sel_getUid("language")]);
    
    sendString = Localized(@"Send");
    cancelString = Localized(@"Cancel");
    sinaWeiboString = Localized(@"Sina Weibo");
    ZNLog(@"%@ %@ %@", sendString, cancelString, sinaWeiboString);
#pragma clang diagnostic pop
}

- (void)languageChangeNotificationHandle:(NSNotification *)notification
{
    ZNLog(@"%@", notification);
}


@end
