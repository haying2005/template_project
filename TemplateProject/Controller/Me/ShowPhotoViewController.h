//
//  ShowPhotoViewController.h
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/3.
//
//

#import <UIKit/UIKit.h>

@class ShowPhotoViewController;

@protocol ShowPhotoViewControllerDelegate <NSObject>

- (void)ShowPhotoViewController:(ShowPhotoViewController *)controller didFinishPickingImage:(NSData *)imageData;
@end

@interface ShowPhotoViewController : UIViewController

@property (nonatomic, strong)UIImage *image;
@property (nonatomic, weak) id <ShowPhotoViewControllerDelegate> delegate;
@end
