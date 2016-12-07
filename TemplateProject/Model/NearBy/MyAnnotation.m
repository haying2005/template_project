//
//  MyAnnotation.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/7.
//
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
    _subtitle = @"";
    _title = [NSString stringWithFormat:@"%f, %f", _coordinate.latitude, _coordinate.longitude];
}

@end
