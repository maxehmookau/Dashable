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
    
    
    DSNumberTile *tempTile = [[DSNumberTile alloc] initWithURL:[NSURL URLWithString:@"http://xkcd.com/info.0.json"] titleText:@"Current Temp" xPosition:0 yPosition:0 keyPath:@"month" imageName:@"sun.png"];
    
    DSNumberTile *tempTile2 = [[DSNumberTile alloc] initWithURL:[NSURL URLWithString:@"http://xkcd.com/102/info.0.json"] titleText:@"LB" xPosition:2 yPosition:0 keyPath:@"month" imageName:@"sun.png"];
    
    DSNumberTile *tempTile3 = [[DSNumberTile alloc] initWithURL:[NSURL URLWithString:@"http://json-time.appspot.com/time.json"] titleText:@"Second" xPosition:3 yPosition:1 keyPath:@"second" imageName:@"sun.png"];
    
    DSNumberTile *tempTile4 = [[DSNumberTile alloc] initWithURL:[NSURL URLWithString:@"http://json-time.appspot.com/time.json"] titleText:@"Minute" xPosition:3 yPosition:2 keyPath:@"minute" imageName:@"sun.png"];
    
    [mainDashboard addTile:tempTile];
    [mainDashboard addTile:tempTile2];
    [mainDashboard addTile:tempTile3];
    [mainDashboard addTile:tempTile4];
    
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
    
}
@end
