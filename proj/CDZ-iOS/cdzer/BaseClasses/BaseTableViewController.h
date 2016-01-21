//
//  BaseTableViewController.h
//  cdzer
//
//  Created by KEns0n on 3/12/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ShareAction.h"
#import "UIView+ShareAction.h"

@interface BaseTableViewController : UITableViewController

@property (nonatomic, strong) NSString *accessToken;

@end
