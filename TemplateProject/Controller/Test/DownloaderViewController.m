//
//  DownloaderViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/7.
//
//

#import "DownloaderViewController.h"
#import <AFNetworking.h>

@interface DownloaderViewController ()
{
    UIButton *btnDownload;
    UIButton *btnPause;
    UIImageView *imageView;
    NSURLSessionDownloadTask *currentTask;
}

@end

@implementation DownloaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    WEAKSELF;

    imageView = [UIImageView new];
    [self.view addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    btnDownload = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDownload setTitle:@"下载" forState:UIControlStateNormal];
    [btnDownload setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnDownload setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:btnDownload];
    [btnDownload addTarget:self action:@selector(testDownload) forControlEvents:UIControlEventTouchUpInside];
    
    [btnDownload mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.center.equalTo(weakSelf.view);
    }];
    
    //[btnDownload rac_signalForControlEvents:UIControlEventTouchUpInside];
    
    btnPause = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPause setTitle:@"暂停" forState:UIControlStateNormal];
    [btnPause setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btnPause setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:btnPause];
    [btnPause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [btnPause setHidden:YES];
    
    [btnPause mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.centerX.mas_equalTo(btnDownload);
        make.top.equalTo(btnDownload.mas_bottom).with.offset(20);
    }];
    
}

- (void)testDownload {
    
    btnDownload.enabled = NO;
    [btnPause setHidden:NO];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/f603918fa0ec08faf0f7ace15cee3d6d54fbda85.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        ZNLog(@"%f", downloadProgress.fractionCompleted);
        dispatch_async(dispatch_get_main_queue(), ^{
            [btnDownload setTitle:[NSString stringWithFormat:@"%.0f %%", downloadProgress.fractionCompleted * 100] forState:UIControlStateDisabled];
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *directoryURL = [[NSFileManager defaultManager] URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [directoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            ZNLog(@"%@", error.description);
        }
        ZNLog(@"%@", filePath);
        if (filePath) {
            UIImage *img = [UIImage imageWithContentsOfFile:filePath.path];
            [imageView setImage:img];
        }
        
        [btnDownload setTitle:@"0 %" forState:UIControlStateDisabled];
        [btnDownload setEnabled:YES];
        [btnPause setHidden:YES];
        
        currentTask = nil;
    }];
    
    [task resume];
    currentTask = task;
    
}

- (void)pause {
    if (currentTask) {
        if ([currentTask state] == NSURLSessionTaskStateSuspended) {
            [currentTask resume];
            [btnPause setTitle:@"暂停" forState:UIControlStateNormal];
        }
        else if ([currentTask state] == NSURLSessionTaskStateRunning) {
            [currentTask suspend];
            [btnPause setTitle:@"继续" forState:UIControlStateNormal];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [imageView setImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
