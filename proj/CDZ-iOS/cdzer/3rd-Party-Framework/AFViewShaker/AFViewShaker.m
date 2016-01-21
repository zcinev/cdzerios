//
//  AFViewShaker
//  AFViewShaker
//
//  Created by Philip Vasilchenko on 03.12.13.
//  Copyright (c) 2014 okolodev. All rights reserved.
//

#import "AFViewShaker.h"

static NSTimeInterval const kAFViewShakerDefaultDuration = 0.5;
static NSString * const kAFViewShakerAnimationKey = @"kAFViewShakerAnimationKey";


@interface AFViewShaker ()
@property (nonatomic, strong) NSArray * views;
@property (nonatomic, assign) NSUInteger completedAnimations;
@property (nonatomic, copy) void (^completionBlock)();
@end


@implementation AFViewShaker

- (instancetype)initWithView:(UIView *)view {
    return [self initWithViewsArray:@[ view ]];
}


- (instancetype)initWithViewsArray:(NSArray *)viewsArray {
    self = [super init];
    if ( self ) {
        self.views = viewsArray;
    }
    return self;
}


#pragma mark- Public methods

- (void)shake {
    [self shakeWithDuration:kAFViewShakerDefaultDuration completion:nil];
}


- (void)shakeWithDuration:(NSTimeInterval)duration completion:(void (^)())completion {
    self.completionBlock = completion;
    for (UIView * view in self.views) {
        [self addShakeAnimationForView:view withDuration:duration];
    }
}


- (void)shakeByViewIndex:(NSInteger)index {
    [self shakeByViewIndex:index withDuration:kAFViewShakerDefaultDuration completion:nil];
}

- (void)shakeByViewIndex:(NSInteger)index withDuration:(NSTimeInterval)duration {
    [self shakeByViewIndex:index withDuration:kAFViewShakerDefaultDuration completion:nil];
}

- (void)shakeByViewIndex:(NSInteger)index withDuration:(NSTimeInterval)duration completion:(void (^)())completion {
    if (index<(_views.count-1)) {
        UIView * view = _views[index];
        [self addShakeAnimationForView:view withDuration:duration];
    }
}

- (void)shakeByView:(UIView *)view {
    [self shakeByView:view withDuration:kAFViewShakerDefaultDuration completion:nil];
}

- (void)shakeByView:(UIView *)view withDuration:(NSTimeInterval)duration {
    [self shakeByView:view withDuration:kAFViewShakerDefaultDuration completion:nil];
}

- (void)shakeByView:(UIView *)view withDuration:(NSTimeInterval)duration completion:(void (^)())completion {
    
    [_views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([view isEqual:obj]) {
            [self addShakeAnimationForView:view withDuration:duration];
            *stop = YES;
        }
    }];
}

#pragma mark- Shake Animation

- (void)addShakeAnimationForView:(UIView *)view withDuration:(NSTimeInterval)duration {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.delegate = self;
    animation.duration = duration;
    animation.values = @[ @(0), @(10), @(-8), @(8), @(-5), @(5), @(0) ];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:kAFViewShakerAnimationKey];
}


#pragma mark- CAAnimation Delegate

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    self.completedAnimations += 1;
    if ( self.completedAnimations >= self.views.count ) {
        self.completedAnimations = 0;
        if ( self.completionBlock ) {
            self.completionBlock();
        }
    }
}


@end