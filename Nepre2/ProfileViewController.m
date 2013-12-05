//
//  ProfileViewController.m
//  Nepre2
//
//  Created by Lsr on 11/26/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "ProfileViewController.h"
#import "FavoriteViewController.h"
#import "FollowViewController.h"
#import "FollowCell.h"
#import "Mydata.h"
#import "FoodDetailViewController.h"
#import "WentViewController.h"

@interface ProfileViewController ()

@property (weak, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIView *slideView;
@property (weak, nonatomic) IBOutlet UIView *iconView;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *myNavibar;

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

    
	if ([self.navigationController.parentViewController respondsToSelector:@selector(revealGesture:)] && [self.navigationController.parentViewController respondsToSelector:@selector(revealToggle:)])
	{
		// Check if a UIPanGestureRecognizer already sits atop our NavigationBar.
		if (![[self.navigationController.navigationBar gestureRecognizers] containsObject:self.navigationBarPanGestureRecognizer])
		{
			// If not, allocate one and add it.
			UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
			self.navigationBarPanGestureRecognizer = panGestureRecognizer;
			
            //			[self.navigationController.view addGestureRecognizer:self.navigationBarPanGestureRecognizer];
            [self.slideView addGestureRecognizer:self.navigationBarPanGestureRecognizer];
            
		}
		
		// Check if we have a revealButton already.
		if (![self.navigationItem leftBarButtonItem])
		{
			// If not, allocate one and add it.
            
            [self.menuButton addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
            
		}
	}
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goSpot)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goTimeline)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
//    
//    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openCamera)];
//    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
//    [self.cameraView addGestureRecognizer:swipeUp];
//    
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    //calculate View position
    [self putImage];
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //set avatar image
    NSLog(@"%@",[Mydata sharedSingleton].nowGoProfile);
    self.profileAvatar.image = [UIImage imageNamed:[Mydata sharedSingleton].nowGoProfile ];
    
    //follow table
    tableClick = 0;
    //huwahuwa initail
    position1 = [[NSMutableArray alloc]init];
    position2 = [[NSMutableArray alloc]init];
    animat = 0;//不是动画
    
    //check
    
    if([Mydata sharedSingleton].foodViewArray == nil){
        [self initDataArray];
    }
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    
    int imageViewY = 1;
    int imageTagNum = 0;
    for(int i = 0;i<[Mydata sharedSingleton].foodViewArray.count;i++){
        NSDictionary *jsonImage = [[Mydata sharedSingleton].foodViewArray objectAtIndex:i];
        NSArray *imageViewnameArray = [jsonImage valueForKey:@"name"];
        NSArray *imageViewheightArray = [jsonImage valueForKey:@"height"];
        NSArray *imageViewwidthArray = [jsonImage valueForKey:@"width"];
        NSArray *imageViewidArray = [jsonImage valueForKey:@"id"];
        
        //make a image wrap view
        UIView *homeView = [[UIView alloc]initWithFrame:CGRectMake(2, imageViewY, 320, [imageViewheightArray[0] floatValue])];
        [homeView setBackgroundColor:[UIColor blackColor]];
        homeView.tag = i+100;
        [self.scroller addSubview:homeView];
        
        
        
        //paste imageView
        int imageButtonX = 0;
        for(int j = 0 ; j<imageViewnameArray.count ; j++){
            
            //add info to Mydata
            [[Mydata sharedSingleton].imageViewnameArray addObject:imageViewnameArray[j]];
            [[Mydata sharedSingleton].imageViewheightArray addObject:imageViewheightArray[j]];
            [[Mydata sharedSingleton].imageViewwidthArray addObject:imageViewwidthArray[j]];
            [[Mydata sharedSingleton].imageViewidArray addObject:imageViewidArray[j]];
            //
            NSString *homeImageFileName = [NSString stringWithFormat:@"%@",imageViewnameArray[j]];
            UIButton *homeImageView = [[UIButton alloc]initWithFrame:CGRectMake(imageButtonX, 0, [imageViewwidthArray[j] floatValue], [imageViewheightArray[j] floatValue])];
            [homeImageView setImage:[UIImage imageNamed:homeImageFileName] forState:UIControlStateNormal];
            imageButtonX = imageButtonX + [imageViewwidthArray[j] floatValue];
            imageButtonX = imageButtonX +2;
            homeImageView.tag = imageTagNum;
            imageTagNum++;
            [homeImageView addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchUpInside];
            [homeView addSubview:homeImageView];
            
            //went people
            int wentPersonX = 5;
            float wentY = [imageViewheightArray[j] floatValue];
            wentY = wentY - 45.0;
            
            if( [imageViewnameArray count] == 1){
                int value = (arc4random() % 4) + 1;
                int value2 = (arc4random() % 4) + 5;
                int value3 = (arc4random() % 4) + 9;
                int randomNum[] = {value,value2,value3};
                for(int j = 0;j<3;j++){
                    UIButton *wentperson = [[UIButton alloc]initWithFrame:CGRectMake(wentPersonX, wentY, 35, 35)];
                    
                    NSString *wentPersonIconFileName = [NSString stringWithFormat:@"_icon_-%d",randomNum[j]];
                    wentperson.tag = randomNum[j];
                    [wentperson addTarget:self action:@selector(goProfile:) forControlEvents:UIControlEventTouchUpInside];
                    [wentperson setImage:[UIImage imageNamed:wentPersonIconFileName] forState:UIControlStateNormal];
                    wentPersonX = wentPersonX + 40;
                    [homeImageView addSubview:wentperson];
                }
            }
            
            //went num
            UIView *wentNumView = [[UIView alloc]initWithFrame:CGRectMake(wentPersonX, wentY, 35, 35)];
            [wentNumView setAlpha:0.75];
            [wentNumView setBackgroundColor:[UIColor redColor]];
            UILabel *wentNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
            wentNumLabel.text = @"+";
            wentNumLabel.textColor= [UIColor whiteColor];
            wentNumLabel.textAlignment = UITextAlignmentCenter;
            [wentNumLabel setBackgroundColor:[UIColor clearColor]];
            [wentNumView addSubview:wentNumLabel];
            [homeImageView addSubview:wentNumView];
            
            //likeImageview
            float likeX = [imageViewwidthArray[j] floatValue];
            UIImageView *likeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(likeX-50, wentY-3, 40, 40)];
            likeImageView.image = [UIImage imageNamed:@"icon-09"];
            UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
            numLabel.backgroundColor = [UIColor clearColor];
            numLabel.text = [NSString stringWithFormat:@"%d",i];
            [numLabel setTextAlignment:UITextAlignmentCenter];
            numLabel.textColor = [UIColor whiteColor];
            [likeImageView addSubview:numLabel];
            [homeImageView addSubview:likeImageView];
            
        }
        imageViewY = imageViewY + [imageViewheightArray[0] floatValue];
        imageViewY = imageViewY +2;
        //huwahuwa initail2
        [position1 addObject:[NSNumber numberWithFloat:homeView.frame.origin.y]];
        float bottom = homeView.frame.origin.y+homeView.frame.size.height;
        [position2 addObject:[NSNumber numberWithFloat:bottom]];
    }
    
    
    [self.scroller setContentSize:CGSizeMake(320, imageViewY)];
    [self.scroller setTag:1000];
    
    //set scroller Y
    currentScrollerY = self.scroller.frame.size.height;
    
//    followTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 148, 159, 408) style:UITableViewStylePlain];
//    followerTable = [[UITableView alloc]initWithFrame:CGRectMake(162, 148, 158, 408) style:UITableViewStylePlain];
    
    followTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 148, 159, 0) style:UITableViewStylePlain];
    followerTable = [[UITableView alloc]initWithFrame:CGRectMake(162, 148, 158, 0) style:UITableViewStylePlain];
    
    backBlackview = [[UIView alloc]initWithFrame:CGRectMake(0, 148, 320, 0)];
    [backBlackview setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:backBlackview];
    
    followerTable.delegate = self;
    followTable.delegate = self;
    followerTable.dataSource = self;
    followTable.dataSource = self;
    followTable.tag = 300;
    followerTable.tag = 301;
    [followTable setBackgroundColor:[UIColor blackColor]];
    [followerTable setBackgroundColor:[UIColor blackColor]];
    [followTable setSeparatorColor:[UIColor blackColor]];
    [followerTable setSeparatorColor:[UIColor blackColor]];
    [self.view addSubview:followTable];
    [self.view addSubview:followerTable];
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
    if(tableView.tag == 300){
        return 14;
    } else if(tableView.tag == 301) {
        return 14;
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

- (IBAction)pushButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    [Mydata sharedSingleton].detailImageTag = [NSString stringWithFormat:@"%d",button.tag];
    
    FoodDetailViewController *foodDetailViewController = [[FoodDetailViewController alloc]init];
    [self.navigationController pushViewController:foodDetailViewController animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
	scrolling = 1;
	CGPoint offset = aScrollView.contentOffset;
	CGRect bounds = aScrollView.bounds;
	CGSize size = aScrollView.contentSize;
	UIEdgeInsets inset = aScrollView.contentInset;
	float y = offset.y + bounds.size.height - inset.bottom;
    float top = y - self.scroller.frame.size.height;
    //    	 NSLog(@"offset: %f", offset.y);
    //    	 NSLog(@"content.height: %f", size.height);
    //    	 NSLog(@"bounds.height: %f", bounds.size.height);
    //    	 NSLog(@"inset.top: %f", inset.top);
    //    	 NSLog(@"inset.bottom: %f", inset.bottom);
    //        NSLog(@"pos: %f of %f", y, h);
    //        NSLog(@"top: %f",y-aScrollView.frame.size.height);
    float diff = y -currentScrollerY;
    //    NSLog(@"%f",diff);
    //    if(refreshFlag == 0){
    NSNumber *bottomLine;
    NSNumber *topLine;
    if(tableClick == 0){
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
                    UIView *tempView = (UIView *)[self.scroller viewWithTag:i+100];
                    [UIView animateWithDuration:0.3 animations:^{
                        [tempView setFrame:CGRectMake(tempView.frame.origin.x, [topLine floatValue], tempView.frame.size.width, tempView.frame.size.height)];
                    } completion:^(BOOL finshed){
                    }];
                }
                
                if(top > [bottomLine floatValue]-10){
                    UIView *tempView = (UIView *)[self.scroller viewWithTag:i+100];
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
                        [self.scroller setFrame:CGRectMake(0, 185, 320, 360)];
                    } completion:^(BOOL finshed){
                        animat = 0;
                    }];
                }
            }
            
            for (int i = 0;i<[position1 count];i++){
                topLine = [position1 objectAtIndex:i];
                bottomLine = [position2 objectAtIndex:i];
                
                if(y < [topLine floatValue]){
                    UIView *tempView = (UIView *)[self.scroller viewWithTag:i+100];
                    [UIView animateWithDuration:1.0 animations:^{
                        [tempView setFrame:CGRectMake(tempView.frame.origin.x, [topLine floatValue]+100, tempView.frame.size.width, tempView.frame.size.height)];
                    } completion:^(BOOL finshed){
                    }];
                }
                
                if(top < [bottomLine floatValue]-10 && top > [topLine floatValue]){
                    UIView *tempView = (UIView *)[self.scroller viewWithTag:i+100];
                    [UIView animateWithDuration:0.3 animations:^{
                        [tempView setFrame:CGRectMake(tempView.frame.origin.x, [topLine floatValue], tempView.frame.size.width, tempView.frame.size.height)];
                    } completion:^(BOOL finshed){
                    }];
                }
                
            }
        }
        //        }
        
    }
        currentScrollerY = y;
	}
}



-(void) putImage {
    int sHeight = self.scroller.frame.size.height;
    for(int i = 100;i < [[Mydata sharedSingleton].foodViewArray count]+100 ; i++){
        UIView *tempView = (UIView *)[self.scroller viewWithTag:i];
        if(tempView.frame.origin.y >sHeight){
            [tempView setFrame:CGRectMake(tempView.frame.origin.x, tempView.frame.origin.y+100.0, tempView.frame.size.width, tempView.frame.size.height)];
        }
        
    }
    
}


-(void) initDataArray{
    
    NSLog(@"%d",[[Mydata sharedSingleton].foodViewArray count]);
    
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:@"http://ll.is.tokushima-u.ac.jp/Nepre/GetPhoto"];
    
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    
    //第三步，连接服务器
    self.recieveData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *receiveStr = [[NSString alloc]initWithData:self.recieveData encoding:NSUTF8StringEncoding];
    NSData* jsonData = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *result = [[NSMutableArray alloc]initWithArray:[jsonData objectFromJSONData]];
    [Mydata sharedSingleton].foodViewArray = [[NSMutableArray alloc]initWithArray:result];
}

- (IBAction)goWent:(id)sender {
    for(int i = 0 ;i<[[Mydata sharedSingleton].foodViewArray count];i++){
        UIView *removeView = (UIView*)[self.scroller viewWithTag:100+i];
        [removeView removeFromSuperview];
    }
    WentViewController *wvc = [[WentViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:NO];
}


- (IBAction)goFavorite:(id)sender {
    for(int i = 0 ;i<[[Mydata sharedSingleton].foodViewArray count];i++){
        UIView *removeView = (UIView*)[self.scroller viewWithTag:100+i];
        [removeView removeFromSuperview];
    }
    FavoriteViewController * fvc = [[FavoriteViewController alloc]init];
    
    [self.navigationController pushViewController:fvc animated:NO];
}
- (IBAction)goFollow:(id)sender {
//    FollowViewController *follow = [[FollowViewController alloc]init];
//
//    [self.navigationController pushViewController:follow animated:NO];
    
    if(tableClick == 0){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [followTable setFrame:CGRectMake(0, 148, 159, 320)];
            [followerTable setFrame:CGRectMake(162, 148, 158, 320)];
            [backBlackview setFrame:CGRectMake(0, 148, 320, 320)];
        } completion:^(BOOL finshed){
            tableClick = 1;
        }];
    } else {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [followTable setFrame:CGRectMake(0, 148, 159, 0)];
            [followerTable setFrame:CGRectMake(162, 148, 158, 0)];
            [backBlackview setFrame:CGRectMake(0, 148, 320, 0)];
        } completion:^(BOOL finshed){
            tableClick = 0;
        }];
    }

}

-(void) goProfile:(id)sender{
    UIButton *button = (UIButton*)sender;
    NSLog(@"%d    %@",button.tag,[[Mydata sharedSingleton].userList objectAtIndex:button.tag]);
    for(int i = 0 ;i<[[Mydata sharedSingleton].foodViewArray count];i++){
        UIView *removeView = (UIView*)[self.scroller viewWithTag:100+i];
        [removeView removeFromSuperview];
    }
    [Mydata sharedSingleton].nowGoProfile = [[Mydata sharedSingleton].userList objectAtIndex:button.tag];
    ProfileViewController *pvc = [[ProfileViewController alloc]init];
    [self.navigationController pushViewController:pvc animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
