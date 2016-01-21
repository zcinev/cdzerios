//
//  MessageAlertCell.h
//  cdzer
//
//  Created by KEns0n on 6/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageAlertCell : UITableViewCell

- (void)updateUIDataWithData:(NSDictionary *)dataDetail;

+ (CGFloat)getDynamicHeight:(NSDictionary *)dataDetail;
@end
