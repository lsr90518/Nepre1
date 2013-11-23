//
//  SidebarViewController.m
//  Nepre2
//
//  Created by Lsr on 11/22/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "SidebarViewController.h"

@interface SidebarViewController ()

@end

@implementation SidebarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)goHome:(id)sender {
    
    RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    
    
    if(![revealController.frontViewController isKindOfClass:[FoodViewController class]]){
        FoodViewController *foodViewController = [[FoodViewController alloc]init];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:foodViewController];
        
        [revealController setFrontViewController:navigationController animated:NO];
    }
}

- (IBAction)goProfile:(id)sender {
    
    RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    
    
    if(![revealController.frontViewController isKindOfClass:[ProfileViewController class]]){
        ProfileViewController *foodViewController = [[ProfileViewController alloc]init];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:foodViewController];
        
        [revealController setFrontViewController:navigationController animated:NO];
    }
}

- (IBAction)goFood:(id)sender {
    
    RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    
    
    if(![revealController.frontViewController isKindOfClass:[FoodViewController class]]){
        FoodViewController *foodViewController = [[FoodViewController alloc]init];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:foodViewController];
        
        [revealController setFrontViewController:navigationController animated:NO];
    }
}

- (IBAction)goPlace:(id)sender {
    
    RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    
    
    if(![revealController.frontViewController isKindOfClass:[PlaceViewController class]]){
        PlaceViewController *foodViewController = [[PlaceViewController alloc]init];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:foodViewController];
        
        [revealController setFrontViewController:navigationController animated:NO];
    }
}

- (IBAction)goTimeline:(id)sender {
    
    RevealController *revealController = [self.parentViewController isKindOfClass:[RevealController class]] ? (RevealController *)self.parentViewController : nil;
    
    
    if(![revealController.frontViewController isKindOfClass:[TimelineViewController class]]){
        TimelineViewController *timelineViewController = [[TimelineViewController alloc]init];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:timelineViewController];
        
        [revealController setFrontViewController:navigationController animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
