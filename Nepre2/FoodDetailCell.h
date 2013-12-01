//
//  FoodDetailCell.h
//  Nepre2
//
//  Created by Lsr on 11/28/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZUUIRevealController.h"

@interface FoodDetailCell : UITableViewCell{
    int sideFlag;
}
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIImageView *wentPerson1;
@property (weak, nonatomic) IBOutlet UIImageView *wentPerson2;
@property (weak, nonatomic) IBOutlet UIImageView *wentPerson3;
@property (weak, nonatomic) IBOutlet UIView *andView;
@property (weak, nonatomic) IBOutlet UILabel *andLabel;
@property (weak, nonatomic) IBOutlet UIView *likeView;
@property (weak, nonatomic) IBOutlet UIButton *authorButton;
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@end
