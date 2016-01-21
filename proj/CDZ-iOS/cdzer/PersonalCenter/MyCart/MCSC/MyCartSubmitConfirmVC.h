//
//  MyCartSubmitConfirmVC.h
//  cdzer
//
//  Created by KEns0n on 6/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^MCSCCompletionBlock)();

@interface MyCartSubmitConfirmVC : BaseViewController

@property (nonatomic, strong) NSDictionary *infoConfirmData;

@property (nonatomic, strong) NSArray *stockCountList;

@end
