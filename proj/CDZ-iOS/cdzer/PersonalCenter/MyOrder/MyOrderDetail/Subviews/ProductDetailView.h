//
//  ProductDetailView.h
//  cdzer
//
//  Created by KEns0n on 3/31/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderConfig.h"

@interface ProductDetailView : UITableView
- (void)initializationUIWithDetailInfo:(NSDictionary *)detailInfo andOrderStatus:(MyOrderStatus)orderStatus isAutoResize:(BOOL)isAutoResize;

- (void)setPopCommentVCActionTarget:(id)target action:(SEL)action;
@end
