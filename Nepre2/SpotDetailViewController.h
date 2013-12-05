//
//  SpotDetailViewController.h
//  Nepre2
//
//  Created by Lsr on 12/5/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"

@interface SpotDetailViewController : UIViewController<UIScrollViewDelegate>{
    int sideFlag;
    float cellHeight;
    int currentScrollerY;
    int der;
    NSMutableArray *position1;
    NSMutableArray *position2;
    int animat;
    int scrolling;
    int initFlag;
}
@property NSArray *items;

@end
