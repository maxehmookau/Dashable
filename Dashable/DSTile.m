//
//  DSTile.m
//  Dashable
//
//  This class should be treated as an abstract class and only concrete subclasses
//  of this should be created as a tile.
//
//  Each subclass should have a model e.g. DSNumberTile which conatains
//  the data for that tile and a corresponding UIView subclass which determines the position
//  of elements. Or maybe actually we could have a (UIView *) method here which returns the visual
//  representation of the view...
//
//  Created by Max Woolf on 06/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSTile.h"
#define WIDTH_PX 300
#define HEIGHT_PX 300

@implementation DSTile
@synthesize delegate;

#pragma mark - Initialization
- (id)initWithURL:(NSURL *)aURL
{
    sourceURL = aURL;
    urlConnection = [self initiateConnectionWithRequest: [self connectionRequest]];
    [delegate tile:self didStartConnection:urlConnection];
    
    return [self init];
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
    NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:tempReceivedData options:NSJSONReadingAllowFragments error:nil];
    return [json valueForKeyPath:keyPath];
}

#pragma mark - View Generation
- (UIView *)view
{
    UIView *tile = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_PX, HEIGHT_PX)];
    [tile setBackgroundColor:[UIColor greenColor]];
    return tile;
}
@end
