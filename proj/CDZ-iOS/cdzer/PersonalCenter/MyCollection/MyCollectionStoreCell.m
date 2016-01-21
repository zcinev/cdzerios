//
//  MyCollectionStoreCell.m
//  cdzer
//
//  Created by KEns0n on 3/10/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MyCollectionStoreCell.h"

@implementation MyCollectionStoreCell

- (void)initializationUI {
    @autoreleasepool {
        [self setBackgroundColor:CDZColorOfWhite];
        [self.contentView setBackgroundColor:CDZColorOfWhite];
        UIColor *commonTextColor = [UIColor colorWithRed:0.353f green:0.345f blue:0.349f alpha:1.00f];
        
        if (!_logoImageView) {
            CGRect rect = CGRectZero;
            rect.size = CGSizeMake(vAdjustByScreenRatio(78.0f), vAdjustByScreenRatio(54.0f));
            rect.origin = CGPointMake(vAdjustByScreenRatio(8.0f), vAdjustByScreenRatio(7.0f));
            [self setLogoImageView:[[UIImageView alloc] initWithFrame:rect]];
            [_logoImageView setBackgroundColor:[UIColor blackColor]];
            [self.contentView addSubview:_logoImageView];
        }
        
        if (!_storeTitleLabel) {
            CGRect rect = CGRectZero;
            rect.origin.x = CGRectGetMaxX(_logoImageView.frame)+vAdjustByScreenRatio(10.0f);
            rect.origin.y = CGRectGetMinY(_logoImageView.frame);
            rect.size = CGSizeMake(vAdjustByScreenRatio(140.f), CGRectGetHeight(_logoImageView.frame)*0.6f);
            [self setStoreTitleLabel:[[UILabel alloc] initWithFrame:rect]];
            [_storeTitleLabel setText:@"人和车合快修店"];
            [_storeTitleLabel setFont:[UIFont boldSystemFontOfSize:vAdjustByScreenRatio(16.0f)]];
            [self.contentView addSubview:_storeTitleLabel];
        }
        
        if (!_addreeLabel) {
            CGRect rect = CGRectZero;
            rect.origin.x = CGRectGetMinX(_logoImageView.frame);
            rect.origin.y = CGRectGetMaxY(_logoImageView.frame)+vAdjustByScreenRatio(6.0f);
            rect.size = CGSizeMake(vAdjustByScreenRatio(200.0f), CGRectGetHeight(_logoImageView.frame)*0.3f);
            [self setAddreeLabel:[[UILabel alloc] initWithFrame:rect]];
            [_addreeLabel setText:@"地址：长沙市岳麓区岳麓大道50号"];
            [_addreeLabel setTextColor:commonTextColor];
            [_addreeLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(13.0f)]];
            [self.contentView addSubview:_addreeLabel];
        }
        
        if (!_starRatingView) {
            CGRect rect = CGRectZero;
            rect.origin.x = CGRectGetMinX(_storeTitleLabel.frame);
            rect.origin.y = CGRectGetMaxY(_storeTitleLabel.frame);
            rect.size = CGSizeMake(CGRectGetWidth(_storeTitleLabel.frame)*0.5f, CGRectGetHeight(_logoImageView.frame)*0.4f);
            [self setStarRatingView:[[HCSStarRatingView alloc] initWithFrame:rect]];
            [_starRatingView setAllowsHalfStars:YES];
            [_starRatingView setMaximumValue:5.0f];
            [_starRatingView setMinimumValue:0.0f];
            [_starRatingView setValue:3.0f];
            [_starRatingView setTintColor:[UIColor redColor]];
            [_starRatingView setUserInteractionEnabled:NO];
//            [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
             [self.contentView addSubview:_starRatingView];
        }
        
        if (!_typeLabel) {
            CGRect rect = CGRectZero;
            rect.origin.x = CGRectGetMidX(_storeTitleLabel.frame);
            rect.origin.y = CGRectGetMaxY(_storeTitleLabel.frame);
            rect.size = CGSizeMake(CGRectGetWidth(_storeTitleLabel.frame)/2, CGRectGetHeight(_logoImageView.frame)*0.4f);
            [self setTypeLabel:[[UILabel alloc] initWithFrame:rect]];
            [_typeLabel setText:@"四级维修店"];
            [_typeLabel setTextColor:commonTextColor];
            [_typeLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(12.0f)]];
            [_typeLabel setTextAlignment:NSTextAlignmentRight];
            [self.contentView addSubview:_typeLabel];
        }
    }
}
@end
