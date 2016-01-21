//
//  MyOrderDetailByStatusVC.h
//  cdzer
//
//  Created by KEns0n on 3/30/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderConfig.h"
@class OrderStatusDTO;

@interface MyOrderDetailByStatusVC : BaseViewController

- (void)setupOrderDetail:(NSDictionary *)detail withOrderStatus:(OrderStatusDTO *)orderStatus;

@end
