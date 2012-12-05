//
//  DSAddTileViewController.h
//  Dashable
//
//  Created by Max Woolf on 04/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISColorWheel.h"

@interface DSAddTileViewController : UIViewController <ISColorWheelDelegate>
{
    IBOutlet UITextField *urlField;
    IBOutlet UISegmentedControl *methodSegment;

    IBOutlet UISegmentedControl *authSegment;
    IBOutlet UITextField *authUserField;
    IBOutlet UITextField *authPassField;
    
    IBOutlet UIView *colorPickerContainer;
    IBOutlet UIView *requestContainer;
    
    ISColorWheel *backgroundColorWheel;
}

- (IBAction)didPressCancelButton:(id)sender;
- (IBAction)didPressSaveButton:(id)sender;
- (IBAction)didSelectDifferentHTTPMethod:(id)sender;
- (IBAction)didSelectDifferentAuthType:(id)sender;
- (IBAction)didPressNextButton:(id)sender;
- (void)addColorWheelToView;
- (BOOL)URLIsValid:(NSString *)aURL;
@end
