//
//  TimelineViewController.h
//  Nepre2
//
//  Created by Lsr on 11/23/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"

@interface TimelineViewController : UIViewController{
    int sideFlag;
    float cellHeight;
    int currentScrollerY;
    int der;
    NSMutableArray *position1;
    NSMutableArray *position2;
    int animat;
    int scrolling;
}

@property NSArray *items;

@end
