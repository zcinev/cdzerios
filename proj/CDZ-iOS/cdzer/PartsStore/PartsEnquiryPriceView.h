//
//  PartsEnquiryPriceView.h
//  cdzer
//
//  Created by KEns0n on 8/19/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "BaseViewController.h"
@class KeyCityDTO;
@class UserSelectedAutosInfoDTO;
@interface PartsEnquiryPriceView : UIScrollView

@property (nonatomic, strong) KeyCityDTO *selectedcity;

@property (nonatomic, strong) UserSelectedAutosInfoDTO *autoData;

@property (nonatomic, strong) NSString *productID;

- (void)initializationUI;

- (void)setupCitySelectionBtnAction:(SEL)action target:(id)target forControlEvents:(UIControlEvents)controlEvents;

- (void)setupPurchaseCenterBtnAction:(SEL)action target:(id)target forControlEvents:(UIControlEvents)controlEvents;

@end
