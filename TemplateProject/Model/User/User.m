//
//  User.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import "User.h"
#import "FMDB.h"

#define currentUserId @"currentUserId"

@implementation User

- (instancetype)init {
    if (self = [super init]) {
        self.loginStatus = NO;
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"userId" : @"id"
             };
}

+ (instancetype)shareInstance {
    static User *user;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
    });
    
    return user;
}


- (NSString *)getUUID {
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

//用于初始化接口回调成功后 把从网络返回的信息传入到本地对象
- (void)setUserFromDictionary:(NSDictionary *)dictionary {
    NSDictionary *userInfo = [dictionary objectForKey:@"user"];
    
    //self.isComplete = [[dictionary objectForKey:@"isComplete"]boolValue];
    self.accessToken = [dictionary objectForKey:@"accessToken"];
    //self.sign = [dictionary objectForKey:@"sign"];
    self.loginStatus = [[dictionary objectForKey:@"loginStatus"] boolValue];
    
    self.userId = [[userInfo objectForKey:@"id"]stringValue];
    //self.userDesc = [userInfo objectForKey:@"description"];
    self.userName = [userInfo objectForKey:@"username"];
    self.nickName = [userInfo objectForKey:@"nickName"];
    self.head = [userInfo objectForKey:@"head"];
    //self.cover = [userInfo objectForKey:@"cover"];
    //self.userLevel = [[userInfo objectForKey:@"userLevel"]integerValue];
    //self.userExp = [[userInfo objectForKey:@"userExp"]integerValue];
    //self.liveLevel = [[userInfo objectForKey:@"liveLevel"]integerValue];
    //self.liveExp = [[userInfo objectForKey:@"liveExp"]integerValue];
    //self.followCnt = [[userInfo objectForKey:@"followCnt"]integerValue];
    //self.fansCnt = [[userInfo objectForKey:@"fansCnt"]integerValue];
    //self.coin = [[userInfo objectForKey:@"coin"]integerValue];
    //self.income = [[userInfo objectForKey:@"income"]integerValue];
    //self.guildId = [[userInfo objectForKey:@"guildId"]stringValue];
    //self.guildName = [userInfo objectForKey:@"guildName"];
    //self.timeOffset = [[NSDate date] timeIntervalSince1970] - [[dictionary objectForKey:@"time"] doubleValue];
    //self.vipLevel = [[userInfo objectForKey:@"vipLevel"] integerValue];
    //self.vipExpiryTime = [[userInfo objectForKey:@"vipExpiryTime"] doubleValue];
    //self.specialPayFlag = [[dictionary objectForKey:@"specialPay"] boolValue];
    
}

- (NSString *)description {
    return [self yy_modelDescription];
}


@end
