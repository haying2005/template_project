//
//  HotFixEngine.m
//  TemplateProject
//
//  Created by tan on 2016/12/6.
//
//

#import "HotFixEngine.h"
#import "JPEngine.h"

@implementation HotFixEngine

+ (void)startHotFixEngine
{
#define TEST_ENVIRONMENT 1
    
    if (TEST_ENVIRONMENT) { // 本地测试
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"];
        NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
        [JPEngine startEngine];
        [JPEngine evaluateScript:script];
    }
    else {                  // 从服务器拉取
        // NSString *bundleShortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://cnbang.net/test.js"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            // to do - data judge
            NSString *script = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [JPEngine startEngine];
            [JPEngine evaluateScript:script];
        }];
    }
}

@end
