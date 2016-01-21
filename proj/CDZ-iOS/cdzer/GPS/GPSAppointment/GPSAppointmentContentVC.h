//
//  GPSAppointmentContentVC.h
//  cdzer
//
//  Created by KEns0n on 10/27/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

typedef NS_ENUM(NSInteger, GPSAppointmentResultType) {
    GPSAppointmentResultTypeOfUnknowError,
    GPSAppointmentResultTypeOfSuccess,
    GPSAppointmentResultTypeOfWasAppointmented,
    GPSAppointmentResultTypeOfMissingAutosData
};

typedef void (^GPSAppointmentResultBlock)(GPSAppointmentResultType result, NSString *errorString);
#import <UIKit/UIKit.h>

@interface GPSAppointmentNavVC : UINavigationController

@property (nonatomic, strong) NSNumber *stepOneID;

@property (nonatomic, strong) NSNumber *stepTwoID;

@property (nonatomic, copy) GPSAppointmentResultBlock resultBlock;

- (void)retryAppointmentRequest;

@end


@interface GPSAppointmentContentVC : BaseViewController

@property (nonatomic, readonly) NSUInteger currentStep;

- (instancetype)initWithStepID:(NSUInteger)stepID;

- (void)retryAppointmentRequest;

@end
