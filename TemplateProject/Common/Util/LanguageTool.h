//
//  LanguageTool.h
//  Test4
//
//  Created by tan on 2016/12/1.
//  Copyright © 2016年 谭建平. All rights reserved.
//

#import <Foundation/Foundation.h>

// 英文
#define EN              @"en"

// 简体中文
#define CN_S            @"zh-Hans"

// 繁体中文
#define CN_T            @"zh-Hant"

// 应用语言改变的通知
#define NOTIFICATION_LANGUAGE_CHANGE    @"NOTIFICATION_LANGUAGE_CHANGE"

// 获取当前语言的某个键的值
#define Localized(key)                  ((NSString *)[[LanguageTool shareInstance] getStringForKey:key])

@interface LanguageTool : NSObject

+ (instancetype)shareInstance;

- (NSString *)getStringForKey:(NSString *)key;

- (void)setNewLanguage:(NSString *)language;

@end
