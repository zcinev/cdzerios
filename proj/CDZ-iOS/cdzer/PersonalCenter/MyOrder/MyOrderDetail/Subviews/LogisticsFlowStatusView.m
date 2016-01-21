//
//  LogisticsFlowStatusView.m
//  cdzer
//
//  Created by KEns0n on 3/30/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight vAdjustByScreenRatio(60.0f)

#import "LogisticsFlowStatusView.h"

@implementation LogisticsFlowStatusView

- (void)setFrame:(CGRect)frame {
    
    if (vMinHeight>CGRectGetHeight(frame)) {
        frame.size.height = vMinHeight;
    }
    [super setFrame:frame];
}

- (void)initializationUIWithOrderStatus:(MyOrderStatus)orderStatus {
    @autoreleasepool {
        NSInteger stepIdx = 0;
        if (orderStatus==MyOrderStatusOfOrderWait4Payment||orderStatus==MyOrderStatusOfOrderPayOnDeliveryNWait4Delivery) stepIdx = 1;
        if (orderStatus==MyOrderStatusOfOrderDelivering) stepIdx = 2;
        if (orderStatus==MyOrderStatusOfOrderWait4Payment) stepIdx = 3;
        
        [self setBackgroundColor:sCommonBGColor];
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(vAdjustByScreenRatio(8.0f),
                                                    vAdjustByScreenRatio(30.0f),
                                                    vAdjustByScreenRatio(8.0f),
                                                    vAdjustByScreenRatio(30.0f));
        NSArray *flowStepTitle = @[@"submit_order",@"deliveries",@"product_received"];
        CGFloat width = (CGRectGetWidth(self.frame)-insetsValue.left*4.0f)/3.0f;
        CGFloat height = (CGRectGetHeight(self.frame)-insetsValue.top*2.0f)/2.0f;
        __block CGPoint firstPoint = CGPointZero;
        __block CGPoint lastPoint = CGPointZero;
        
        [flowStepTitle enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BOOL isCurrentStep = ((idx+1)<=stepIdx);
            
            CGRect titleRect = CGRectZero;
            titleRect.size = CGSizeMake(width, height);
            titleRect.origin.y = insetsValue.top;
            titleRect.origin.x = insetsValue.left+(insetsValue.left+width)*idx;
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleRect];
            [titleLabel setBackgroundColor:CDZColorOfClearColor];
            [titleLabel setTextColor:CDZColorOfDefaultColor];
            [titleLabel setText:getLocalizationString(obj)];
            [titleLabel setTextAlignment:NSTextAlignmentCenter];
            [titleLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(16.0f)]];
            [self addSubview:titleLabel];
            
            CGRect stepLabelRect = CGRectZero;
            stepLabelRect.origin.y = CGRectGetMaxY(titleRect);
            stepLabelRect.size = CGSizeMake(CGRectGetHeight(titleRect), CGRectGetHeight(titleRect));
            UILabel *stepLabel = [[UILabel alloc] initWithFrame:stepLabelRect];
            [stepLabel setTag:10+idx];
            [stepLabel setTextAlignment:NSTextAlignmentCenter];
            [stepLabel setText:[[NSNumber numberWithUnsignedInteger:idx+1] stringValue]];
            [stepLabel setBackgroundColor:isCurrentStep?CDZColorOfDefaultColor:sCommonBGColor];
            [stepLabel setTextColor:isCurrentStep?CDZColorOfWhite:CDZColorOfDefaultColor];
            [stepLabel setFont:[UIFont boldSystemFontOfSize:vAdjustByScreenRatio(15.0f)]];
            [stepLabel setCenter:CGPointMake(titleLabel.center.x, stepLabel.center.y)];
            
            [stepLabel setBorderWithColor:CDZColorOfDefaultColor borderWidth:(1.5f)];
            [stepLabel.layer setMasksToBounds:YES];
            [stepLabel.layer setCornerRadius:CGRectGetHeight(stepLabelRect)/2.0f];
            [self addSubview:stepLabel];
            
            
            if ([[flowStepTitle firstObject] isEqual:obj]) firstPoint = stepLabel.center;
            if ([[flowStepTitle lastObject] isEqual:obj]) lastPoint = stepLabel.center;
            
            
        }];
        CGRect lineIVRect = CGRectZero;
        lineIVRect.size = CGSizeMake(lastPoint.x-firstPoint.x, vAdjustByScreenRatio(3.0f));
        lineIVRect.origin.x = firstPoint.x;
        
        UIImageView *lineIV = [[UIImageView alloc] initWithFrame:lineIVRect];
        [lineIV setCenter:CGPointMake(lineIV.center.x, firstPoint.y)];
        [lineIV setBackgroundColor:CDZColorOfDefaultColor];
        [self insertSubview:lineIV belowSubview:[self viewWithTag:10]];

    }
}

@end
