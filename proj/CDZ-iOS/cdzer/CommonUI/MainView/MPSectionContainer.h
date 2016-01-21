//
//  MPSectionContainer.h
//  cdzer
//
//  Created by KEns0n on 2/28/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPSBDelegate.h"

@interface MPSectionContainer : UIView

@property (nonatomic, assign) id <MPSBDelegate> delegate;

- (instancetype)initWithOrigin:(CGPoint)origin;

- (void)initializationUI;

@end
