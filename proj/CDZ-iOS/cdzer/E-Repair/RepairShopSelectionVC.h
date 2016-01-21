//
//  RepairShopSelectionVC.h
//  cdzer
//
//  Created by KEns0n on 3/6/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
@class KeyCityDTO;
#import <UIKit/UIKit.h>

@interface RepairShopSelectionVC : BaseViewController

@property (nonatomic, strong) NSString *keywordString;

@property (nonatomic, strong) NSString *shopTypeString;

@property (nonatomic, strong) NSString *shopServiceTypeString;

@property (nonatomic, assign) KeyCityDTO *selectedCity;
@end
