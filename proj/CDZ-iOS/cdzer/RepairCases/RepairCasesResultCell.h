//
//  RepairCasesResultCell.h
//  cdzer
//
//  Created by KEns0n on 6/23/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  InsetsLabel;
@interface RepairCasesResultCell : UITableViewCell

- (void)updateUIDataWithData:(NSDictionary *)dataDetail;

+ (CGFloat)getCellHieght:(NSDictionary *)detail;
@end
