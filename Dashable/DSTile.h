//
//  DSTile.h
//  Dashable
//
//  Created by Max Woolf on 06/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DSTile;

@protocol DSTileDelegate <NSObject>

- (void)tile:(DSTile *)aTile didStartConnection:(NSURLConnection *)aConnection;
- (void)tile:(DSTile *)aTile didFinishConnection:(NSURLConnection *)aConnection withValue:(NSString *)currentValue;
- (void)tile:(DSTile *)didFailWithError:(NSError *)error;

@end

@interface DSTile : NSObject <NSURLConnectionDataDelegate, UIGestureRecognizerDelegate>
{
    NSURL *sourceURL;
    
    // A keypath value to the desired value
    //   Example:
    //     person.name.first => Max
    NSString *keyPath;
    
    // Background color
    UIColor *backgroundColor;
    
    // Relative coordinates of tile on grid.
    int xPosition;
    int yPosition;
    
    NSURLConnection *urlConnection;
    
    id delegate;
    
    NSMutableData *tempReceivedData;
    
    NSString *rawData;
    
    BOOL firstRun;
}

- (id)initWithURL:(NSURL *)aURL;
- (NSURLConnection *)initiateConnectionWithRequest:(NSURLRequest *)aRequest;
- (NSURLRequest *)connectionRequest;
- (NSString *)tileValue;
- (float)xPosition;
- (float)yPosition;

+ (float)tileSize;

- (UIView *)drawTile:(UIView *)sender shouldDrawSettingsIcons:(BOOL)shouldDrawSettingsIcons;

@property (nonatomic) id delegate;
@property (nonatomic) BOOL firstRun;
@end
