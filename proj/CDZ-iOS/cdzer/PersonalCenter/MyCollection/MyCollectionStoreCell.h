//
//  MyCollectionStoreCell.h
//  cdzer
//
//  Created by KEns0n on 3/10/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"


@interface MyCollectionStoreCell : UITableViewCell

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *storeTitleLabel;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *addreeLabel;

@property (nonatomic, strong) HCSStarRatingView *starRatingView;

- (void)initializationUI;

@end
