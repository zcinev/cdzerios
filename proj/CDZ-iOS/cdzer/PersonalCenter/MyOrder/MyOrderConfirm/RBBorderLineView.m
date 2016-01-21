//
//  RBBorderLineView.m
//  test
//
//  Created by KEns0n on 4/9/15.
//  Copyright (c) 2015 CDZer. All rights reserved.
//

#import "RBBorderLineView.h"

@implementation RBBorderLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGFloat kDashedBorderWidth     = vAdjustByScreenRatio(5.0f);
    CGFloat kDashedPhase           = vAdjustByScreenRatio(0.0f);
    CGFloat kDashedLinesLength[]   = {vAdjustByScreenRatio(7.0f), vAdjustByScreenRatio(21.0f)};
    size_t kDashedCount            = vAdjustByScreenRatio(2.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    ////////////
    ////////////
    CGContextSaveGState(context);
    ////////////
    ////////////
    CGContextSetLineWidth(context, kDashedBorderWidth);
    CGContextSetStrokeColorWithColor(context, CDZColorOfRed.CGColor);
    CGContextSetLineDash(context, kDashedPhase, kDashedLinesLength, kDashedCount) ;
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
    ////////////
    ////////////
    CGContextRestoreGState(context);
    ////////////
    ////////////
    CGContextSetLineWidth(context, kDashedBorderWidth);
    CGContextSetStrokeColorWithColor(context, CDZColorOfDefaultColor.CGColor);
    CGContextSetLineDash(context, vAdjustByScreenRatio(14.0f), kDashedLinesLength, kDashedCount) ;
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
    ////////////
    ////////////
    CGContextSaveGState(context);
    ////////////
    ////////////
    
    CGFloat offsetX = vAdjustByScreenRatio(20.0f);
    CGFloat offsetY = vAdjustByScreenRatio(30.0f);
    CGContextSetLineWidth(context, vAdjustByScreenRatio(1.0f));
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGFloat kLinesLength[]   = {vAdjustByScreenRatio(3.0f), vAdjustByScreenRatio(3.0f)};
    CGContextSetLineDash(context, 0.0f, kLinesLength, kDashedCount) ;
    CGContextMoveToPoint(context, offsetX, offsetY);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect)-offsetX, offsetY);
    CGContextStrokePath(context);
    
    ////////////
    ////////////
    CGContextRestoreGState(context);
    ////////////
    ////////////
}



@end
