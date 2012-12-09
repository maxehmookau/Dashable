//
//  DSNumberTile.m
//  Dashable
//
//  Created by Max Woolf on 06/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSNumberTile.h"
#import "Sun.h"
#import <QuartzCore/QuartzCore.h>

@implementation DSNumberTile

- (id)initWithURL:(NSURL *)aURL titleText:(NSString *)aTitle
{
    title = aTitle;
    return [super initWithURL:aURL];
}

- (UIView *)view
{
    //Initialize view
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [view setBackgroundColor:[UIColor purpleColor]];
    [[view layer]setMasksToBounds:YES];
    [[view layer]setCornerRadius:3.0f];

    //Add subviews
    [view addSubview:[self backgroundView]];
    [view addSubview:[self numberLabel]];
    [view addSubview:[self titleLabel]];
    
    return view;
}

- (UILabel *)titleLabel
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 70)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"Open Sans" size:36]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    return titleLabel;
}

-(UIView *)numberLabel
{
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, view.bounds.size.width, 130)];
    [numberLabel setText:@"4"];
    [numberLabel setTextAlignment:NSTextAlignmentCenter];
    [numberLabel setTextColor:[UIColor whiteColor]];
    [numberLabel setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:108]];
    [numberLabel setBackgroundColor:[UIColor clearColor]];
    return numberLabel;
}

-(UIView *)backgroundView
{
    Sun *sun = [[Sun alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
    [sun setBackgroundColor:[UIColor greenColor]];
    [sun setAlpha:0.6];
}

@end
