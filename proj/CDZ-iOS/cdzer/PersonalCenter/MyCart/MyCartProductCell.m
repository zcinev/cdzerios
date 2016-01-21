//
//  MyCartProductCell.m
//  cdzer
//
//  Created by KEns0n on 3/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight 180.0f
#define view2ViewSpace 4.0f
#import "MyCartProductCell.h"
#import "InsetsLabel.h"
#import "CheckBoxBtn.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MyCartProductCell ()

@property (nonatomic) SEL selector;

@property (nonatomic) id target;

@property (nonatomic, strong) UIImageView *productPortraitIV;

@property (nonatomic, strong) InsetsLabel *productNameLabel;

@property (nonatomic, strong) InsetsLabel *productCenterLabel;

@property (nonatomic, strong) InsetsLabel *productPriceWithQuantityLabel;

@end

@implementation MyCartProductCell

static NSArray * statusList;

//- (void)willTransitionToState:(UITableViewCellStateMask)state {
//    UITableViewCellSelectionStyle selectionStyle = (state==UITableViewCellStateShowingEditControlMask)?UITableViewCellSelectionStyleGray:UITableViewCellSelectionStyleNone;
//    [self setSelectionStyle:selectionStyle];
//}
//
//- (void)didTransitionToState:(UITableViewCellStateMask)state {
//    UITableViewCellSelectionStyle selectionStyle =  (state==UITableViewCellStateShowingEditControlMask)?UITableViewCellSelectionStyleGray:UITableViewCellSelectionStyleNone;
//    [self setSelectionStyle:selectionStyle];
//}

- (void)selectionAction {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:self];
    [self.target performSelector:self.selector withObject:indexPath afterDelay:0];
}

- (void)cellDetailAction:(SEL)selector target:(id)target {
    [self setTarget:target];
    [self setSelector:selector];
}

- (void)setSeparatorLineWithOrigin:(CGPoint)point width:(CGFloat)width container:(UIView*)view {
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
        [self.contentView setFrame:self.bounds];
        
        CGRect leftViewRect = CGRectZero;
        leftViewRect.size = CGSizeMake(36.0f, remainHeight);
        
        UIView *leftView = [[UIView alloc] initWithFrame:leftViewRect];
        [leftView setBackgroundColor:CDZColorOfWhite];
        [self.contentView addSubview:leftView];
        
        
        if (!_checkBtn) {
            
            CGRect checkBtnRect = leftView.bounds;
            self.checkBtn = [CheckBoxBtn buttonWithType:UIButtonTypeCustom];
            [_checkBtn setFrame:checkBtnRect];
            [_checkBtn setSelected:NO];
            [_checkBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [_checkBtn setUserInteractionEnabled:NO];
            [leftView addSubview:_checkBtn];
        }
      
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect rightViewRect = leftView.bounds;
        rightViewRect.origin.x = CGRectGetMaxX(leftViewRect);
        rightViewRect.size.width = CGRectGetWidth(self.frame)-CGRectGetMinX(rightViewRect);
        
        UIControl *rightView = [[UIControl alloc] initWithFrame:rightViewRect];
        [rightView setBackgroundColor:CDZColorOfWhite];
        [rightView addTarget:self action:@selector(selectionAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:rightView];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (!_productPortraitIV) {
            CGRect rect = CGRectZero;
            rect.size = CGSizeMake(vAdjustByScreenRatio(70.0f), vAdjustByScreenRatio(70.0f));
            rect.origin.x = insetsValue.left;
            rect.origin.y = vAdjustByScreenRatio(20.0f);
            self.productPortraitIV = [[UIImageView alloc] initWithFrame:rect];
            [_productPortraitIV setImage:[ImageHandler getWhiteLogo]];
            [rightView addSubview:_productPortraitIV];
        }
        UIFont *boldFont14S = systemFontBold(14.0f);
    
        if (!_productNameLabel) {
            
            CGRect productNameRect = CGRectZero;
            productNameRect.origin.y = 10.0f;
            productNameRect.origin.x = CGRectGetMaxX(_productPortraitIV.frame);
            productNameRect.size.width = CGRectGetWidth(rightViewRect)-CGRectGetMaxX(_productPortraitIV.frame);
            productNameRect.size.height = CGRectGetHeight(_productPortraitIV.frame)/2.0f+40;
            UIEdgeInsets titleInsets = insetsValue;
            titleInsets.right = insetsValue.left;
            
            
            NSString *storeTitleString = @"Castrol嘉实多 GTX 金嘉护矿机油/润滑油 SN级别 10W-40 1L装";
            
            self.productNameLabel = [[InsetsLabel alloc] initWithFrame:productNameRect andEdgeInsetsValue:titleInsets];
            [_productNameLabel setFont:boldFont14S];
            [_productNameLabel setText:storeTitleString];
            [_productNameLabel setTextColor:CDZColorOfBlack];
            [_productNameLabel setNumberOfLines:0];
            [rightView addSubview:_productNameLabel];
        }
        
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        UIEdgeInsets bottomInsetsValue = insetsValue;
        bottomInsetsValue.right = bottomInsetsValue.left;
        if (!_productCenterLabel) {
            CGRect repairFeeRect = CGRectZero;
            repairFeeRect.origin.y = CGRectGetMaxY(_productPortraitIV.frame)+30.0f;
            repairFeeRect.size.width = CGRectGetWidth(rightView.frame);
            repairFeeRect.size.height = 40.0f;
            
            self.productCenterLabel = [[InsetsLabel alloc] initWithFrame:repairFeeRect andEdgeInsetsValue:bottomInsetsValue];
            [_productCenterLabel setText:@"¥0.00"];
            [_productCenterLabel setFont: systemFontBold(15.0f)];
            [_productCenterLabel setTextColor:CDZColorOfDeepGray];
            [_productCenterLabel setNumberOfLines:0];
            [rightView addSubview:_productCenterLabel];
        }
        
        if (!_productPriceWithQuantityLabel) {
            UIFont *boldFont15S = systemFontBold(15.0f);
            NSMutableAttributedString* message = [NSMutableAttributedString new];
            [message appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:getLocalizationString(@"quantity")
                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray,
                                                          NSFontAttributeName:boldFont15S
                                                          }]];
            [message appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:@"0"
                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                          NSFontAttributeName:boldFont15S
                                                          }]];
            CGFloat height = [SupportingClass getAttributedStringSizeWithString:message widthOfView:CGSizeMake(CGRectGetWidth(rightView.frame), CGFLOAT_MAX)].height;
            CGRect repairFeeRect = CGRectZero;
            repairFeeRect.size.width = CGRectGetWidth(rightView.frame);
            repairFeeRect.size.height = 17.0f;;
            repairFeeRect.origin.y = CGRectGetMaxY(_productNameLabel.frame);
            
            self.productPriceWithQuantityLabel = [[InsetsLabel alloc] initWithFrame:repairFeeRect andEdgeInsetsValue:bottomInsetsValue];
            [_productPriceWithQuantityLabel setAttributedText:message];
            [_productPriceWithQuantityLabel setNumberOfLines:0];
            [_productPriceWithQuantityLabel setTextAlignment:NSTextAlignmentRight];
            [rightView addSubview:_productPriceWithQuantityLabel];
        }
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
    }
}

- (void)updateUIDataWith:(NSDictionary *)dataDetail {
//    "id": "15052216383392443151",
//    "shopId": "15033110055682653471",
//    "shopname": "配件商测试2",
//    "productId": "PD150331102033162271",
//    "productName": "超级发动机",
//    "productImg": "http://he.bccar.net:80/imgUpload/demo/common/product/150331102014wnhn4NMtAS.jpg",
//    "tprice": "665.0",
//    "sprice": "699.0",
//    "buyCount": "1",
//    "subTotal": "665.0",
//    "addTime": "2015-05-22 16:38:33 ",
//    "status": "1",
//    "productType": "配件",
//    "scale": "0.1",
//    "userId": "15033109481363078108"
    [_productPortraitIV setImage:[ImageHandler getWhiteLogo]];
    if (!dataDetail) return;
    
    @autoreleasepool {
        UIFont *boldFont15S = systemFontBold(15.0f);
        NSMutableAttributedString* message = [NSMutableAttributedString new];
        [message appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:[@"¥" stringByAppendingString:dataDetail[@"tprice"]]
                                         attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                      NSFontAttributeName:boldFont15S
                                                      }]];
        [message appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:[@"     x " stringByAppendingString:dataDetail[@"buyCount"]]
                                         attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                      NSFontAttributeName:boldFont15S
                                                      }]];
        _productPriceWithQuantityLabel.attributedText = message;
                                  
        _productNameLabel.text = [NSString stringWithFormat:@"%@\n类型：%@", dataDetail[@"productName"], dataDetail[@"productType"]];
        
        _productCenterLabel.text = [dataDetail[@"provinceName"] stringByAppendingFormat:@"%@\n供应商：%@", dataDetail[@"centerName"], dataDetail[@"shopname"]];
        
        if (dataDetail[@"productImg"]&&[dataDetail[@"productImg"] rangeOfString:@"http"].location!=NSNotFound) {
            [_productPortraitIV sd_setImageWithURL:[NSURL URLWithString:dataDetail[@"productImg"]] placeholderImage:[ImageHandler getWhiteLogo]];
        }
    }
    
    
}
@end
