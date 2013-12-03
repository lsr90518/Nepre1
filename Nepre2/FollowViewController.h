//
//  FollowViewController.h
//  Nepre2
//
//  Created by Lsr on 11/26/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    int sideFlag;
}
@property (retain, nonatomic) IBOutlet UITableView *followTable;
@property (retain, nonatomic) IBOutlet UITableView *followerTable;

@end
