//
//  PlaceViewController.m
//  Nepre2
//
//  Created by Lsr on 11/23/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "PlaceViewController.h"
#import "TimelineViewController.h"

@interface PlaceViewController ()

@property (retain, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *slideView;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

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
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goTimeline)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self.view addGestureRecognizer:swipeLeft];
    
    [self.scroller setContentSize:CGSizeMake(320, 1000)];
}
-(void)goTimeline {
    TimelineViewController *t = [[TimelineViewController alloc]init];
    [self.navigationController pushViewController:t animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
