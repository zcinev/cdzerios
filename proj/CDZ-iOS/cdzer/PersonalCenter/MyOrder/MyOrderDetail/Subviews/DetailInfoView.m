//
//  DetailInfoView.m
//  cdzer
//
//  Created by KEns0n on 3/30/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight vAdjustByScreenRatio(90.0f)
#define topMargin vAdjustByScreenRatio(4.0f)
#define leftMargin vAdjustByScreenRatio(10.0f)
#import "InsetsLabel.h"
#import "DetailInfoView.h"
#import "MyOrderConfig.h"


@implementation DetailInfoView

- (void)initializationUIWithDetailInfos:(NSDictionary *)detailInfo {

    @autoreleasepool {
        if (!detailInfo) return;
        [self setBorderWithColor:nil borderWidth:(0.5f)];
        [self setBackgroundColor:CDZColorOfWhite];
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vAdjustByScreenRatio(18.0f), 0.0f, 0.0f);
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        NSString *supplier = [detailInfo[kCenterDetailKey] objectForKey:@"name"];
        if (!supplier) {
            supplier = @"";
        }
        NSString *totalPrice = [detailInfo[kOrderDetailKey] objectForKey:@"order_price"];
        if (!totalPrice) {
            totalPrice = @"0.00";
        }
        
        NSString *address = [detailInfo[kAddressDetailKey] objectForKey:@"address"];
        if (!address) address = @"";
        
        NSString *telStringWithSymbol = [[detailInfo[kAddressDetailKey] objectForKey:@"tel"] stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"****"];
        if (!telStringWithSymbol) telStringWithSymbol = @"";
        
        NSString *name = [detailInfo[kAddressDetailKey] objectForKey:@"name"];
        if (!name) name = @"";
        
         NSString *receipt = @"";
        if (detailInfo[kAddressDetailKey]) {
            receipt = [detailInfo[kAddressDetailKey] objectForKey:@"receipt"];
            if (![detailInfo[kAddressDetailKey] objectForKey:@"receipt"]) {
                receipt = @"不开收据";
            }
        }
        
        NSArray *titleArray = @[@{@"title":@"supplier",@"content":supplier},
                                @{@"title":@"total_price",@"content":totalPrice},
                                
                                @{@"title":@"delivery_address",@"content":address},
                                @{@"title":@"consignee",@"content":[name stringByAppendingFormat:@" %@",telStringWithSymbol]},
                                
                                @{@"title":@"invoice",@"content":receipt}];
        
        __block CGFloat lastMaxY = 0.0f;
        [titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *titleString = getLocalizationString(obj[@"title"]);
            NSString *contentString = obj[@"content"];
            if ([obj[@"content"] isKindOfClass:NSNumber.class]) {
                contentString = [obj[@"content"] stringValue];
            }
            CGFloat fontSize = 14.0f;
            CGSize stringSize = [SupportingClass getStringSizeWithString:titleString
                                                                    font:systemFontBold(fontSize)
                                                             widthOfView:CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX)];
            CGRect titleRect = CGRectZero;
            titleRect.origin.y = vAdjustByScreenRatio(6.0f)+(stringSize.height+vAdjustByScreenRatio(6.0f))*idx;
            titleRect.size = CGSizeMake(vAdjustByScreenRatio(90.0f), stringSize.height);
            InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:insetsValue];
            [titleLabel setText:titleString];
            [titleLabel setTextAlignment:NSTextAlignmentRight];
            [titleLabel setFont:systemFontBold(fontSize)];
            [self addSubview:titleLabel];
            
            CGRect contentRect = titleRect;
            contentRect.origin.x = CGRectGetMaxX(titleRect);
            contentRect.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(titleRect);
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:contentRect];
            [contentLabel setText:contentString];
            [contentLabel setTextColor:[UIColor grayColor]];
            [contentLabel setTextAlignment:NSTextAlignmentLeft];
            [contentLabel setFont:systemFontBold(fontSize)];
            [self addSubview:contentLabel];
            
            lastMaxY = CGRectGetMaxY(contentRect);
        }];
        
        CGRect frame = self.frame;
        frame.size.height = lastMaxY+vAdjustByScreenRatio(6.0f);
        [self setFrame:frame];

    }
}

- (void)initializationUIWithDetailInfo:(NSDictionary *)detailInfo {
    
    
    NSDictionary *centerDetails = detailInfo[kCenterDetailKey];
    NSDictionary *consigneeDetails = detailInfo[kAddressDetailKey];
    NSDictionary *orderDetail = detailInfo[kOrderDetailKey];
    
    UIEdgeInsets insetsValue = DefaultEdgeInsets;
    BorderOffsetObject *offset = [BorderOffsetObject new];
    offset.bottomLeftOffset = insetsValue.left;
    offset.bottomRightOffset = insetsValue.right;
    
    UIFont *titleFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 15, NO);
    UIFont *font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO);
    
    InsetsLabel *centerTitle = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 30.0f)
                                               andEdgeInsetsValue:insetsValue];
    centerTitle.text = @"配件中心信息";
    centerTitle.textAlignment = NSTextAlignmentCenter;
    centerTitle.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16, NO);
    centerTitle.textColor = CDZColorOfBlack;
    [centerTitle setViewBorderWithRectBorder:UIRectBorderBottom borderSize:1.0f withColor:CDZColorOfLightGray withBroderOffset:offset];
    [self addSubview:centerTitle];
    
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    NSString *centerName = [SupportingClass verifyAndConvertDataToString:centerDetails[@"name"]];
    NSMutableAttributedString* centerNameAttrStr = [NSMutableAttributedString new];
    [centerNameAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"parts_center")
                                                                              attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}]];
    
    [centerNameAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:centerName
                                                                              attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}]];
    
    CGRect centerNameRect = self.bounds;
    centerNameRect.origin.y = CGRectGetMaxY(centerTitle.frame);
    centerNameRect.size.height = 25.0f;
    InsetsLabel *centerNameLabel = [[InsetsLabel alloc] initWithFrame:centerNameRect andEdgeInsetsValue:insetsValue];
    centerNameLabel.attributedText = centerNameAttrStr;
    centerNameLabel.numberOfLines = 0;
    [self addSubview:centerNameLabel];
    
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    NSString *centerContact = [SupportingClass verifyAndConvertDataToString:centerDetails[@"tel"]];
    NSMutableAttributedString* centerContactAttrStr = [NSMutableAttributedString new];
    [centerContactAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"parts_center")
                                                                                 attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}]];
    
    [centerContactAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:centerContact
                                                                                 attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}]];
    
    CGRect centerContactRect = self.bounds;
    centerContactRect.origin.y = CGRectGetMaxY(centerNameLabel.frame);
    centerContactRect.size.height = 25.0f;
    InsetsLabel *centerContactLabel = [[InsetsLabel alloc] initWithFrame:centerContactRect andEdgeInsetsValue:insetsValue];
    centerContactLabel.attributedText = centerContactAttrStr;
    centerContactLabel.numberOfLines = 0;
    [self addSubview:centerContactLabel];
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    NSString *provinceName = [SupportingClass verifyAndConvertDataToString:centerDetails[@"province_name"]];
    NSString *cityName = [SupportingClass verifyAndConvertDataToString:centerDetails[@"city_name"]];
    
    
    NSAttributedString *centerLocateTitle = [[NSAttributedString alloc] initWithString:getLocalizationString(@"current_city")
                                                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}];
    CGSize titleSize = [SupportingClass getAttributedStringSizeWithString:centerLocateTitle widthOfView:CGSizeMake(CGRectGetWidth(self.frame)-insetsValue.left, CGFLOAT_MAX)];
    
    CGRect centerLocateTitleRect = CGRectZero;
    centerLocateTitleRect.size.width = titleSize.width+insetsValue.left;
    centerLocateTitleRect.size.height = titleSize.height;
    InsetsLabel *centerLocateTitleLabel = [[InsetsLabel alloc] initWithFrame:centerLocateTitleRect
                                                          andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
    centerLocateTitleLabel.attributedText = centerLocateTitle;
    centerLocateTitleLabel.numberOfLines = 0;
    
    
    
    
    NSAttributedString* centerLocateAttrStr = [[NSAttributedString alloc] initWithString:[provinceName stringByAppendingFormat:@" %@", cityName]
                                                                              attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}];
    CGSize stringSize = [SupportingClass getAttributedStringSizeWithString:centerLocateAttrStr
                                                               widthOfView:CGSizeMake(CGRectGetWidth(self.frame)-insetsValue.right-CGRectGetWidth(centerLocateTitleLabel.frame), CGFLOAT_MAX)];
    
    CGRect centerLocateRect = self.bounds;
    centerLocateRect.origin.y = CGRectGetMaxY(centerContactLabel.frame)+4.0f;
    centerLocateRect.size.height = stringSize.height;
    InsetsLabel *centerLocateLabel = [[InsetsLabel alloc] initWithFrame:centerLocateRect
                                                     andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, CGRectGetWidth(centerLocateTitleLabel.frame), 0.0f, insetsValue.right)];
    centerLocateLabel.attributedText = centerLocateAttrStr;
    centerLocateLabel.numberOfLines = 0;
    [self addSubview:centerLocateLabel];
    [centerLocateLabel addSubview:centerLocateTitleLabel];

    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    InsetsLabel *consigneeTitle = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(centerLocateLabel.frame)+6.0f, CGRectGetWidth(self.frame), 30.0f)
                                               andEdgeInsetsValue:insetsValue];
    consigneeTitle.text = @"收货信息";
    consigneeTitle.textAlignment = NSTextAlignmentCenter;
    consigneeTitle.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16, NO);
    consigneeTitle.textColor = CDZColorOfBlack;
    [consigneeTitle setViewBorderWithRectBorder:UIRectBorderBottom|UIRectBorderTop borderSize:1.0f withColor:CDZColorOfLightGray withBroderOffset:offset];
    [self addSubview:consigneeTitle];
    
    
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    NSString *consignee = [SupportingClass verifyAndConvertDataToString:consigneeDetails[@"name"]];
    NSMutableAttributedString* consigneeAttrStr = [NSMutableAttributedString new];
    [consigneeAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"consignee")
                                                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}]];
    
    [consigneeAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:consignee
                                                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}]];
    
    CGRect consigneeRect = self.bounds;
    consigneeRect.origin.y = CGRectGetMaxY(consigneeTitle.frame);
    consigneeRect.size.height = 25.0f;
    InsetsLabel *consigneeLabel = [[InsetsLabel alloc] initWithFrame:consigneeRect andEdgeInsetsValue:insetsValue];
    consigneeLabel.attributedText = consigneeAttrStr;
    consigneeLabel.numberOfLines = 0;
    [self addSubview:consigneeLabel];
    
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    
//    NSString *postage = [SupportingClass verifyAndConvertDataToString:orderDetail[@"send_price_dou"]];
//    NSMutableAttributedString* postageAttrStr = [NSMutableAttributedString new];
//    [postageAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"postage")
//                                                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}]];
//    
//    [postageAttrStr appendAttributedString:[[NSAttributedString alloc] initWithString:postage
//                                                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}]];
//    
//    CGRect postageRect = self.bounds;
//    postageRect.origin.y = CGRectGetMaxY(consigneeLabel.frame);
//    postageRect.size.height = 25.0f;
//    InsetsLabel *postageLabel = [[InsetsLabel alloc] initWithFrame:postageRect andEdgeInsetsValue:insetsValue];
//    postageLabel.attributedText = postageAttrStr;
//    postageLabel.numberOfLines = 0;
//    [self addSubview:postageLabel];
//    
//    
//    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    NSString *payWay = [SupportingClass verifyAndConvertDataToString:orderDetail[@"paytype_name"]];
    payWay = [payWay stringByReplacingOccurrencesOfString:@" " withString:@""];
    payWay = [payWay stringByReplacingOccurrencesOfString:@";" withString:@";\n"];
    payWay = [payWay stringByReplacingOccurrencesOfString:@"；" withString:@"；\n"];
    
    
    NSAttributedString *payWayTitle = [[NSAttributedString alloc] initWithString:getLocalizationString(@"pay_way")
                                                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}];
    CGSize payWayTitleSize = [SupportingClass getAttributedStringSizeWithString:payWayTitle widthOfView:CGSizeMake(CGRectGetWidth(self.frame)-insetsValue.left, CGFLOAT_MAX)];
    
    CGRect payWayTitleRect = CGRectZero;
    payWayTitleRect.size.width = payWayTitleSize.width+insetsValue.left;
    payWayTitleRect.size.height = payWayTitleSize.height;
    InsetsLabel *payWayTitleLabel = [[InsetsLabel alloc] initWithFrame:payWayTitleRect
                                                           andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
    payWayTitleLabel.attributedText = payWayTitle;
    payWayTitleLabel.numberOfLines = 0;
    
    
    
    
    NSAttributedString* payWayAttrStr = [[NSAttributedString alloc] initWithString:payWay
                                                                               attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}];
    CGSize payWayStringSize = [SupportingClass getAttributedStringSizeWithString:payWayAttrStr
                                                                   widthOfView:CGSizeMake(CGRectGetWidth(self.frame)-insetsValue.right-CGRectGetWidth(payWayTitleLabel.frame), CGFLOAT_MAX)];
    
    CGRect payWayRect = self.bounds;
    payWayRect.origin.y = CGRectGetMaxY(consigneeLabel.frame)+4.0f;
    payWayRect.size.height = payWayStringSize.height;
    InsetsLabel *payWayLabel = [[InsetsLabel alloc] initWithFrame:payWayRect
                                                      andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, CGRectGetWidth(payWayTitleLabel.frame), 0.0f, insetsValue.right)];
    payWayLabel.attributedText = payWayAttrStr;
    payWayLabel.numberOfLines = 0;
    [self addSubview:payWayLabel];
    [payWayLabel addSubview:payWayTitleLabel];
    
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    NSString *consigneeAddr = [SupportingClass verifyAndConvertDataToString:consigneeDetails[@"address"]];
    
    
    NSAttributedString *consigneeAddrTitle = [[NSAttributedString alloc] initWithString:getLocalizationString(@"delivery_address")
                                                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:titleFont}];
    CGSize addrTitleSize = [SupportingClass getAttributedStringSizeWithString:consigneeAddrTitle widthOfView:CGSizeMake(CGRectGetWidth(self.frame)-insetsValue.left, CGFLOAT_MAX)];
    
    CGRect consigneeAddrTitleRect = CGRectZero;
    consigneeAddrTitleRect.size.width = addrTitleSize.width+insetsValue.left;
    consigneeAddrTitleRect.size.height = addrTitleSize.height;
    InsetsLabel *consigneeAddrTitleLabel = [[InsetsLabel alloc] initWithFrame:consigneeAddrTitleRect
                                                           andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
    consigneeAddrTitleLabel.attributedText = consigneeAddrTitle;
    consigneeAddrTitleLabel.numberOfLines = 0;
    
    
    
    
    NSAttributedString* consigneeAddrAttrStr = [[NSAttributedString alloc] initWithString:consigneeAddr
                                                                               attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray, NSFontAttributeName:font}];
    CGSize addrStringSize = [SupportingClass getAttributedStringSizeWithString:consigneeAddrAttrStr
                                                                   widthOfView:CGSizeMake(CGRectGetWidth(self.frame)-insetsValue.right-CGRectGetWidth(consigneeAddrTitleLabel.frame), CGFLOAT_MAX)];
    
    CGRect consigneeAddrRect = self.bounds;
    consigneeAddrRect.origin.y = CGRectGetMaxY(payWayLabel.frame)+8.0f;
    consigneeAddrRect.size.height = addrStringSize.height;
    InsetsLabel *consigneeAddrLabel = [[InsetsLabel alloc] initWithFrame:consigneeAddrRect
                                                      andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, CGRectGetWidth(consigneeAddrTitleLabel.frame), 0.0f, insetsValue.right)];
    consigneeAddrLabel.attributedText = consigneeAddrAttrStr;
    consigneeAddrLabel.numberOfLines = 0;
    [self addSubview:consigneeAddrLabel];
    [consigneeAddrLabel addSubview:consigneeAddrTitleLabel];

    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    
    
    CGRect frame = self.frame;
    frame.size.height = CGRectGetMaxY(consigneeAddrLabel.frame)+8.0f;
    self.frame = frame;
    self.backgroundColor = CDZColorOfWhite;
    [self setViewBorderWithRectBorder:UIRectBorderTop|UIRectBorderBottom borderSize:0.5f withColor:CDZColorOfLightGray withBroderOffset:nil];
    
}


- (void)setFrame:(CGRect)frame {
    
    if (vMinHeight>CGRectGetHeight(frame)) {
        frame.size.height = vMinHeight;
    }
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
