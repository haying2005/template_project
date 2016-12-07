//
//  MapViewController.m
//  TemplateProject
//
//  Created by fangwenyu on 2016/12/7.
//
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"


@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
{
    MKMapView *mapView;
    CLLocationManager *_locationManager;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view addSubview:mapView];
    mapView.delegate = self;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tapMap:)];
    longPress.minimumPressDuration = 1.0;
    [mapView addGestureRecognizer:longPress];
    
    _locationManager=[[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    if (IOS_VERSION_EQUAL_OR_GREATER(8.0)) {
        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
    }
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    return nil;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    ZNLog(@"didUpdateLocations...");
}

- (void)tapMap:(UITapGestureRecognizer *)tap {
    
    if (tap.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [tap locationInView:mapView];
        CLLocationCoordinate2D coordinate = [mapView convertPoint:point toCoordinateFromView:mapView];
        MyAnnotation *annot = [[MyAnnotation alloc] init];
        annot.coordinate = coordinate;
        [mapView addAnnotation:annot];
        CLLocationDistance distance = [[_locationManager location] distanceFromLocation:[[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude]];
        ZNLog(@"%f", distance);
        NSString *disStr = @"";
        if (distance < 1000) {
            disStr = [NSString stringWithFormat:@"%.0f米", distance];
        }
        else {
            disStr = [NSString stringWithFormat:@"%.1f公里", distance / 1000];
        }
        annot.subtitle = disStr;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_locationManager startUpdatingLocation];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
