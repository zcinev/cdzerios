//
//  UserAutosInfoDTO.h
//  cdzer
//
//  Created by KEns0n on 7/3/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAutosInfoDTO : NSObject

@property (nonatomic, readonly) NSNumber *dbUID;

@property (nonatomic, readonly) NSString *uid;

@property (nonatomic, readonly) NSString *autosUID;

@property (nonatomic, strong) NSString *licensePlate;

@property (nonatomic, strong) NSString *brandName;

@property (nonatomic, strong) NSString *brandImgURL;

@property (nonatomic, strong) NSString *dealershipName;

@property (nonatomic, strong) NSString *seriesName;

@property (nonatomic, strong) NSString *modelName;

@property (nonatomic, strong) NSNumber *brandID;

@property (nonatomic, strong) NSNumber *dealershipID;

@property (nonatomic, strong) NSNumber *seriesID;

@property (nonatomic, strong) NSNumber *modelID;

@property (nonatomic, strong) NSString *gpsID;

@property (nonatomic, strong) NSString *bodyColor;

@property (nonatomic, strong) NSString *mileage;

@property (nonatomic, strong) NSString *insureTime;

@property (nonatomic, strong) NSString *annualTime;

@property (nonatomic, strong) NSString *maintainTime;

@property (nonatomic, strong) NSString *registrTime;

@property (nonatomic, strong) NSString *frameNumber;

@property (nonatomic, strong) NSString *engineCode;


- (void)processDBDataToObjectWithDBData:(NSDictionary *)dbSourcesData;

- (NSDictionary *)processObjectToDBData;

- (void)processDataToObject:(NSDictionary *)sourcesData optionWithUID:(NSString *)uid;

@end
