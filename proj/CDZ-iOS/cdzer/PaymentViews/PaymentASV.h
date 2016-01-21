//
//  PaymentASV.h
//  cdzer
//
//  Created by KEns0n on 9/19/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^PaymentASVResultBlock)(NSString *resultMessage, NSInteger errorCode);
@interface PaymentASV : NSObject

+ (void)showPaymentViewWithPayAfterDelivery:(BOOL)isShowOption paymentData:(NSDictionary *)paymentData withResultBlock:(PaymentASVResultBlock)resultBlock;

+ (void)updatePaymentStatusAndPaymentData:(NSDictionary *)paymentData withResultBlock:(PaymentASVResultBlock)resultBlock; 

@end
