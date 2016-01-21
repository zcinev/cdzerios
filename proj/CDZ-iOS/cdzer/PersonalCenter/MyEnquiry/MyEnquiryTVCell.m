//
//  MyEnquiryTVCell.m
//  cdzer
//
//  Created by KEns0n on 3/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight vAdjustByScreenRatio(170.0f)
#define view2ViewSpace vAdjustByScreenRatio(4.0f)
#import "MyEnquiryTVCell.h"
#import "InsetsLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MyEnquiryTVCell ()

@property (nonatomic, strong) UILabel *statusLabel;

@property (nonatomic, strong) UILabel *dateTimeLabel;

@property (nonatomic, strong) UIImageView *productPortraitIV;

@property (nonatomic, strong) InsetsLabel *productNameLabel;

@property (nonatomic, strong) InsetsLabel *userDetailLabel;

@end

@implementation MyEnquiryTVCell

static NSArray * statusList;

- (void)setSeparatorLineWithOrigin:(CGPoint)point width:(CGFloat)width container:(UIView*)view{
    @autoreleasepool {
        if (!view) {
            view = self;
        }
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y, width, vAdjustByScreenRatio(0.5f))];
        [iv setBorderWithColor:nil borderWidth:(0.5f)];
        [view addSubview:iv];
    }
}

- (void)initializationUI {
    
    @autoreleasepool {
        [self setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
        CGFloat remainHeight = vMinHeight-vAdjustByScreenRatio(10.0f);
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vAdjustByScreenRatio(14.0f), 0.0f, vAdjustByScreenRatio(6.0f));
        UIFont *commentFont = [UIFont systemFontOfSize:vAdjustByScreenRatio(13.0f)];
        UIFont *commentBoldFont = [UIFont boldSystemFontOfSize:vAdjustByScreenRatio(13.0f)];

        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect middleViewRect = self.bounds;
        middleViewRect.size.height = vAdjustByScreenRatio(40.0f);
        remainHeight -= CGRectGetHeight(middleViewRect);
        
        UIView *middleView = [[UIView alloc] initWithFrame:middleViewRect];
        [middleView setBackgroundColor:CDZColorOfWhite];
        [self addSubview:middleView];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        NSString *dateTimeTitleString = getLocalizationString(@"enquiry_datetime");
        CGFloat dateTimeWidth = [SupportingClass getStringSizeWithString:dateTimeTitleString
                                                                    font:commentFont
                                                             widthOfView:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(middleViewRect))].width;
        CGRect dateTimeTitleRect = middleViewRect;
        dateTimeTitleRect.origin = CGPointMake(0.0f, 0.0f);
        dateTimeTitleRect.size.width = dateTimeWidth+insetsValue.left+insetsValue.right;
        InsetsLabel *dateTimeTitle = [[InsetsLabel alloc] initWithFrame:dateTimeTitleRect andEdgeInsetsValue:insetsValue];
        [dateTimeTitle setFont:commentFont];
        [dateTimeTitle setText:dateTimeTitleString];
        [dateTimeTitle setTextColor:[UIColor lightGrayColor]];
        [middleView addSubview:dateTimeTitle];
        
        if (!_dateTimeLabel) {
            
            CGRect diaTimeLabelRect = dateTimeTitleRect;
            diaTimeLabelRect.origin.x = CGRectGetMaxX(dateTimeTitleRect);
            diaTimeLabelRect.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(dateTimeTitleRect);
            [self setDateTimeLabel:[[UILabel alloc] initWithFrame:diaTimeLabelRect]];
            [_dateTimeLabel setFont:commentFont];
            [_dateTimeLabel setText:@"2014-12-19 16:21:30"];
            [_dateTimeLabel setTextColor:CDZColorOfBlack];
            [middleView addSubview:_dateTimeLabel];
            
        }
        
        
        if (!_statusLabel) {
            
            CGRect statusLabelRect = CGRectZero;
            statusLabelRect.size = CGSizeMake(vAdjustByScreenRatio(70.0f), vAdjustByScreenRatio(30.0f));
            statusLabelRect.origin.x = CGRectGetWidth(middleViewRect)-insetsValue.left-CGRectGetWidth(statusLabelRect);
            [self setStatusLabel:[[UILabel alloc] initWithFrame:statusLabelRect]];
            [_statusLabel setBackgroundColor:CDZColorOfRed];
            [_statusLabel setTextColor:CDZColorOfWhite];
            [_statusLabel setFont:commentBoldFont];
            [_statusLabel setText:@"测试状态中"];
            [_statusLabel setTextAlignment:NSTextAlignmentCenter];
            [middleView addSubview:_statusLabel];
            [_statusLabel setCenter:CGPointMake(_statusLabel.center.x, CGRectGetHeight(middleViewRect)/2.0f)];
            
        }
        
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect bottomViewRect = middleViewRect;
        bottomViewRect.origin.y = CGRectGetMaxY(middleViewRect);
        bottomViewRect.size.height = remainHeight;
        
        UIView *bottomView = [[UIView alloc] initWithFrame:bottomViewRect];
        [bottomView setBackgroundColor:CDZColorOfWhite];
        [self addSubview:bottomView];
        [self setSeparatorLineWithOrigin:CGPointMake(insetsValue.left, CGRectGetMaxY(middleViewRect))
                                   width:CGRectGetWidth(self.frame)-insetsValue.left*2.0f
                               container:self];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (!_productPortraitIV) {
            CGRect rect = CGRectZero;
            rect.size = CGSizeMake(vAdjustByScreenRatio(70.0f), vAdjustByScreenRatio(70.0f));
            rect.origin.x = insetsValue.left;
            rect.origin.y = vAdjustByScreenRatio(10.0f);
            [self setProductPortraitIV:[[UIImageView alloc] initWithFrame:rect]];
            [_productPortraitIV setImage:[ImageHandler getWhiteLogo]];
            [bottomView addSubview:_productPortraitIV];
        }
        
        
        
        UIFont *boldFont15S = [UIFont boldSystemFontOfSize:vAdjustByScreenRatio(15.0f)];
        if (!_productNameLabel) {
            
            CGRect productNameRect = _productPortraitIV.frame;
            productNameRect.origin.x = CGRectGetMaxX(_productPortraitIV.frame);
            productNameRect.size.width = CGRectGetWidth(bottomViewRect)-CGRectGetMaxX(_productPortraitIV.frame);
            UIEdgeInsets titleInsets = insetsValue;
            titleInsets.right = insetsValue.left;
            [self setProductNameLabel:[[InsetsLabel alloc] initWithFrame:productNameRect andEdgeInsetsValue:titleInsets]];
            [_productNameLabel setFont:boldFont15S];
            [_productNameLabel setText:@""];
            [_productNameLabel setTextColor:CDZColorOfBlack];
            [_productNameLabel setNumberOfLines:0];
            [bottomView addSubview:_productNameLabel];
        }
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        if (!_userDetailLabel) {
            
            NSMutableAttributedString *tpString = [NSMutableAttributedString new];
            
            [tpString appendAttributedString:[[NSAttributedString alloc]
                                                   initWithString:getLocalizationString(@"order_total_amount")
                                                   attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                                                }]];
            [tpString appendAttributedString:[[NSAttributedString alloc]
                                                   initWithString:@"¥55.00"
                                                   attributes:@{NSForegroundColorAttributeName:CDZColorOfRed
                                                                }]];
            
            CGRect totalPriceLabelRect = bottomView.bounds;
            totalPriceLabelRect.origin.y = CGRectGetMaxY(_productPortraitIV.frame);
            totalPriceLabelRect.size.height = CGRectGetHeight(bottomViewRect)-CGRectGetMaxY(_productPortraitIV.frame);
            UIEdgeInsets newInsets = insetsValue;
            newInsets.right = insetsValue.left;
            
            [self setUserDetailLabel:[[InsetsLabel alloc] initWithFrame:totalPriceLabelRect andEdgeInsetsValue:newInsets]];
            [_userDetailLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)]];
            [_userDetailLabel setAttributedText:tpString];
            [_userDetailLabel setTextAlignment:NSTextAlignmentRight];
            [_userDetailLabel setNumberOfLines:0];
            [bottomView addSubview:_userDetailLabel];
            
        }
        [self setSeparatorLineWithOrigin:CGPointMake(CGRectGetMinX(_productNameLabel.frame)+insetsValue.left,
                                                     CGRectGetMaxY(_productPortraitIV.frame))
                                   width:CGRectGetWidth(bottomView.frame)-insetsValue.left*2.0f-CGRectGetMinX(_productNameLabel.frame)
                               container:bottomView];
    }
}

- (void)updateUIDataWith:(NSDictionary *)dataDetail {
//    "id": "15052215060780775102",
//    "inquirer": "孙凡",
//    "product_id": "14112515073325712198",
//    "tel": "15580067620",
//    "product_name": "节气门",
//    "state": "14111810300445017246",
//    "add_time": "2015-05-22 15:06:07 ",
//    "state_name": "未回复",
//    "imgurl": "http://www.cdzer.com/imgUpload/uploads/20150127142507e6uMU23plA.png"
    
    @autoreleasepool {
        _dateTimeLabel.text = dataDetail[@"add_time"];
        
        _productNameLabel.text = dataDetail[@"product_name"];

        if (dataDetail[@"imgurl"]&&[dataDetail[@"imgurl"] rangeOfString:@"http"].location!=NSNotFound) {
            
            [_productPortraitIV sd_setImageWithURL:[NSURL URLWithString:dataDetail[@"product_img"]] placeholderImage:[ImageHandler getWhiteLogo]];
        }
        
        _userDetailLabel.text = [NSString stringWithFormat:@"%@\n%@", dataDetail[@"inquirer"], dataDetail[@"tel"]];
        
        _statusLabel.text = dataDetail[@"state_name"];
        _statusLabel.textColor = CDZColorOfRed;
        _statusLabel.backgroundColor = CDZColorOfClearColor;
        if (dataDetail[@"color"]) {
            _statusLabel.backgroundColor = [SupportingClass colorWithHexString:dataDetail[@"color"]];
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
