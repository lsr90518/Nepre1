//
//  FavoriteCell.h
//  Nepre2
//
//  Created by Lsr on 11/27/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *hortable;
    NSInteger porsection;
}
@property (weak, nonatomic) IBOutlet UIButton *authorButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@end
