//
//  DSViewController.h
//  Dashable
//
//  Created by Max Woolf on 01/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSAddTileViewController.h"
#import "DSDashboard.h"

@interface DSViewController : UIViewController <DSDashboardDelegate>
{
    DSAddTileViewController *addTileVC;
    DSDashboard *mainDashboard;
}

- (IBAction)didPressAddButton:(id)sender;
@end
