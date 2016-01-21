//
//  MyCollectionProductCell.h
//  cdzer
//
//  Created by KEns0n on 3/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InsetsLabel;
@interface MyCollectionProductCell : UITableViewCell

@property (nonatomic, strong) UIImageView *productPortraitIV;

@property (nonatomic, strong) InsetsLabel *productNameLabel;

@property (nonatomic, strong) InsetsLabel *productPriceLabel;

- (void)initializationUI ;

@end
