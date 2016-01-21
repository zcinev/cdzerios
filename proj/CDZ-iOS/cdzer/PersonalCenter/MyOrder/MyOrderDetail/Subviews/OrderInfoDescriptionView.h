//
//  OrderInfoDescriptionView.h
//  cdzer
//
//  Created by KEns0n on 3/30/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderConfig.h"

@interface OrderInfoDescriptionView : UIView

- (void)initializationUIByOrderStatus:(MyOrderStatus)orderStatus withOrderInfo:(NSDictionary *)infoData;

@end
