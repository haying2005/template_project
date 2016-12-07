//
//  ShowPhotoViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/3.
//
//

#import "ShowPhotoViewController.h"
#import "UIImage+WYImage.h"

@interface ShowPhotoViewController () <UIScrollViewDelegate>
{
    UIImageView *imgV;
    UIView *backView;
    UIScrollView *_scrollView;
    CGFloat _originScale;
}
@end

@implementation ShowPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    WEAKSELF;

    backView = [UIView new];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf.view);
        make.width.and.height.mas_equalTo(weakSelf.view.width);
    }];
    
    UIScrollView *scrollV = [UIScrollView new];
    _scrollView = scrollV;
    
    scrollV.delegate = self;
    scrollV.backgroundColor = [UIColor blackColor];
    scrollV.alwaysBounceVertical = YES;
    scrollV.alwaysBounceHorizontal = YES;
    [backView addSubview:scrollV];
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backView);
    }];
    UIView *border = [UIView new];
    border.userInteractionEnabled = NO;
    [self.view addSubview:border];
    [border mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollV);
    }];
    border.layer.borderColor = [UIColor whiteColor].CGColor;
    border.layer.borderWidth = 1;
    
    if (self.image) {
        _originScale = self.view.size.width / self.image.size.width;
        scrollV.minimumZoomScale = _originScale;
        scrollV.maximumZoomScale = _originScale * 2;
        
        imgV = [[UIImageView alloc] initWithImage:self.image];
        [scrollV addSubview:imgV];
        scrollV.zoomScale = _originScale;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setContentInset:_scrollView];
            
            CGFloat offsetX = (scrollV.contentSize.width - scrollV.bounds.size.width) / 2;
            CGFloat offsetY = (scrollV.contentSize.height - scrollV.bounds.size.height) / 2;
            scrollV.contentOffset = CGPointMake(offsetX, offsetY);
        });
        
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(imagePick)];
    
}

//当用户进行捏合手势的时候，它会询问代理需要对其中那一个控件 进行缩放
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return imgV;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setContentInset:scrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    _scrollView.clipsToBounds = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    _scrollView.clipsToBounds = YES;
}

- (void)setContentInset:(UIScrollView *)scrollView {
    //不加contentinset的话，当contentsize小于scrollView的frame时，contentView的左上角会顶到scrollview的左上角
    CGFloat width = scrollView.bounds.size.width;
    CGFloat height = scrollView.bounds.size.height;
    CGFloat w = scrollView.contentSize.width;
    CGFloat h = scrollView.contentSize.height;
    CGFloat insetW = w < width ? (width - w) / 2 : 0;
    CGFloat insetH = h < height ? (height - h) /2 : 0;
    scrollView.contentInset = UIEdgeInsetsMake(insetH, insetW, insetH, insetW);
}

- (void)imagePick {
    if ([self.delegate respondsToSelector:@selector(ShowPhotoViewController:didFinishPickingImage:)]) {
        [self.delegate ShowPhotoViewController:self didFinishPickingImage:[UIImage convertViewToImage:backView]];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
