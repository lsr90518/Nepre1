//
//  FoodViewController.m
//  Nepre2
//
//  Created by Lsr on 11/22/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "FoodViewController.h"
#import "MainScrollView.h"
#import "PlaceViewController.h"
#import "FoodDetailViewController.h"
#import "TimelineViewController.h"

@interface FoodViewController ()

@property (retain, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UIView *myNavibar;
@property (weak, nonatomic) IBOutlet UIView *slideView;
@property (weak, nonatomic) IBOutlet UIView *cameraView;

@end

@implementation FoodViewController

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
    
//    self.title =@"foodView";
    
    
//    self.scroller.scrollEnabled = YES;
    
    UIColor *foodColor = [[UIColor alloc]initWithRed:69.0f/255.0f green:3.0f/255.0f blue:7.0f/255.0f alpha:1.0f];
    
    
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
    
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openCamera)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.cameraView addGestureRecognizer:swipeUp];
    
    
    self.navigationController.navigationBar.hidden = YES;
    [self.scrollView setContentSize:CGSizeMake(320, 920)];
    
    //calculate View position
    [self putImage];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    int userWentCount = 8;
    int x = 5;
    for(int i = 0;i < 3;i++){
        NSString *fileName = [NSString stringWithFormat:@"_icon-0%d",i+1];
        UIImage *userIcon = [UIImage imageNamed:fileName];
        UIImageView *userIconView = [[UIImageView alloc]initWithFrame:CGRectMake(x, self.imageButton.frame.size.height-35, 30, 30)];
        x = x+35;
        userIconView.image = userIcon;
        [imageArray addObject:userIconView];
    }
    
    if(userWentCount > 3){
        UILabel *userWentCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, self.imageButton.frame.size.height-35, 30, 30)];
        userWentCountLabel.text = [NSString stringWithFormat:@"+%d",userWentCount];
        userWentCountLabel.backgroundColor = [UIColor colorWithRed:231.0/255.0 green:20.0/255.0 blue:26.0/255.0 alpha:1.0];
        userWentCountLabel.alpha = 0.55;
        userWentCountLabel.textColor = [UIColor whiteColor];
        userWentCountLabel.textAlignment = UITextAlignmentCenter;
        
        [imageArray addObject:userWentCountLabel];
    }
    
    
    
    for(int i = 0;i < imageArray.count;i++){
        [self.imageButton addSubview:imageArray[i]];
    }
    
    //set scroller Y
    currentScrollerY = self.scrollView.frame.size.height;
    
}

- (IBAction)pushButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    NSLog(@"%d",button.tag);
    
    FoodDetailViewController *foodDetailViewController = [[FoodDetailViewController alloc]init];
    [self.navigationController pushViewController:foodDetailViewController animated:YES];
    
}

-(void) goTimeline {
    TimelineViewController *tvc = [[TimelineViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionMoveIn;
//    animation.subtype = kCATransitionFromTop;
    [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    [self.navigationController pushViewController:tvc animated:NO];
}

-(void) goSpot{
    PlaceViewController *p = [[PlaceViewController alloc]init];
    [self.navigationController pushViewController:p animated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void) openCamera{
    //判断是否可以打开相机，模拟器此功能无法使用
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"你没有摄像头" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //图片存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
	
	CGPoint offset = aScrollView.contentOffset;
	CGRect bounds = aScrollView.bounds;
	CGSize size = aScrollView.contentSize;
	UIEdgeInsets inset = aScrollView.contentInset;
	float y = offset.y + bounds.size.height - inset.bottom;
	float h = size.height;
//	 NSLog(@"offset: %f", offset.y);
//	 NSLog(@"content.height: %f", size.height);
//	 NSLog(@"bounds.height: %f", bounds.size.height);
//	 NSLog(@"inset.top: %f", inset.top);
//	 NSLog(@"inset.bottom: %f", inset.bottom);
//    NSLog(@"pos: %f of %f", y, h);
//    NSLog(@"top: %f",y-self.scrollView.frame.size.height);
    float diff = y -currentScrollerY;
    if(y>518 && y<920){
        if(diff>0) {
            //down
            der = 1;
            if(diff > 7.0){
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView animateWithDuration:0.3 animations:^{
                    [self.myNavibar setFrame:CGRectMake(0, -30, 320, 30)];
                    [self.scrollView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
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
                    [self.scrollView setFrame:CGRectMake(0, 30, 320, 518)];
                } completion:^(BOOL finshed){
                }];
            }
        }
    }
    
    [self moveBlowImage:y];
    [self moveAboveImage:y];
        
    currentScrollerY = y;
	
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
//    CGPoint offset = aScrollView.contentOffset;
//	CGRect bounds = aScrollView.bounds;
//	UIEdgeInsets inset = aScrollView.contentInset;
//	float y = offset.y + bounds.size.height - inset.bottom;
//    [self scrollTopTopos:y-518.0];
//    NSLog(@"scrollViewDidEndDecelerating  -   End of Scrolling.");
//}
//// 触摸屏幕并拖拽画面，再松开，最后停止时，触发该函数
//- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate {
//    CGPoint offset = aScrollView.contentOffset;
//	CGRect bounds = aScrollView.bounds;
//	UIEdgeInsets inset = aScrollView.contentInset;
//	float y = offset.y + bounds.size.height - inset.bottom;
//    [self scrollTopTopos:y-518.0];
//    NSLog(@"scrollViewDidEndDragging  -  End of Scrolling.");
//}



-(void) putImage {
    int sHeight = self.view.frame.size.height;
    if(self.imageWrap5.frame.origin.y > sHeight){
        [self.imageWrap5 setFrame:CGRectMake(3, 1000, 320, 140)];
    }
    if(self.imageWrap4.frame.origin.y > sHeight){
        [self.imageWrap4 setFrame:CGRectMake(3, 867, 320, 130)];
    }

}

-(void) moveBlowImage:(float)y{
    //down

    if(y > 639 && der == 1){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageWrap4 setFrame:CGRectMake(3, 645, 320, 130)];
        } completion:^(BOOL finshed){
        }];
    }
    if(y > 772 && der == 1){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageWrap5 setFrame:CGRectMake(3, 778, 320, 140)];
        } completion:^(BOOL finshed){
        }];
    }
    //up

    if(y < 639 && der == 0){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageWrap4 setFrame:CGRectMake(3, 867, 320, 130)];
        } completion:^(BOOL finshed){
        }];
    }
    if(y < 772 && der == 0){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageWrap5 setFrame:CGRectMake(3, 1000, 320, 140)];
        } completion:^(BOOL finshed){
        }];
    }

}

-(void) moveAboveImage:(float)y{
    float top = y - self.view.frame.size.height;
    NSLog(@"top %f",top);
    if(top > 260 && der == 1){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageWrap0 setFrame:CGRectMake(3, -137, 320, 260)];
        } completion:^(BOOL finshed){
        }];
    }
    if(top < 260 && der == 0){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageWrap0 setFrame:CGRectMake(3, 3, 320, 260)];
        } completion:^(BOOL finshed){
        }];
    }
    if(top > 363 && der == 1){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageWrap1 setFrame:CGRectMake(3, -37, 320, 100)];
        } completion:^(BOOL finshed){
        }];
    }
    if(top < 363 && der == 0){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.3 animations:^{
            [self.imageWrap1 setFrame:CGRectMake(3, 266, 320, 100)];
        } completion:^(BOOL finshed){
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
