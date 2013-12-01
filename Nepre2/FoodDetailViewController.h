//
//  FoodDetailViewController.h
//  Nepre2
//
//  Created by Lsr on 11/25/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"

@interface FoodDetailViewController : UIViewController<UIScrollViewDelegate>{
    int sideFlag;
    float cellHeight;
    int currentScrollerY;
    int der;
}
@property NSArray *items;


@end
