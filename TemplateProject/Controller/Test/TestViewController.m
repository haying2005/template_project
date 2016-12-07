//
//  TestViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import "TestViewController.h"
#import "Masonry.h"


@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view.
    UIView *superV = self.view;
    UIScrollView *scrollV = [UIScrollView new];
    [superV addSubview:scrollV];
    [scrollV setBackgroundColor:[UIColor blackColor]];
    //scrollV.clipsToBounds = NO;
    [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superV);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    UIView *container = [UIView new];
    [scrollV addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollV);
        make.width.equalTo(scrollV);
    }];
    
    UIView *lastV = nil;
    
    for (int i = 0; i < 10; i ++) {
        UIView *subV = [UIView new];
        [container addSubview:subV];
        subV.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1];
        [subV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(44);
            
            if (lastV) {
                make.top.equalTo(lastV.mas_bottom);
            }
            else {
                make.top.mas_equalTo(0);
            }
        }];
        
        lastV = subV;
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastV);
    }];
    
    BOOL b1 = [self isKindOfClass:[self class]];
    BOOL b2 = [self isKindOfClass:[UIViewController class]];
    NSLog(@"%d - %d", b1, b2);
    
    BOOL b3 = [self isMemberOfClass:[self class]];
    BOOL b4 = [self isMemberOfClass:[UIViewController class]];
    BOOL b5 = [self isMemberOfClass:[NSObject class]];
    BOOL b6 = [self isMemberOfClass:[TestViewController class]];
    NSLog(@"%d - %d - %d - %d", b3, b4, b5, b6);
    
    NSLog(@"%@", [self class]);
    NSLog(@"%@", [TestViewController class]);
    
    // test jspatch
    [self.view addSubview:[self genView]];
}

- (UIView *)genView
{
    return [[UIView alloc] initWithFrame:CGRectMake((self.view.width - 320) / 2., (self.view.height - 320) / 2., 320, 320)];
}

- (void)testMethodWithParam1:(NSDictionary *)param1 param2:(NSString *(^)(NSString *content, BOOL success))param2
{
    ZNLog(@"%@", param1);
    
    if (param2) {
        ZNLog(@"%@", param2(@"test jspatch", YES));
    }
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
