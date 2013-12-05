//
//  PlaceViewController.m
//  Nepre2
//
//  Created by Lsr on 11/23/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "FoodViewController.h"
#import "MainScrollView.h"
#import "PlaceViewController.h"
#import "SpotDetailViewController.h"
#import "FoodDetailViewController.h"
#import "TimelineViewController.h"
#import "AppDelegate.h"
#import "Mydata.h"
#import "ProfileViewController.h"

@interface PlaceViewController ()

@property (weak, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *slideView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIView *cameraView;

@property (weak, nonatomic) IBOutlet UIView *myNavibar;
@property (weak, nonatomic) UIActivityIndicatorView *spinner;
@property (weak, nonatomic) UILabel *sorryLabel;

@end

@implementation PlaceViewController

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
    refreshFlag = 0;
    
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
            wentNumLabel.text = @"+8";
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
    
}


- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    //    self.title =@"foodView";
    
    
    //    self.scroller.scrollEnabled = YES;
    //设置旋转标识
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.spinner setFrame:CGRectMake(120, 45, 10, 10)]; // I do this because I'm in landscape mode
    self.sorryLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 35, 320, 30)];
    self.sorryLabel.backgroundColor = [UIColor blackColor];
    self.sorryLabel.text = @"Sorry...";
    self.sorryLabel.textColor = [UIColor whiteColor];
    self.sorryLabel.textAlignment = UITextAlignmentCenter;
    [self.sorryLabel setHidden:YES];
    [self.view addSubview:self.sorryLabel];
    [self.view addSubview:self.spinner];
    
    
    
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
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goTimeline)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goFood)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    
    
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(openCamera)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.cameraView addGestureRecognizer:swipeUp];
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    //calculate View position
    [self putImage];
    
    
}

- (IBAction)pushButton:(id)sender {
    UIButton *button = (UIButton *)sender;
    [Mydata sharedSingleton].detailImageTag = [NSString stringWithFormat:@"%d",button.tag];
    
    SpotDetailViewController *foodDetailViewController = [[SpotDetailViewController alloc]init];
    [self.navigationController pushViewController:foodDetailViewController animated:YES];
    
}

-(void)goTimeline {
    TimelineViewController *t = [[TimelineViewController alloc]init];
    [self.navigationController pushViewController:t animated:YES];
}

-(void) goFood {
    FoodViewController *tvc = [[FoodViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionMoveIn;
    //    animation.subtype = kCATransitionFromTop;
    [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    [self.navigationController pushViewController:tvc animated:NO];
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
        
        
        currentScrollerY = y;
	}
}


-(void) scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate{
    
    CGRect bounds = aScrollView.bounds;
    CGPoint offset = aScrollView.contentOffset;
	CGSize size = aScrollView.contentSize;
	UIEdgeInsets inset = aScrollView.contentInset;
	float y = offset.y + bounds.size.height - inset.bottom;
    refreshFlag = 1;
    float refreshLine = bounds.size.height - 60;
    if(y < refreshLine){
        [self.spinner startAnimating];
        [self.sorryLabel setHidden:NO];
        [UIView animateWithDuration:0.3 animations:^{
            [aScrollView setFrame:CGRectMake(0, 70, 320, self.scroller.frame.size.height)];
        } completion:^(BOOL finshed){
            [UIView animateWithDuration:0.5 animations:^{
                [self refreshView];
                [self.spinner stopAnimating];
                [self.sorryLabel setHidden:YES];
                
            } completion:^(BOOL finshed){
                [UIView animateWithDuration:0.3 animations:^{
                    [aScrollView setFrame:CGRectMake(0, 30, 320, self.scroller.frame.size.height)];
                } completion:^(BOOL finshed){
                    refreshFlag = 0;
                }];
            }];
        }];
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

-(void)refreshView{
    
    for(int i = 0 ;i<[[Mydata sharedSingleton].foodViewArray count];i++){
        UIView *removeView = (UIView*)[self.scroller viewWithTag:100+i];
        [removeView removeFromSuperview];
    }
    
    [[Mydata sharedSingleton].foodViewArray removeAllObjects];
    [self initDataArray];
    
    [position1 removeAllObjects];
    [position2 removeAllObjects];
    animat = 0;//不是动画
    
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
                    UIImageView *wentperson = [[UIImageView alloc]initWithFrame:CGRectMake(wentPersonX, wentY, 35, 35)];
                    
                    NSString *wentPersonIconFileName = [NSString stringWithFormat:@"_icon_-%d",randomNum[j]];
                    wentperson.image = [UIImage imageNamed:wentPersonIconFileName];
                    wentPersonX = wentPersonX + 40;
                    [homeImageView addSubview:wentperson];
                }
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
}

-(void) goProfile:(id)sender{
    UIButton *button = (UIButton*)sender;
    NSLog(@"%d    %@",button.tag,[[Mydata sharedSingleton].userList objectAtIndex:button.tag]);
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
