//
//  FavoriteCell.m
//  Nepre2
//
//  Created by Lsr on 11/27/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "FavoriteCell.h"

@interface FavoriteCell()

@property (nonatomic, retain) NSMutableArray   *dataArray1;

@end

@implementation FavoriteCell
@synthesize dataArray1 = _dataArray1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        hortable = [[UITableView alloc]initWithFrame:CGRectMake(90, -50, 140, 320) style:UITableViewStylePlain];
        hortable.delegate = self;
        hortable.dataSource = self;
        hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
        hortable.showsHorizontalScrollIndicator = NO;
        hortable.showsVerticalScrollIndicator = NO;
        UIButton *authorButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 25, 25)];
        
        [self addSubview:authorButton];
        
		[self addSubview:hortable];
        _dataArray1 = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",nil];
        
    }
    hortable.tag = 1;
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [_dataArray1 count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%d",indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        [[cell textLabel] setText:[_dataArray1 objectAtIndex:indexPath.row]];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		
	}
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"fff%d",tableView.tag);
    NSLog(@"点击%d",[indexPath row]);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
