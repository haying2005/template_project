//
//  User.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import "User.h"
#import "FMDatabase.h"


@implementation User

- (instancetype)init {
    if (self = [super init]) {
        self.userId = @"007";
        self.userName = @"13818268049";
        self.userNick = @"爱笑的女孩";
        self.headUrl = @"";
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


//测试代码
+ (NSDictionary *)registerUser:(User *)user {
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (!db.open) {
        db = nil;
        NSDictionary *dic = @{@"code" : @1, @"errMsg" : @"数据库错误"};
        return dic;
    }
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_user (id integer PRIMARY KEY AUTOINCREMENT, username text NOT NULL, password text NOT NULL, nick text NOT NULL, head text NOT NULL, login bool NOT NULL)"];
    if (result) {
        NSLog(@"建表成功");
    }
    else {
        NSLog(@"建表失败");
        NSDictionary *dic = @{@"code" : @1, @"errMsg" : @"数据库错误"};
        return dic;
    }
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_user"];
    while ([rs next]) {
//        int ID = [rs intForColumn:@"id"];
        NSString *username = [rs stringForColumn:@"username"];
//        NSString *password = [rs stringForColumn:@"password"];
//        NSString *nick = [rs stringForColumn:@"nick"];
//        NSString *head = [rs stringForColumn:@"head"];
//        BOOL login = [rs boolForColumn:@"login"];
        
        
        if ([username isEqualToString: user.userName]) {
            NSLog(@"用户名已被占用！");
            NSDictionary *dic = @{@"code" : @1, @"errMsg" : @"用户名已被占用"};
            return dic;
        }
    }
    
    
    BOOL result1 = [db executeUpdate: @"INSERT INTO t_user (username, password, nick, head, login) VALUES (?, ?, ?, ?, ?);", user.userName, user.password, user.userNick, user.headUrl, @(0)];
    if (result1) {
        NSLog(@"插入成功！");
        NSDictionary *dic = @{@"code" : @0, @"errMsg" : @"ok!"};
        return dic;
    }
    else {
        NSLog(@"error = %@", [db lastErrorMessage]);
        NSDictionary *dic = @{@"code" : @1, @"errMsg" : @"数据库错误"};
        return dic;
    }
}

+ (NSDictionary *)login:(NSString *)userName pass:(NSString *)pass {
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tmp.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (!db.open) {
        db = nil;
        NSDictionary *dic = @{@"code" : @1, @"errMsg" : @"数据库错误"};
        return dic;
    }
    
    BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_user (id integer PRIMARY KEY AUTOINCREMENT, username text NOT NULL, password text NOT NULL, nick text NOT NULL, head text NOT NULL, login bool NOT NULL)"];
    if (result) {
        NSLog(@"建表成功");
    }
    else {
        NSLog(@"建表失败");
        NSDictionary *dic = @{@"code" : @1, @"errMsg" : @"数据库错误"};
        return dic;
    }


    FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_user"];
    while ([rs next]) {
        int ID = [rs intForColumn:@"id"];
        NSString *username = [rs stringForColumn:@"username"];
        NSString *password = [rs stringForColumn:@"password"];
        NSString *nick = [rs stringForColumn:@"nick"];
        NSString *head = [rs stringForColumn:@"head"];
        //BOOL login = [rs boolForColumn:@"login"];
        
        if ([username isEqualToString: userName] && [password isEqualToString:pass]) {
            [[User shareInstance] setUserId:[NSString stringWithFormat:@"%d", ID]];
            [[User shareInstance] setUserName:userName];
            [[User shareInstance] setPassword:password];
            [[User shareInstance] setUserNick:nick];
            [[User shareInstance] setHeadUrl:head];
            [[User shareInstance] setIsLogin:YES];
            
            NSLog(@"登录成功！");
            NSDictionary *dic = @{@"code" : @0, @"errMsg" : @"ok!"};
            return dic;
        }
    }
    NSDictionary *dic = @{@"code" : @1, @"errMsg" : @"用户名或密码错误"};
    return dic;
}
@end
