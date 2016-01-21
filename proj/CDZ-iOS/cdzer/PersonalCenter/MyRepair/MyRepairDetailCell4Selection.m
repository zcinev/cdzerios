//
//  MyRepairDetailCell4Selection.m
//  cdzer
//
//  Created by KEns0n on 6/27/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MyRepairDetailCell4Selection.h"
#import "InsetsLabel.h"
@interface MyRepairDetailCell4Selection ()
@property (nonatomic, strong) InsetsLabel *itemsLabel;

@property (nonatomic, strong) InsetsLabel *itemsTitleLabel;

@property (nonatomic, strong) InsetsLabel *priceLabel;

@property (nonatomic, strong) InsetsLabel *quantityLabel;

@end

@implementation MyRepairDetailCell4Selection

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializationUI];
    }
    return self;
}

- (void)initializationUI {
    @autoreleasepool {
        CGFloat topRatio = 0.65f;
        CGFloat buttomRatio = 1.0f-topRatio;
        
        if (!_itemsLabel) {
            NSString *test = @"配件名称：";
            UIFont *font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 15, NO);
            CGFloat width = [SupportingClass getStringSizeWithString:test font:font widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
            self.itemsTitleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width+15.0f, CGRectGetHeight(self.contentView.frame)*topRatio)
                                                            andEdgeInsetsValue: UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
            _itemsTitleLabel.font = font;
            _itemsTitleLabel.textAlignment = NSTextAlignmentLeft;
            _itemsTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
            _itemsTitleLabel.translatesAutoresizingMaskIntoConstraints = YES;
            _itemsTitleLabel.textColor = UIColor.lightGrayColor;
            [self.contentView addSubview:_itemsTitleLabel];
            
            self.itemsLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame)*topRatio)
                                                       andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, CGRectGetWidth(_itemsTitleLabel.frame), 0.0f, 15.0f)];
            _itemsLabel.font = font;
            _itemsLabel.textAlignment = NSTextAlignmentLeft;
            _itemsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin;
            _itemsLabel.translatesAutoresizingMaskIntoConstraints = YES;
            _itemsLabel.textColor = CDZColorOfBlack;
            _itemsLabel.numberOfLines = 0;
            [self.contentView addSubview:_itemsLabel];
            
            
        }
        if (!_quantityLabel) {
            self.quantityLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_itemsLabel.frame), CGRectGetWidth(self.contentView.frame)/2.0f, CGRectGetHeight(self.contentView.frame)*buttomRatio)
                                                          andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
            _quantityLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfLight, 13, NO);
            _quantityLabel.textAlignment = NSTextAlignmentLeft;
            _quantityLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin;
            _quantityLabel.translatesAutoresizingMaskIntoConstraints = YES;
            _quantityLabel.textColor = CDZColorOfBlack;
            [self.contentView addSubview:_quantityLabel];
        }
        if (!_priceLabel) {
            self.priceLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame)/2.0f, CGRectGetMaxY(_itemsLabel.frame), CGRectGetWidth(self.contentView.frame)/2.0f, CGRectGetHeight(self.contentView.frame)*buttomRatio)
                                                        andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 15.0f)];
            
            _priceLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfLight, 13, NO);
            _priceLabel.textAlignment = NSTextAlignmentRight;
            _priceLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|
            UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
            _priceLabel.translatesAutoresizingMaskIntoConstraints = YES;
            _priceLabel.textColor = CDZColorOfBlack;
            [self.contentView addSubview:_priceLabel];
        }
        
    }
}

- (void)updateUIDataWithData:(NSDictionary *)dataDetail detailType:(CDZRepairDetailType)detailType {
    //content: "亲爱的用户，百城1已经接受了您的预约，请您在2015-06-30 09前去维修！【车队长】",
    //msg_type: "维修消息",
    //create_time: "2015-06-06 09:24:08 ",
    //state_name: "未读"
    
    
    NSString *itemKey = @"";
    NSString *quantityKey = @"";
    NSString *priceKey = @"";
    NSString *itemTitle = @"";
    NSString *quantityTitle = @"";
    NSString *priceTitle = @"";
    switch (detailType) {
        case CDZRepairDetailTypeOfWXXM:
            itemKey = kWXXMMalfunctionName;
            quantityKey = kWXXMWorkingPring;
            priceKey = kWXXMWorkingHour;
            itemTitle = @"维修项目：";
            quantityTitle = @"维修工时：";
            priceTitle = @"工时费：¥";
            break;
            
        case CDZRepairDetailTypeOfWXCL:
            itemKey = kWXCLComponentName;
            quantityKey = kWXCLComponentPring;
            priceKey = kWXCLComponentQuantity;
            itemTitle = @"配件名称：";
            quantityTitle = @"数量：";
            priceTitle = @"单价：¥";
            break;
            
        default:
            break;
    }
    _itemsTitleLabel.text  = @"";
    _itemsLabel.text  = @"";
    _quantityLabel.text = @"";
    _priceLabel.text = @"";
    self.textLabel.text = @"";
    self.detailTextLabel.text = @"";
    if (detailType==CDZRepairDetailTypeOfPrice) {
        self.textLabel.text = dataDetail[kPDPriceTitle];
        if ([dataDetail[kPDPriceContent] isKindOfClass:NSNumber.class]) {
            self.detailTextLabel.text = [@"¥" stringByAppendingString:[dataDetail[kPDPriceContent] stringValue]];
        }else if([dataDetail[kPDPriceTitle] isKindOfClass:NSString.class]) {
            self.detailTextLabel.text = [@"¥" stringByAppendingString:dataDetail[kPDPriceContent]];
        }
        return;
    }

    _itemsTitleLabel.text = itemTitle;
    _itemsLabel.text = dataDetail[itemKey];
    NSString *quantity = dataDetail[quantityKey];
    if ([quantity isEqualToString:@""]) {
        quantity = @"--";
    }
    _quantityLabel.text = [quantityTitle stringByAppendingString:quantity];
    
    NSString *price = dataDetail[priceKey];
    if ([price isEqualToString:@""]) {
        priceTitle = [priceTitle stringByReplacingOccurrencesOfString:@"¥" withString:@""];
        price = @"--";
    }
    _priceLabel.text = [priceTitle stringByAppendingString:price];

    
}

@end
