//
//  APIsErrorHandler.m
//  cdzer
//
//  Created by KEns0n on 4/20/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "APIsErrorHandler.h"
#import "APIsDefine.h"

@implementation APIsErrorHandler


+ (BOOL)isTokenErrorWithResponseObject:(id)responseObject {
    @autoreleasepool {
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        
        if ([message rangeOfString:@"token"].location!=NSNotFound && [message rangeOfString:@"错误"].location!=NSNotFound ) {
            [[DBHandler shareInstance] clearUserIdentData];
            [ProgressHUDHandler dismissHUDWithCompletion:^{
                
            }];
            return YES;
        }
        
        return NO;
    }
}
@end
