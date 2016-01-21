//
//  InsetsLabel.m
//  cdzer
//
//  Created by KEns0n on 3/20/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//


#import "InsetsLabel.h"

@implementation InsetsLabel


- (id)initWithFrame:(CGRect)frame andEdgeInsetsValue:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.edgeInsets = insets;
    }
    return self;
}

- (id)initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.edgeInsets = insets;
    }
    return self;
}

- (void)setEdgeInsets:(UIEdgeInsets)insets {
    _edgeInsets = UIEdgeInsetsZero;
    _edgeInsets = insets;
//    [self setNeedsLayout];
}

- (void)drawTextInRect:(CGRect)rect {
    
    CGRect newRect = UIEdgeInsetsInsetRect(rect, self.edgeInsets);
    
    [super drawTextInRect:newRect];
    CGSize textSize ;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        textSize = [[self text] sizeWithAttributes:@{NSFontAttributeName:[self font]}];
        
    }else {
#pragma clang diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        textSize = [[self text] sizeWithFont:[self font]];
#pragma clang diagnostic pop
        
    }
    CGFloat strikeWidth = textSize.width;
    CGRect lineRect;
    
    if ([self textAlignment] == NSTextAlignmentRight) {
        lineRect = CGRectMake(rect.size.width - strikeWidth, rect.size.height/2, strikeWidth, 1);
    } else if ([self textAlignment] == NSTextAlignmentCenter) {
        lineRect = CGRectMake(rect.size.width/2 - strikeWidth/2, rect.size.height/2, strikeWidth, 1);
    } else {
        lineRect = CGRectMake(0, rect.size.height/2, strikeWidth, 1);
    }
    
    if (_strikeThroughEnabled) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextFillRect(context, lineRect);
    }
}
@end
