//
//  InsetsLabel.h
//  cdzer
//
//  Created by KEns0n on 3/20/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsetsLabel : UILabel

@property(nonatomic) UIEdgeInsets edgeInsets;

@property (nonatomic) BOOL strikeThroughEnabled;

-(id) initWithFrame:(CGRect)frame andEdgeInsetsValue:(UIEdgeInsets)insets;

-(id) initWithInsets:(UIEdgeInsets)insets;

@end
