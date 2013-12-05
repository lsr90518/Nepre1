//
//  WentViewController.h
//  Nepre2
//
//  Created by Lsr on 12/5/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
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
