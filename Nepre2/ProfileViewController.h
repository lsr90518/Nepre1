//
//  ProfileViewController.h
//  Nepre2
//
//  Created by Lsr on 11/26/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"

@interface ProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    int sideFlag;
    UITableView *followTable;
    UITableView *followerTable;
    int tableClick;
    int currentScrollerY;
    int der;
    float cellHeight;
    NSMutableArray *position1;
    NSMutableArray *position2;
    int animat;
    int scrolling;
    UIView *backBlackview;
}

@property (weak, nonatomic) IBOutlet UIImageView *profileAvatar;
@property (retain, nonatomic) NSMutableData *recieveData;

@end
