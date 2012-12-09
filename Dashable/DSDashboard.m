//
//  DSDashboard.m
//  Dashable
//
//  Created by Max Woolf on 09/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSDashboard.h"
#import "DSNumberTile.h"

@implementation DSDashboard
@synthesize  delegate;
- (id)init
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    CGFloat screenWidth = screenRect.size.width;
    dashboardView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    tiles = [[NSMutableArray alloc] init];
    return [super init];
}

- (void)addTile:(DSTile *)tile
{
    //[tile setDelegate:self];
    [tiles addObject:tile];
    [self draw];
}

- (UIView *)draw
{
    //Redraw
    for (id tile in tiles) {
        [dashboardView addSubview:[tile view]];
    }
    return dashboardView;
}


@end
