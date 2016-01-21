//
//  MyOrderTraceTVCell.h
//  cdzer
//
//  Created by KEns0n on 3/31/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InsetsLabel;
@interface MyOrderTraceTVCell : UITableViewCell

@property (nonatomic, strong) UIImageView *criceImageView;

@property (nonatomic, strong) InsetsLabel *contentLabel;

@property (nonatomic, strong) InsetsLabel *dateTimeLabel;

- (void)initializationUIWithDetail:(NSDictionary *)detailInfo;

+ (CGFloat)getContentStringHeight:(NSString *)textString isLastCell:(BOOL)isLastCell;

@end
