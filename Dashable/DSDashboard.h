//
//  DSDashboard.h
//  Dashable
//
//  Created by Max Woolf on 09/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSTile.h"
#import "DSNumberTile.h"
@class DSDashboard;

@protocol DSDashboardDelegate <NSObject>

- (void)dashboardReadyToBeRedrawn;

@end
@interface DSDashboard : NSObject
{
    NSMutableArray *tiles;
    id delegate;
    UIView *dashboardView;
}

- (id)init;
- (void)addTile:(DSTile *)tile;
- (UIView *)draw;

@property (nonatomic) id delegate;
@end
