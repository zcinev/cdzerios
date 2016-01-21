//
//  PartsSearchReferenceObject.h
//  cdzer
//
//  Created by KEns0n on 9/29/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartsSearchReferenceObject : NSObject

@property (nonatomic, strong) NSString *partsID;

@property (nonatomic, strong) NSString *keyword;

@property (nonatomic, strong) NSString *partsImagePath;

@property (nonatomic, assign) BOOL isSearchFromKeyword;

- (void)processDataToObject:(NSDictionary *)addressData;

@end
