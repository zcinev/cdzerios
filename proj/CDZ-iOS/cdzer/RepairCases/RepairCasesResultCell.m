//
//  RepairCasesResultCell.m
//  cdzer
//
//  Created by KEns0n on 6/23/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define normalHeight 24.0f

#import "RepairCasesResultCell.h"
#import "InsetsLabel.h"
@interface RepairCasesResultCell ()

@property (nonatomic, strong) InsetsLabel *userName;

@property (nonatomic, strong) InsetsLabel *dateTime;

@property (nonatomic, strong) InsetsLabel *priceLabel;

@property (nonatomic, strong) InsetsLabel *repairShopName;

@property (nonatomic, strong) InsetsLabel *repairItemName;

@property (nonatomic, strong) InsetsLabel *shopAddress;

@property (nonatomic, strong) UIButton *moreButton;


@end

@implementation RepairCasesResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializationUI];
    }
    return self;
}

- (void)initializationUI {
    // Initialization code
    UIEdgeInsets insetValueLR = DefaultEdgeInsets;
    UIEdgeInsets insetValueL = UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f);
    UIEdgeInsets insetValueR = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 15.0f);
    UIFont *commonFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
    @autoreleasepool {
        if (!_userName) {
            CGRect rect = self.contentView.bounds;
            rect.size.height = normalHeight;
            self.userName = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueLR];
            _userName.text = @"用户：";\
            _userName.font = commonFont;
            [self.contentView addSubview:_userName];
        }
        if (!_dateTime) {
            self.dateTime = [[InsetsLabel alloc] initWithFrame:_userName.frame andEdgeInsetsValue:insetValueLR];
            _dateTime.text = @"2015-06-27 15:42:43";
            _dateTime.textAlignment = NSTextAlignmentRight;
            _dateTime.textColor = CDZColorOfDeepGray;
            _dateTime.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 13.0f, NO);
            [self.contentView addSubview:_dateTime];
        }
        if (!_priceLabel) {
            CGRect rect = _userName.frame;
            rect.origin.y = CGRectGetMaxY(_userName.frame);
            
            NSString *titleString = @"维修费用：";
            CGSize size = [SupportingClass getStringSizeWithString:titleString font:commonFont widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            CGRect titleRect = CGRectZero;
            titleRect.size.width = size.width+insetValueL.left;
            titleRect.size.height = CGRectGetHeight(rect);
            
            
            InsetsLabel *title = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:insetValueL];
            title.textAlignment = NSTextAlignmentRight;
            title.textColor = CDZColorOfDeepGray;
            title.text = titleString;
            title.font = commonFont;
            
            UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, CGRectGetWidth(titleRect), 0.0f, insetValueR.right);
            self.priceLabel = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetsValue];
            _priceLabel.text = @"维修费用：";
            _priceLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
            [self.contentView addSubview:_priceLabel];
            [_priceLabel addSubview:title];
        }
        
        if (!_repairShopName) {
            CGRect rect = self.contentView.bounds;
            rect.origin.y = CGRectGetMaxY(_priceLabel.frame);
            rect.size.height = normalHeight;
            
            NSString *titleString = @"维修商：";
            CGSize size = [SupportingClass getStringSizeWithString:titleString font:commonFont widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            CGRect titleRect = CGRectZero;
            titleRect.size.width = size.width+insetValueL.left;
            titleRect.size.height = CGRectGetHeight(rect);
            
            
            InsetsLabel *title = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:insetValueL];
            title.textAlignment = NSTextAlignmentRight;
            title.textColor = CDZColorOfDeepGray;
            title.text = titleString;
            title.font = commonFont;
            
            UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, CGRectGetWidth(titleRect), 0.0f, insetValueR.right);
            self.repairShopName = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetsValue];
            _repairShopName.text = @"是多哈时代；阿华盛顿；哈大；谁的";
            _repairShopName.font = commonFont;
            _repairShopName.numberOfLines = 0;
            [self.contentView addSubview:_repairShopName];
            [_repairShopName addSubview:title];
        }
        
        
        if (!_shopAddress) {
            CGRect rect = _repairShopName.frame;
            rect.origin.y = CGRectGetMaxY(_repairShopName.frame);
            rect.size.height = normalHeight;
            
            NSString *titleString = @"地址：";
            CGSize size = [SupportingClass getStringSizeWithString:titleString font:commonFont widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            CGRect titleRect = CGRectZero;
            titleRect.size.width = size.width+insetValueL.left;
            titleRect.size.height = CGRectGetHeight(rect);
            
            
            InsetsLabel *title = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:insetValueL];
            title.textColor = CDZColorOfDeepGray;
            title.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            title.translatesAutoresizingMaskIntoConstraints = YES;
            title.text = titleString;
            title.font = commonFont;
            
            UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, CGRectGetWidth(titleRect), 0.0f, insetValueR.right);
            self.shopAddress = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetsValue];
            _shopAddress.text = @"";
            _shopAddress.font = commonFont;
            _shopAddress.numberOfLines = 0;
            [self.contentView addSubview:_shopAddress];
            [_shopAddress addSubview:title];
        }
        
        if (!_repairItemName) {
            CGRect rect = _shopAddress.bounds;
            rect.origin.y = CGRectGetMaxY(_shopAddress.frame);
            rect.size.height = normalHeight*1.2f;
            
            NSString *titleString = @"维修项目：";
            CGSize size = [SupportingClass getStringSizeWithString:titleString font:commonFont widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            CGRect titleRect = CGRectZero;
            titleRect.size.width = size.width+insetValueL.left;
            titleRect.size.height = CGRectGetHeight(rect);
            
            
            InsetsLabel *title = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:insetValueL];
            title.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            title.translatesAutoresizingMaskIntoConstraints = YES;
            title.textColor = CDZColorOfDeepGray;
            title.text = titleString;
            title.font = commonFont;
            
            UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, CGRectGetWidth(titleRect), 0.0f, insetValueR.right);
            self.repairItemName = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetsValue];
            _repairItemName.text = @"是多哈时代；阿华盛顿；哈大；谁的";
            _repairItemName.font = commonFont;
            _repairItemName.numberOfLines = 0;
            [self.contentView addSubview:_repairItemName];
            [_repairItemName addSubview:title];
        }
        
        if(!_moreButton) {
            self.moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
            [self.contentView addSubview:_moreButton];
        }
    }
}


- (void)updateUIDataWithData:(NSDictionary *)dataDetail {
    //    wxs_name: "湖南百城网络科技有限公司",
    //    project: "发动机不能启动，且无着车征兆",
    //    real_name: "小贺",
    //    fee: "295.0",
    //    add_time: "2015-06-16 11:14:32 ",
    //    address: "湖南省长沙市"
    NSString *shopName = dataDetail[@"wxs_name"];
    NSString *priceName = dataDetail[@"fee"];
    NSString *projectName = dataDetail[@"project"];
    NSString *userName = dataDetail[@"real_name"];
    NSString *addressName = dataDetail[@"address"];
    
    _repairShopName.text = shopName;
    _userName.text = [@"用户：" stringByAppendingString:userName];
    _priceLabel.text = [@"¥" stringByAppendingString:priceName];
    _repairItemName.text = projectName;
    _shopAddress.text = addressName;
    
    CGRect itemRect = _repairItemName.frame;
    itemRect.size.height = normalHeight*1.2f;
    CGFloat fullWidth = SCREEN_WIDTH-15.0f*2.0f;
    UIFont *commonFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
    if ([SupportingClass getStringSizeWithString:[@"维修项目：" stringByAppendingString:projectName] font:commonFont widthOfView:CGSizeMake(fullWidth, CGFLOAT_MAX)].height>CGRectGetHeight(itemRect)) {
        itemRect.size.height = normalHeight*1.9f;
    }
    _repairItemName.frame = itemRect;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    NSLog(@"%f", CGRectGetHeight(self.frame));

}

+ (CGFloat)getCellHieght:(NSDictionary *)detail {
    
    UIFont *commonFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
    //        NSString *userName = detail[@"real_name"];
    //        if (!userName) {
    //            userName = @"";
    //        }
    //        userName = [@"用户：" stringByAppendingString:userName];
    //
    //        NSString *priceName = detail[@"fee"];
    //        if (!priceName) {
    //            priceName = @"";
    //        }
    //        priceName = [@"维修费用：" stringByAppendingString:priceName];
    //
    //        NSString *shopName = detail[@"wxs_name"];
    //        if (!shopName) {
    //            shopName = @"";
    //        }
    //        shopName = [@"维修商：" stringByAppendingString:shopName];
    
    NSString *addressName = detail[@"address"];
    if (!addressName) {
        addressName = @"";
    }
    addressName = [@"地址：" stringByAppendingString:addressName];
    
    NSString *projectName = detail[@"project"];
    if (!projectName) {
        projectName = @"";
    }
    projectName = [@"维修项目：" stringByAppendingString:projectName];
    
    CGFloat fullWidth = SCREEN_WIDTH-15.0f*2.0f;
    
    CGFloat userNameHeight = normalHeight;//[SupportingClass getStringSizeWithString:userName font:commonFont widthOfView:CGSizeMake(fullWidth, CGFLOAT_MAX)].height;
    CGFloat priceNameHeight = normalHeight;//[SupportingClass getStringSizeWithString:priceName font:commonFont widthOfView:CGSizeMake(fullWidth, CGFLOAT_MAX)].height;
    CGFloat shopNameHeight = normalHeight;//[SupportingClass getStringSizeWithString:shopName font:commonFont widthOfView:CGSizeMake(fullWidth, CGFLOAT_MAX)].height;
    CGFloat addressNameHeight = normalHeight;//[SupportingClass getStringSizeWithString:addressName font:commonFont widthOfView:CGSizeMake(fullWidth, CGFLOAT_MAX)].height;
    if ([SupportingClass getStringSizeWithString:addressName font:commonFont widthOfView:CGSizeMake(fullWidth, CGFLOAT_MAX)].height>addressNameHeight) {
        addressNameHeight = normalHeight*1.5f;
    }
    CGFloat projectNameHeight = normalHeight*1.2f;//[SupportingClass getStringSizeWithString:projectName font:commonFont widthOfView:CGSizeMake(fullWidth, CGFLOAT_MAX)].height;
    if ([SupportingClass getStringSizeWithString:projectName font:commonFont widthOfView:CGSizeMake(fullWidth, CGFLOAT_MAX)].height>projectNameHeight) {
        projectNameHeight = normalHeight*1.9f;
    }
    
    CGFloat totalHeight = userNameHeight+priceNameHeight+shopNameHeight+addressNameHeight+projectNameHeight;
    return totalHeight;
    return totalHeight;
}

@end
