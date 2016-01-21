//
//  PartsSearchReferenceObject.m
//  cdzer
//
//  Created by KEns0n on 9/29/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "PartsSearchReferenceObject.h"

@implementation PartsSearchReferenceObject

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.keyword = @"";
        self.partsID = @"";
        self.partsImagePath = @"";
        self.isSearchFromKeyword = NO;
    }
    
    return self;
}

- (void)processDataToObject:(NSDictionary *)addressData {
    if (addressData[@"imgurl"]) {
        self.partsImagePath = [SupportingClass verifyAndConvertDataToString:addressData[@"imgurl"]];
        
    }
    if (addressData[@"name"]) {
        self.keyword = [SupportingClass verifyAndConvertDataToString:addressData[@"name"]];
        
    }
    if (addressData[@"id"]) {
        self.partsID = [SupportingClass verifyAndConvertDataToString:addressData[@"id"]];
    }
}

@end
