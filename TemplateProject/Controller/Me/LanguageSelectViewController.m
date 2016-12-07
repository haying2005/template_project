//
//  LanguageSelectViewController.m
//  TemplateProject
//
//  Created by tan on 2016/12/7.
//
//

#import "LanguageSelectViewController.h"
#import "LanguageTool.h"

@interface LanguageSelectViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
    
    UIButton *_saveButton;
}
@end

@implementation LanguageSelectViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"语言选择";
    
    _dataArray = @[[NSMutableDictionary dictionaryWithDictionary:@{EN : @"English", @"isSelect" : @(NO)}],
                   [NSMutableDictionary dictionaryWithDictionary:@{CN_S : @"简体中文", @"isSelect" : @(NO)}],
                   [NSMutableDictionary dictionaryWithDictionary:@{CN_T : @"繁體中文", @"isSelect" : @(NO)}]];
    
    for (NSMutableDictionary *dict in _dataArray) {
        if ([[dict allKeys] containsObject:[LanguageTool shareInstance].language]) {
            dict[@"isSelect"] = @(YES);
        }
    }
    
    [self setupRightBarButtonItem];

    [self setupContentView];
    
    [self configureDefaultLeftItem];
}

#pragma mark - Setup UI

- (void)setupContentView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor colorWithHexString:@"e6e5e6"];
    tableView.separatorColor = [UIColor colorWithHexString:@"e6e5e6"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [tableView setTableFooterView:[UIView new]];
}

- (void)setupRightBarButtonItem
{
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setFrame:CGRectMake(0, 0, 45, 35)];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _saveButton = saveButton;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    
    _saveButton.enabled = NO;
}

#pragma mark - Button Actions

- (void)saveButtonAction:(UIButton *)sender
{
    for (NSMutableDictionary *dict in _dataArray) {
        if ([dict[@"isSelect"] boolValue]) {
            [[LanguageTool shareInstance] setNewLanguage:[[dict allKeys][0] isEqualToString:@"isSelect"] ? [dict allKeys][1] : [dict allKeys][0]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - Table View Data Source & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    }
    
    NSDictionary *dict = _dataArray[indexPath.row];
    cell.textLabel.text = [[dict allValues][0] isKindOfClass:[NSString class]] ? [dict allValues][0] : [dict allValues][1];
    
    cell.accessoryType = [dict[@"isSelect"] boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    for (int i = 0; i < _dataArray.count; i++) {
        NSMutableDictionary *dict = _dataArray[i];
        dict[@"isSelect"] = @(i == indexPath.row);
        
        if (i == indexPath.row) {
            NSString *newLanguage = [[dict allKeys][0] isEqualToString:@"isSelect"] ? [dict allKeys][1] : [dict allKeys][0];
            _saveButton.enabled = ![newLanguage isEqualToString:[LanguageTool shareInstance].language];
        }
    }

    [tableView reloadData];
}

@end
