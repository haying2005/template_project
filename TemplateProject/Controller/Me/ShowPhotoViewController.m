//
//  ShowPhotoViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/3.
//
//

#import "ShowPhotoViewController.h"

@interface ShowPhotoViewController ()

@end

@implementation ShowPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgv.backgroundColor = [UIColor blackColor];
    imgv.contentMode = UIViewContentModeScaleAspectFit;
    if (self.image) {
        [imgv setImage:self.image];
    }
    
    [self.view addSubview:imgv];
    
    
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
