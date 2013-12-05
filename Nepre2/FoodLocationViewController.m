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
#import "FoodDetailViewController.h"
#import "JSONKit.h"
#import <MapKit/MKAnnotation.h>

@interface FoodLocationViewController ()

@property (retain, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (retain, nonatomic) IBOutlet UIButton *menuButton;
@property (retain, nonatomic) IBOutlet UIView *slideView;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;


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
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    // If not, allocate one and add it.
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
    self.navigationBarPanGestureRecognizer = panGestureRecognizer;
    
    //			[self.navigationController.view addGestureRecognizer:self.navigationBarPanGestureRecognizer];
    [self.slideView addGestureRecognizer:self.navigationBarPanGestureRecognizer];
    
    //initail map
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.mapView.delegate = self;
//    
    [self.mapView addAnnotations:[self generateAnnotations]];
//
    [self setupLocationManager];
    
    //fffffffffffffffffffffffffffffffffffffff
    
    // Origin Location.
    CLLocationCoordinate2D loc1;
    loc1.latitude = 34.070351;
    loc1.longitude = 134.554911;
//    JPSThumbnail *origin2 = [[JPSThumbnail alloc] initWithTitle:@"loc1" subTitle:@"Home1" andCoordinate:loc1];
    
    
    
//    [self.mapView addAnnotation:destination];
    

    
    
}

- (void) beginNavigation {
    JPSThumbnail *origin = [[JPSThumbnail alloc] init];
    origin.image = [UIImage imageNamed:@"f3.jpg"];
    origin.title = @"Parliament of Canada";
    origin.subtitle = @"Oh Canada!";
    origin.coordinate = CLLocationCoordinate2DMake(34.070351,134.554911);
    origin.disclosureBlock = ^{ NSLog(@"selected Ottawa"); };
    //    [self.mapView addAnnotation:origin];
    
    // Destination Location.
    CLLocationCoordinate2D loc2;
    loc2.latitude = 34.070365;
    loc2.longitude = 134.559553;
    //    Annotation *destination = [[Annotation alloc] initWithTitle:@"loc2" subTitle:@"Home2" andCoordinate:loc2];
    
    JPSThumbnail *destination = [[JPSThumbnail alloc] init];
    destination.image = [UIImage imageNamed:@"f3.jpg"];
    destination.title = @"Parliament of Canada";
    destination.subtitle = @"Oh Canada!";
    destination.coordinate = CLLocationCoordinate2DMake(34.070365,134.559553);
    destination.disclosureBlock = ^{ NSLog(@"selected Ottawa"); };
    if(arrRoutePoints) // Remove all annotations
        [self.mapView removeAnnotations:[self.mapView annotations]];
    
    arrRoutePoints = [self getRoutePointFrom:origin to:destination];
    [self drawRoute];
    [self centerMap];
}

- (NSArray *)generateAnnotations {
    NSMutableArray *annotations = [[NSMutableArray alloc] initWithCapacity:1];

    
    // Parliament of Canada
    JPSThumbnail *ottawa = [[JPSThumbnail alloc] init];
    ottawa.image = [UIImage imageNamed:@"f3.jpg"];
    ottawa.title = @"Parliament of Canada";
    ottawa.subtitle = @"Oh Canada!";
    ottawa.coordinate = CLLocationCoordinate2DMake(34.070351,134.554911);
    ottawa.disclosureBlock = ^{
        [self beginNavigation];
        [self centerMap];
    };
    
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
    [self.mapView setCenterCoordinate:centerCoord zoomLevel:13 animated:NO];
    currentLocation = centerCoord;
//    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(34.070365,134.559553)];
}

- (IBAction)goDetail:(id)sender {
    FoodDetailViewController *fdvc = [[FoodDetailViewController alloc]init];
    [UIView beginAnimations:@"Flips" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    
    [self.navigationController pushViewController:fdvc animated:YES];
    
    [UIView commitAnimations];
}

/* MKMapViewDelegate Meth0d -- for viewForOverlay*/
- (MKOverlayView*)mapView:(MKMapView*)theMapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKPolylineView *view = [[MKPolylineView alloc] initWithPolyline:objPolyline];
    view.fillColor = [UIColor blackColor];
    view.strokeColor = [UIColor blackColor];
    view.lineWidth = 4;
    return view;
}

- (NSArray*)getRoutePointFrom:(JPSThumbnail *)origin to:(JPSThumbnail *)destination
{
//    NSString* saddr = [NSString stringWithFormat:@"%f,%f", origin.coordinate.latitude, origin.coordinate.longitude];
//    NSString* daddr = [NSString stringWithFormat:@"%f,%f", destination.coordinate.latitude, destination.coordinate.longitude];
    NSString* saddr = [NSString stringWithFormat:@"34.070365,134.559553"];
     NSString* daddr = [NSString stringWithFormat:@"34.070351,134.554911"];
    
    
    NSString* apiUrlStr = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=34.070351,134.554911&sensor=false",currentLocation.latitude,currentLocation.longitude];
    NSURL* apiUrl = [NSURL URLWithString:apiUrlStr];
    
    NSError *error;
    NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl encoding:NSUTF8StringEncoding error:&error];
    NSRange range;
    range=[apiResponse rangeOfString:@"overview_polyline"];
    apiResponse = [apiResponse substringFromIndex:range.location+range.length];
    NSRange range2 = [apiResponse rangeOfString:@"points\" : "];
    int titleLen = range2.location+range2.length;
    titleLen = titleLen+1;
    NSString *response2 = [apiResponse substringFromIndex:titleLen];
    NSRange range3 = [response2 rangeOfString:@"},"];
    NSString *response3 = [response2 substringToIndex:range3.location-1];
    NSString *encodedPoint=response3;
    
    return [self decodePolyLine:[encodedPoint mutableCopy]];
}

- (NSMutableArray *)decodePolyLine:(NSMutableString *)encodedString
{
//    [encodedString setString:@"yj}nEedhtXGrI_EYq@G@zFZ|PvAAj@CDeA@aC"];
    [encodedString replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                      options:NSLiteralSearch
                                        range:NSMakeRange(0, [encodedString length])];
    NSInteger len = [encodedString length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encodedString characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encodedString characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        printf("\n[%f,", [latitude doubleValue]);
        printf("%f]", [longitude doubleValue]);
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:loc];
    }
    return array;
}

- (void)drawRoute
{
    int numPoints = [arrRoutePoints count];
    if (numPoints > 1)
    {
        CLLocationCoordinate2D* coords = malloc(numPoints * sizeof(CLLocationCoordinate2D));
        for (int i = 0; i < numPoints; i++)
        {
            CLLocation* current = [arrRoutePoints objectAtIndex:i];
            coords[i] = current.coordinate;
        }
        
        objPolyline = [MKPolyline polylineWithCoordinates:coords count:numPoints];
        free(coords);
        
        [self.mapView addOverlay:objPolyline];
        [self.mapView setNeedsDisplay];
    }
}

- (void)centerMap
{

    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(currentLocation.latitude,currentLocation.longitude) zoomLevel:13 animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
