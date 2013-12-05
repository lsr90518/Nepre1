//
//  FavoriteViewController.m
//  Nepre2
//
//  Created by Lsr on 11/26/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "FavoriteViewController.h"
#import "ProfileViewController.h"
#import "FavoriteCell.h"
#import "WentViewController.h"
#import "FollowCell.h"

@interface FavoriteViewController ()
@property (weak, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *slideView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIView *myNavibar;
@property (weak, nonatomic) IBOutlet UIView *iconView;
@property (weak, nonatomic) IBOutlet UIView *menuView;


@end

@implementation FavoriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		// Check if a UIPanGestureRecognizer already sits atop our NavigationBar.
		if (![[self.navigationController.navigationBar gestureRecognizers] containsObject:self.navigationBarPanGestureRecognizer])
		{
			// If not, allocate one and add it.
			UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
			self.navigationBarPanGestureRecognizer = panGestureRecognizer;
			
			[self.slideView addGestureRecognizer:self.navigationBarPanGestureRecognizer];
		}
		
		// Check if we have a revealButton already.
		if (![self.navigationItem leftBarButtonItem])
		{
			// If not, allocate one and add it.
            
            [self.menuButton addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
		}
	}
    
//    self.favoriteTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationController.navigationBar.hidden = YES;
    
    //set avatar image
    NSLog(@"%@",[Mydata sharedSingleton].nowGoProfile);
    self.profileAvatar.image = [UIImage imageNamed:[Mydata sharedSingleton].nowGoProfile ];
    
    position1 = [[NSMutableArray alloc]init];
    position2 = [[NSMutableArray alloc]init];
    animat = 0;//不是动画
    
    
    self.items = [[NSArray alloc]initWithObjects:@"4.jpg",@"f2.jpg",@"13.jpg",@"f14.jpg",@"f5.jpg",@"f6.jpg",@"f7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg",@"f12.jpg",@"f13.jpg",@"14.jpg",@"15.jpg",@"f16.jpg",@"17.jpg",@"18.jpg",@"19.jpg",@"20.jpg", nil];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goFood)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.scroller addGestureRecognizer:swipeLeft];
    int inity = 15;
    
    for(int i = 0;i<14;i++){
        //make detail view
        //foodImage
        NSString *imageFileName = [NSString stringWithFormat:@"%d.jpg",i+1];
        UIImage *foodImage = [UIImage imageNamed:imageFileName];
        float imageWidth = foodImage.size.width;
        float imageHeight = foodImage.size.height;
        float rate = imageWidth/imageHeight;
        float newHeight = 320.0/rate;
        cellHeight = newHeight;
        
        //detailView
        UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, inity, 320, newHeight)];
        UIScrollView *detailScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, newHeight)];
        
        //detailImaveView
        UIButton *detailImageview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, newHeight)];
        [detailImageview setImage:foodImage forState:UIControlStateNormal];
        [detailImageview setImage:foodImage forState:UIControlStateHighlighted];
        UIImageView *likeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(270, newHeight-50, 40, 40)];
        likeImageView.image = [UIImage imageNamed:@"icon-09"];
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.text = [NSString stringWithFormat:@"%d",i];
        [numLabel setTextAlignment:UITextAlignmentCenter];
        numLabel.textColor = [UIColor whiteColor];
        [likeImageView addSubview:numLabel];
        [detailImageview setTag:i];
        [detailImageview addSubview:likeImageView];
        
        
        //init scroller
        [detailScroll setContentSize:CGSizeMake(640, 0)];
        [detailScroll setAlwaysBounceVertical:NO];
        [detailScroll setBackgroundColor:[UIColor whiteColor]];
        [detailScroll addSubview:detailImageview];
        [detailScroll setBackgroundColor:[UIColor blackColor]];
        [detailScroll setShowsHorizontalScrollIndicator:NO];
        [detailScroll setDelegate:self];
        [detailView setTag:i];
        [detailView addSubview:detailScroll];
        
        
        //went people
        int wentPersonX = 5;
        float wentY;
        for(int j = 0;j<3;j++){
            int value = (arc4random() % 4) + 1;
            int value2 = (arc4random() % 4) + 5;
            int value3 = (arc4random() % 4) + 9;
            int randomNum[] = {value,value2,value3};
            wentY = cellHeight-45.0;
            UIButton *wentperson = [[UIButton alloc]initWithFrame:CGRectMake(wentPersonX, wentY, 35, 35)];
            NSString *wentPersonIconFileName = [NSString stringWithFormat:@"_icon_-%d",randomNum[j]];
            NSLog(@"%@",wentPersonIconFileName);
            wentperson.tag = randomNum[j]+300;
            [wentperson setImage:[UIImage imageNamed:wentPersonIconFileName] forState:UIControlStateNormal];
            [wentperson addTarget:self action:@selector(goFriend:) forControlEvents:UIControlEventTouchUpInside];
            wentPersonX = wentPersonX + 40;
            [wentperson setAlpha:0.75];
            [detailView addSubview:wentperson];
        }
        
        //went num
        UIView *wentNumView = [[UIView alloc]initWithFrame:CGRectMake(wentPersonX, wentY, 35, 35)];
        [wentNumView setAlpha:0.75];
        [wentNumView setBackgroundColor:[UIColor redColor]];
        UILabel *wentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
        wentNumLabel.text = @"+8";
        wentNumLabel.textColor= [UIColor whiteColor];
        wentNumLabel.textAlignment = UITextAlignmentCenter;
        [wentNumLabel setBackgroundColor:[UIColor clearColor]];
        [wentNumView addSubview:wentNumLabel];
        [detailView addSubview:wentNumView];
        
        //author button
        UIButton *authorButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 50, 50)];
        int value = (arc4random() %14)+1;
        NSString *authorImageFileName = [NSString stringWithFormat:@"_icon_-%d",value];
        authorButton.tag = value+300;
        UIImage *authorImage = [UIImage imageNamed:authorImageFileName];
        [authorButton setImage:authorImage forState:UIControlStateNormal];
        [authorButton addTarget:self action:@selector(goFriend:) forControlEvents:UIControlEventTouchUpInside];
        authorButton.alpha=0.75;
        [detailImageview addSubview:authorButton];
        
        //map
        UIButton *mapButton = [[UIButton alloc]initWithFrame:CGRectMake(270, 5, 45, 45)];
        [mapButton setImage:[UIImage imageNamed:@"icon-01"] forState:UIControlStateNormal];
        [mapButton addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
        [mapButton setTag:i];
        [detailView addSubview:mapButton];
        
        
        //like,star button
        //        UIButton *likeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 55, 320, cellHeight)];
        //        likeButton.alpha = 0.75;
        //        likeButton.titleLabel.text = @"afwefwefawef";
        //        likeButton.tag=i;
        //        [likeButton setImage:[UIImage imageNamed:@"icon-09"] forState:UIControlStateNormal];
        //        [likeButton addTarget:self action:@selector(pushLike:) forControlEvents:UIControlEventTouchDownRepeat];
        //        [detailView addSubview:likeButton];
        
        inity = inity + cellHeight+15;
        [self.scroller addSubview:detailView];
        [position1 addObject:[NSNumber numberWithFloat:detailView.frame.origin.y]];
        float bottom = detailView.frame.origin.y+detailView.frame.size.height;
        [position2 addObject:[NSNumber numberWithFloat:bottom]];
    }
    [self.scroller setContentSize:CGSizeMake(320, inity)];
    [self.scroller setDelegate:self];
    [self putImage];
    
    //make follow table
    
    backBlackview = [[UIView alloc]initWithFrame:CGRectMake(0, 148, 320, 0)];
    [backBlackview setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:backBlackview];
    
    followTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 148, 158, 0) style:UITableViewStylePlain];
    followerTable = [[UITableView alloc]initWithFrame:CGRectMake(162, 148, 158, 0) style:UITableViewStylePlain];
    
    followerTable.delegate = self;
    followTable.delegate = self;
    followerTable.dataSource = self;
    followTable.dataSource = self;
    followTable.tag = 100;
    followerTable.tag = 101;
    [followTable setBackgroundColor:[UIColor blackColor]];
    [followerTable setBackgroundColor:[UIColor blackColor]];
    [followTable setSeparatorColor:[UIColor blackColor]];
    [followerTable setSeparatorColor:[UIColor blackColor]];
    
    [self.view addSubview:followTable];
    [self.view addSubview:followerTable];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
	scrolling = 1;
	CGPoint offset = aScrollView.contentOffset;
	CGRect bounds = aScrollView.bounds;
	CGSize size = aScrollView.contentSize;
	UIEdgeInsets inset = aScrollView.contentInset;
	float y = offset.y + bounds.size.height - inset.bottom;
	float h = size.height;
    float top = y - self.scroller.frame.size.height;
    float x = offset.x;
    //    	 NSLog(@"offset: %f", offset.y);
    //    	 NSLog(@"content.height: %f", size.height);
    //    	 NSLog(@"bounds.height: %f", bounds.size.height);
    //    	 NSLog(@"inset.top: %f", inset.top);
    //    	 NSLog(@"inset.bottom: %f", inset.bottom);
    //        NSLog(@"pos: %f of %f", y, h);
    //        NSLog(@"top: %f",y-aScrollView.frame.size.height);
    float diff = y -currentScrollerY;
    //    NSLog(@"%f",diff);
    
    NSNumber *bottomLine;
    NSNumber *topLine;
    
    if(y>bounds.size.height && y<aScrollView.contentSize.height){
        if(diff>0) {
            //down
            der = 1;
            if(diff > 10.0){
                if(animat == 0){
                    [UIView animateWithDuration:0.3 animations:^{
                        animat = 1;
                        [self.myNavibar setFrame:CGRectMake(0, -30, 320, 30)];
                        [self.iconView setFrame:CGRectMake(0, -80, 320, 80)];
                        [self.menuView setFrame:CGRectMake(0, -35, 320, 78)];
                        
                        [self.scroller setFrame:CGRectMake(0, 40, 320, self.view.frame.size.height-40)];
                    } completion:^(BOOL finshed){
                        animat = 0;
                    }];
                }
                
            }
            
            //move image function
            for (int i = 0;i<[position1 count];i++){
                topLine = [position1 objectAtIndex:i];
                bottomLine = [position2 objectAtIndex:i];
                if(y > [topLine floatValue]+10.0 && y <[bottomLine floatValue]){
                    UIView *tempView = (UIView *)[self.scroller viewWithTag:i];
                    [UIView animateWithDuration:0.3 animations:^{
                        [tempView setFrame:CGRectMake(tempView.frame.origin.x, [topLine floatValue], tempView.frame.size.width, tempView.frame.size.height)];
                    } completion:^(BOOL finshed){
                    }];
                }
                
                if(top > [bottomLine floatValue]-10){
                    UIView *tempView = (UIView *)[self.scroller viewWithTag:i];
                    [UIView animateWithDuration:0.3 animations:^{
                        [tempView setFrame:CGRectMake(tempView.frame.origin.x, [topLine floatValue]-100.0, tempView.frame.size.width, tempView.frame.size.height)];
                    } completion:^(BOOL finshed){
                    }];
                }
            }
            
        } else {
            //up
            der = 0;
            if(diff < -10.0){
                if(animat == 0){
                    [UIView animateWithDuration:0.3 animations:^{
                        animat = 1;
                        [self.myNavibar setFrame:CGRectMake(0, 0, 320, 30)];
                        [self.iconView setFrame:CGRectMake(0, 30, 320, 80)];
                        [self.menuView setFrame:CGRectMake(0, 110, 320, 78)];
                        [self.scroller setFrame:CGRectMake(0, 185, 320, 363)];
                    } completion:^(BOOL finshed){
                        animat = 0;
                    }];
                }
            }
            
            for (int i = 0;i<[position1 count];i++){
                topLine = [position1 objectAtIndex:i];
                bottomLine = [position2 objectAtIndex:i];
                
                if(y < [topLine floatValue]){
                    UIView *tempView = (UIView *)[self.scroller viewWithTag:i];
                    [UIView animateWithDuration:1.0 animations:^{
                        [tempView setFrame:CGRectMake(tempView.frame.origin.x, [topLine floatValue]+100, tempView.frame.size.width, tempView.frame.size.height)];
                    } completion:^(BOOL finshed){
                    }];
                }
                
                if(top < [bottomLine floatValue]-10 && top > [topLine floatValue]){
                    UIView *tempView = (UIView *)[self.scroller viewWithTag:i];
                    [UIView animateWithDuration:0.3 animations:^{
                        [tempView setFrame:CGRectMake(tempView.frame.origin.x, [topLine floatValue], tempView.frame.size.width, tempView.frame.size.height)];
                    } completion:^(BOOL finshed){
                    }];
                }
                
            }
        }
    }
    
    currentScrollerY = y;
	
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)aScrollView{
    
}
-(void) scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate{
    //    NSLog(@"%c",decelerate);
    //    if(aScrollView.tag != 100){
    //        CGPoint offset = aScrollView.contentOffset;
    //        float x = offset.x;
    //        NSLog(@"%f",x);
    //        if(x < 200){
    //            [aScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //        } else {
    //            [aScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    //        }
    //    }
}

-(void) putImage {
    int sHeight = self.scroller.frame.size.height;
    for(int i = 13;i>-1;i--){
        UIView *tempView = (UIView *)[self.scroller viewWithTag:i];
        if(tempView.frame.origin.y >sHeight){
            [tempView setFrame:CGRectMake(tempView.frame.origin.x, tempView.frame.origin.y+100.0, tempView.frame.size.width, tempView.frame.size.height)];
        }
    }
}

//table source
#pragma mark -
#pragma mark Table view data source
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView.tag == 0){
        return 1;
    } else {
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag == 100){
        return 8;
    } else if(tableView.tag == 101) {
        return 8;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FollowCell";
    
    FollowCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
    
    cell = (FollowCell*)[nibArray objectAtIndex:0];
    
    if(tableView.tag == 300){
        NSString *avatarName = [NSString stringWithFormat:@"_icon_-%d",indexPath.row+1];
        [cell.avatarIcon setImage:[UIImage imageNamed:avatarName] forState:UIControlStateNormal];
        [cell.avatarIcon addTarget:self action:@selector(goProfile:) forControlEvents:UIControlEventTouchUpInside];
        cell.avatarIcon.tag = indexPath.row+1;
        [cell.followButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [cell.followButton addTarget:self action:@selector(changeCheck:) forControlEvents:UIControlEventTouchUpInside];
        cell.followButton.tag = indexPath.row+100;
    } else {
        NSString *avatarName = [NSString stringWithFormat:@"_icon_-%d",14-indexPath.row];
        [cell.avatarIcon setImage:[UIImage imageNamed:avatarName] forState:UIControlStateNormal];
        [cell.avatarIcon addTarget:self action:@selector(goProfile:) forControlEvents:UIControlEventTouchUpInside];
        cell.avatarIcon.tag = 14-indexPath.row;
        [cell.followButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [cell.followButton addTarget:self action:@selector(changeCheck:) forControlEvents:UIControlEventTouchUpInside];
        cell.followButton.tag = indexPath.row+200;
    }
    if (cell == nil) {
        cell = [[FollowCell alloc]init];
        
    }
    
    
    return cell;
}

-(void) changeCheck:(UIButton*)sender{
    UIButton *button = sender;
    if(button.tag>199){
        //follower
        int newtag = button.tag-200;
        if([[[Mydata sharedSingleton].followerList objectAtIndex:newtag] intValue] == 0){
            [button setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
            NSNumber *friend = [[NSNumber alloc]initWithInt:1];
            [[Mydata sharedSingleton].followerList replaceObjectAtIndex:newtag withObject:friend];
        } else {
            [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            NSNumber *friend = [[NSNumber alloc]initWithInt:0];
            [[Mydata sharedSingleton].followerList replaceObjectAtIndex:newtag withObject:friend];
        }
    } else {
        int newtag = button.tag-100;
        
        if([[[Mydata sharedSingleton].followList objectAtIndex:newtag] intValue] == 0){
            [button setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
            NSNumber *friend = [[NSNumber alloc]initWithInt:1];
            [[Mydata sharedSingleton].followList replaceObjectAtIndex:newtag withObject:friend];
        } else {
            [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            NSNumber *friend = [[NSNumber alloc]initWithInt:0];
            [[Mydata sharedSingleton].followList replaceObjectAtIndex:newtag withObject:friend];
        }
    }
}

//select
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d       %d",tableView.tag,indexPath.row);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *FollowColor = [UIColor colorWithRed:32.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
    UIColor *FollowerColor = [UIColor colorWithRed:49.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (tableView.tag == 300) {
        cell.backgroundColor = FollowColor;
    }
    else if(tableView.tag == 301) {
        cell.backgroundColor = FollowerColor;
    }
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (IBAction)goFollow:(id)sender {
    //    FollowViewController *follow = [[FollowViewController alloc]init];
    //
    //    [self.navigationController pushViewController:follow animated:NO];
    if(tableClick == 0){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [followTable setFrame:CGRectMake(0, 148, 158, 408)];
            [followerTable setFrame:CGRectMake(162, 148, 158, 408)];
            [backBlackview setFrame:CGRectMake(0, 148, 320, 408)];
        } completion:^(BOOL finshed){
            tableClick = 1;
        }];
    } else {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [followTable setFrame:CGRectMake(0, 148, 158, 0)];
            [followerTable setFrame:CGRectMake(162, 148, 158, 0)];
            [backBlackview setFrame:CGRectMake(0, 148, 320, 0)];
        } completion:^(BOOL finshed){
            tableClick = 0;
        }];
    }
    
}

- (IBAction)goWent:(id)sender {
    [self.scroller removeFromSuperview];
    WentViewController *wvc = [[WentViewController alloc]init];
    
    [self.navigationController pushViewController:wvc animated:NO];
}

- (IBAction)goProfile:(id)sender {
    
    [self.scroller removeFromSuperview];
    ProfileViewController *p = [[ProfileViewController alloc]init];
    
    [self.navigationController pushViewController:p animated:NO];
}

-(void) goFriend:(id)sender{
    UIButton *button = (UIButton*)sender;
    NSLog(@"%d    %@",button.tag,[[Mydata sharedSingleton].userList objectAtIndex:button.tag-300]);
    [Mydata sharedSingleton].nowGoProfile = [[Mydata sharedSingleton].userList objectAtIndex:button.tag-300];
    [self.scroller removeFromSuperview];
    ProfileViewController *pvc = [[ProfileViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
