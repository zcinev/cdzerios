//
//  ActionOfStatusButtonView.h
//  cdzer
//
//  Created by KEns0n on 3/30/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderConfig.h"

@interface ActionOfStatusButtonView : UIView

@property (nonatomic, strong) UIButton *otherBtn;

@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, strong) UIButton *orderTraceBtn;

- (void)initializationUIWithOrderStatus:(MyOrderStatus)orderStatus target:(id)target Actions:(NSArray *)actionsList isOnlyShowTrackBtn:(BOOL)isOnlyShow ;

@end
