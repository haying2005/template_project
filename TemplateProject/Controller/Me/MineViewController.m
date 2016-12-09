//
//  MineViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import "MineViewController.h"
#import "PersonalInfoViewController.h"
#import "LanguageSelectViewController.h"
#import "ModifyPassWordViewController.h"
#import "MapViewController.h"
#import "CacheUtil.h"

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *itemArr;
    NSString *cacheStr;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    WEAKSELF;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    itemArr = @[
                @{@"icon" : @"tab_me_sel", @"title" : @"设置", @"key" : @"setting"},
                @{@"icon" : @"tab_me_sel", @"title" : @"地图", @"key" : @"map"},
                @{@"icon" : @"tab_me_sel", @"title" : @"设置"},
                @{@"icon" : @"tab_me_sel", @"title" : @"多语言", @"key" : @"multiLanguage"},
                @{@"icon" : @"tab_me_sel", @"title" : @"清缓存", @"key" : @"cache"},
                @{@"icon" : @"tab_me_sel", @"title" : @"修改密码", @"key" : @"editpass"},
                @{@"icon" : @"tab_me_sel", @"title" : @"登出", @"key" : @"logout"}
              ];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(toSetting:)];
    
    __weak UITableView *tableV = _tableView;
    [RACObserve([User shareInstance], nickName) subscribeNext:^(id  _Nullable x) {
        [tableV reloadData];
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return itemArr.count;
            break;
            
            
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.imageView.image = [UIImage imageNamed:@"tab_me_sel"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"手机号：%@", [User shareInstance].userName];
            cell.textLabel.text = [NSString stringWithFormat:@"昵称：%@", [User shareInstance].nickName];
            return cell;
            break;
        }
        case 1:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            NSDictionary *dic = [itemArr objectAtIndex:indexPath.row];
            cell.imageView.image = [UIImage imageNamed:[dic valueForKey:@"icon"]];
            cell.textLabel.text = [dic valueForKey:@"title"];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            if ([[[itemArr objectAtIndex:indexPath.row] valueForKey:@"key"] isEqualToString:@"cache"]) {
                cell.detailTextLabel.text = cacheStr;
            }
            return cell;
            break;
        }
            
        default:
            return nil;
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 80;
            break;
            
        default:
            return 44;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        PersonalInfoViewController *ctrl = [[PersonalInfoViewController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    
    //地图
    else if (indexPath.section == 1 && [[[itemArr objectAtIndex:indexPath.row] valueForKey:@"key"] isEqualToString:@"map"]) {
        MapViewController *ctrl = [[MapViewController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    
    //清缓存
    else if (indexPath.section == 1 && [[[itemArr objectAtIndex:indexPath.row] valueForKey:@"key"] isEqualToString:@"cache"]) {
        ZNLog(@"清除缓存");
    }
    //登出
    else if (indexPath.section == 1 && [[[itemArr objectAtIndex:indexPath.row] valueForKey:@"key"] isEqualToString:@"logout"]) {
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"你确定退出？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                
            }
            else if (buttonIndex == 1) {
                //todo
            }
        }];
    }
    //修改密码
    else if (indexPath.section == 1 && [[[itemArr objectAtIndex:indexPath.row] valueForKey:@"key"] isEqualToString:@"editpass"]) {
        ModifyPassWordViewController *ctrl = [[ModifyPassWordViewController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    // 多语言
    else if (indexPath.section == 1 && [[[itemArr objectAtIndex:indexPath.row] valueForKey:@"key"] isEqualToString:@"multiLanguage"]) {
        LanguageSelectViewController *languageSelectViewController = [LanguageSelectViewController new];
        languageSelectViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:languageSelectViewController animated:YES];
    }    
}

- (void)toSetting:(id)sender {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = [CacheUtil fileSizeStrForCacheDir];
        dispatch_async(dispatch_get_main_queue(), ^{
            cacheStr = str;
            [_tableView reloadData];
        });
    });
}


@end
