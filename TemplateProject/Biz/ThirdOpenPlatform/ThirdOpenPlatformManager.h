//
//  ThirdOpenPlatformManager.h
//  TemplateProject
//
//  Created by tan on 2016/12/9.
//
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "ShareModel.h"

typedef enum {
    ThirdOpenPlatformLoginType_QQ,
    ThirdOpenPlatformLoginType_WeChat,
    ThirdOpenPlatformLoginType_SinaWeibo,
    ThirdOpenPlatformLoginType_FaceBook,
    ThirdOpenPlatformLoginType_Twitter
} ThirdOpenPlatformLoginType;

typedef enum {
    ThirdOpenPlatformShareType_QQFriend,
    ThirdOpenPlatformShareType_QQZone,
    ThirdOpenPlatformShareType_WeChatFriend,
    ThirdOpenPlatformShareType_WeChatCircle,
    ThirdOpenPlatformShareType_SinaWeibo,
    ThirdOpenPlatformShareType_FaceBook,
    ThirdOpenPlatformShareType_Twitter
} ThirdOpenPlatformShareType;

@interface ThirdOpenPlatformManager : NSObject

@property (nonatomic, assign) ThirdOpenPlatformLoginType loginType;
@property (nonatomic, assign) ThirdOpenPlatformShareType shareType;

+ (ThirdOpenPlatformManager *)shareManager;

- (void)registerThirdOpenPlatform;

- (BOOL)handleOpenURL:(NSURL *)url
          application:(UIApplication *)application
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation;

- (void)handleApplicationDidBecomeActive;

- (void)thirdOpenPlatformLoginWithType:(ThirdOpenPlatformLoginType)loginType
                        viewController:(id)viewController
                      completeCallback:(void (^)(BOOL success, id info))completeCallback;

- (void)thirdOpenPlatformLogout;

- (void)thirdOpenPlatformShareWithType:(ThirdOpenPlatformShareType)shareType
                               content:(ShareModel *)shareModel
                        viewController:(id)viewController
                      completeCallback:(void (^)(BOOL success, id info))completeCallback;

@end
