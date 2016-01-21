//
//  ProgressHUDHandler.m
//  cdzer
//
//  Created by KEns0n on 4/18/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "ProgressHUDHandler.h"
#import <KVNProgress/KVNProgress.h>

@implementation ProgressHUDHandler


static BOOL isShowing = NO;
# pragma mark - Show HUD
+ (void)showHUD {
    isShowing = YES;
    [KVNProgress show];
}

+ (void)showHUDWithTitle:(NSString *)title onView:(UIView *)superview {
    [KVNProgress showWithStatus:title onView:superview];
}
# pragma mark Show HUD End

# pragma mark - Show Progress HUD
+ (void)showStartProgress {
    [self showStartProgressStatusWithTitle:nil onView:nil];
}

+ (void)showStartProgressStatusWithTitle:(NSString *)title onView:(UIView *)superview {
    [KVNProgress showProgress:0.0f status:title onView:superview];
}

+ (void)updateHUDProgress:(CGFloat)progress {
    [KVNProgress updateProgress:progress
                       animated:YES];
}

+ (void)updateProgressStatusWithTitle:(NSString *)title {
    [KVNProgress updateStatus:title];
}
# pragma mark Show Progress HUD End

# pragma mark - Show Success HUD
+ (void)showSuccess {
    [KVNProgress showSuccessWithStatus:getLocalizationString(@"success")];
}

+ (void)showSuccessWithStatus:(NSString *)status onView:(UIView *)superview completion:(KVNCompletionBlock)completion {
    [KVNProgress showSuccessWithStatus:status onView:superview completion:completion];
}
# pragma mark Show Success HUD End

# pragma mark - Show Error HUD
+ (void)showError {
    [KVNProgress showErrorWithStatus:getLocalizationString(@"error")];
}

+ (void)showErrorWithStatus:(NSString *)status onView:(UIView *)superview completion:(KVNCompletionBlock)completion {
    [KVNProgress showErrorWithStatus:status onView:superview completion:completion];
}
# pragma mark Show Error HUD End

# pragma mark - Dismiss HUD
+ (void)dismissHUD {
    [KVNProgress dismiss];
}

+ (void)dismissHUDWithCompletion:(KVNCompletionBlock)completion {
    [KVNProgress dismissWithCompletion:completion];
    
}
# pragma mark Dismiss HUD End

# pragma mark - HUD Status

+ (BOOL)isVisible {
    return [KVNProgress isVisible];
}

# pragma mark HUD Status End

//static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
//{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        block();
//    });
//}

@end
