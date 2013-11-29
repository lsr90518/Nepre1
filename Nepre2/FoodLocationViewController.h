//
//  FoodLocationViewController.h
//  Nepre2
//
//  Created by Lsr on 11/29/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "ZUUIRevealController.h"

@interface FoodLocationViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    CLLocation *checkinLocation;
}

@end
