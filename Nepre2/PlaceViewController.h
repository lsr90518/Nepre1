//
//  PlaceViewController.h
//  Nepre2
//
//  Created by Lsr on 11/23/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceViewController : UIViewController<UIScrollViewDelegate>{
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
