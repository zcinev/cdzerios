//
//  BaseViewController.h
//  cdzer
//
//  Created by KEns0n on 2/6/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
@class KeyCityDTO;
#import <UIKit/UIKit.h>
#import "UIViewController+ShareAction.h"
#import "UIView+ShareAction.h"

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSString *accessToken;

- (void)presentLoginViewAtViewController:(id)viewController backTitle:(NSString *)backTitle animated:(BOOL)flag completion:(void (^)(void))completion;

- (void)pushToAutoSelectionViewWithBackTitle:(NSString *)backTitle animated:(BOOL)flag onlyForSelection:(BOOL)onlyForSelection;

- (void)pushToCitySelectionViewWithBackTitle:(NSString *)backTitle selectedCity:(KeyCityDTO *)selectedCity hiddenLocation:(BOOL)hidden onlySelection:(BOOL)onlySelection animated:(BOOL)flag;
@end
