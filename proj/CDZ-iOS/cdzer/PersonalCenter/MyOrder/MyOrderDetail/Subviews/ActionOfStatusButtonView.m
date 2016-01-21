//
//  ActionOfStatusButtonView.m
//  cdzer
//
//  Created by KEns0n on 3/30/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define leftMargin vAdjustByScreenRatio(10.0f)
#define btn2BtnSpace vAdjustByScreenRatio(20.0f)
#import "ActionOfStatusButtonView.h"

@implementation ActionOfStatusButtonView

- (void)initializationUIWithOrderStatus:(MyOrderStatus)orderStatus target:(id)target Actions:(NSArray *)actionsList isOnlyShowTrackBtn:(BOOL)isOnlyShow {
    
    @autoreleasepool {
        CGFloat width4One = CGRectGetWidth(self.frame)-leftMargin*2.0f;
        CGFloat width4Two = (width4One-btn2BtnSpace)/2.0f;
        
        if (isOnlyShow) {
            if (!_orderTraceBtn) {
                NSString *title = @"订单跟踪";
                [self setOrderTraceBtn:[UIButton buttonWithType:UIButtonTypeSystem]];
                [_orderTraceBtn setBorderWithColor:nil borderWidth:(0.5)];
                [_orderTraceBtn setFrame:CGRectMake(leftMargin, 0.0f, width4One, CGRectGetHeight(self.frame))];
                [_orderTraceBtn setBackgroundColor:[UIColor lightGrayColor]];
                [_orderTraceBtn setTitleColor:CDZColorOfBlack forState:UIControlStateNormal];
                [_orderTraceBtn setTitle:title forState:UIControlStateNormal];
                [_orderTraceBtn setTitleColor:CDZColorOfBlack forState:UIControlStateHighlighted];
                [_orderTraceBtn setTitle:title forState:UIControlStateHighlighted];
                [self addSubview:_orderTraceBtn];
            }
        }else {
            
            
            CGRect commentBtnRect = CGRectMake(leftMargin, 0.0f, (actionsList.count>=2)?width4Two:width4One, CGRectGetHeight(self.frame));
            CGRect otherBtnRect = CGRectMake(CGRectGetWidth(self.frame)-width4Two-leftMargin, 0.0f, width4Two, CGRectGetHeight(self.frame));
            UIColor *titleColor = CDZColorOfWhite;
            UIColor *commonBGColor = CDZColorOfDefaultColor;
            UIColor *otherBGColor = CDZColorOfDefaultColor;
            
            NSString *commonTitle = @"";
            NSString *otherTitle = @"";
            
            if (orderStatus==MyOrderStatusOfOrderWait4Payment) {
                commonTitle = @"去支付";
                otherTitle = @"取消订单";
                commonBGColor = CDZColorOfRed;
            }
            
            if (orderStatus==MyOrderStatusOfOrderWasPaidNWait4Delivery||orderStatus==MyOrderStatusOfOrderPayOnDeliveryNWait4Delivery) {
                commonTitle = @"取消订单";
            }
            
            if (orderStatus==MyOrderStatusOfOrderDelivering) {
                commonBGColor = CDZColorOfRed;
                commonTitle = @"确认收货";
                otherTitle = @"申请返修／退换货";
            }
            
            if (orderStatus==MyOrderStatusOfOrderCancel||
                orderStatus==MyOrderStatusOfOrderAcceptApplingReturnPurchase) {
                commonTitle = @"删除订单";
            }
            
            if (orderStatus==MyOrderStatusOfOrderFinish) {
                commonTitle = @"删除订单";
                otherTitle = @"评价订单";
                otherBGColor = [UIColor colorWithRed:0.992f green:0.427f blue:0.133f alpha:1.00f];
            }

            
            
            if (actionsList.count>=1) {
                self.commentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                [_commentBtn setFrame:commentBtnRect];
                [_commentBtn setBackgroundColor:commonBGColor];
                [_commentBtn setTitleColor:titleColor forState:UIControlStateNormal];
                [_commentBtn setTitle:commonTitle forState:UIControlStateNormal];
                [_commentBtn setTitleColor:titleColor forState:UIControlStateHighlighted];
                [_commentBtn setTitle:commonTitle forState:UIControlStateHighlighted];
                if (target&&actionsList.count!=0&&![actionsList[0] isEqualToString:@""]) {
                    if ([target respondsToSelector:NSSelectorFromString(actionsList[0])]) {
                        [_commentBtn addTarget:target action:NSSelectorFromString(actionsList[0]) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
                
                [self addSubview:_commentBtn];
            }
            
            if (actionsList.count>=2) {
                self.otherBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                _otherBtn.frame = otherBtnRect;
                [_otherBtn setBackgroundColor:otherBGColor];
                [_otherBtn setTitleColor:titleColor forState:UIControlStateNormal];
                [_otherBtn setTitle:otherTitle forState:UIControlStateNormal];
                [_otherBtn setTitleColor:titleColor forState:UIControlStateHighlighted];
                [_otherBtn setTitle:otherTitle forState:UIControlStateHighlighted];
                if (target&&actionsList.count!=0&&![actionsList[1] isEqualToString:@""]) {
                    if ([target respondsToSelector:NSSelectorFromString(actionsList[1])]) {
                        [_otherBtn addTarget:target action:NSSelectorFromString(actionsList[1]) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
                [self addSubview:_otherBtn];
            }
            
        }
        
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
