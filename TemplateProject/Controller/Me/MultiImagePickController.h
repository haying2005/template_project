//
//  MultiImagePickController.h
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/2.
//
//

#import <UIKit/UIKit.h>

@class MultiImagePickController;

@protocol MultiImagePickControllerDelegate <NSObject>


- (void)multiImagePickController:(MultiImagePickController *)picker didFinishPickingImage:(NSData *)imageData;
- (void)multiImagePickController:(MultiImagePickController *)picker didFinishPickingImages:(NSArray<NSData *> *)imageDatas;
- (void)multiImagePickControllerrDidCancel:(MultiImagePickController *)picker;

@end

@interface MultiImagePickController : UIViewController

@property (nonatomic, weak)id <MultiImagePickControllerDelegate> delegate;

@end
