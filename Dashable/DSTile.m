//
//  DSTile.m
//  Dashable
//
//  This class should be treated as an abstract class and only concrete subclasses
//  of this should be created as a tile.
//
//  The concrete subclass should implement the method -(UIView *)view; to display
//  the data required.
//
//  Created by Max Woolf on 06/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSTile.h"
#import "DSDashboard.h"
#import "DSAppDelegate.h"
#define WIDTH_PX 300
#define HEIGHT_PX 300

@implementation DSTile
@synthesize delegate, firstRun;

#pragma mark - Initialization

// Do not call this method directly. Call via class hierarchy on subclasses.
// Make sure to override view method.
- (id)initWithURL:(NSURL *)aURL
{
    firstRun = YES;
    sourceURL = aURL;
    urlConnection = [self initiateConnectionWithRequest: [self connectionRequest]];
    
    [delegate tile:self didStartConnection:urlConnection];
    NSTimer *timer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return [super init];
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
    urlConnection = [self initiateConnectionWithRequest: [self connectionRequest]];
    [delegate tile:self didStartConnection:urlConnection];
}

- (NSURLRequest *)connectionRequest
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:sourceURL];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:120];
    return request;
}

- (NSURLConnection *)initiateConnectionWithRequest:(NSURLRequest *)aRequest
{
    return [[NSURLConnection alloc] initWithRequest:aRequest delegate:self startImmediately:YES];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    tempReceivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [tempReceivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [delegate tile:self didFinishConnection:connection withValue:[self tileValue]];
}

#pragma mark - JSON Processing
-(NSString *)tileValue
{
    if ([tempReceivedData isKindOfClass:[NSMutableData class]]) {
       return [[NSString alloc] initWithFormat:@"%@", [[NSJSONSerialization JSONObjectWithData:tempReceivedData options:NSJSONReadingAllowFragments error:nil]valueForKeyPath:keyPath]];
    }else{
        return @"";
    }
}

#pragma mark - Class Methods
+ (float)tileSize
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    return screenHeight/4;
}


#pragma mark - Generate Dashboard Position
- (float)xPosition
{
    return [DSTile tileSize]*xPosition;
}

- (float)yPosition
{
    return [DSTile tileSize]*yPosition;
}

#pragma mark - Settings
- (UIView *)drawTile:(UIView *)sender shouldDrawSettingsIcons:(BOOL)shouldDrawSettingsIcons
{
    if (shouldDrawSettingsIcons) {
        UIView *settingsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sender.frame.size.width,  44)];
        [settingsView setBackgroundColor:[UIColor clearColor]];
        
        UIButton *settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [settingsButton setImage:[UIImage imageNamed:@"21-wrench.png"] forState:UIControlStateNormal];
        [settingsButton setBackgroundColor:[UIColor clearColor]];
        [settingsButton addTarget:self action:@selector(didPressSettingsButton) forControlEvents:UIControlEventTouchUpInside];
        [settingsView addSubview:settingsButton];
        
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 0, 44, 44)];
        [deleteButton setImage:[UIImage imageNamed:@"433-x.png"] forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:[UIColor clearColor]];
        [deleteButton addTarget:self action:@selector(didPressDeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [settingsView addSubview:deleteButton];
        
        [sender addSubview:settingsView];
    }
    
    return sender;
}

- (void) didPressDeleteButton
{
    NSLog(@"Delete - %@", [self description]);
    DSDashboard *mainDashboard = [(DSAppDelegate*)[[UIApplication sharedApplication] delegate] dashboard];
    [mainDashboard removeTile:self];
}

- (void) didPressSettingsButton
{
    NSLog(@"Settings");
}

@end
