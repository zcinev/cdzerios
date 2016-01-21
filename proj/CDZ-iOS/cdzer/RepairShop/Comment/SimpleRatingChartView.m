//
//  SimpleRatingChartView.m
//  cdzer
//
//  Created by KEns0n on 3/14/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight vAdjustByScreenRatio(110.0f)
#define vMinWidth vAdjustByScreenRatio(170.0f)

#import "SimpleRatingChartView.h"
#import "AnimationHandler.h"

@implementation SimpleRatingChartView


- (void)initializationUIWithData:(NSArray *)arrayData {
    
    CGFloat startPositionY = vAdjustByScreenRatio(5.0f);
    for (int i = 0; i < [arrayData count]; i++) {
        
        NSDictionary *dictionary = [arrayData objectAtIndex:i];
        NSString *currentStarName = [dictionary objectForKey:@"ratingName"];
        CGFloat arg2TotalCount = [[dictionary objectForKey:@"totalRating"] floatValue];
        CGFloat arg3CurrentCount = [[dictionary objectForKey:@"numberOfRating"] floatValue];
        
        CGRect labelRect = CGRectZero;
        CGSize labelSize = CGSizeMake(vAdjustByScreenRatio(40.0f), vAdjustByScreenRatio(16.0f));
        labelRect.size = labelSize;
        labelRect.origin.y = startPositionY+(labelSize.height+startPositionY)*i;
        UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor colorWithRed:0.349f green:0.341f blue:0.345f alpha:1.00f]];
        [label setText:[NSString stringWithFormat:getLocalizationString(@"star_with_integer"),currentStarName]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)]];
        [self addSubview:label];
        
        
        CGRect chartRect = CGRectZero;
        chartRect.origin.x = CGRectGetMaxX(labelRect);
        chartRect.size = CGSizeMake(CGRectGetWidth(self.frame)-CGRectGetMaxX(labelRect), labelSize.height);
        chartRect.origin.y = CGRectGetMinY(labelRect);
        UIView *chartView = [[UIView alloc] initWithFrame:chartRect];
        [self addSubview:chartView];
        
        SEL theSelector = @selector(makeBarChartAnimationWithView:totalCount:currentCount:);
        NSMethodSignature* signature1 = [[AnimationHandler class] methodSignatureForSelector:theSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature1];
        [invocation setTarget:[AnimationHandler class]];
        [invocation setSelector:theSelector];
        [invocation setArgument:&chartView atIndex:2];
        [invocation setArgument:&arg2TotalCount atIndex:3];
        [invocation setArgument:&arg3CurrentCount atIndex:4];
        [invocation performSelector:@selector(invoke) withObject:nil afterDelay:0.5];
    }
    
    
}


- (void)removeAllView {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)setFrame:(CGRect)frame {
    CGSize size = frame.size;
    if (size.width < vMinWidth) size.width = vMinWidth;
    if (size.height < vMinHeight) size.height = vMinHeight;
    
    [super setFrame:frame];
}


@end
