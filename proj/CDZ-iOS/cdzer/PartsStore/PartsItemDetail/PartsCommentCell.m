//
//  PartsCommentCell.m
//  cdzer
//
//  Created by KEns0n on 3/16/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight (120.0f)
#import "PartsCommentCell.h"
#import "InsetsLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PartsCommentCell ()

@property (nonatomic, strong) InsetsLabel *userNameLabel;

@property (nonatomic, strong) HCSStarRatingView *starRatingView;

@property (nonatomic, strong) InsetsLabel *dateTimeLabel;

@property (nonatomic, strong) InsetsLabel *commentDescriptionLabel;

@end

@implementation PartsCommentCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15.0f, 5.0f, 50.0f, 50.0f);
    
    CGRect nameRect = _userNameLabel.frame;
    nameRect.origin.y = CGRectGetMinY(self.imageView.frame);
    nameRect.size.height = CGRectGetWidth(self.imageView.frame)/2.0f;
    _userNameLabel.frame = nameRect;
    _userNameLabel.edgeInsets = UIEdgeInsetsMake(0.0f, CGRectGetMaxX(self.imageView.frame)+10.0f, 0.0f, 15.0f);
    
    CGRect ratingRect = _starRatingView.frame;
    ratingRect.origin.x = CGRectGetMaxX(self.imageView.frame)+10.0f;
    ratingRect.origin.y = CGRectGetMaxY(nameRect);
    ratingRect.size.height = CGRectGetWidth(self.imageView.frame)/2.0f;
    _starRatingView.frame = ratingRect;
    
    
    CGRect dateTimeFrame = self.bounds;
    dateTimeFrame.origin.y = CGRectGetHeight(self.frame)-30.0f;
    dateTimeFrame.size.height = 30.0f;
    _dateTimeLabel.frame = dateTimeFrame;
    _dateTimeLabel.textAlignment = NSTextAlignmentRight;
    
    
    CGRect commentRect = self.frame;
    commentRect.origin.y = CGRectGetMaxY(self.imageView.frame);
    commentRect.size.height = CGRectGetHeight(self.frame)-CGRectGetMaxY(self.imageView.frame)-CGRectGetHeight(_dateTimeLabel.frame);
    self.commentDescriptionLabel.frame = commentRect;
    
    CGRect textFrame = self.textLabel.frame;
    textFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10.0f;
    self.textLabel.frame = textFrame;
    
    CGPoint textCenter = self.textLabel.center;
    textCenter.y = self.imageView.center.y;
    self.textLabel.center = textCenter;
    
    CGRect detailTextFrame = self.detailTextLabel.frame;
    detailTextFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10.0f;
    self.detailTextLabel.frame = detailTextFrame;
    
    [self.imageView setAutoresizingMask:UIViewAutoresizingNone];

    [self setViewBorderWithRectBorder:UIRectBorderBottom|UIRectBorderTop borderSize:0.5f withColor:self.getDefaultSeparatorLineDarkColor withBroderOffset:nil];
}

- (void)initializationUI {
    UIEdgeInsets insetValue = DefaultEdgeInsets;
    
    if (!_userNameLabel) {
        NSString *nameText = @"测试名字";
        UIFont *nameFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16.0f, NO);
        UIColor *textColor = [UIColor colorWithRed:0.353f green:0.345f blue:0.349f alpha:1.00f];
        
        CGRect rect = self.bounds;
        self.userNameLabel = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValue];
        _userNameLabel.text = nameText;
        _userNameLabel.textColor = textColor;
        _userNameLabel.font = nameFont;
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_userNameLabel];
    }
    
    
    
    if (!_starRatingView) {
        CGRect rect = CGRectZero;
        rect.size = CGSizeMake((80.0f), (25.0f));
        self.starRatingView = [[HCSStarRatingView alloc] initWithFrame:rect];
        _starRatingView.allowsHalfStars = YES;
        _starRatingView.maximumValue = 5.0f;
        _starRatingView.minimumValue = 0.0f;
        _starRatingView.value = 3.0f;
        _starRatingView.tintColor = [UIColor redColor];
        _starRatingView.userInteractionEnabled = NO;
        [self addSubview:_starRatingView];
    }
    
    if (!_dateTimeLabel) {
        NSString *timeText = @"2015-03-19 25:10:10";
        CGRect rect = CGRectZero;
        rect.origin.y = CGRectGetMinY(_userNameLabel.frame);
        self.dateTimeLabel = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValue];
        _dateTimeLabel.text = timeText;
        _dateTimeLabel.numberOfLines = -1;
        _dateTimeLabel.textColor = [UIColor lightGrayColor];
        _dateTimeLabel.textAlignment = NSTextAlignmentRight;
        _dateTimeLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 12.0f, NO);
        [self addSubview:_dateTimeLabel];
        
    }
    
    
    
    
    if (!_commentDescriptionLabel) {
        NSString *timeText = @"环境还不错，有无线上网，";//价格比较划算！值得推存，服务态度更加别提了，极好，给个赞！！！！";
        UIFont *font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
        CGRect rect = self.frame;
        rect.origin.y = CGRectGetMaxY(self.imageView.frame);
        rect.size.height = CGRectGetHeight(self.frame)-CGRectGetMaxY(self.imageView.frame)-CGRectGetHeight(_dateTimeLabel.frame);
        self.commentDescriptionLabel = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValue];
        _commentDescriptionLabel.text = timeText;
        _commentDescriptionLabel.font = font;
        _commentDescriptionLabel.numberOfLines = 1;
        _commentDescriptionLabel.textColor = [UIColor blackColor];
        _commentDescriptionLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_commentDescriptionLabel];
        
    }
}

- (void)updateUIDataWithData:(NSDictionary *)dataDetail {
//    "content": "bxncjncjd",
//    "face_img": "http://cdz.cdzer.com:80/imgUpload/demo/basic/faceImg/150914163436gWgtHsGurl.jpg",
//    "create_time": "2015-09-16 16:28:15 ",
//    "userName": "181****7163",
//    "autopart_name": "嘉实多ATF多用途自动变速箱油/波箱油/排档液4L",
//    "star": "1.0",
//    "id": "15091616281597383050",
//    "repply_content": ""
    @autoreleasepool {
        NSMutableString *dateString = [NSMutableString stringWithString:[dataDetail[@"create_time"] stringByReplacingOccurrencesOfString:@" " withString:@"\n"]];
        if ([[dateString substringWithRange:NSMakeRange(dateString.length-1, 1)] isEqualToString:@"\n"]) {
            [dateString deleteCharactersInRange:NSMakeRange(dateString.length-1, 1)];
        }
        _dateTimeLabel.text = dataDetail[@"create_time"];
        _userNameLabel.text = dataDetail[@"userName"];
        _starRatingView.value = [dataDetail[@"star"] floatValue]*5.0f;
        _commentDescriptionLabel.text = dataDetail[@"content"];
        
        
        NSString *urlString = dataDetail[@"face_img"];
        UIImage *defaultImage = [ImageHandler getWhiteLogo];
        self.imageView.image = nil;
        self.imageView.image = defaultImage;
        if ([urlString rangeOfString:@"http"].location != NSNotFound) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:defaultImage];
        }
    }
    
}

@end
