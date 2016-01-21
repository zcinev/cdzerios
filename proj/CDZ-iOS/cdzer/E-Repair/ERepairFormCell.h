//
//  ERepairFormCell.h
//  cdzer
//
//  Created by KEns0n on 11/4/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsetsLabel.h"
#import "InsetsTextField.h"
#import "IQDropDownTextField.h"

@interface ERepairFormCell : UITableViewCell

@property (nonatomic, strong) InsetsTextField *textField;

@property (nonatomic, strong) IQDropDownTextField *dateTimeTextField;

@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
