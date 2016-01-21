//
//  MyRepairDetailCellConfig.h
//  cdzer
//
//  Created by KEns0n on 10/9/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#ifndef MyRepairDetailCellConfig_h
#define MyRepairDetailCellConfig_h
typedef NS_ENUM(NSInteger, CDZRepairDetailType) {
    CDZRepairDetailTypeOfUser = 0,
    CDZRepairDetailTypeOfPrice = 1,
    CDZRepairDetailTypeOfWXXM = 2,
    CDZRepairDetailTypeOfWXCL = 3,
};


static NSString * const kPDPriceTitle = @"title";
static NSString * const kPDPriceContent = @"content";

static NSString * const kWXXMMalfunctionName = @"diagph_name";
static NSString * const kWXXMWorkingPring = @"f_gongshiprice";
static NSString * const kWXXMWorkingHour = @"f_sumgongshi";

static NSString * const kWXCLComponentName = @"wname";
static NSString * const kWXCLComponentPring = @"w_price";
static NSString * const kWXCLComponentQuantity = @"wnum";
#endif /* MyRepairDetailCellConfig_h */
