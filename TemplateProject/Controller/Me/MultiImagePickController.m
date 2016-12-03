//
//  MultiImagePickController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/2.
//
//

#import "MultiImagePickController.h"
#import "ShowPhotoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface MultiImagePickController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSMutableArray *photoArr;
    UICollectionView *_collectionView;
    ALAssetsLibrary *_assetsLib;
}

@end

@implementation MultiImagePickController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"照片";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissSelf)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = CGSizeMake((self.view.bounds.size.width - 15) / 4, (self.view.bounds.size.width - 15) / 4);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.allowsMultipleSelection = YES;  //允许多选
    _collectionView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:_collectionView];
    
    [self loadPhotos];
}

- (void)loadPhotos {
    photoArr = [NSMutableArray array];
    ALAssetsLibrary *assetsLib = [[ALAssetsLibrary alloc] init];
    _assetsLib = assetsLib;
    [assetsLib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            
            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [photoArr addObject:result];
            }
            
            if (stop) {
                [_collectionView reloadData];   //此方法为异步 一定要在此reload..
            }
        }];
        
    } failureBlock:^(NSError *error) {
        ZNLog(@"%@", error);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //ZNLog(@"%@", photoArr);
    return photoArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *img = [cell viewWithTag:49];
    if (!img) {
        img = [UIImageView new];
        img.backgroundColor = [UIColor greenColor];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        img.tag = 49;
        [cell addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
    }
    UIView *v = [cell viewWithTag:949];
    if (!v) {
        v = [UIView new];
        v.tag = 949;
        v.backgroundColor = [UIColor redColor];
        [cell addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
    }
    v.hidden = !cell.selected;
    ALAsset *photo = [photoArr objectAtIndex:indexPath.row];
    //ZNLog(@"%@", photo);
    [img setImage:[UIImage imageWithCGImage:[photo aspectRatioThumbnail]]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //ZNLog(@"didSelectItemAtIndexPath");
    [[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:949].hidden = NO;
    ALAsset *photo = [photoArr objectAtIndex:indexPath.row];
    ALAssetRepresentation *rep = [photo defaultRepresentation];
    ZNLog(@"%@", rep);
    
    ShowPhotoViewController *ctrl = [[ShowPhotoViewController alloc] init];
    ctrl.image = [UIImage imageWithCGImage:rep.fullScreenImage];
    [self.navigationController pushViewController:ctrl animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    //ZNLog(@"didDeselectItemAtIndexPath");
    [[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:949].hidden = YES;
}

- (void)dismissSelf {
    if (self.delegate) {
        [self.delegate multiImagePickControllerrDidCancel:self];
    }

    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)submit {
    if (self.delegate && ![_collectionView indexPathsForSelectedItems].count) {
        [self.delegate multiImagePickControllerrDidCancel:self];
    }
    else if (self.delegate && [_collectionView indexPathsForSelectedItems].count == 1) {
        [self.delegate multiImagePickController:self didFinishPickingImage:nil];
    }
    else if (self.delegate && [_collectionView indexPathsForSelectedItems].count > 1) {
        [self.delegate multiImagePickController:self didFinishPickingImages:nil];
    }
    
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    ZNLog();
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
