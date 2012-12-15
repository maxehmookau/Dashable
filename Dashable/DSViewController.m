//
//  DSViewController.m
//  Dashable
//
//  Created by Max Woolf on 01/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSViewController.h"
#import "DSAppDelegate.h"
#import "DSDashboard.h"
#import "DSNumberTile.h"

@interface DSViewController ()

@end

@implementation DSViewController

-(void)didPressAddButton:(id)sender
{
    addTileVC = [[DSAddTileViewController alloc] init];
    [addTileVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:addTileVC animated:YES completion:^{}];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mainDashboard = [(DSAppDelegate*)[[UIApplication sharedApplication] delegate] dashboard];
    [mainDashboard setDelegate:self];
    
    
    DSNumberTile *tempTile = [[DSNumberTile alloc] initWithURL:[NSURL URLWithString:@"http://xkcd.com/info.0.json"] titleText:@"Year" xPosition:0 yPosition:0 keyPath:@"year" imageName:@"sun.png"];
    

    
    [mainDashboard addTile:tempTile];
    
    DSNumberTile *tempTile2 = [[DSNumberTile alloc] initWithURL:[NSURL URLWithString:@"http://xkcd.com/info.0.json"] titleText:@"Month" xPosition:2 yPosition:0 keyPath:@"month" imageName:@"sun.png"];
    
    
    
    [mainDashboard addTile:tempTile2];
    
    [self.view addSubview:[mainDashboard draw]];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - DSDashboardDelegate
- (void)dashboardReadyToBeRedrawn
{
    NSLog(@"Hello");
    for (UIView *view in [[self view]subviews]) {
        [view removeFromSuperview];
    }
    [self.view addSubview: [mainDashboard draw]];
}
@end
