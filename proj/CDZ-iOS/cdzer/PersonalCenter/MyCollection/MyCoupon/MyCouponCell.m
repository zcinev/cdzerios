

//
//  MyCouponCell.m
//  cdzer
//
//  Created by KEns0n on 10/31/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "MyCouponCell.h"
#import "InsetsLabel.h"
#import "CouponDisplayView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MyCouponCell ()

@property (nonatomic, strong) CouponDisplayView *couponDetailView;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) InsetsLabel *companyNameLabel;

@property (nonatomic, strong) InsetsLabel *dateTimeLabel;

@end


@implementation MyCouponCell

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializationUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _remindLabel.frame = self.bounds;
    
    CGRect logoIVFrame = self.logoImageView.frame;
    logoIVFrame.origin.y = CGRectGetHeight(self.contentView.frame)-85.0f;
    logoIVFrame.origin.x = 15.0f;
    self.logoImageView.frame = logoIVFrame;
//    self.logoImageView.center = CGPointMake((CGRectGetWidth(self.frame)-CGRectGetWidth(self.couponDetailView.frame)-15.0f)/2.0f, self.logoImageView.center.y);
    
    self.companyNameLabel.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), CGRectGetMinY(self.logoImageView.frame));
    
    CGRect couponDVFrame = self.couponDetailView.frame;
    couponDVFrame.origin = CGPointMake(CGRectGetWidth(self.frame)-CGRectGetWidth(couponDVFrame)-15.0f, CGRectGetMinY(self.logoImageView.frame));
    self.couponDetailView.frame = couponDVFrame;
    
    self.dateTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.logoImageView.frame),
                                          CGRectGetMinY(self.logoImageView.frame),
                                          CGRectGetMinX(self.couponDetailView.frame)-CGRectGetMaxX(self.logoImageView.frame),
                                          CGRectGetHeight(self.logoImageView.frame));
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initializationUI {
    @autoreleasepool {
        self.couponDetailView = [[CouponDisplayView alloc] init];
        _couponDetailView.showCouponStrOnly = YES;
        [self.contentView addSubview:_couponDetailView];
        
        
        self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 70.0f)];
        _logoImageView.image = ImageHandler.getDefaultWhiteLogo;
        [self.contentView addSubview:_logoImageView];
        
        CGRect companyNameFrame = self.bounds;
        self.companyNameLabel = [[InsetsLabel alloc] initWithFrame:companyNameFrame
                                                andEdgeInsetsValue:DefaultEdgeInsets];
        _companyNameLabel.text = @"湖南百城汽车维修服务有限公司";
        _companyNameLabel.numberOfLines = 0;
        _companyNameLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16.0f, YES);
        _companyNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_companyNameLabel];
        
        
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
        paragraphStyle.alignment  = NSTextAlignmentCenter;
        NSMutableAttributedString *datetimeString = NSMutableAttributedString.new;
        [datetimeString appendAttributedString:[[NSAttributedString alloc] initWithString:@" 有效日期：\n" attributes:nil]];
        [datetimeString appendAttributedString:[[NSAttributedString alloc] initWithString:@"2015-10-10" attributes:@{NSParagraphStyleAttributeName:paragraphStyle}]];
        [datetimeString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n至\n" attributes:@{NSParagraphStyleAttributeName:paragraphStyle}]];
        [datetimeString appendAttributedString:[[NSAttributedString alloc] initWithString:@"2015-12-31" attributes:@{NSParagraphStyleAttributeName:paragraphStyle}]];
        self.dateTimeLabel = [[InsetsLabel alloc] initWithFrame:self.bounds
                                              andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 5.0f)];
        _dateTimeLabel.attributedText = datetimeString;
        _dateTimeLabel.numberOfLines = 0;
        _dateTimeLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14.0f, YES);
        _dateTimeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_dateTimeLabel];
        
        
        self.remindLabel = [[InsetsLabel alloc] initWithFrame:self.bounds
                                           andEdgeInsetsValue:DefaultEdgeInsets];
        _remindLabel.backgroundColor = CDZColorOfWhite;
        _remindLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 18.0f, NO);
        _remindLabel.numberOfLines = 0;
        _remindLabel.textAlignment = NSTextAlignmentCenter;
        _remindLabel.text = @"没有更多优惠劵\n请前往维修商查询领取！";
        [self.contentView addSubview:_remindLabel];
    }
}

- (void)updateUIDataWithData:(NSDictionary *)detailData {
    @autoreleasepool {
        
        NSString *shopName = [SupportingClass verifyAndConvertDataToString:detailData[@"storeName"]];
        self.companyNameLabel.text = shopName;
        
        NSString *urlStr = detailData[@"shopImg"];
        self.logoImageView.image = ImageHandler.getDefaultWhiteLogo;
        if (urlStr&&[urlStr rangeOfString:@"http"].location!=NSNotFound) {
            [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:ImageHandler.getDefaultWhiteLogo];
        }
        
        NSString *startDate = [[SupportingClass verifyAndConvertDataToString:detailData[@"startime"]]
                               stringByReplacingOccurrencesOfString:@":" withString:@"-"];
        NSString *endDate = [[SupportingClass verifyAndConvertDataToString:detailData[@"endtime"]]
                             stringByReplacingOccurrencesOfString:@":" withString:@"-"];
        NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
        paragraphStyle.alignment  = NSTextAlignmentCenter;
        NSMutableAttributedString *datetimeString = NSMutableAttributedString.new;
        [datetimeString appendAttributedString:[[NSAttributedString alloc] initWithString:@" 有效日期：\n" attributes:nil]];
        [datetimeString appendAttributedString:[[NSAttributedString alloc] initWithString:startDate attributes:@{NSParagraphStyleAttributeName:paragraphStyle}]];
        [datetimeString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n至\n" attributes:@{NSParagraphStyleAttributeName:paragraphStyle}]];
        [datetimeString appendAttributedString:[[NSAttributedString alloc] initWithString:endDate attributes:@{NSParagraphStyleAttributeName:paragraphStyle}]];
        _dateTimeLabel.attributedText = datetimeString;
        
        BOOL isExpired = ([SupportingClass verifyAndConvertDataToNumber:detailData[@"overdue"]].integerValue==2);
        
        NSString *priceStr = [SupportingClass verifyAndConvertDataToString:detailData[@"amount"]];
        NSString *contentStr = detailData[@"content"];
        _couponDetailView.displayType = isExpired?CouponDisplayTypeOfBlackNWhiteWithWasExpiredImg:CouponDisplayTypeOfColor;
        [_couponDetailView setPriceText:priceStr andContentText:contentStr];
    }
    
}
@end
