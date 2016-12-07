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

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *itemArr;
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
                @{@"icon" : @"tab_me_sel", @"title" : @"设置"},
                @{@"icon" : @"tab_me_sel", @"title" : @"设置"},
                @{@"icon" : @"tab_me_sel", @"title" : @"多语言"},
                @{@"icon" : @"tab_me_sel", @"title" : @"登出", @"key" : @"logout"}
              ];
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(toSetting:)];
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
            }
            cell.imageView.image = [UIImage imageNamed:@"tab_me_sel"];
            cell.textLabel.text = [User shareInstance].userNick;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"用户id: %@", [User shareInstance].userId];
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
    else if (indexPath.section == 1) {
        
        if ([[[itemArr objectAtIndex:indexPath.row] valueForKey:@"key"] isEqualToString:@"logout"]) {
            //登出
            [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"你确定退出？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    
                }
                else if (buttonIndex == 1) {
                    NSDictionary *result = [[User shareInstance] logout];
                    if ([result[@"code"] integerValue] == 0) {
                        ZNLog(@"logout 成功！");
                    }
                    else {
                        ZNLog(@"%@", result[@"errMsg"]);
                    }
                }
            }];
            
        }
        else if (indexPath.row == 4) {
            LanguageSelectViewController *languageSelectViewController = [LanguageSelectViewController new];
            languageSelectViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:languageSelectViewController animated:YES];
        }
    }
    
}

- (void)toSetting:(id)sender {
    
}


@end
