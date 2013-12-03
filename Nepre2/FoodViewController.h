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

@interface FoodViewController : UIViewController<UIScrollViewDelegate>{
    int sideFlag;
    int currentScrollerY;
    int der;
}
@property (retain, nonatomic) IBOutlet UIView *imageWrap0;
@property (retain, nonatomic) IBOutlet UIView *imageWrap1;
@property (retain, nonatomic) IBOutlet UIView *imageWrap2;
@property (retain, nonatomic) IBOutlet UIView *imageWrap3;
@property (retain, nonatomic) IBOutlet UIView *imageWrap4;
@property (retain, nonatomic) IBOutlet UIView *imageWrap5;

@end
