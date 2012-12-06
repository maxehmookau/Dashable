//
//  DSNumberTile.m
//  Dashable
//
//  Created by Max Woolf on 06/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSNumberTile.h"
#import "Sunshine.h"
#import <QuartzCore/QuartzCore.h>

@implementation DSNumberTile

- (id)initWithURL:(NSURL *)aURL titleText:(NSString *)aTitle
{
    title = aTitle;
    return [super initWithURL:aURL];
}

- (UIView *)view
{
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [view setBackgroundColor:[UIColor purpleColor]];
    [[view layer]setMasksToBounds:YES];
    [[view layer]setCornerRadius:10.0f];
    Sunshine *sun = [[Sunshine alloc] initWithFrame:CGRectMake(0, 250, 100, 100)];
    [sun setBackgroundColor:[UIColor clearColor]];
    [sun setAlpha:0.6];
    [view addSubview:sun];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, view.bounds.size.width, 130)];
    [numberLabel setText:@"4"];
    [numberLabel setTextAlignment:NSTextAlignmentCenter];
    [numberLabel setTextColor:[UIColor whiteColor]];
    [numberLabel setFont:[UIFont boldSystemFontOfSize:102]];
    [numberLabel setBackgroundColor:[UIColor clearColor]];
    [view addSubview:numberLabel];
    
    [view addSubview:[self titleLabel]];
    
    return view;
}

- (UILabel *)titleLabel
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, 70)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:42]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    return titleLabel;
}

@end
