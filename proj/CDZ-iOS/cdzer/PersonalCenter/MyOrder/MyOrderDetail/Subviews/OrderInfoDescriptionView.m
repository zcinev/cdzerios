//
//  OrderInfoDescriptionView.m
//  cdzer
//
//  Created by KEns0n on 3/30/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "OrderInfoDescriptionView.h"
#import "InsetsLabel.h"

@implementation OrderInfoDescriptionView

- (void)initializationUIByOrderStatus:(MyOrderStatus)orderStatus withOrderInfo:(NSDictionary *)infoData {
    
    @autoreleasepool {
        
        UIEdgeInsets insetsValue = DefaultEdgeInsets;
        UIFont *titleFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 15, NO);
        UIFont *font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO);
        
        NSDictionary *orderDetail = infoData[kOrderDetailKey];
        
        NSString *orderID = orderDetail[@"main_order_id"];
        NSString *orderDateTime = orderDetail[@"create_time"];
        NSString *orderStatus = orderDetail[@"state_name"];
    
        
        NSMutableAttributedString* orderIDAttrStr = [NSMutableAttributedString new];
        [orderIDAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"order_id")
                                                                               attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}]];
        
        [orderIDAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:orderID
                                                                               attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}]];
        
        CGRect orderIDRect = self.bounds;
        orderIDRect.origin.y = vAdjustByScreenRatio(5.0f);
        orderIDRect.size.height = 25.0f;
        InsetsLabel *orderIDLabel = [[InsetsLabel alloc] initWithFrame:orderIDRect andEdgeInsetsValue:insetsValue];
        orderIDLabel.attributedText = orderIDAttrStr;
        orderIDLabel.numberOfLines = 0;
        [self addSubview:orderIDLabel];
        
        
        
        NSMutableAttributedString* orderStatusAttrStr = [NSMutableAttributedString new];
        [orderStatusAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"order_status")
                                                                                   attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}]];
        
        [orderStatusAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:orderStatus
                                                                                   attributes:@{NSForegroundColorAttributeName:CDZColorOfDefaultColor, NSFontAttributeName:font}]];
        
        CGRect orderStatusRect = self.bounds;
        orderStatusRect.origin.y = CGRectGetMaxY(orderIDLabel.frame);
        orderStatusRect.size.height = 25.0f;
        InsetsLabel *orderStatusLabel = [[InsetsLabel alloc] initWithFrame:orderStatusRect andEdgeInsetsValue:insetsValue];
        orderStatusLabel.attributedText = orderStatusAttrStr;
        orderStatusLabel.numberOfLines = 0;
        [self addSubview:orderStatusLabel];
        
        
        
        
        NSMutableAttributedString* orderTimeAttrStr = [NSMutableAttributedString new];
        [orderTimeAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"order_datetime")
                                                                                 attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}]];
        
        [orderTimeAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:orderDateTime
                                                                                 attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}]];
        
        CGRect orderTimeRect = self.bounds;
        orderTimeRect.origin.y = CGRectGetMaxY(orderStatusLabel.frame);
        orderTimeRect.size.height = 25.0f;
        InsetsLabel *orderDateTimeLabel = [[InsetsLabel alloc] initWithFrame:orderTimeRect andEdgeInsetsValue:insetsValue];
        orderDateTimeLabel.attributedText = orderTimeAttrStr;
        orderDateTimeLabel.numberOfLines = 0;
        [self addSubview:orderDateTimeLabel];
        
        
        
        
        
//        NSArray *productsList = [orderDetail[@"product_list"] valueForKey:@"autopartinfo_name"];
//        NSString *productsName = [productsList componentsJoinedByString:@",\n"];
//        
//        NSAttributedString *productsNameTitle = [[NSAttributedString alloc] initWithString:getLocalizationString(@"products_name")
//                                                                                attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}];
//        CGSize titleSize = [SupportingClass getAttributedStringSizeWithString:productsNameTitle widthOfView:CGSizeMake(CGRectGetWidth(self.frame)-insetsValue.left, CGFLOAT_MAX)];
//        
//        CGRect productsNameTitleRect = CGRectZero;
//        productsNameTitleRect.size.width = titleSize.width+insetsValue.left;
//        productsNameTitleRect.size.height = titleSize.height;
//        InsetsLabel *productsNameTitleLabel = [[InsetsLabel alloc] initWithFrame:productsNameTitleRect
//                                                              andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
//        productsNameTitleLabel.attributedText = productsNameTitle;
//        productsNameTitleLabel.numberOfLines = 0;
//        
//        
//        
//        
//        NSAttributedString* productsNameAttrStr = [[NSAttributedString alloc] initWithString:productsName
//                                                                                  attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}];
//        CGSize stringSize = [SupportingClass getAttributedStringSizeWithString:productsNameTitle
//                                                                   widthOfView:CGSizeMake(CGRectGetWidth(self.frame)-insetsValue.right-CGRectGetWidth(productsNameTitleLabel.frame), CGFLOAT_MAX)];
//        
//        CGRect productsNameRect = self.bounds;
//        productsNameRect.origin.y = CGRectGetMaxY(orderDateTimeLabel.frame)+4.0f;
//        productsNameRect.size.height = stringSize.height;
//        InsetsLabel *productsNameLabel = [[InsetsLabel alloc] initWithFrame:productsNameRect
//                                                         andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, CGRectGetWidth(productsNameTitleLabel.frame), 0.0f, insetsValue.right)];
//        productsNameLabel.attributedText = productsNameAttrStr;
//        productsNameLabel.numberOfLines = 0;
//        [self addSubview:productsNameLabel];
//        [productsNameLabel addSubview:productsNameTitleLabel];
        
        
        
        
        CGRect frame = self.frame;
        frame.size.height = CGRectGetMaxY(orderDateTimeLabel.frame)+5.0f;
        self.frame = frame;
        self.backgroundColor = CDZColorOfWhite;
        [self setViewBorderWithRectBorder:UIRectBorderTop|UIRectBorderBottom borderSize:0.5f withColor:CDZColorOfLightGray withBroderOffset:nil];
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
