//
//  DSViewController.m
//  Dashable
//
//  Created by Max Woolf on 01/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSViewController.h"
#import "DSTile.h"

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
    DSTile *tempTile = [[DSTile alloc] init];
    [self.view addSubview:[tempTile view]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
