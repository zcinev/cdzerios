//
//  MyRepairDetailVC.h
//  cdzer
//
//  Created by KEns0n on 3/27/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepairDetailDToModel.h"

@interface MyRepairDetailVC : BaseViewController

@property (nonatomic, strong) RepairDetailDToModel *repairDetail;

@property (nonatomic, strong) NSString *statusName;

@property (nonatomic, strong) NSString *repairID;

@property (nonatomic, strong) NSNumber *paymentStatus;

@end
