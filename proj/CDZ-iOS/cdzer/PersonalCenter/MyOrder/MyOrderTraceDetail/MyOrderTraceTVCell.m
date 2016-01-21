//
//  MyOrderTraceTVCell.m
//  cdzer
//
//  Created by KEns0n on 3/31/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vTopMargin vAdjustByScreenRatio(10.0f)
#define vLeftMargin vAdjustByScreenRatio(16.0f)
#define vContenLeftMargin vAdjustByScreenRatio(36.0f)
#define vDefaultFontSize vAdjustByScreenRatio(16.0f)
#define vDefaultTimeFontSize vAdjustByScreenRatio(14.0f)

#import "MyOrderTraceTVCell.h"
#import "InsetsLabel.h"

@interface MyOrderTraceTVCell ()

@end

@implementation MyOrderTraceTVCell

+ (CGFloat)getContentStringHeight:(NSString *)textString isLastCell:(BOOL)isLastCell{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds)-vContenLeftMargin-vLeftMargin;
    CGSize contentSize = [SupportingClass getStringSizeWithString:textString font:systemFont(vDefaultFontSize) widthOfView:CGSizeMake(width, CGFLOAT_MAX)];
    CGSize timeSize = [SupportingClass getStringSizeWithString:@"预计真实时间：2015-03-24 14:20:35" font:systemFont(vDefaultTimeFontSize) widthOfView:CGSizeMake(width, CGFLOAT_MAX)];
    CGFloat totalHeight = ceil(timeSize.height)+ceil(contentSize.height)+vTopMargin+(isLastCell?vTopMargin:0.0f);
    return totalHeight;
}

- (void)initializationUIWithDetail:(NSDictionary *)detailInfo {

    
    @autoreleasepool {
        BOOL isCurrentPoint = [[detailInfo objectForKey:@"is_current_point"] boolValue];
        BOOL isPassed = [[detailInfo objectForKey:@"is_passed"] boolValue];
        UIColor *statusColor = isCurrentPoint?CDZColorOfDefaultColor:(isPassed?[UIColor colorWithRed:0.439f green:0.443f blue:0.459f alpha:1.00f]:CDZColorOfBlack);
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vContenLeftMargin, 0.0f, vLeftMargin);
        UIFont *font = systemFont(vDefaultFontSize);
        UIFont *timeFont = systemFont(vDefaultTimeFontSize);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        if (!_contentLabel) {
            [self setContentLabel:[[InsetsLabel alloc] initWithInsets:insetsValue]];
            [_contentLabel setFrame:self.bounds];
            [_contentLabel setFont:font];
            [_contentLabel setBackgroundColor:CDZColorOfClearColor];
            [_contentLabel setNumberOfLines:0];
            [self addSubview:_contentLabel];
        }
        NSString *contentString = [detailInfo objectForKey:@"description"];
        CGRect contentLabelRect = self.bounds;
        contentLabelRect.origin.y = vTopMargin;
        contentLabelRect.size.height = [SupportingClass getStringSizeWithString:contentString
                                                                           font:font
                                                                    widthOfView:CGSizeMake(CGRectGetWidth(contentLabelRect),
                                                                                           CGFLOAT_MAX)].height;
        [_contentLabel setFrame:contentLabelRect];
        [_contentLabel setTextColor:statusColor];
        [_contentLabel setText:contentString];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        if (!_dateTimeLabel) {
            [self setDateTimeLabel:[[InsetsLabel alloc] initWithInsets:insetsValue]];
            [_dateTimeLabel setFrame:self.bounds];
            [_dateTimeLabel setFont:timeFont];
            [_dateTimeLabel setBackgroundColor:CDZColorOfClearColor];
            [_dateTimeLabel setNumberOfLines:0];
            [self addSubview:_dateTimeLabel];
        }
        
        NSString *dateTimeString = [getLocalizationString(@"eta") stringByAppendingString:[detailInfo objectForKey:@"eta"]];
        if (isPassed) {
            dateTimeString = [getLocalizationString(@"ata") stringByAppendingString:[detailInfo objectForKey:@"ata"]];
        }
        CGRect dateTimeLabelRect = self.bounds;
        dateTimeLabelRect.origin.y = CGRectGetMaxY(contentLabelRect);
        dateTimeLabelRect.size.height = [SupportingClass getStringSizeWithString:dateTimeString
                                                                           font:timeFont
                                                                    widthOfView:CGSizeMake(CGRectGetWidth(contentLabelRect),
                                                                                           CGFLOAT_MAX)].height;
        [_dateTimeLabel setFrame:dateTimeLabelRect];
        [_dateTimeLabel setTextColor:[UIColor colorWithRed:0.659f green:0.659f blue:0.659f alpha:1.00f]];
        [_dateTimeLabel setText:dateTimeString];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        if (!_criceImageView) {
            [self setCriceImageView:[UIImageView new]];
            [_criceImageView setBackgroundColor:CDZColorOfClearColor];
            [_criceImageView.layer setMasksToBounds:YES];
            [self addSubview:_criceImageView];
        }
        
        CGRect criceIVRect = contentLabelRect;
        CGSize dummySize = [SupportingClass getStringSizeWithString:@"测试"
                                                               font:font
                                                        widthOfView:CGSizeMake(CGRectGetWidth(contentLabelRect),
                                                                               CGFLOAT_MAX)];
        criceIVRect.size = CGSizeMake(dummySize.height/3*2, dummySize.height/3.0f*2.0f);
        [_criceImageView setFrame:criceIVRect];
        [_criceImageView setCenter:CGPointMake(vContenLeftMargin/3.0f*2.0f, dummySize.height/2.0f+vTopMargin)];
        [_criceImageView setBorderWithColor:statusColor borderWidth:3.0f];
        [_criceImageView.layer setCornerRadius:CGRectGetHeight(criceIVRect)/2.0f];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
