//
//  UserInfosDTO.h
//  cdzer
//
//  Created by KEns0n on 8/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfosDTO : NSObject

@property (nonatomic, readonly) NSNumber *dbUID;

@property (nonatomic, readonly) NSNumber *lastUpdate;

@property (nonatomic, strong) NSNumber *gender;

@property (nonatomic, strong) NSString *credits;

@property (nonatomic, strong) NSString *qqNum;

@property (nonatomic, strong) NSString *nichen;

@property (nonatomic, strong) NSString *modelName;

@property (nonatomic, strong) NSString *portrait;

@property (nonatomic, strong) NSString *birthday;

@property (nonatomic, strong) NSString *telphone;

@property (nonatomic, strong) NSString *email;

- (NSDictionary *)processObjectToDBData;

- (void)processDataToObjectWithData:(NSDictionary *)userData isFromDB:(BOOL)isFromDB;


@end
