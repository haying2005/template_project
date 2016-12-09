//
//  User.h
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy)NSString *userId;
//@property (nonatomic, copy)NSString *password;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy)NSString *head;
@property (nonatomic, assign)BOOL loginStatus;
@property (nonatomic, strong)NSString *accessToken;

+ (instancetype)shareInstance;

//用于初始化接口回调成功后 把从网络返回的信息传入到本地对象
- (void)setUserFromDictionary:(NSDictionary *)dictionary;

- (NSString *)getUUID;

@end
