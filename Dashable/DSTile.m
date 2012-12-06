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
    
    return [super init];
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
@end
