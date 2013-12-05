//
//  FavoriteViewController.h
//  Nepre2
//
//  Created by Lsr on 11/26/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"
#import "Mydata.h"

@interface FavoriteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    int sideFlag;
    float cellHeight;
    int currentScrollerY;
    int der;
    NSMutableArray *position1;
    NSMutableArray *position2;
    int animat;
    int scrolling;
    UITableView *followTable;
    UITableView *followerTable;
    int tableClick;
    UIView *backBlackview;
    
}

@property NSArray *items;
@property (weak, nonatomic) IBOutlet UIImageView *profileAvatar;
@property (strong, nonatomic) NSMutableData *recieveData;

@end
