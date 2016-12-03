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
@property (nonatomic, copy)NSString *password;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *userNick;
@property (nonatomic, copy)NSString *headUrl;
@property (nonatomic, assign)BOOL isLogin;

+ (instancetype)shareInstance;
+ (NSDictionary *)registerUser:(User *)user;
+ (NSDictionary *)login:(NSString *)userName pass:(NSString *)pass;
- (NSDictionary *)logout;
+ (void)loadCurrentUser;
- (BOOL)updateInfo:(NSDictionary *)dic;

@end
