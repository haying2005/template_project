//
//  CacheUtil.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/7.
//
//

#import "CacheUtil.h"

@implementation CacheUtil

+ (long long)fileSizeForDir:(NSString*)path//计算文件夹下文件的总大小
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    long long size = 0;
    
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];

    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            
            NSDictionary *fileAttributeDic = [fileManager attributesOfItemAtPath:fullPath error:nil];;
            
            size += fileAttributeDic.fileSize;
        }
        else
            //如果是目录的话，递归
        {
            //跳过Snapshots目录，因为该目录没有权限删除
            if (isDir && [[fullPath lastPathComponent]isEqualToString:@"Snapshots"]) {
                continue;
            }
            
            size += [self fileSizeForDir:fullPath];
        }
    }
    
    return size;
    
}

+ (NSString *)fileSizeStrForCacheDir {
    NSArray *cachePathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    //double kBytes = ([self fileSizeForDir:NSTemporaryDirectory()]) / 1024;
    double kBytes = ([self fileSizeForDir:NSTemporaryDirectory()] + [self fileSizeForDir:[cachePathArr firstObject]]) / 1024;
    
    if (kBytes < 1024) {
        return [NSString stringWithFormat:@"%.2fK", kBytes];
    }
    else {
        double mBytes = kBytes / 1024;
        if (mBytes < 1024) {
            return [NSString stringWithFormat:@"%.2fM", mBytes];
        }
        else {
            double gBytes = mBytes / 1024;
            return [NSString stringWithFormat:@"%.2fG", gBytes];
        }
    }
    
}

//清除tempoary目录下一切文件
+ (void)clearTmpDir {
    NSArray* array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:nil];
    for (NSString *path in array) {
        NSString *fullPath = [NSTemporaryDirectory() stringByAppendingString:path];
        [[NSFileManager defaultManager] removeItemAtPath:fullPath error:nil];
    }
    NSLog(@"NSTemporaryDirectory 清空");
}

//清空cache目录下一切文件
+ (void)clearCacheDir {
    
    NSArray *cachePathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePathArr firstObject];
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cachePath error:nil];
    for (NSString *path in array) {
        
        NSError *error;
        
        NSString *fullPath = [cachePath stringByAppendingPathComponent:path];
        
        BOOL isDir;
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDir]) {
            //跳过Snapshots目录,因为该目录没有权限删除
            if ([[fullPath lastPathComponent]isEqualToString:@"Snapshots"]) {
                continue;
            }
            
        }
        NSLog(@"%@", fullPath);
        [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&error];
        
        if (error.userInfo) {
            NSLog(@"%@", error.userInfo);
        }
        
    }
    NSLog(@"NSCachesDirectory 清空");
}

@end
