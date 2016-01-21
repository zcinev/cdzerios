//
//  MyAddressEditWithInsertVC.h
//  cdzer
//
//  Created by KEns0n on 4/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
@class AddressDTO;
typedef NS_ENUM (NSInteger, MyAddressDisplayMode)
{
    MyAddressDisplayTypeOfNormal,
    MyAddressDisplayTypeOfEdit,
    MyAddressDisplayTypeOfInsert
};

#import <UIKit/UIKit.h>

@interface MyAddressEditWithInsertVC : BaseViewController

- (instancetype)initWithDisplayMode:(MyAddressDisplayMode)displayMode withAddressData:(AddressDTO *)addressData;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil displayMode:(MyAddressDisplayMode)displayMode withAddressData:(AddressDTO *)addressData;
@end
