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
    ThirdOpenPlatform_QQ,
    ThirdOpenPlatform_WeChat,
    ThirdOpenPlatform_SinaWeibo
} ThirdOpenPlatformType;

typedef enum {
    ThirdOpenPlatformShareType_QQFriend,
    ThirdOpenPlatformShareType_QQZone,
    ThirdOpenPlatformShareType_WeChatFriend,
    ThirdOpenPlatformShareType_WeChatCircle,
    ThirdOpenPlatformShareType_SinaWeibo
} ThirdOpenPlatformShareType;

@interface ThirdOpenPlatformManager : NSObject

@property (nonatomic, assign) ThirdOpenPlatformType loginType;
@property (nonatomic, assign) ThirdOpenPlatformShareType shareType;

+ (ThirdOpenPlatformManager *)shareManager;

- (void)registerThirdOpenPlatform;

- (BOOL)handleOpenURL:(NSURL *)url;

- (void)thirdOpenPlatformLoginWithType:(ThirdOpenPlatformType)loginType
                        viewController:(id)viewController
                      completeCallback:(void (^)(BOOL success, id info))completeCallback;

- (void)thirdOpenPlatformLogout;

- (void)thirdOpenPlatformShareWithType:(ThirdOpenPlatformShareType)shareType
                               content:(ShareModel *)shareModel
                        viewController:(id)viewController
                      completeCallback:(void (^)(BOOL success, id info))completeCallback;

@end
