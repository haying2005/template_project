//
//  CacheUtil.h
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/7.
//
//

#import <Foundation/Foundation.h>

@interface CacheUtil : NSObject

//计算文件夹下文件的总大小
+ (long long)fileSizeForDir:(NSString*)path;
//计算temp + cache目录的文件总大小
+ (NSString *)fileSizeStrForCacheDir;
//清除tempoary目录下一切文件
+ (void)clearTmpDir;
//清空cache目录下一切文件
+ (void)clearCacheDir;

@end
