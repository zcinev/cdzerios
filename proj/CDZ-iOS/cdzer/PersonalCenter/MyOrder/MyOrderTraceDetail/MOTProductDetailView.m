//
//  MOTProductDetailView.m
//  cdzer
//
//  Created by KEns0n on 3/31/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight vAdjustByScreenRatio(90.0f)
#define topMargin vAdjustByScreenRatio(10.0f)
#define leftMargin vAdjustByScreenRatio(10.0f)

#import "InsetsLabel.h"
#import "MOTProductDetailView.h"

@implementation MOTProductDetailView

- (void)initializationUIWithDetailInfo:(NSDictionary *)detailInfo {
    @autoreleasepool {
        
        if (!detailInfo) return;
        [self setBorderWithColor:nil borderWidth:(0.5f)];
        [self setBackgroundColor:CDZColorOfWhite];
        
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vAdjustByScreenRatio(18.0f), 0.0f, 0.0f);
        CGRect portraitRect = CGRectZero;
        portraitRect.origin.y = topMargin;
        portraitRect.size = CGSizeMake(vAdjustByScreenRatio(70.0f), vAdjustByScreenRatio(70.0f));
        portraitRect.origin.x = insetsValue.left;
        UIImageView *productPortraitIV = [[UIImageView alloc] initWithFrame:portraitRect];
        [productPortraitIV setBackgroundColor:[UIColor blackColor]];
        [self addSubview:productPortraitIV];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        UIFont *boldFont14S = systemFontBold(14.0f);
        UIEdgeInsets titleInsets = UIEdgeInsetsMake(0.0f, vAdjustByScreenRatio(10.0f), 0.0f, insetsValue.left);
        CGRect productNameRect = productPortraitIV.frame;
        productNameRect.origin.x = CGRectGetMaxX(productPortraitIV.frame);
        productNameRect.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(productPortraitIV.frame);
        productNameRect.size.height = CGRectGetHeight(productPortraitIV.frame)/2.0f;
        NSString *storeTitleString = @"Castrol嘉实多 GTX 金嘉护矿机油/润滑油 SN级别 10W-40 1L装";
        CGSize textSize = [SupportingClass getStringSizeWithString:storeTitleString
                                                              font:boldFont14S
                                                       widthOfView:CGSizeMake(CGRectGetWidth(productNameRect)-titleInsets.right-titleInsets.left,
                                                                              CGFLOAT_MAX)];
        productNameRect.size.height = textSize.height;
        
        
        InsetsLabel *productNameLabel = [[InsetsLabel alloc] initWithFrame:productNameRect andEdgeInsetsValue:titleInsets];
        [productNameLabel setFont:boldFont14S];
        [productNameLabel setText:storeTitleString];
        [productNameLabel setTextColor:CDZColorOfBlack];
        [productNameLabel setNumberOfLines:0];
        [self addSubview:productNameLabel];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        UIFont *boldFont16S = systemFontBold(16.0f);
        NSString *priceTitleString = getLocalizationString(@"product_fee");
        CGSize priceTitleSize = [SupportingClass getStringSizeWithString:priceTitleString
                                                                      font:boldFont16S
                                                               widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        CGRect priceTitleRect = productNameRect;
        priceTitleRect.origin.y = CGRectGetMaxY(productNameRect);
        priceTitleRect.size.width = priceTitleSize.width+titleInsets.left;
        InsetsLabel *priceTitleLabel = [[InsetsLabel alloc] initWithFrame:priceTitleRect andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, titleInsets.left,
                                                                                                                    0.0f, 0.0f)];
        [priceTitleLabel setFont:boldFont16S];
        [priceTitleLabel setText:priceTitleString];
        [priceTitleLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:priceTitleLabel];
        
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        NSString *repairFeeString = @"¥55.00";
        CGFloat repairFeeWidth = [SupportingClass getStringSizeWithString:repairFeeString
                                                                     font:boldFont16S
                                                              widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        CGRect repairFeeRect = priceTitleRect;
        repairFeeRect.origin.x = CGRectGetMaxX(priceTitleRect);
        repairFeeRect.size.width = repairFeeWidth;
        
        UILabel *productPriceLabel = [[UILabel alloc] initWithFrame:repairFeeRect];
        [productPriceLabel setFont:boldFont16S];
        [productPriceLabel setText:repairFeeString];
        [productPriceLabel setTextColor:CDZColorOfRed];
        [productPriceLabel setNumberOfLines:0];
        [self addSubview:productPriceLabel];
        
    }
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
