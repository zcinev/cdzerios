//
//  MyAddressesTVCell.h
//  cdzer
//
//  Created by KEns0n on 4/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAddressesTVCell : UITableViewCell

@property (nonatomic, strong) NSString *provinceString;

@property (nonatomic, strong) NSString *cityString;

@property (nonatomic, strong) NSString *districtString;

@property (nonatomic, strong) NSString *addressString;

@property (nonatomic, strong) NSString *userNameString;

@property (nonatomic, strong) NSString *phoneNumberString;

@property (nonatomic, strong) NSString *postNumberString;

- (void)initializationUI;

@end
