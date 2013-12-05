//
//  RevealController.m
//  Nepre2
//
//  Created by Lsr on 11/22/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "RevealController.h"
#import "AppDelegate.h"

@interface RevealController ()

@end

@implementation RevealController

@synthesize foodViewArray = _foodViewArray;

#pragma mark - Initialization

- (id)initWithFrontViewController:(UIViewController *)aFrontViewController rearViewController:(UIViewController *)aBackViewController
{
	self = [super initWithFrontViewController:aFrontViewController rearViewController:aBackViewController];
	
    
	if (nil != self)
	{
		self.delegate = self;
	}
    
    touchbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [touchbutton setBackgroundColor:[UIColor clearColor]];
    [touchbutton addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:touchbutton];
    
    self.foodViewArray = [[NSMutableArray alloc]initWithCapacity:10];
    NSString *temp = @"test";
    [self.foodViewArray addObject:temp];
	
	return self;
}


/*
 * All of the methods below are optional. You can use them to control the behavior of the ZUUIRevealController,
 * or react to certain events.
 */
- (BOOL)revealController:(ZUUIRevealController *)revealController shouldRevealRearViewController:(UIViewController *)rearViewController
{
	return YES;
}

- (BOOL)revealController:(ZUUIRevealController *)revealController shouldHideRearViewController:(UIViewController *)rearViewController
{
	return YES;
}

- (void)revealController:(ZUUIRevealController *)revealController willRevealRearViewController:(UIViewController *)rearViewController
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(ZUUIRevealController *)revealController didRevealRearViewController:(UIViewController *)rearViewController
{
    [touchbutton setFrame:CGRectMake(60, 30, 320, 518)];
	NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(ZUUIRevealController *)revealController willHideRearViewController:(UIViewController *)rearViewController
{
	NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(ZUUIRevealController *)revealController didHideRearViewController:(UIViewController *)rearViewController
{
    [touchbutton setFrame:CGRectMake(0, 0, 0, 0)];
	NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end
