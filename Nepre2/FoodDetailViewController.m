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

@interface FoodDetailViewController ()


@property (retain, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
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
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.items = [[NSArray alloc]initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg",@"12.jpg",@"13.jpg",@"14.jpg",@"15.jpg",@"16.jpg",@"17.jpg",@"18.jpg",@"19.jpg",@"20.jpg", nil];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goFood)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.scroller addGestureRecognizer:swipeLeft];
    int inity = 15;
    
    for(int i = 0;i<14;i++){
    //make detail view
        NSString *imageFileName = [NSString stringWithFormat:@"f%d.jpg",i+1];
        UIImage *foodImage = [UIImage imageNamed:imageFileName];
        float imageWidth = foodImage.size.width;
        float imageHeight = foodImage.size.height;
        float rate = imageWidth/imageHeight;
        float newHeight = 320.0/rate;
        cellHeight = newHeight;
    
        UIScrollView *detailScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, inity, 320, newHeight)];
        UIImageView *detailImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, newHeight)];
        detailImageview.image = foodImage;
        UIImageView *likeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(270, newHeight-50, 40, 40)];
        likeImageView.image = [UIImage imageNamed:@"icon-09"];
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.text = [NSString stringWithFormat:@"%d",i];
        [numLabel setTextAlignment:UITextAlignmentCenter];
        numLabel.textColor = [UIColor whiteColor];
        [likeImageView addSubview:numLabel];
        [detailImageview addSubview:likeImageView];

        
        //init scroller
        [detailScroll setContentSize:CGSizeMake(640, 0)];
        [detailScroll setAlwaysBounceVertical:NO];
        [detailScroll setBackgroundColor:[UIColor whiteColor]];
        [detailScroll addSubview:detailImageview];
        [detailScroll setBackgroundColor:[UIColor blackColor]];
        [detailScroll setShowsHorizontalScrollIndicator:NO];
        [detailScroll setTag:i];
        [self.scroller addSubview:detailScroll];
        
        //went people
        int wentPersonX = 5;
        float wentY;
        for(int j = 0;j<3;j++){
            wentY = cellHeight-45.0;
            wentY = wentY + (float)inity;
            
            UIImageView *wentperson = [[UIImageView alloc]initWithFrame:CGRectMake(wentPersonX, wentY, 35, 35)];
            NSString *wentPersonIconFileName = [NSString stringWithFormat:@"_icon-0%d",j+1];
            wentperson.image = [UIImage imageNamed:wentPersonIconFileName];
            wentPersonX = wentPersonX + 40;
            [self.scroller addSubview:wentperson];
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
        [self.scroller addSubview:wentNumView];
        
        
        //map
        UIButton *mapButton = [[UIButton alloc]initWithFrame:CGRectMake(270, 5+inity, 45, 45)];
        [mapButton setImage:[UIImage imageNamed:@"icon-01"] forState:UIControlStateNormal];
        [mapButton addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroller addSubview:mapButton];
        
        inity = inity + cellHeight+15;
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
    
    
}


#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count]; // or self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    static NSString *CellIdentifier = @"FoodDetailCell";
    
    FoodDetailCell *cell = [[FoodDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    //input image
    UIImage *imageHolder = [UIImage imageNamed:@"icon-06"];
    NSString *imageFileName = [NSString stringWithFormat:@"f%d.jpg",indexPath.row+1];

    cell.detailImageView.image = [UIImage imageNamed:imageFileName];

    //input mapView
    [cell.mapButton addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchDown];
    if (cell == nil) {
        cell = [[FoodDetailCell alloc]init];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *imageFileName = [NSString stringWithFormat:@"f%d.jpg",indexPath.row+1];
    UIImage *foodImage = [UIImage imageNamed:imageFileName];
    float imageWidth = foodImage.size.width;
    float imageHeight = foodImage.size.height;
    NSLog(@"width = %f, height= %f",imageWidth,imageHeight);
    float rate = imageWidth/imageHeight;
    float newHeight = 320.0/rate;
    NSLog(@"rate=%f   newheight=%f",rate,newHeight);
    cellHeight = newHeight;
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ok");
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
	
	CGPoint offset = aScrollView.contentOffset;
	CGRect bounds = aScrollView.bounds;
	CGSize size = aScrollView.contentSize;
	UIEdgeInsets inset = aScrollView.contentInset;
	float y = offset.y + bounds.size.height - inset.bottom;
	float h = size.height;
//    	 NSLog(@"offset: %f", offset.y);
//    	 NSLog(@"content.height: %f", size.height);
//    	 NSLog(@"bounds.height: %f", bounds.size.height);
//    	 NSLog(@"inset.top: %f", inset.top);
//    	 NSLog(@"inset.bottom: %f", inset.bottom);
//        NSLog(@"pos: %f of %f", y, h);
//        NSLog(@"top: %f",y-aScrollView.frame.size.height);
    float diff = y -currentScrollerY;
//    NSLog(@"%f",diff);
    
    if(y>bounds.size.height && y<aScrollView.contentSize.height){
        if(diff>0) {
            //down
            der = 1;
            if(diff > 7.0){
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView animateWithDuration:0.3 animations:^{
                    [self.myNavibar setFrame:CGRectMake(0, -30, 320, 30)];
                    [self.scroller setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
                } completion:^(BOOL finshed){
                }];
                
            }
        } else {
            //up
            der = 0;
            if(diff < 10.0){
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView animateWithDuration:0.3 animations:^{
                    [self.myNavibar setFrame:CGRectMake(0, 0, 320, 30)];
                    NSLog(@"height %f",self.view.frame.size.height-30);
                    [self.scroller setFrame:CGRectMake(0, 30, 320, 518)];
                } completion:^(BOOL finshed){
                }];
            }
        }
    }
//
//    [self moveBlowImage:y];
//    [self moveAboveImage:y];
    
    currentScrollerY = y;
	
}



-(void) putImage {
//    int sHeight = self.view.frame.size.height;
//    if(self.imageWrap5.frame.origin.y > sHeight){
//        [self.imageWrap5 setFrame:CGRectMake(3, 1000, 320, 140)];
//    }
//    if(self.imageWrap4.frame.origin.y > sHeight){
//        [self.imageWrap4 setFrame:CGRectMake(3, 867, 320, 130)];
//    }
    
}
//
//-(void) moveBlowImage:(float)y{
//    //down
//    
//    if(y > 639 && der == 1){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.imageWrap4 setFrame:CGRectMake(3, 645, 320, 130)];
//        } completion:^(BOOL finshed){
//        }];
//    }
//    if(y > 772 && der == 1){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.imageWrap5 setFrame:CGRectMake(3, 778, 320, 140)];
//        } completion:^(BOOL finshed){
//        }];
//    }
//    //up
//    
//    if(y < 639 && der == 0){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.imageWrap4 setFrame:CGRectMake(3, 867, 320, 130)];
//        } completion:^(BOOL finshed){
//        }];
//    }
//    if(y < 772 && der == 0){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.imageWrap5 setFrame:CGRectMake(3, 1000, 320, 140)];
//        } completion:^(BOOL finshed){
//        }];
//    }
//    
//}
//
//-(void) moveAboveImage:(float)y{
//    float top = y - self.view.frame.size.height;
//    NSLog(@"top %f",top);
//    if(top > 260 && der == 1){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.imageWrap0 setFrame:CGRectMake(3, -137, 320, 260)];
//        } completion:^(BOOL finshed){
//        }];
//    }
//    if(top < 260 && der == 0){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.imageWrap0 setFrame:CGRectMake(3, 3, 320, 260)];
//        } completion:^(BOOL finshed){
//        }];
//    }
//    if(top > 363 && der == 1){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.imageWrap1 setFrame:CGRectMake(3, -37, 320, 100)];
//        } completion:^(BOOL finshed){
//        }];
//    }
//    if(top < 363 && der == 0){
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.imageWrap1 setFrame:CGRectMake(3, 266, 320, 100)];
//        } completion:^(BOOL finshed){
//        }];
//    }
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


