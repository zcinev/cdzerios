//
//  MyCreditCell.m
//  cdzer
//
//  Created by KEns0n on 6/19/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight 100.0f
#import "MyCreditCell.h"
#import "InsetsLabel.h"

@interface MyCreditCell ()

@property (nonatomic, strong) InsetsLabel *costCreditLabel;

@property (nonatomic, strong) InsetsLabel *creditLabel;

@property (nonatomic, strong) InsetsLabel *productNameLabel;

@property (nonatomic, strong) InsetsLabel *productPriceLabel;

@property (nonatomic, strong) InsetsLabel *productTypeLabel;

@property (nonatomic, strong) InsetsLabel *shopNameLabel;

@property (nonatomic, strong) InsetsLabel *dataTimeLabe;

@end

@implementation MyCreditCell

+ (CGFloat)cellHeight {
    return vMinHeight;
}

- (void)initializationUI {
    
    @autoreleasepool {
        UIEdgeInsets insetsValue = DefaultEdgeInsets;
        UIFont *bottomFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
        UIFont *centerFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfThin, 15.0f, NO);
        self.productNameLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.3f)
                                                      andEdgeInsetsValue:insetsValue];
        _productNameLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16.0f, NO);;
        [self.contentView addSubview:_productNameLabel];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        self.productTypeLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_productNameLabel.frame),
                                                                          CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.25f)
                                                     andEdgeInsetsValue:insetsValue];
        _productTypeLabel.font = centerFont;
        [self.contentView addSubview:_productTypeLabel];
        
        self.creditLabel = [[InsetsLabel alloc] initWithFrame:_productTypeLabel.frame
                                                    andEdgeInsetsValue:insetsValue];
        _creditLabel.font = centerFont;
        _creditLabel.textAlignment = NSTextAlignmentRight;
        _creditLabel.textColor = CDZColorOfRed;
        [self.contentView addSubview:_creditLabel];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        self.productPriceLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_productTypeLabel.frame),
                                                                              CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.2f)
                                                         andEdgeInsetsValue:insetsValue];
        _productPriceLabel.font = centerFont;
        [self.contentView addSubview:_productPriceLabel];
        
        self.costCreditLabel = [[InsetsLabel alloc] initWithFrame:_productPriceLabel.frame
                                                    andEdgeInsetsValue:insetsValue];
        _costCreditLabel.font = centerFont;
        _costCreditLabel.textAlignment = NSTextAlignmentRight;
        _costCreditLabel.textColor = CDZColorOfRed;
        [self.contentView addSubview:_costCreditLabel];
        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        self.shopNameLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.frame)*0.75f, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)*0.25f)
                                                      andEdgeInsetsValue:insetsValue];
        _shopNameLabel.font = bottomFont;
        [self.contentView addSubview:_shopNameLabel];
        
        self.dataTimeLabe = [[InsetsLabel alloc] initWithFrame:_shopNameLabel.frame
                                                      andEdgeInsetsValue:insetsValue];
        _dataTimeLabe.font = bottomFont;
        _dataTimeLabe.textAlignment = NSTextAlignmentRight;
        _dataTimeLabe.textColor = CDZColorOfDeepGray;
        [self.contentView addSubview:_dataTimeLabe];
    }
}

- (void)updateUIData:(NSDictionary *)data {
    _productNameLabel.text = [@"订单号："stringByAppendingString:data[@"main_id"]];
    
    _productTypeLabel.text = [@"类型："stringByAppendingString:data[@"type"]];
    
//    _productPriceLabel.text = [@"价格：" stringByAppendingString:data[@"goods_price"]];
    
//    _creditLabel.text = @"4";//[@"积分：" stringByAppendingString:data[@"credits"]];

    _costCreditLabel.text = [@"积分：" stringByAppendingString:data[@"credits"]];
    
//    _shopNameLabel.text = @"6";//data[@"shop_name"];
    
    _dataTimeLabe.text = data[@"add_time"];
    
    
}
@end
