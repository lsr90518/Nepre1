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
        hortable = [[UITableView alloc]initWithFrame:CGRectMake(80, -40, 170, 320) style:UITableViewStylePlain];
        hortable.delegate = self;
        hortable.dataSource = self;
        hortable.transform = CGAffineTransformMakeRotation(M_PI / 2 *3);
        hortable.showsHorizontalScrollIndicator = NO;
        hortable.showsVerticalScrollIndicator = NO;
        hortable.backgroundColor = [UIColor blackColor];
		[self addSubview:hortable];
        
        //input author button
        UIButton *authorButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 25, 25)];
        [authorButton setImage:[UIImage imageNamed:@"_icon-02"] forState:UIControlStateNormal];
        [authorButton addTarget:self action:@selector(goFriend:) forControlEvents:UIControlEventTouchUpInside];
        [authorButton setTag:1];
        [self addSubview:authorButton];
        
        //input plus button
        UIButton *plusButton = [[UIButton alloc]initWithFrame:CGRectMake(290, 5, 25, 25)];
        [plusButton setImage:[UIImage imageNamed:@"icon-22"] forState:UIControlStateNormal];
        [plusButton addTarget:self action:@selector(plusFriend:) forControlEvents:UIControlEventTouchUpInside];
        [plusButton setTag:1];
        [self addSubview:plusButton];
        
        //input a black line
        UIView *blackLine= [[UIView alloc]initWithFrame:CGRectMake(0, 201, 320, 4)];
        blackLine.backgroundColor = [UIColor blackColor];
        [self addSubview:blackLine];
        
        
        _dataArray1 = [[NSMutableArray alloc]initWithObjects:@"f1.jpg",@"2.jpg",@"f3.jpg",@"f4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"f9.jpg",@"f10.jpg",@"11.jpg",nil];
        
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
        cell = [[UITableViewCell alloc]init];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        
        //input imageView
        UIButton *detailButton = [[UIButton alloc]initWithFrame:CGRectMake(5,0, 190, 135)];
        [detailButton setImage:[UIImage imageNamed:[_dataArray1 objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        [detailButton setTag:indexPath.row];
        [cell addSubview:detailButton];
        
        //input heart star
        UIButton *likeButton = [[UIButton alloc]initWithFrame:CGRectMake(75, 137, 20, 20)];
        [likeButton setImage:[UIImage imageNamed:@"icon-09"] forState:UIControlStateNormal];
        [cell addSubview:likeButton];
        
        //input star star
        UIButton *starButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 137, 20, 20)];
        [starButton setImage:[UIImage imageNamed:@"icon-16"] forState:UIControlStateNormal];
        [cell addSubview:starButton];
		
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor blackColor];
}


-(void) goFriend :(id)sender{
    
    UIButton *button = (UIButton*)sender;
    NSLog(@"%d",button.tag);
}

-(void) plusFriend: (id)sender{
    UIButton *button = (UIButton *)sender;
    NSLog(@"plus friend %d",button.tag);
}

@end
