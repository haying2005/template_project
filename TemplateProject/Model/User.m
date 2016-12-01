//
//  User.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import "User.h"

@implementation User

- (instancetype)init {
    if (self = [super init]) {
        self.userId = @"007";
        self.userName = @"13818268049";
        self.userNick = @"爱笑的女孩";
        self.headUrl = @"http://tva1.sinaimg.cn/crop.0.0.1080.1080.1024/871462bbjw8ew5s8g3y7oj20u00u0wg5.jpg";
        self.isLogin = NO;
    }
    return self;
}

+ (instancetype)shareInstance {
    static User *user;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        user = [[User alloc]init];
    });
    
    return user;
}
@end
