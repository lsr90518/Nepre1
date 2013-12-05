//
//  FoodDetailViewController.m
//  Nepre2
//
//  Created by Lsr on 11/25/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "FoodDetailViewController.h"
#import "FoodViewController.h"
#import "FoodDetailCell.h"
#import "FoodLocationViewController.h"
#import "Mydata.h"
#import "JSONKit.h"

@interface FoodDetailViewController ()


@property (weak, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIView *myNavibar;

@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *slideView;

@end

@implementation FoodDetailViewController

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
    
    //huwahuwa initail
    position1 = [[NSMutableArray alloc]init];
    position2 = [[NSMutableArray alloc]init];
    animat = 0;//不是动画
    
    self.navigationController.navigationBar.hidden = YES;
    
    //交换位置
    int dtag = [[Mydata sharedSingleton].detailImageTag intValue];
    
    //连服务器，获取数据
//    [self initData];
    
//    self.items = [[NSArray alloc]initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg",@"12.jpg",@"13.jpg",@"14.jpg",@"15.jpg",@"16.jpg",@"17.jpg",@"18.jpg",@"19.jpg",@"20.jpg", nil];
    
    self.items = [[NSArray alloc]initWithArray:[Mydata sharedSingleton].imageViewnameArray];
//    self.items = [[NSArray alloc]initWithArray:self.foodViewArray];
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goFood)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.scroller addGestureRecognizer:swipeLeft];
    int inity = 15;
    
    for(int i = 0;i<self.items.count;i++){
        
//        NSDictionary *item = [self.items[i] objectFromJSONString];
//        NSString *imageName1 = [item valueForKey:@"name1"];
//        NSString *imageName2 = [item valueForKey:@"name2"];
//        NSString *imageName3 = [item valueForKey:@"name3"];
        //make detail view
        NSString *imageFileName = [NSString stringWithFormat:@"%@",self.items[i]];
        UIImage *foodImage = [UIImage imageNamed:imageFileName];
        float imageWidth = foodImage.size.width;
        float imageHeight = foodImage.size.height;
        float rate = imageWidth/imageHeight;
        float newHeight = 320.0/rate;
        cellHeight = newHeight;
    
        UIView *detailView = [[UIView alloc]initWithFrame:CGRectMake(0, inity, 320, newHeight)];
        UIScrollView *detailScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, newHeight)];
        
        
        
        //多张
        UIImageView *detailImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, newHeight)];
        detailImageview.image = foodImage;
        
        //likeImageview
        UIImageView *likeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(270, newHeight-50, 40, 40)];
        likeImageView.image = [UIImage imageNamed:@"icon-09"];
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.text = [NSString stringWithFormat:@"%d",i];
        [numLabel setTextAlignment:UITextAlignmentCenter];
        numLabel.textColor = [UIColor whiteColor];
        [likeImageView addSubview:numLabel];
        [detailImageview addSubview:likeImageView];

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

        
        
        //init scroller
        [detailScroll setContentSize:CGSizeMake(960, 0)];
        [detailScroll setAlwaysBounceVertical:NO];
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
            NSString *wentPersonIconFileName = [NSString stringWithFormat:@"_icon_-%d",j+1];
            wentperson.image = [UIImage imageNamed:wentPersonIconFileName];
            wentPersonX = wentPersonX + 40;
            [detailView addSubview:wentperson];
        }
        
        
        
        
        //map
        UIButton *mapButton = [[UIButton alloc]initWithFrame:CGRectMake(270, 5, 45, 45)];
        [mapButton setImage:[UIImage imageNamed:@"icon-01"] forState:UIControlStateNormal];
        [mapButton addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
        [detailView addSubview:mapButton];
        
        inity = inity + cellHeight+15;
        [self.scroller addSubview:detailView];
        
        //huwahuwa initail2
        [position1 addObject:[NSNumber numberWithFloat:detailView.frame.origin.y]];
        float bottom = detailView.frame.origin.y+detailView.frame.size.height;
        [position2 addObject:[NSNumber numberWithFloat:bottom]];
    }
    [self.scroller setContentSize:CGSizeMake(320, inity)];
    
    
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    
    [self.menuButton addTarget:self.navigationController.parentViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.hidden = YES;
    
    
    // If not, allocate one and add it.
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.navigationController.parentViewController action:@selector(revealGesture:)];
    self.navigationBarPanGestureRecognizer = panGestureRecognizer;
    
    //			[self.navigationController.view addGestureRecognizer:self.navigationBarPanGestureRecognizer];
    [self.slideView addGestureRecognizer:self.navigationBarPanGestureRecognizer];
    [self putImage];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void) goFood{
    FoodViewController *fvc = [[FoodViewController alloc]init];
    [UIView beginAnimations:@"Flips" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    
    [self.navigationController pushViewController:fvc animated:YES];
    
    [UIView commitAnimations];
}

-(void) goMap: (id)sender {
    UIButton *button = (UIButton*)sender;
    [Mydata sharedSingleton].mapTag = [[Mydata sharedSingleton].imageViewNumArray objectAtIndex:button.tag];
    
    FoodLocationViewController *flvc = [[FoodLocationViewController alloc]init];
    [self.navigationController pushViewController:flvc animated:YES];
}

-(void)handleSingleFingerEvent:(UIGestureRecognizer *) _recon
{
    if(_recon.numberOfTouches == 2)
    {
        
    }
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
//

-(void) initData{
    NSLog(@"%d",[[Mydata sharedSingleton].imageViewNumArray count]);
    NSString * urlStr = [[NSString alloc]init];
    urlStr = @"?idlist=";
    for(int i = 0;i<[Mydata sharedSingleton].imageViewNumArray.count;i++){
        urlStr = [urlStr stringByAppendingFormat:@"%@,", [[Mydata sharedSingleton].imageViewNumArray objectAtIndex:i]];
    }
    urlStr = [urlStr stringByAppendingFormat:@"&tag=%@",[Mydata sharedSingleton].detailImageTag];
    
    NSString *urlStr1 = [NSString stringWithFormat:@"http://ll.is.tokushima-u.ac.jp/Nepre/GetDetailByID%@",urlStr];
    
    //第一步，创建URL
    NSURL *url = [NSURL URLWithString:urlStr1];
    
    //第二步，通过URL创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    
    //第三步，连接服务器
    self.recieveData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *receiveStr = [[NSString alloc]initWithData:self.recieveData encoding:NSUTF8StringEncoding];
    NSData* jsonData = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *result = [[NSMutableArray alloc]initWithArray:[jsonData objectFromJSONData]];
    self.foodViewArray = [[NSMutableArray alloc]initWithArray:result];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


