//
//  OrderStatusDTO.h
//  cdzer
//
//  Created by KEns0n on 9/22/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyOrderConfig.h"

@interface OrderStatusDTO : NSObject

@property (nonatomic, strong, readonly) NSString *stateID;

@property (nonatomic, assign, readonly) MyOrderStatus orderStatusType;

@property (nonatomic, strong, readonly) NSString *stateName;

- (NSDictionary *)processObjectToDBData;

- (void)processDataToObjectWithData:(NSDictionary *)userData;

@end
