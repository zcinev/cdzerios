//
//  AnimationHandler.m
//  cdzer
//
//  Created by KEns0n on 3/16/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "AnimationHandler.h"

@implementation AnimationHandler

+ (void)makeBarChartAnimationWithView:(UIView *)view totalCount:(CGFloat)totalCount currentCount:(CGFloat)currentCount {
    CGFloat scaleRatio = 1.0f;
    CGFloat ratio = currentCount/totalCount;
    CGRect rect = view.bounds;
    rect.size.width = CGRectGetWidth(rect)*ratio*scaleRatio;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0.0f, CGRectGetHeight(rect)/2.0f);
    CGPathAddLineToPoint(path, nil, CGRectGetWidth(rect), CGRectGetHeight(rect)/2.0f);
    CGPathCloseSubpath(path);
    
    
    CAShapeLayer *lineChart = [CAShapeLayer layer];
    lineChart.path = path;
    lineChart.fillColor = [UIColor clearColor].CGColor;
    lineChart.strokeColor = CDZColorOfDefaultColor.CGColor;
    lineChart.lineWidth = CGRectGetHeight(rect);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.5f;
    animation.removedOnCompletion = NO;
    animation.autoreverses = NO;
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [lineChart addAnimation:animation forKey:@"drawChartAnimation"];
    
    [view.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [view.layer addSublayer:lineChart];
}
@end
