//
//  FoodDetailCell.m
//  Nepre2
//
//  Created by Lsr on 11/28/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "FoodDetailCell.h"

@implementation FoodDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UITapGestureRecognizer *doubleClick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self.detailImageView addGestureRecognizer:doubleClick];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)chooseLike:(id)sender  {
    NSLog(@"double click");
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView animateWithDuration:0.5 animations:^{
        [self.likeImageView setFrame:CGRectMake(140, 180, 100, 100)];
        self.likeImageView.alpha = 0.75;
    } completion:^(BOOL finshed){
        [UIView animateWithDuration:1.0 animations:^{
            [self.likeImageView setFrame:CGRectMake(120, 160, 120, 120)];
        } completion:^(BOOL finshed){
            [UIView animateWithDuration:0.5 animations:^{
                self.likeImageView.alpha = 0.0;
                
            } completion:nil];
        }];
    }];
}
- (IBAction)goMap:(id)sender {
    NSLog(@"push me");
}


@end
