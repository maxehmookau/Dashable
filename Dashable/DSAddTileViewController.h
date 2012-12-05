//
//  DSAddTileViewController.h
//  Dashable
//
//  Created by Max Woolf on 04/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSAddTileViewController : UIViewController
{
    IBOutlet UITextField *urlField;
    IBOutlet UISegmentedControl *methodSegment;
    IBOutlet UISegmentedControl *authSegment;
}

- (IBAction)didPressCancelButton:(id)sender;
- (IBAction)didPressSaveButton:(id)sender;
- (IBAction)didSelectDifferentHTTPMethod:(id)sender;
- (IBAction)didSelectDifferentAuthType:(id)sender;
@end
