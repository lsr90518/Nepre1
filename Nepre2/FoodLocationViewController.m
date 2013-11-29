//
//  FoodLocationViewController.m
//  Nepre2
//
//  Created by Lsr on 11/29/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "FoodLocationViewController.h"
#import "JPSThumbnailAnnotation.h"
#import "MKMapView+ZoomLevel.h"

@interface FoodLocationViewController ()

@property (retain, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *slideView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end

@implementation FoodLocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.menuButton addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.hidden = YES;
    
    
    // If not, allocate one and add it.
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
    self.navigationBarPanGestureRecognizer = panGestureRecognizer;
    
    //			[self.navigationController.view addGestureRecognizer:self.navigationBarPanGestureRecognizer];
    [self.slideView addGestureRecognizer:self.navigationBarPanGestureRecognizer];
    
    //initail map
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mapView.delegate = self;
    
    [self.mapView addAnnotations:[self generateAnnotations]];
    
    [self setupLocationManager];
    
    
    
}

- (NSArray *)generateAnnotations {
    NSMutableArray *annotations = [[NSMutableArray alloc] initWithCapacity:3];
    
    // Empire State Building
    JPSThumbnail *empire = [[JPSThumbnail alloc] init];
    empire.image = [UIImage imageNamed:@"f1.jpg"];
    empire.title = @"Empire State Building";
    empire.subtitle = @"NYC Landmark";
    empire.coordinate = CLLocationCoordinate2DMake(35.6615773236, 139.6981975234);
    empire.disclosureBlock = ^{ NSLog(@"selected Empire"); };
    
    [annotations addObject:[[JPSThumbnailAnnotation alloc] initWithThumbnail:empire]];
    
    // Apple HQ
    JPSThumbnail *apple = [[JPSThumbnail alloc] init];
    apple.image = [UIImage imageNamed:@"f2.jpg"];
    apple.title = @"Apple HQ";
    apple.subtitle = @"Apple Headquarters";
    apple.coordinate = CLLocationCoordinate2DMake(35.6599303437, 139.7003307415);
    apple.disclosureBlock = ^{ NSLog(@"selected Appple"); };
    
    [annotations addObject:[[JPSThumbnailAnnotation alloc] initWithThumbnail:apple]];
    
    // Parliament of Canada
    JPSThumbnail *ottawa = [[JPSThumbnail alloc] init];
    ottawa.image = [UIImage imageNamed:@"f3.jpg"];
    ottawa.title = @"Parliament of Canada";
    ottawa.subtitle = @"Oh Canada!";
    ottawa.coordinate = CLLocationCoordinate2DMake(35.6487707021, 139.7083193987);
    ottawa.disclosureBlock = ^{ NSLog(@"selected Ottawa"); };
    
    [annotations addObject:[[JPSThumbnailAnnotation alloc] initWithThumbnail:ottawa]];
    
    return annotations;
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}

- (void) setupLocationManager {
    locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog( @"Starting CLLocationManager" );
        locationManager.delegate = self;
        locationManager.distanceFilter = 200;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    } else {
        NSLog( @"Cannot Starting CLLocationManager" );
        /*self.locationManager.delegate = self;
         self.locationManager.distanceFilter = 200;
         locationManager.desiredAccuracy = kCLLocationAccuracyBest;
         [self.locationManager startUpdatingLocation];*/
    }  
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    checkinLocation = newLocation;
    CLLocationCoordinate2D centerCoord = {checkinLocation.coordinate.latitude,checkinLocation.coordinate.longitude};
    [self.mapView setCenterCoordinate:centerCoord zoomLevel:15 animated:NO];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
