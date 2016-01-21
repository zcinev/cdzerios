//
//  PartsStoreResultCell.m
//  cdzer
//
//  Created by KEns0n on 3/10/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeigth vAdjustByScreenRatio(130.0f)

#import "PartsStoreResultCell.h"
#import "InsetsLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PartsStoreResultCell ()

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) InsetsLabel *partsStoreLabel;

@property (nonatomic, strong) InsetsLabel *itemTitleLabel;

@property (nonatomic, strong) InsetsLabel *quantityLabel;

@property (nonatomic, strong) InsetsLabel *commentLabel;

@property (nonatomic, strong) InsetsLabel *priceLabel;

@property (nonatomic, strong) HCSStarRatingView *starRatingView;

@end

@implementation PartsStoreResultCell

- (void)initializationUI {
    @autoreleasepool {
        [self setBackgroundColor:CDZColorOfWhite];
        UIColor *commonTextColor = [UIColor colorWithRed:0.353f green:0.345f blue:0.349f alpha:1.00f];
        UIEdgeInsets insetValueForRight = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 10.0f);
        UIEdgeInsets insetValueForLeft = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
        
        if (!_logoImageView) {
            CGRect rect = CGRectZero;
            rect.size = CGSizeMake(vAdjustByScreenRatio(70.0f), vAdjustByScreenRatio(70.0f));
            rect.origin = CGPointMake(vAdjustByScreenRatio(10.0f), vAdjustByScreenRatio(7.0f));
            [self setLogoImageView:[[UIImageView alloc] initWithFrame:rect]];
            [_logoImageView setImage:[ImageHandler getWhiteLogo]];
            [self addSubview:_logoImageView];
        }
        
        if (!_itemTitleLabel) {
            CGRect rect = self.bounds;
            rect.origin.x = CGRectGetMaxX(_logoImageView.frame)+vAdjustByScreenRatio(10.0f);
            rect.origin.y = CGRectGetMinY(_logoImageView.frame);
            rect.size.width -= CGRectGetMinX(rect);
            rect.size.height = CGRectGetHeight(_logoImageView.frame)*0.7f;
            [self setItemTitleLabel:[[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueForRight]];
            [_itemTitleLabel setText:@""];
            [_itemTitleLabel setNumberOfLines:0];
            [_itemTitleLabel setFont:systemFontBold(16.0f)];
            [self addSubview:_itemTitleLabel];
        }
        
        if (!_starRatingView) {
            CGRect rect = CGRectZero;
            rect.origin.x = CGRectGetMinX(_itemTitleLabel.frame);
            rect.origin.y = CGRectGetMaxY(_itemTitleLabel.frame);
            rect.size = CGSizeMake(CGRectGetWidth(_itemTitleLabel.frame)*0.4f, CGRectGetHeight(_logoImageView.frame)*0.3f);
            [self setStarRatingView:[[HCSStarRatingView alloc] initWithFrame:rect]];
            [_starRatingView setAllowsHalfStars:YES];
            [_starRatingView setMaximumValue:5.0f];
            [_starRatingView setMinimumValue:0.0f];
            [_starRatingView setValue:3.0f];
            [_starRatingView setTintColor:[UIColor redColor]];
            [_starRatingView setUserInteractionEnabled:NO];
            [self addSubview:_starRatingView];
        }
        
        if (!_priceLabel) {
            CGRect rect = _starRatingView.frame;
            rect.size.width = CGRectGetWidth(_itemTitleLabel.frame)*0.6f;
            rect.origin.x = CGRectGetMaxX(_starRatingView.frame);
            [self setPriceLabel:[[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueForRight]];
            [_priceLabel setTextColor:[UIColor redColor]];
            [_priceLabel setFont:systemFontBold(15.0f)];
            [_priceLabel setNumberOfLines:-1];
            [_priceLabel setTextAlignment:NSTextAlignmentRight];
            [self addSubview:_priceLabel];
        }


        if (!_commentLabel) {
            CGRect rect = CGRectZero;
            rect.origin.y = CGRectGetMaxY(_logoImageView.frame)+vAdjustByScreenRatio(5.0f);
            rect.size = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(_logoImageView.frame)*0.25f);
            [self setCommentLabel:[[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueForLeft]];
            [_commentLabel setText:@""];
            [_commentLabel setTextColor:commonTextColor];
            [_commentLabel setTextAlignment:NSTextAlignmentLeft];
            [_commentLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(15.0f)]];
            [self addSubview:_commentLabel];
            
        }

        if (!_partsStoreLabel) {
            CGRect rect = self.bounds;
            rect.size.height = vAdjustByScreenRatio(30.0f);
            rect.origin.y = vMinHeigth-CGRectGetHeight(rect);
            [self setPartsStoreLabel:[[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueForLeft]];
            [_partsStoreLabel setText:@""];
            [_partsStoreLabel setTextColor:commonTextColor];
            [_partsStoreLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(15.0f)]];
            [self addSubview:_partsStoreLabel];
        }


        if (!_quantityLabel) {
            CGRect rect = _partsStoreLabel.frame;
            [self setQuantityLabel:[[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueForRight]];
            [_quantityLabel setText:@""];
            [_quantityLabel setTextColor:commonTextColor];
            [_quantityLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(15.0f)]];
            [_quantityLabel setTextAlignment:NSTextAlignmentRight];
            [self addSubview:_quantityLabel];
        }


    }
}

- (void)setTextPartsStoreLabel:(NSString *)partsStore {
    _partsStoreLabel.text = [@"供应商：" stringByAppendingString:partsStore];
}

- (void)setPriceLabelText:(id)priceValue andIsPriceEnquiry:(id)isPriceEnquiry{
    
    if (!isPriceEnquiry||[isPriceEnquiry boolValue]) {
        
        NSString *price = @"0";
        if ([priceValue isKindOfClass:[NSNumber class]]) {
            price = [priceValue stringValue];
        }else if ([priceValue isKindOfClass:[NSString class]]) {
            if(![priceValue isEqualToString:@""]) price = priceValue;
        }
        
        @autoreleasepool {
            [_priceLabel setText:[@"价格：¥" stringByAppendingString:price]];
        }
    }else {
        [_priceLabel setText:@"询价"];
    }
}

- (void)setCommentLabelText:(id)commentValue {
    NSString *comment = @"0";
    if ([commentValue isKindOfClass:[NSNumber class]]) {
        comment = [commentValue stringValue];
    }else if ([commentValue isKindOfClass:[NSString class]]) {
        comment = commentValue;
    }
    _commentLabel.text = [NSString stringWithFormat:@"（评论人数：%@）",comment];
}

- (void)setLogoImageViewText:(NSString *)theURLString {
    if ([theURLString isEqualToString:@""]||!theURLString||[theURLString rangeOfString:@"http"].location==NSNotFound) {
        _logoImageView.image = [ImageHandler getWhiteLogo];
    }else {
        [_logoImageView sd_setImageWithURL:[NSURL URLWithString:theURLString] placeholderImage:[ImageHandler getWhiteLogo]];
    }
    
}

- (void)setQuantityLabelText:(id)quantityValue {
    NSString *quantity = @"0";
    if ([quantityValue isKindOfClass:[NSNumber class]]) {
        quantity = [quantityValue stringValue];
    }else if ([quantityValue isKindOfClass:[NSString class]]) {
        quantity = quantityValue;
    }
    _quantityLabel.text = [@"数量：" stringByAppendingString:quantity];
}

- (void)setitemTitleLabelText:(NSString *)storeTitle {
    _itemTitleLabel.text = storeTitle;
}

- (void)setStarValue:(id)starValue {
    if ([starValue isKindOfClass:[NSNumber class]]) {
        _starRatingView.value = [starValue floatValue]/5.0f;
    }else if ([starValue isKindOfClass:[NSString class]]) {
        if ([starValue isEqualToString:@""]) {
            _starRatingView.value = 0.0f;
        }else {
            _starRatingView.value = [starValue floatValue]*5.0f;
        }
    }
}

- (void)setUIDataWithDetailData:(NSDictionary *)dataDetail {
    if (!dataDetail) return;
    @autoreleasepool {
        
//        @"address"
//        @"member_hoursprice"
//        @"distance"
//        @"user_shop_logo"
//        @"user_kind_name"
//        @"wxs_name"
//        @"star"
//        @"id"
//        @"lat"
//        @"lng"
//        @"major_brand"
//        @"service_time"
//        @"state"
//        @"state_name"
//        @"user_id"
//        @"user_kind_id"
//        @"user_province"
//        @"user_region"
//        @"usercity"
//        @"wxs_telphone"
        
//        addtime = "2015-03-31 10:28:43";
//        "comment_size" = 0;
//        factory = 15033110185678601620;
//        "factory_name" = "\U5cb3\U9e93\U533a\U751f\U4ea7\U5546";
//        id = 15033110284317800115;
//        image = "http://he.bccar.net:80/imgUpload/demo/common/product/1503311028177SGXnCguuA.gif";
//        memberprice = 739;
//        name = "\U53d8\U901f\U5668\U65e0\U654c\U7248";
//        number = PD150331102843566717;
//        star = 1;
//        stocknum = 888;
        [self setQuantityLabelText:dataDetail[@"stocknum"]];
        [self setStarValue:dataDetail[@"star"]];
        
        
        
        [self setPriceLabelText:dataDetail[@"memberprice"] andIsPriceEnquiry:dataDetail[@"no_yes"]];
        [self setTextPartsStoreLabel:dataDetail[@"factory_name"]];
        [self setLogoImageViewText:dataDetail[@"image"]];
        [self setitemTitleLabelText:dataDetail[@"name"]];
        if ([dataDetail[@"comment_size"] isKindOfClass:NSNumber.class]) {
            [self setCommentLabelText:[dataDetail[@"comment_size"] stringValue]];
        }else {
            [self setCommentLabelText:dataDetail[@"comment_size"]];
        }

    }
}

@end
