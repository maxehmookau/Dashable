//
//  DSNumberTile.m
//  Dashable
//
//  Created by Max Woolf on 06/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSNumberTile.h"
#import <QuartzCore/QuartzCore.h>

@implementation DSNumberTile
@synthesize numberLabelView;

- (id)initWithURL:(NSURL *)aURL titleText:(NSString *)aTitle xPosition:(int)x yPosition:(int)y keyPath:(NSString *)aKeyPath imageName:(NSString *)aName
{
    title = aTitle;
    xPosition = x;
    yPosition = y;
    keyPath = aKeyPath;
    imageName = aName;
    view = [[UIView alloc] initWithFrame:CGRectMake([self xPosition], [self yPosition], [DSTile tileSize], [DSTile tileSize])];
    
    [[view layer]setMasksToBounds:YES];
    [[view layer]setCornerRadius:3.0f];
    [self setDelegate:self];
    return [super initWithURL:aURL];
}

-(void)tile:(DSTile *)aTile didStartConnection:(NSURLConnection *)aConnection
{
    
}

-(void)tile:(DSTile *)aTile didFinishConnection:(NSURLConnection *)aConnection withValue:(NSString *)currentValue
{
    [numberLabelView setText:currentValue];
    NSLog(@"%@", currentValue);
}

- (UIView *)view
{   
    
    //Initialize view
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    [view setBackgroundColor:color];
    
    //Add subviews
    [view addSubview:[self backgroundView]];
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, view.bounds.size.height/2-(130/2), view.bounds.size.width, 130)];
    [numberLabel setText:[self tileValue]];
    [numberLabel setTextAlignment:NSTextAlignmentCenter];
    [numberLabel setTextColor:[UIColor whiteColor]];
    [numberLabel setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:108]];
    [numberLabel setBackgroundColor:[UIColor clearColor]];
    [view addSubview:numberLabel];
    numberLabelView = numberLabel;
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


-(UIView *)backgroundView
{
    UIImageView *sun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [sun setFrame:CGRectMake(20, 20, view.bounds.size.width-40, view.bounds.size.height-40)];
    [sun setAlpha:0.1];
    return sun;
}

@end
