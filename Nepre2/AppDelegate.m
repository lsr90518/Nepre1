//
//  AppDelegate.m
//  Nepre2
//
//  Created by Lsr on 11/22/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "AppDelegate.h"
#import "FoodViewController.h"
#import "SidebarViewController.h"
#import "ViewController.h"
#import "Mydata.h"

@implementation AppDelegate

@synthesize window =_window;
@synthesize viewController = _viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    FoodViewController *foodViewController = [[FoodViewController alloc]init];
    SidebarViewController *sidebarViewController = [[SidebarViewController alloc]init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:foodViewController];
	
	RevealController *revealController = [[RevealController alloc] initWithFrontViewController:navigationController rearViewController:sidebarViewController];
	self.viewController = revealController;
    

    [self initData];
    
    self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];
    
    return YES;
}

-(void) initData {
    ///////////////////////////////
    [Mydata sharedSingleton].imageViewheightArray = [[NSMutableArray alloc]init];
    [Mydata sharedSingleton].imageViewnameArray = [[NSMutableArray alloc]init];
    [Mydata sharedSingleton].imageViewwidthArray = [[NSMutableArray alloc]init];
    [Mydata sharedSingleton].imageViewidArray = [[NSMutableArray alloc]init];
    [Mydata sharedSingleton].imageViewlatArray = [[NSMutableArray alloc]init];
    [Mydata sharedSingleton].imageViewlngArray = [[NSMutableArray alloc]init];
    
    [Mydata sharedSingleton].followerList = [[NSMutableArray alloc] init];
    [Mydata sharedSingleton].followList = [[NSMutableArray alloc] init];

    
    [Mydata sharedSingleton].userList = [[NSMutableArray alloc]init];
    for(int i = 0;i< 15;i++){
        NSString *userimage = [NSString stringWithFormat:@"_icon_-%d",i];
        [[Mydata sharedSingleton].userList addObject:userimage];
        NSNumber *friend = [[NSNumber alloc]initWithInt:0];
        NSNumber *unFriend = [[NSNumber alloc]initWithInt:1];
        [[Mydata sharedSingleton].followerList addObject:friend];
        [[Mydata sharedSingleton].followList addObject:unFriend];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
