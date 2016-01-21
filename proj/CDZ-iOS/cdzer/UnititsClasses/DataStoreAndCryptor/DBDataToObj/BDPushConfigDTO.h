//
//  BDPushConfigDTO.h
//  cdzer
//
//  Created by KEns0n on 9/16/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDPushConfigDTO : NSObject

@property (nonatomic, readonly) NSNumber *dbUID;

@property (nonatomic, strong) NSString *bdpUserID;

@property (nonatomic, strong) NSString *channelID;

@property (nonatomic, strong) NSString *deviceToken;

- (NSDictionary *)processObjectToDBData;
@end
