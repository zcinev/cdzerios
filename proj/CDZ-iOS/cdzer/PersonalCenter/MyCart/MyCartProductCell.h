//
//  MyCartProductCell.h
//  cdzer
//
//  Created by KEns0n on 3/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InsetsLabel;
@class CheckBoxBtn;
@interface MyCartProductCell : UITableViewCell

@property (nonatomic, strong) CheckBoxBtn *checkBtn;

@property (nonatomic, weak) UITableView *tableView;

- (void)initializationUI;

- (void)cellDetailAction:(SEL)selector target:(id)target;

- (void)updateUIDataWith:(NSDictionary *)dataDetail;

@end
