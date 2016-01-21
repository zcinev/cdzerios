//
//  MyAddressesVC.h
//  cdzer
//
//  Created by KEns0n on 4/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressDTO;
@interface MyAddressesVC : BaseViewController

@property (nonatomic, assign) BOOL isForSelection;

@property (nonatomic, strong) AddressDTO *selectedDTO;

@end
