//
//  LanguageTool.m
//  Test4
//
//  Created by tan on 2016/12/1.
//  Copyright © 2016年 谭建平. All rights reserved.
//

#import "LanguageTool.h"

// 应用的当前语言
#define AppLanguage     @"appLanguage"

@interface LanguageTool()

@property (nonatomic, strong) NSBundle *bundle;

@end

@implementation LanguageTool

#pragma mark - Singleton

+ (instancetype)shareInstance {
    static LanguageTool *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initLanguage];
    }
    
    return self;
}

- (void)initLanguage
{
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage];
    NSString *path;
    
    if (!currentLanguage)
    {
        currentLanguage = [self getDeviceLanguage];
        
        [[NSUserDefaults standardUserDefaults] setObject:currentLanguage forKey:AppLanguage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    self.language = currentLanguage;
    path = [[NSBundle mainBundle] pathForResource:self.language ofType:@"lproj"];
    self.bundle = [NSBundle bundleWithPath:path];
}

#pragma mark - Utility

- (NSString *)getDeviceLanguage
{
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    if ([currentLanguage hasPrefix:EN]) {
        currentLanguage = EN;
    }
    else if ([currentLanguage hasPrefix:CN_S]) {
        currentLanguage = CN_S;
    }
    else if ([currentLanguage hasPrefix:CN_T]) {
        currentLanguage = CN_T;
    }
    else {
        currentLanguage = EN;
    }
    
    return currentLanguage;
}

- (NSString *)getStringForKey:(NSString *)key
{
    if (self.bundle)
    {
        return NSLocalizedStringFromTableInBundle(key, @"Language", self.bundle, @"");
    }
    
    return NSLocalizedStringFromTable(key, @"Language", @"");
}

- (void)setNewLanguage:(NSString *)language
{
    if ([language isEqualToString:self.language])
    {
        return;
    }
    
    if ([language isEqualToString:EN] || [language isEqualToString:CN_S] || [language isEqualToString:CN_T])
    {
        NSString *path = [[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
        self.bundle = [NSBundle bundleWithPath:path];
        self.language = language;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:AppLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LANGUAGE_CHANGE object:nil];
}

@end
