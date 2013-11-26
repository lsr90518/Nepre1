//
//  FoodDetailViewController.m
//  Nepre2
//
//  Created by Lsr on 11/25/13.
//  Copyright (c) 2013 Lsr. All rights reserved.
//

#import "FoodDetailViewController.h"

@interface FoodDetailViewController ()


@property (retain, nonatomic) UIPanGestureRecognizer *navigationBarPanGestureRecognizer;

@property (weak, nonatomic) IBOutlet UITableView *ImageTable;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

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
			
			[self.navigationController.view addGestureRecognizer:self.navigationBarPanGestureRecognizer];
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

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count]; // or self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.row);
    UIImage *imageHolder = [UIImage imageNamed:self.items[indexPath.row]];
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, 314, 400)];
    imageview.image = imageHolder;
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil) cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, 320, 406)];
    NSLog(@"%f",imageview.frame.size.height);
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    [cell.contentView addSubview:imageview];
    
    // Step 3: Set the cell text
//    cell.textLabel.text = [items objectAtIndex:indexPath.row];
    
    // Step 4: Return the cell
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *imageHolder = [UIImage imageNamed:self.items[indexPath.row]];
    
    return 406;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
