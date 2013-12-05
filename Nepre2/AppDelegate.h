//
//  AppDelegate.h
//  Nepre2
//
//  Created by Lsr on 11/22/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RevealController.h"
#import "JSONKit.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableString *initArray;
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RevealController *viewController;

@end
