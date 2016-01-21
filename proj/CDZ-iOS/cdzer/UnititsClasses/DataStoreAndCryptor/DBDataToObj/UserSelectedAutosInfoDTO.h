//
//  UserSelectedAutosInfoDTO.h
//  cdzer
//
//  Created by KEns0n on 7/3/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

@class UserAutosInfoDTO;
#import <Foundation/Foundation.h>

@interface UserSelectedAutosInfoDTO : NSObject

@property (nonatomic, readonly) NSString *dbUID;

@property (nonatomic, assign, readonly) BOOL isSelectFromOnline;

@property (nonatomic, strong) NSString *brandName;

@property (nonatomic, strong) NSString *brandImgURL;

@property (nonatomic, strong) NSString *dealershipName;

@property (nonatomic, strong) NSString *seriesName;

@property (nonatomic, strong) NSString *modelName;

@property (nonatomic, strong) NSNumber *brandID;

@property (nonatomic, strong) NSNumber *dealershipID;

@property (nonatomic, strong) NSNumber *seriesID;

@property (nonatomic, strong) NSNumber *modelID;



- (void)processDBDataToObjectWithDBData:(NSDictionary *)dbSourcesData;

- (NSDictionary *)processObjectToDBData;

- (void)processDataToObjectWithDto:(UserAutosInfoDTO *)userDto;

@end
