//
//  UIViewController+ShareAction.h
//  cdzer
//
//  Created by KEns0n on 3/12/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ShareAction)

- (void)setNavBarBackButtonTitleOrImage:(id)titleOrImage titleColor:(UIColor *)color;

- (void)setNavBarBackButtonTitleOrImage:(id)titleOrImage titleColor:(UIColor *)color withTarget:(id)target action:(SEL)action;

- (UIBarButtonItem *)setRightNavButtonWithTitleOrImage:(id)sender style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action titleColor:(UIColor *)color isNeedToSet:(BOOL)isNeedToSet;

- (UIBarButtonItem *)setRightNavButtonWithSystemItemStyle:(UIBarButtonSystemItem)style target:(id)target action:(SEL)action isNeedToSet:(BOOL)isNeedToSet;

- (UIBarButtonItem *)setLeftNavButtonWithTitleOrImage:(id)sender style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action titleColor:(UIColor *)color isNeedToSet:(BOOL)isNeedToSet;

- (UIBarButtonItem *)setLeftNavButtonWithSystemItemStyle:(UIBarButtonSystemItem)style target:(id)target action:(SEL)action isNeedToSet:(BOOL)isNeedToSet;
@end
