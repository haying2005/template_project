//
//  LanguageSelectViewController.m
//  TemplateProject
//
//  Created by tan on 2016/12/7.
//
//

#import "LanguageSelectViewController.h"

@interface LanguageSelectViewController ()
{
    NSArray *_dataArray;
}
@end

@implementation LanguageSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[@"English", @"简体中文", @"繁體中文"];
}

#pragma mark - Table View Data Source & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont customLightFontOfSize:14.];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"0d0014"];
        
        UIImage *normalImage = [UIImage imageNamed:@"messagecenter_pricebutton_normal"];
        UIImage *selectImage = [UIImage imageNamed:@"messagecenter_pricebutton_select"];
        UIButton *controlButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - normalImage.size.width - 15., (55 - normalImage.size.height) / 2., normalImage.size.width, normalImage.size.height)];
        [controlButton setBackgroundImage:normalImage forState:UIControlStateNormal];
        [controlButton setBackgroundImage:selectImage forState:UIControlStateSelected];
        [controlButton setImage:selectImage forState:UIControlStateHighlighted];
        [controlButton setImage:selectImage forState:UIControlStateSelected | UIControlStateHighlighted];
        [controlButton addTarget:self action:@selector(controlButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        controlButton.tag= CONTROL_BUTTON_TAG;
        [cell addSubview:controlButton];
        
        UIImage *arrowImage = [UIImage imageNamed:@"setting_rightarrow"];
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - arrowImage.size.width - 15., (55 - arrowImage.size.height) / 2., arrowImage.size.width, arrowImage.size.height)];
        [arrowImageView setImage:arrowImage];
        arrowImageView.tag= ARROWIMAGEVIEW_TAG;
        [cell addSubview:arrowImageView];
    }
    
    NSDictionary *dict = _dataArray[indexPath.section][indexPath.row];
    
    cell.textLabel.text = dict[@"title"];
    
    BOOL isSetting = [dict[@"issetting"] boolValue];
    
    UIButton *controlButton = (UIButton *)[cell viewWithTag:CONTROL_BUTTON_TAG];
    controlButton.hidden = !isSetting;
    if (isSetting) {
        controlButton.selected = [dict[@"ison"] boolValue];
    }
    
    UIImageView *arrowImageView = (UIImageView *)[cell viewWithTag:ARROWIMAGEVIEW_TAG];
    arrowImageView.hidden = isSetting;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
