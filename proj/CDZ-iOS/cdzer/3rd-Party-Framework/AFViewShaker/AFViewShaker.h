//
//  AFViewShaker
//  AFViewShaker
//
//  Created by Philip Vasilchenko on 03.12.13.
//  Copyright (c) 2014 okolodev. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AFViewShaker : NSObject

- (instancetype)initWithView:(UIView *)view;
- (instancetype)initWithViewsArray:(NSArray *)viewsArray;

- (void)shake;
- (void)shakeWithDuration:(NSTimeInterval)duration completion:(void (^)())completion;

- (void)shakeByViewIndex:(NSInteger)index;
- (void)shakeByViewIndex:(NSInteger)index withDuration:(NSTimeInterval)duration;
- (void)shakeByViewIndex:(NSInteger)index withDuration:(NSTimeInterval)duration completion:(void (^)())completion;


- (void)shakeByView:(UIView *)view;
- (void)shakeByView:(UIView *)view withDuration:(NSTimeInterval)duration;
- (void)shakeByView:(UIView *)view withDuration:(NSTimeInterval)duration completion:(void (^)())completion;
@end