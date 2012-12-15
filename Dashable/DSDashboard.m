//
//  DSDashboard.m
//  Dashable
//
//  Created by Max Woolf on 09/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSDashboard.h"
#import "DSNumberTile.h"
#import "DSAddTileViewController.h"
#import "DSViewController.h"

@implementation DSDashboard
@synthesize  delegate, tiles;
- (id)init
{
    
    
    tiles = [[NSMutableArray alloc] init];
    return [super init];
}

- (void)addTile:(DSTile *)tile
{
    //[tile setDelegate:self];
    [tiles addObject:tile];
    [self draw];
}

- (void)removeTile:(DSTile *)tile
{
    [tiles removeObject:tile];
    [delegate dashboardReadyToBeRedrawn];
}

- (UIView *)draw
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    dashboardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5000, screenHeight)];
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture)];
    [swipeGesture setNumberOfTouchesRequired:3];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [dashboardView addGestureRecognizer:swipeGesture];
    //Redraw
    for (id tile in tiles) {
        [dashboardView addSubview:[tile view]];
    }
    return dashboardView;
}


-(void)handleGesture
{
    [(DSViewController *)delegate didPressAddButton:self];
}
@end
