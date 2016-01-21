//
//  MyRepairTVCell.m
//  cdzer
//
//  Created by KEns0n on 3/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight 190.0f
#define view2ViewSpace 4.0f
#import "MyRepairTVCell.h"
#import "InsetsLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MyRepairTVCell ()

@property (nonatomic, strong) InsetsLabel *diagnosisNumLabel;

@property (nonatomic, strong) InsetsLabel *statusLabel;

@property (nonatomic, strong) InsetsLabel *dateTimeLabel;

@property (nonatomic, strong) InsetsLabel *lineOneLabel;

@property (nonatomic, strong) InsetsLabel *lineTwoLabel;

@property (nonatomic, strong) InsetsLabel *lineThreeLabel;

@property (nonatomic, strong) InsetsLabel *lineFourLabel;

@end

@implementation MyRepairTVCell

- (void)initializationUI {
    
    @autoreleasepool {
        [self setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
        CGFloat remainHeight = vMinHeight-10.0f;
        UIEdgeInsets insetsValue = DefaultEdgeInsets;
        UIFont *commentFont = [UIFont systemFontOfSize:13.0f];
        UIFont *commentBoldFont = [UIFont boldSystemFontOfSize:13.0f];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        CGRect upperViewRect = self.bounds;
        upperViewRect.size.height = 38.0f;
        remainHeight -= CGRectGetHeight(upperViewRect);
        
        UIView *upperView = [[UIView alloc] initWithFrame:upperViewRect];
        [upperView setBackgroundColor:CDZColorOfWhite];
        [upperView setBorderWithColor:nil borderWidth:(0.5f)];
        [self addSubview:upperView];

        if (!_diagnosisNumLabel) {
            
            self.diagnosisNumLabel = [[InsetsLabel alloc] initWithFrame:upperView.bounds andEdgeInsetsValue:insetsValue];
            [_diagnosisNumLabel setFont:commentFont];
            [_diagnosisNumLabel setText:@"WX328712429741744012"];
            [_diagnosisNumLabel setTextColor:CDZColorOfBlack];
            [upperView addSubview:_diagnosisNumLabel];

        }
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        if (!_statusLabel) {
            
            CGRect statusLabelRect = CGRectZero;
            statusLabelRect.size = CGSizeMake(100.0f, 30.0f);
            statusLabelRect.origin.x = CGRectGetWidth(upperViewRect)-CGRectGetWidth(statusLabelRect);
            self.statusLabel = [[InsetsLabel alloc] initWithFrame:statusLabelRect andEdgeInsetsValue:insetsValue];
            [_statusLabel setBackgroundColor:CDZColorOfRed];
            [_statusLabel setTextColor:CDZColorOfWhite];
            [_statusLabel setFont:commentBoldFont];
            [_statusLabel setText:@"测试状态中"];
            [_statusLabel setTextAlignment:NSTextAlignmentRight];
            [upperView addSubview:_statusLabel];
            [_statusLabel setCenter:CGPointMake(_statusLabel.center.x, CGRectGetHeight(upperViewRect)/2.0f)];
            
        }
        


        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect middleViewRect = upperViewRect;
        middleViewRect.origin.y = CGRectGetMaxY(upperViewRect);
        middleViewRect.size.height = 28.0f;
        remainHeight -= CGRectGetHeight(middleViewRect);
        
        UIView *middleView = [[UIView alloc] initWithFrame:middleViewRect];
        [middleView setBackgroundColor:CDZColorOfWhite];
        [middleView setBorderWithColor:nil borderWidth:(0.5f)];
        [self addSubview:middleView];

        if (!_dateTimeLabel) {

            self.dateTimeLabel = [[InsetsLabel alloc] initWithFrame:middleView.bounds andEdgeInsetsValue:insetsValue];
            [_dateTimeLabel setFont:commentFont];
            [_dateTimeLabel setText:@"2014-12-19 16:21:30"];
            [_dateTimeLabel setTextColor:CDZColorOfBlack];
            [middleView addSubview:_dateTimeLabel];
            
        }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect bottomViewRect = middleViewRect;
        bottomViewRect.origin.y = CGRectGetMaxY(middleViewRect);
        bottomViewRect.size.height = remainHeight;
        
        UIView *bottomView = [[UIView alloc] initWithFrame:bottomViewRect];
        [bottomView setBackgroundColor:CDZColorOfWhite];
        [bottomView setBorderWithColor:nil borderWidth:(0.5f)];
        [self addSubview:bottomView];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        UIFont *boldFont15 = systemFont(15.0f);
        if (!_lineOneLabel) {
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:getLocalizationString(@"repair_shop_with_symbol")
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:boldFont15}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:@"啊舍不得；哦啊实打实力度；哈色"
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                       NSFontAttributeName:boldFont15}]];
            
            
            CGRect repairShopRect = CGRectZero;
            repairShopRect.origin.y = 5.0f;
            repairShopRect.size.width = CGRectGetWidth(bottomViewRect);
            repairShopRect.size.height = 25.0f;
            self.lineOneLabel = [[InsetsLabel alloc] initWithFrame:repairShopRect andEdgeInsetsValue:insetsValue];
            [_lineOneLabel setNumberOfLines:0];
            [_lineOneLabel setAttributedText:text];
            [bottomView addSubview:_lineOneLabel];
        }
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (!_lineTwoLabel) {
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:getLocalizationString(@"mycar_number_with_symbol")
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:boldFont15}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:@"XA12H093"
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                       NSFontAttributeName:boldFont15}]];
            
            
            
            CGRect carNumberRect = _lineOneLabel.frame;
            carNumberRect.origin.y = CGRectGetMaxY(_lineOneLabel.frame);
            
            self.lineTwoLabel = [[InsetsLabel alloc] initWithFrame:carNumberRect andEdgeInsetsValue:insetsValue];
            [_lineTwoLabel setNumberOfLines:0];
            [_lineTwoLabel setAttributedText:text];
            [bottomView addSubview:_lineTwoLabel];
        }
        
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (!_lineThreeLabel) {
            
            CGRect projectTitleRect = _lineTwoLabel.frame;
            projectTitleRect.origin.y = CGRectGetMaxY(_lineTwoLabel.frame);
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:getLocalizationString(@"repair_item_with_symbol")
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:boldFont15}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:@"abc"
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                       NSFontAttributeName:boldFont15}]];
            
            self.lineThreeLabel = [[InsetsLabel alloc] initWithFrame:projectTitleRect andEdgeInsetsValue:insetsValue];
            [_lineThreeLabel setNumberOfLines:0];
            [_lineThreeLabel setAttributedText:text];
            [bottomView addSubview:_lineThreeLabel];
        }
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (!_lineFourLabel) {
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:getLocalizationString(@"diagnosis_fee")
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:boldFont15}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:@"¥1,200"
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                       NSFontAttributeName:boldFont15}]];
            
            
            CGRect repairFeeRect = _lineThreeLabel.frame;
            repairFeeRect.origin.y = CGRectGetMaxY(_lineThreeLabel.frame);
            
            self.lineFourLabel = [[InsetsLabel alloc] initWithFrame:repairFeeRect andEdgeInsetsValue:insetsValue];
            [_lineFourLabel setNumberOfLines:0];
            [_lineFourLabel setTextAlignment:NSTextAlignmentRight];
            [_lineFourLabel setAttributedText:text];
            [bottomView addSubview:_lineFourLabel];
        }
        

        
    }
}

- (void)updateUIDataWithData:(NSDictionary *)dataDetail withStatusType:(CDZMaintenanceStatusType)statusType {
    
    @autoreleasepool {
        
        UIFont *boldFont15 = systemFontWithoutRatio(15.0f);
        UIFont *commentFont = [UIFont systemFontOfSize:13.0f];
        NSString *orderID = nil;
        NSString *statusName = @"state_name";
        NSString *lineOneStrKey = nil;
        NSString *lineTwoStrKey = nil;
        NSString *lineThreeStrKey = nil;
        NSString *lineFourStrKey = nil;
        switch (statusType) {
            case CDZMaintenanceStatusTypeOfAppointment:
                orderID = @"make_number";
                lineOneStrKey = @"wxs_name";
                lineTwoStrKey = @"service_project";
                lineThreeStrKey = @"car_number";
                lineFourStrKey = @"make_technician";
            
                break;
            case CDZMaintenanceStatusTypeOfDiagnosis:
                orderID = @"diacaplan";
                lineOneStrKey = @"wxs_name";
                lineTwoStrKey = @"usering_car";
                lineFourStrKey = @"fJianchaprice";
                break;
            case CDZMaintenanceStatusTypeOfUserAuthorized:
                orderID = @"dia_number";
                lineOneStrKey = @"wxs_name";
                lineTwoStrKey = @"usering_car";
                lineFourStrKey = @"w_allcost";
                break;
            case CDZMaintenanceStatusTypeOfHasBeenClearing:
                orderID = @"balance_number";
                lineOneStrKey = @"car_number";
                lineFourStrKey = @"fee";
                break;
                
            default:
                break;
        }
        
        
        if (dataDetail[orderID]&&![dataDetail[orderID] isEqualToString:@""]) {
            
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:getLocalizationString(@"diagnosis_number")
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:commentFont}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:dataDetail[orderID]
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                       NSFontAttributeName:commentFont}]];
            
            _diagnosisNumLabel.attributedText = text;
        }
        
        if (dataDetail[@"addtime"]&&![dataDetail[@"addtime"] isEqualToString:@""]) {
            
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:getLocalizationString(@"diagnosis_datetime")
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:commentFont}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:dataDetail[@"addtime"]
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                       NSFontAttributeName:commentFont}]];
            
            _dateTimeLabel.attributedText = text;
        }
        
        _statusLabel.text = dataDetail[statusName];
        _statusLabel.textColor = CDZColorOfRed;
        _statusLabel.backgroundColor = CDZColorOfClearColor;
        if (dataDetail[@"color"]) {
            _statusLabel.backgroundColor = [SupportingClass colorWithHexString:dataDetail[@"color"]];
        }
        
        
        _lineOneLabel.attributedText = nil;
        _lineTwoLabel.attributedText = nil;
        _lineThreeLabel.attributedText = nil;
        _lineFourLabel.attributedText = nil;
        
        if (lineOneStrKey) {
            BOOL isClearing = (statusType==CDZMaintenanceStatusTypeOfHasBeenClearing);
            NSString *title = getLocalizationString(isClearing?@"mycar_number_with_symbol":@"repair_shop_with_symbol");
            
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:title
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:boldFont15}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:dataDetail[lineOneStrKey]
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                       NSFontAttributeName:boldFont15}]];
            
            [_lineOneLabel setAttributedText:text];
        }
        
        if (lineTwoStrKey) {
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString: getLocalizationString(@"mycar_number_with_symbol")
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:boldFont15}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:dataDetail[lineTwoStrKey]
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                       NSFontAttributeName:boldFont15}]];
            
            [_lineTwoLabel setAttributedText:text];
        }
        
        if (lineThreeStrKey) {
            
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:getLocalizationString(@"repair_item_with_symbol")
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:boldFont15}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:dataDetail[lineThreeStrKey]
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                       NSFontAttributeName:boldFont15}]];
            
            [_lineThreeLabel setAttributedText:text];
        }
        
        if (lineFourStrKey) {
            BOOL isAppointment = (statusType==CDZMaintenanceStatusTypeOfAppointment);
            NSString *title = getLocalizationString(isAppointment?@"repair_technician_with_symbol":@"diagnosis_fee");
            NSString *content = dataDetail[lineFourStrKey];
            if (!isAppointment) {
                content = [@"¥" stringByAppendingString:dataDetail[lineFourStrKey]];
            }
            NSMutableAttributedString* text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:title
                                          attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                       NSFontAttributeName:boldFont15}]];
            [text appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:content
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                       NSFontAttributeName:boldFont15}]];
            
            [_lineFourLabel setAttributedText:text];
        }
    }
}

@end
