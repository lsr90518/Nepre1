//
//  FollowViewController.m
//  Nepre2
//
//  Created by Lsr on 11/26/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "FollowViewController.h"
#import "ProfileViewController.h"
#import "FavoriteViewController.h"
#import "FollowCell.h"
#import <QuartzCore/QuartzCore.h>

@interface FollowViewController ()

@property (weak, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIView *slideView;

@end

@implementation FollowViewController

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
    
    self.navigationController.navigationBar.hidden = YES;
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
    if(tableView.tag == 0){
        return 8;
    } else {
        return 8;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FollowCell";
    
    FollowCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
    
    cell = (FollowCell*)[nibArray objectAtIndex:0];

    cell.followButton.tag = indexPath.row;
    
        if (cell == nil) {
        cell = [[FollowCell alloc]init];

    }
    
    
    return cell;
}

//select
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d       %d",tableView.tag,indexPath.row);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIColor *FollowColor = [UIColor colorWithRed:32.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
    UIColor *FollowerColor = [UIColor colorWithRed:49.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (tableView.tag == 0) {
        cell.backgroundColor = FollowColor;
    }
    else {
        cell.backgroundColor = FollowerColor;
    }
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}


- (IBAction)goProfile:(id)sender {
    ProfileViewController *p = [[ProfileViewController alloc]init];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionReveal;
    //    animation.subtype = kCATransitionFromTop;
    [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    
    [self.navigationController pushViewController:p animated:YES];
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
