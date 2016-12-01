//
//  Validate.h
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import <Foundation/Foundation.h>

@interface Validate : NSObject

//邮箱
+ (BOOL) validateEmail:(NSString *)email;


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;


//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;


//车型
+ (BOOL) validateCarType:(NSString *)CarType;


//用户名
+ (BOOL) validateUserName:(NSString *)name;


//密码
+ (BOOL) validatePassword:(NSString *)passWord;


//昵称
+ (BOOL) validateNickname:(NSString *)nickname;


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

@end
