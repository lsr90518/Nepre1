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

@property (weak, nonatomic) IBOutlet UITableView *ImageTable;
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
    
    [self.ImageTable addGestureRecognizer:swipeLeft];
    
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
//    NSLog(@"%d",indexPath.row);
    static NSString *CellIdentifier = @"FoodDetailCell";
    
    FoodDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
    
    cell = (FoodDetailCell*)[nibArray objectAtIndex:0];
    
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
    UIImage *imageHolder = [UIImage imageNamed:self.items[indexPath.row]];
    NSLog(@"%d",indexPath.row);
    return 406;
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
    NSLog(@"inininin");
    if(_recon.numberOfTouches == 2)
    {
        NSLog(@"double click");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
