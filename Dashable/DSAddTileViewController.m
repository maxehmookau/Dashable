//
//  DSAddTileViewController.m
//  Dashable
//
//  Created by Max Woolf on 04/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSAddTileViewController.h"

@interface DSAddTileViewController ()

@end

@implementation DSAddTileViewController

#pragma mark - Save/Cancel Button Actions
- (void)didPressCancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didPressSaveButton:(id)sender
{
    //Perform validation
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Not yet implemented" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

#pragma mark - UI Controls
- (void)didSelectDifferentAuthType:(id)sender
{
    if ([sender selectedSegmentIndex] == 0) {
        [authUserField setHidden:YES];
        [authPassField setHidden:YES];
    }else if([sender selectedSegmentIndex] == 1)
    {
        [authUserField setHidden:NO];
        [authPassField setHidden:NO];
    }
}

#pragma mark - Colour Wheel
-(void)addColorWheelToView
{
    backgroundColorWheel = [[ISColorWheel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    backgroundColorWheel.center = colorPickerContainer.center;
    [backgroundColorWheel setDelegate:self];
    [colorPickerContainer addSubview:backgroundColorWheel];
    [backgroundColorWheel setUserInteractionEnabled:NO];
    [backgroundColorWheel setAlpha:0.2];
}

-(void)colorWheelDidChangeColor:(ISColorWheel *)colorWheel
{
    [colorPickerContainer setBackgroundColor:[colorWheel currentColor]];
}

#pragma mark - Pass to Model
- (void)didPressNextButton:(id)sender
{
    //Perform validation (controller)
    if(![self URLIsValid:[urlField text]])
    {
        UIAlertView *noURLAlert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You need to enter a valid URL" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [noURLAlert show];
    }else{
    
        //Create a tile object
        
        //Fetch JSON feed
        
        //Process and display in table view
        
        [requestContainer setAlpha:0.2];
    }
}

-(BOOL)URLIsValid:(NSString *)aURL
{
    if([aURL hasPrefix:@"http://"] || [aURL hasPrefix:@"https://"])
    {
        return YES;
    }
    return NO;
}

#pragma mark - View Lifecycle
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
    [self setModalPresentationStyle:UIModalPresentationFullScreen];
    [self addColorWheelToView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
