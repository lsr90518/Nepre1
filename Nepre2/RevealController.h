//
//  RevealController.h
//  Nepre2
//
//  Created by Lsr on 11/22/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"

@class FoodViewController;
@class SidebarViewController;

@interface RevealController : ZUUIRevealController <ZUUIRevealControllerDelegate>{
    UIButton *touchbutton;
}

@property (retain, nonatomic) NSMutableArray *foodViewArray;

@end
