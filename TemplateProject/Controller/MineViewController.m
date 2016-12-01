//
//  MineViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/1.
//
//

#import "MineViewController.h"
#import "PersonalInfoViewController.h"

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
    _tableView.backgroundColor = [UIColor lightGrayColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    WEAKSELF;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    itemArr = @[
              @{@"icon" : @"tab_me_sel", @"title" : @"设置"},
              @{@"icon" : @"tab_me_sel", @"title" : @"设置"},
              @{@"icon" : @"tab_me_sel", @"title" : @"设置"},
              @{@"icon" : @"tab_me_sel", @"title" : @"设置"},
              @{@"icon" : @"tab_me_sel", @"title" : @"登出"}
              ];
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
            }
            NSDictionary *dic = [itemArr objectAtIndex:indexPath.row];
            cell.imageView.image = [UIImage imageNamed:[dic valueForKey:@"icon"]];
            cell.textLabel.text = [dic valueForKey:@"title"];
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        PersonalInfoViewController *ctrl = [[PersonalInfoViewController alloc] init];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}


@end
