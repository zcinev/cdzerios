//
//  MPSectionButton.h
//  cdzer
//
//  Created by KEns0n on 2/27/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPSBDelegate.h"

@interface MPSectionButton : UIView

@property (nonatomic, assign, readonly) MPSButtonType buttonType;

@property (nonatomic, strong) UIButton *button;

- (instancetype)initWithButtonType:(MPSButtonType)type ContainerSize:(CGSize)size;

- (void)initializationUI;

@end
