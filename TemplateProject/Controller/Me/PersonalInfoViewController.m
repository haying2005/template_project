//
//  PersonalInfoViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import "PersonalInfoViewController.h"
#import "MultiImagePickController.h"


@interface PersonalInfoViewController () <UITableViewDelegate, UITableViewDataSource, MultiImagePickControllerDelegate>
{
    UITableView *_tableView;
    NSArray *items;
    
    UIImage *testHeadImage;
}

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    WEAKSELF;
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_tableView setBackgroundColor:[UIColor whiteColor]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    items = @[
              @{@"icon" : @"", @"title" : @"头像"},
              @{@"icon" : @"", @"title" : @"昵称"},
              @{@"icon" : @"", @"title" : @"用户名"},
              @{@"icon" : @"", @"title" : @"性别"},
              @{@"icon" : @"", @"title" : @"地区"},
              @{@"icon" : @"", @"title" : @"个性签名"},
              ];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 0) {
            UIImageView *img = [UIImageView new];
            img.backgroundColor = [UIColor greenColor];
            img.layer.cornerRadius = 5;
            img.layer.masksToBounds = YES;
            img.tag = 49;
            [cell addSubview:img];
            
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell).with.offset(-30);
                make.centerY.equalTo(cell);
                make.width.and.height.equalTo(cell.mas_height).with.offset(- 20);
            }];

        }
    }
    cell.textLabel.text = [items[indexPath.row] valueForKey:@"title"];
    
    if (indexPath.row == 0) {
        UIImageView *img = [cell viewWithTag:49];
        if (img && testHeadImage) {
            img.image = testHeadImage;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        MultiImagePickController *ctrl = [[MultiImagePickController alloc] init];
        ctrl.delegate = self;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ctrl];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


#pragma mark - MultiImagePickControllerDelegate
- (void)multiImagePickController:(MultiImagePickController *)picker didFinishPickingImage:(UIImage *)image {
    ZNLog(@"didFinishPickingImage...");
    testHeadImage = image;
    [_tableView reloadData];
    
}
- (void)multiImagePickController:(MultiImagePickController *)picker didFinishPickingImages:(NSArray<UIImage *> *)images {
    ZNLog(@"didFinishPickingImages...");
}
- (void)multiImagePickControllerrDidCancel:(MultiImagePickController *)picker {
    ZNLog(@"multiImagePickControllerrDidCancel...");
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
