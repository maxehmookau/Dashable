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


@implementation DSTile
@synthesize delegate;

- (id)initWithURL:(NSURL *)aURL
{
    sourceURL = aURL;
    connection = [self initiateConnectionWithRequest: [self connectionRequest]];
    [delegate tile:self didStartConnection:connection];
    
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

@end
