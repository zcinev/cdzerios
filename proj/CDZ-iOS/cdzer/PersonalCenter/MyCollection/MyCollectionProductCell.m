//
//  MyCollectionProductCell.m
//  cdzer
//
//  Created by KEns0n on 3/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight vAdjustByScreenRatio(100.0f)
#define view2ViewSpace vAdjustByScreenRatio(4.0f)
#import "MyCollectionProductCell.h"
#import "InsetsLabel.h"

@interface MyCollectionProductCell ()

@end

@implementation MyCollectionProductCell

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

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    UIColor *backgroundColor = self.productPortraitIV.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    self.productPortraitIV.backgroundColor = backgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UIColor *backgroundColor = self.productPortraitIV.backgroundColor;
    [super setSelected:selected animated:animated];
    self.productPortraitIV.backgroundColor = backgroundColor;
}

- (void)initializationUI {
    
    @autoreleasepool {
        [self setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
        [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
        CGFloat remainHeight = vMinHeight-vAdjustByScreenRatio(10.0f);
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vAdjustByScreenRatio(14.0f), 0.0f, vAdjustByScreenRatio(6.0f));

        

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect bottomViewRect = self.bounds;
        bottomViewRect.size.height = remainHeight;
        
        UIView *bottomView = [[UIView alloc] initWithFrame:bottomViewRect];
        [bottomView setBackgroundColor:CDZColorOfWhite];
        [self.contentView addSubview:bottomView];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (!_productPortraitIV) {
            CGRect rect = CGRectZero;
            rect.size = CGSizeMake(vAdjustByScreenRatio(70.0f), vAdjustByScreenRatio(70.0f));
            rect.origin.x = insetsValue.left;
            rect.origin.y = vAdjustByScreenRatio(10.0f);
            [self setProductPortraitIV:[[UIImageView alloc] initWithFrame:rect]];
            [_productPortraitIV setBackgroundColor:[UIColor blackColor]];
            [bottomView addSubview:_productPortraitIV];
        }
        UIFont *boldFont14S = systemFontBold(14.0f);
        if (!_productNameLabel) {
            
            CGRect productNameRect = _productPortraitIV.frame;
            productNameRect.origin.x = CGRectGetMaxX(_productPortraitIV.frame);
            productNameRect.size.width = CGRectGetWidth(bottomViewRect)-CGRectGetMaxX(_productPortraitIV.frame);
            productNameRect.size.height = CGRectGetHeight(_productPortraitIV.frame)/2.0f;
            UIEdgeInsets titleInsets = insetsValue;
            titleInsets.right = insetsValue.left;
            
            
            NSString *storeTitleString = @"Castrol嘉实多 GTX 金嘉护矿机油/润滑油 SN级别 10W-40 1L装";
            CGSize textSize = [SupportingClass getStringSizeWithString:storeTitleString
                                                                  font:boldFont14S
                                                           widthOfView:CGSizeMake(CGRectGetWidth(productNameRect)-insetsValue.right*2, CGFLOAT_MAX)];
            productNameRect.size.height = textSize.height;
            
            
            [self setProductNameLabel:[[InsetsLabel alloc] initWithFrame:productNameRect andEdgeInsetsValue:titleInsets]];
            [_productNameLabel setFont:boldFont14S];
            [_productNameLabel setText:storeTitleString];
            [_productNameLabel setTextColor:CDZColorOfBlack];
            [_productNameLabel setNumberOfLines:0];
            [bottomView addSubview:_productNameLabel];
        }
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        UIEdgeInsets bottomInsetsValue = insetsValue;
        UIFont *boldFont15S = systemFontBold(15.0f);
        NSString *priceTitleString = getLocalizationString(@"product_fee");
        CGSize priceTitleSize = [SupportingClass getStringSizeWithString:priceTitleString
                                                                   font:boldFont15S
                                                            widthOfView:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(_productNameLabel.frame))];
        CGRect priceTitleRect = _productNameLabel.frame;
        priceTitleRect.origin.y = CGRectGetMaxY(_productNameLabel.frame);
        priceTitleRect.size.width = priceTitleSize.width+insetsValue.left+insetsValue.right;
        
        bottomInsetsValue.top = priceTitleSize.height;
        
        InsetsLabel *priceTitleLabel = [[InsetsLabel alloc] initWithFrame:priceTitleRect andEdgeInsetsValue:bottomInsetsValue];
        [priceTitleLabel setFont:boldFont15S];
        [priceTitleLabel setText:priceTitleString];
        [priceTitleLabel setTextColor:[UIColor lightGrayColor]];
        [bottomView addSubview:priceTitleLabel];
        
        
        if (!_productPriceLabel) {
            NSString *repairFeeString = @"¥55.00";
            CGFloat repairFeeWidth = [SupportingClass getStringSizeWithString:repairFeeString
                                                                          font:boldFont15S
                                                                   widthOfView:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(_productNameLabel.frame))].width;
            
            CGRect repairFeeRect = priceTitleRect;
            repairFeeRect.origin.x = CGRectGetMaxX(priceTitleRect);
            repairFeeRect.size.width = repairFeeWidth;
            
            [self setProductPriceLabel:[[InsetsLabel alloc] initWithFrame:repairFeeRect andEdgeInsetsValue:bottomInsetsValue]];
            [_productPriceLabel setFont:boldFont15S];
            [_productPriceLabel setText:repairFeeString];
            [_productPriceLabel setTextColor:CDZColorOfRed];
            [_productPriceLabel setNumberOfLines:0];
            [bottomView addSubview:_productPriceLabel];
        }
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
    }
}

@end
