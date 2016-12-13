//
//  ThirdOpenPlatformManager.m
//  TemplateProject
//
//  Created by tan on 2016/12/9.
//
//

#import "ThirdOpenPlatformManager.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "WXApiObject.h"
#import <MBProgressHUD.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

@interface ThirdOpenPlatformManager () <TencentSessionDelegate, WeiboSDKDelegate, WXApiDelegate, QQApiInterfaceDelegate, FBSDKSharingDelegate>
{
    TencentOAuth *_tencentOAuth;
    NSString *_sinaWeiBoAccessToken;
}

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, copy) void (^loginCompleteCallback)(BOOL success, id info);
@property (nonatomic, copy) void (^shareCompleteCallback)(BOOL success, id info);

@end

@implementation ThirdOpenPlatformManager

#pragma mark - Singleton

+ (ThirdOpenPlatformManager *)shareManager
{
    static ThirdOpenPlatformManager *thirdOpenPlatformManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!thirdOpenPlatformManager) {
            thirdOpenPlatformManager = [[self alloc] init];
        }
    });
    return thirdOpenPlatformManager;
}

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

#pragma mark - Utility

- (void)registerThirdOpenPlatform
{
    [self registerWeChat];
    [self registerSinaWeibo];
    [self registerQQ];
    [self registerFaceBook];
    [self registerTwitter];
}

- (BOOL)handleOpenURL:(NSURL *)url
          application:(UIApplication *)application
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation
{
    NSString *string = [url absoluteString];
    if ([string hasPrefix:@"tencent"]) { // QQ
        if ([string rangeOfString:@"qzapp"].location != NSNotFound) { // QQ登录
            [TencentOAuth HandleOpenURL:url];
        } else if ([string rangeOfString:@"response_from_qq"].location != NSNotFound) { // QQ分享
            [QQApiInterface handleOpenURL:url delegate:self];
        }
    } else if ([string hasPrefix:@"wb"]) { // 微博
        [WeiboSDK handleOpenURL:url delegate:self];
    } else if ([string hasPrefix:@"wx"]) { // 微信
        [WXApi handleOpenURL:url delegate:self];
    }
    else if ([string hasPrefix:@"fb"]) { // FaceBook
        [[FBSDKApplicationDelegate sharedInstance] application:application
                                                       openURL:url
                                             sourceApplication:sourceApplication
                                                    annotation:annotation];
    }
    
    return YES;
}

- (void)handleApplicationDidBecomeActive
{
    [FBSDKAppEvents activateApp];
}

- (void)thirdOpenPlatformLoginWithType:(ThirdOpenPlatformLoginType)loginType
                        viewController:(id)viewController
                      completeCallback:(void (^)(BOOL success, id info))completeCallback
{
    self.loginType = loginType;
    self.viewController = viewController;
    self.loginCompleteCallback = completeCallback;
    
    switch (loginType) {
        case ThirdOpenPlatformLoginType_QQ: {
            [self qqLogin];
            break;
        }
        case ThirdOpenPlatformLoginType_WeChat: {
            [self weiXinLogin];
            break;
        }
        case ThirdOpenPlatformLoginType_SinaWeibo: {
            [self sinaWeiBoLogin];
            break;
        }
        case ThirdOpenPlatformLoginType_FaceBook: {
            [self faceBookLogin];
            break;
        }
        case ThirdOpenPlatformLoginType_Twitter: {
            [self twitterLogin];
            break;
        }
    }
}

- (void)thirdOpenPlatformLogout
{
    switch (self.loginType) {
        case ThirdOpenPlatformLoginType_QQ: {
            [self qqLogout];
            break;
        }
        case ThirdOpenPlatformLoginType_WeChat: {
            [self weiXinLogout];
            break;
        }
        case ThirdOpenPlatformLoginType_SinaWeibo: {
            [self sinaWeiBoLogout];
            break;
        }
        case ThirdOpenPlatformLoginType_FaceBook: {
            [self faceBookLogout];
            break;
        }
        case ThirdOpenPlatformLoginType_Twitter: {
            [self twitterLogout];
            break;
        }
    }
}

- (void)thirdOpenPlatformShareWithType:(ThirdOpenPlatformShareType)shareType
                               content:(ShareModel *)shareModel
                        viewController:(id)viewController
                      completeCallback:(void (^)(BOOL success, id info))completeCallback
{
    self.shareType = shareType;
    self.viewController = viewController;
    self.shareCompleteCallback = completeCallback;
    
    switch (shareType) {
        case ThirdOpenPlatformShareType_QQFriend: {
            [self qqShareToFriend:shareModel];
            break;
        }
        case ThirdOpenPlatformShareType_QQZone: {
            [self qqShareToZone:shareModel];
            break;
        }
        case ThirdOpenPlatformShareType_WeChatFriend: {
            [self weiXinShareToFriend:shareModel];
            break;
        }
        case ThirdOpenPlatformShareType_WeChatCircle: {
            [self weiXinShareToCircle:shareModel];
            break;
        }
        case ThirdOpenPlatformShareType_SinaWeibo: {
            [self sinaWeiBoShare:shareModel];
            break;
        }
        case ThirdOpenPlatformShareType_FaceBook: {
            [self faceBookShare:shareModel];
            break;
        }
        case ThirdOpenPlatformShareType_Twitter: {
            [self twitterShare:shareModel];
            break;
        }
    }
}

- (void)showMessage:(NSString *)string {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow] animated:NO];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = string;
    [hud hide:YES afterDelay:2.];
}

#pragma mark - QQ

- (void)registerQQ
{
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kTencentQQAppKey andDelegate:self];
}

- (void)qqLogin
{
    NSArray *permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            nil];
    
    [_tencentOAuth authorize:permissions inSafari:NO];
}

- (void)tencentDidLogin
{
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]) {
        if (self.loginCompleteCallback) {
            self.loginCompleteCallback(YES, nil);
        }
    } else {
        if (self.loginCompleteCallback) {
            self.loginCompleteCallback(NO, nil);
        }
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (self.loginCompleteCallback) {
        self.loginCompleteCallback(NO, cancelled ? @"用户取消" : nil);
    }
}

- (void)tencentDidNotNetWork
{
    ZNLog();
}

- (void)onReq:(QQBaseReq *)req
{
    ZNLog();
}

- (void)isOnlineResponse:(NSDictionary *)response
{
    ZNLog();
}

- (void)qqLogout
{
    [_tencentOAuth logout:nil];
}

- (void)qqShareToFriend:(ShareModel *)shareModel
{
    [self qqShare:NO content:shareModel];
}

- (void)qqShareToZone:(ShareModel *)shareModel
{
    [self qqShare:YES content:shareModel];
}

- (void)qqShare:(BOOL)isShareToZone content:(ShareModel *)shareModel
{
    if (![QQApiInterface isQQInstalled]) {
        [self showMessage:@"您没有安装QQ客户端!"];
        return;
    }
    
    QQApiNewsObject *newsObj = nil;
    
    if (shareModel.shareImageUrl) {
        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareModel.shareUrl]
                                           title:shareModel.shareTitle
                                     description:shareModel.shareDescription
                                 previewImageURL:[NSURL URLWithString:shareModel.shareImageUrl]];
    }
    else if (shareModel.shareImage) {
        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:shareModel.shareUrl]
                                           title:shareModel.shareTitle
                                     description:shareModel.shareDescription
                                previewImageData:UIImagePNGRepresentation(shareModel.shareImage)];
    }
    
    if (!newsObj) {
        return ;
    }
    
    if (isShareToZone) {
        [newsObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    }
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    ZNLog(@"%d", sent);
}

#pragma mark - WeiXin

- (void)registerWeChat
{
    [WXApi registerApp:kWeiXinAppKey];
}

- (NSString *)generateRandomStringWithLength:(int)length
{
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (int i = 0; i < length; i++)
    {
        unsigned index = arc4random() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

- (void)weiXinLogin
{
    SendAuthReq *sendAuthReq = [SendAuthReq new];
    sendAuthReq.scope = @"snsapi_userinfo";
    sendAuthReq.state = [self generateRandomStringWithLength:15];
    
    [WXApi sendAuthReq:sendAuthReq viewController:self.viewController delegate:self];
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) { // 微信支付

    } else if ([resp isKindOfClass:[SendMessageToWXResp class]]) { // 微信分享
        alert(@"提示", (resp.errCode == WXSuccess) ? @"分享成功" : @"分享失败");
    } else if ([resp isKindOfClass:[SendAuthResp class]]) { // 微信登录
        NSString *urlString = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", kWeiXinAppKey, kWeiXinAppSecret, ((SendAuthResp *)resp).code];

        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data.length) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                NSString *accessToken = dict[@"access_token"];
                if (accessToken) {
                    if (self.loginCompleteCallback) {
                        self.loginCompleteCallback((accessToken != nil), nil);
                    }
                }
            }
        }];
    } else if ([resp isKindOfClass:[QQBaseResp class]]) { // QQ分享
        if ([(QQBaseResp *)resp type] == 2) {
            BOOL isSuccess = NO;
            if ([[(QQBaseResp *)resp result] isEqualToString:@"0"]) {
                isSuccess = YES;
            }
            alert(@"提示", isSuccess ? @"分享成功" : @"分享失败");
        }
    }
}

- (void)weiXinLogout
{
    
}

- (void)weiXinShareToFriend:(ShareModel *)shareModel
{
    [self weiXinShare:WXSceneSession content:shareModel];
}

- (void)weiXinShareToCircle:(ShareModel *)shareModel
{
    [self weiXinShare:WXSceneTimeline content:shareModel];
}

- (void)weiXinShare:(int)wxScene content:(ShareModel *)shareModel
{
    if (![WXApi isWXAppInstalled]) {
        [self showMessage:@"您没有安装微信客户端!"];
        return;
    }
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = shareModel.shareUrl;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = shareModel.shareTitle;
    message.description = shareModel.shareDescription;
    message.thumbData = UIImagePNGRepresentation(shareModel.shareImage);
    message.mediaObject = ext;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = wxScene;
    
    [WXApi sendReq:req];
}

#pragma mark - SinaWeiBo

- (void)registerSinaWeibo
{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaWeiBoAppKey];
}

- (void)sinaWeiBoLogin
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kSinaWeiBoRedirectURL;
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    ZNLog();
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            alert(@"提示", @"分享成功");
        }
        else {
            alert(@"提示", @"分享失败");
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        if (self.loginCompleteCallback) {
            self.loginCompleteCallback((response.statusCode == WeiboSDKResponseStatusCodeSuccess), nil);
        }
        
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            _sinaWeiBoAccessToken = [(WBAuthorizeResponse *)response accessToken];
        }
    }
}

- (void)sinaWeiBoLogout
{
    [WeiboSDK logOutWithToken:_sinaWeiBoAccessToken delegate:nil withTag:nil];
}

- (void)sinaWeiBoShare:(ShareModel *)shareModel
{
    if (![WeiboSDK isWeiboAppInstalled]) {
        [self showMessage:@"您没有安装微博客户端!"];
        return;
    }
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kSinaWeiBoRedirectURL;
    authRequest.scope = @"all";
    
    WBImageObject *image = [WBImageObject object];
    image.imageData = UIImagePNGRepresentation(shareModel.shareImage);
    
    WBMessageObject *message = [WBMessageObject message];
    message.imageObject = image;
    message.text = shareModel.shareDescription;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}

#pragma mark - FaceBook

- (void)registerFaceBook
{
    [[FBSDKApplicationDelegate sharedInstance] application:nil
                             didFinishLaunchingWithOptions:nil];
}

- (void)faceBookLogin
{
    WEAKSELF
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithPublishPermissions:@[@"publish_actions"]
                    fromViewController:self.viewController
                               handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                   if (error) {
                                       if (weakSelf.loginCompleteCallback) {
                                           weakSelf.loginCompleteCallback(NO, nil);
                                       }
                                       return;
                                   }
                                   
                                   if ([FBSDKAccessToken currentAccessToken] &&
                                       [[FBSDKAccessToken currentAccessToken].permissions containsObject:@"publish_actions"]) {
                                       if (weakSelf.loginCompleteCallback) {
                                           weakSelf.loginCompleteCallback(YES, nil);
                                       }
                                       return;
                                   }
                               }];
}

- (void)faceBookLogout
{
    if ([FBSDKAccessToken currentAccessToken]) {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logOut];
    }
}

- (void)faceBookShare:(ShareModel *)shareModel
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:shareModel.shareUrl];
    content.contentTitle = shareModel.shareTitle;
    content.imageURL = [NSURL URLWithString:shareModel.shareImageUrl];
    content.contentDescription = shareModel.shareDescription;
    
    [FBSDKShareDialog showFromViewController:self.viewController
                                 withContent:content
                                    delegate:self];
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    if (self.shareCompleteCallback) {
        self.shareCompleteCallback((results != nil), nil);
    }
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    if (self.shareCompleteCallback) {
        self.shareCompleteCallback(NO, nil);
    }
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    if (self.shareCompleteCallback) {
        self.shareCompleteCallback(NO, @"用户取消");
    }
}

#pragma mark - Twitter

- (void)registerTwitter
{
    [Fabric with:@[[Twitter class]]];
    [[Twitter sharedInstance] startWithConsumerKey:kTwitterAppKey consumerSecret:kTwitterAppSecret];
}

- (void)twitterLogin
{
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            if (self.loginCompleteCallback) {
                self.loginCompleteCallback(YES, nil);
            }
        } else {
            if (self.loginCompleteCallback) {
                self.loginCompleteCallback(NO, nil);
            }
        }
    }];
}

- (void)twitterLogout
{
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    NSString *userID = store.session.userID;
    [store logOutUserID:userID];
}

- (void)twitterShare:(ShareModel *)shareModel
{
    TWTRComposer *composer = [[TWTRComposer alloc] init];
    [composer setText:shareModel.shareDescription];
    [composer setImage:shareModel.shareImage];
    [composer setURL:[NSURL URLWithString:shareModel.shareUrl]];
    
    [composer showFromViewController:self.viewController completion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) {
            if (self.shareCompleteCallback) {
                self.shareCompleteCallback(NO, @"用户取消");
            }
        }
        else {
            if (self.shareCompleteCallback) {
                self.shareCompleteCallback(YES, nil);
            }
        }
    }];
}

@end
