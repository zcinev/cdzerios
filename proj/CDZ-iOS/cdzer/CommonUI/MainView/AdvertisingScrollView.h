//
//  AdvertisingScrollView.h
//  cdzer
//
//  Created by KEns0n on 2/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisingScrollView : UIView

- (void)setAnimationDuration:(NSTimeInterval)newVar;

- (instancetype)initWithMinFrame:(CGRect)frame;

- (void)initializationUIWithDataArray:(NSArray *)dataArray;
@end
