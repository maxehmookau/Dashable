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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
