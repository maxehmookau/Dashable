//
//  DSNumberTile.h
//  Dashable
//
//  Created by Max Woolf on 06/12/2012.
//  Copyright (c) 2012 Max Woolf. All rights reserved.
//

#import "DSTile.h"

@interface DSNumberTile : DSTile <DSTileDelegate>
{
    NSString *title;
    UIView *view;
    UILabel *numberLabelView;
    NSString *imageName;
}

- (id)initWithURL:(NSURL *)aURL titleText:(NSString *)aTitle xPosition:(int)x yPosition:(int)y keyPath:(NSString *)aKeyPath imageName:(NSString *)aName;
- (UILabel *)titleLabel;
- (UIView *)view;
- (UIView *)backgroundView;

@property (nonatomic) UILabel *numberLabelView;
@end
