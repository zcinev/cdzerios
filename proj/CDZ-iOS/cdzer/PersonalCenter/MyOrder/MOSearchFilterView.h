//
//  MOSearchFilterView.h
//  cdzer
//
//  Created by KEns0n on 3/9/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MOSearchFilterBlock)();
@interface MOSearchFilterView : UIView

@property (nonatomic, strong) NSString *statusString;

- (instancetype)initWithOrigin:(CGPoint)origin;

- (void)unfoldingFilterView;

- (void)initializationUIWithMaskView:(UIButton *)maskBtnView;

- (void)setSelectionResponseBlock:(MOSearchFilterBlock)block;
@end
