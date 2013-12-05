//
//  TimelineViewController.m
//  Nepre2
//
//  Created by Lsr on 11/23/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "TimelineViewController.h"
#import "FoodViewController.h"
#import "PlaceViewController.h"

@interface TimelineViewController ()

@property (weak, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIView *slideView;
@property (weak, nonatomic) IBOutlet UIView *myNavibar;

@end

@implementation TimelineViewController

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
    
    self.navigationController.navigationBar.hidden = YES;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goFood)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.scroller addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goSpot)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.scroller addGestureRecognizer:swipeRight];
    
    position1 = [[NSMutableArray alloc]init];
    position2 = [[NSMutableArray alloc]init];
    animat = 0;//不是动画
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.items = [[NSArray alloc]initWithObjects:@"f4.jpg",@"2.jpg",@"13.jpg",@"4.jpg",@"f5.jpg",@"6.jpg",@"f7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg",@"f12.jpg",@"f13.jpg",@"14.jpg",@"15.jpg",@"f16.jpg",@"17.jpg",@"18.jpg",@"19.jpg",@"20.jpg", nil];
    
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goFood)];
    
    int inity = 15;
    
    for(int i = 0;i<8;i++){
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
        [detailImageview addTarget:self action:@selector(pushLike:) forControlEvents:UIControlEventTouchDownRepeat];
        [detailImageview setTag:i];
        [detailImageview addSubview:likeImageView];
        
        UILongPressGestureRecognizer *longpressGesutre=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongpressGesture:)];
        //长按时间为1秒
        longpressGesutre.minimumPressDuration=0.5;
        longpressGesutre.allowableMovement=1;
        longpressGesutre.numberOfTouchesRequired=1;
        [longpressGesutre setDelegate:self];
        [detailImageview addGestureRecognizer:longpressGesutre];
        
        
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
            wentY = cellHeight-45.0;
            UIImageView *wentperson = [[UIImageView alloc]initWithFrame:CGRectMake(wentPersonX, wentY, 35, 35)];
            NSString *wentPersonIconFileName = [NSString stringWithFormat:@"_icon-0%d",j+1];
            wentperson.image = [UIImage imageNamed:wentPersonIconFileName];
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
        UIImage *authorImage = [UIImage imageNamed:@"_icon-07"];
        [authorButton setImage:authorImage forState:UIControlStateNormal];
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
}

-(void) goFood {
    FoodViewController *fvc = [[FoodViewController alloc]init];
    [self.navigationController pushViewController:fvc animated:YES];
}

-(void) goSpot {
    PlaceViewController *tvc = [[PlaceViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionMoveIn;
    //    animation.subtype = kCATransitionFromTop;
    [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    [self.navigationController pushViewController:tvc animated:NO];
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
                        [self.scroller setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
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
                        [self.scroller setFrame:CGRectMake(0, 30, 320, 518)];
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

- (void)pushLike:(id)sender{
    UIButton *button = (UIButton*)sender;
    int heartY = button.frame.size.height - 80;
    heartY = heartY/2;
    UIImageView *heartImageView = [[UIImageView alloc]initWithFrame:CGRectMake(120, heartY, 80, 80)];
    heartImageView.image = [UIImage imageNamed:@"icon-09"];
    heartImageView.alpha=0;
    [button addSubview:heartImageView];
    [UIView animateWithDuration:1.4 animations:^{
        [heartImageView setAlpha:0.9];
        [heartImageView setFrame:CGRectMake(110, heartY-10, 100, 100)];
    } completion:^(BOOL finshed){
        [UIView animateWithDuration:1.1 animations:^{
            [heartImageView setAlpha:0.0];
        } completion:^(BOOL finshed){
        }];
    }];
}

- (void)handleLongpressGesture:(UITapGestureRecognizer *)sender{
    UIButton *button = (UIButton*)sender.view;
    
    int heartY = button.frame.size.height - 80;
    heartY = heartY/2;
    UIImageView *heartImageView = [[UIImageView alloc]initWithFrame:CGRectMake(120, heartY, 80, 80)];
    heartImageView.image = [UIImage imageNamed:@"favorite_popup_03"];
    heartImageView.alpha=0;
    [button addSubview:heartImageView];
    [UIView animateWithDuration:1.7 animations:^{
        [heartImageView setAlpha:1.0];
        [heartImageView setFrame:CGRectMake(110, heartY-10, 100, 100)];
    } completion:^(BOOL finshed){
        [UIView animateWithDuration:1.1 animations:^{
            [heartImageView setAlpha:0.0];
        } completion:^(BOOL finshed){
        }];
    }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
