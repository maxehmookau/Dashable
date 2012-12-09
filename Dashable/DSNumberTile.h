//
//  DSNumberTile.h
//  Dashable
//
//  Created by Max Woolf on 06/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSTile.h"

@interface DSNumberTile : DSTile
{
    NSString *title;
    UIView *view;
}

- (id)initWithURL:(NSURL *)aURL titleText:(NSString *)aTitle xPosition:(int)x yPosition:(int)y;
- (UILabel *)titleLabel;
- (UIView *)view;
- (UIView *)numberLabel;
- (UIView *)backgroundView;
@end
