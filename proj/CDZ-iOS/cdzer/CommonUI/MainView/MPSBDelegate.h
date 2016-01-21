//
//  MPSBDelegate.h
//  cdzer
//
//  Created by KEns0n on 2/28/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
@class MPSectionButton;
#import <Foundation/Foundation.h>

static NSString * const kMPSButtonType = @"kMPSButtonType";

typedef NS_ENUM(NSInteger, MPSButtonType) {
    MPSButtonTypeOfGPS = 1,
    MPSButtonTypeOfRepair = 2,
    MPSButtonTypeOfParts = 3,
    MPSButtonTypeOfUsedCars = 4,
    MPSButtonTypeOfTrafficViolation = 5,
    MPSButtonTypeOfVehicleManagement = 6,
    MPSButtonTypeOfGPSAppiontment = 7,
    MPSButtonTypeOfMessageHistory = 8,
    MPSButtonTypeOfCS = 9,
};

@protocol MPSBDelegate <NSObject>

@optional

-(void)MPSButtonResponseByType:(MPSButtonType)type;

@end
