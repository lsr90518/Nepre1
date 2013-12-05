//
//  FoodViewController.h
//  Nepre2
//
//  Created by Lsr on 11/22/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ZUUIRevealController.h"
#import "JSONKit.h"

@interface FoodViewController : UIViewController<UIScrollViewDelegate>{
    int sideFlag;
    int currentScrollerY;
    int der;
    float cellHeight;
    NSMutableArray *position1;
    NSMutableArray *position2;
    int animat;
    int scrolling;
    int refreshFlag;
}

@property (strong, nonatomic) NSMutableData *recieveData;

@end
