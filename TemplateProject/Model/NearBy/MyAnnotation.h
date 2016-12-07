//
//  MyAnnotation.h
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/7.
//
//

#import <Foundation/Foundation.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;



@end
