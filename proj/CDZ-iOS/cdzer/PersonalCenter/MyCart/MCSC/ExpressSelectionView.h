//
//  ExpressSelectionView.h
//  cdzer
//
//  Created by KEns0n on 7/20/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressSelectionView : UIView

@property (nonatomic, strong) NSString *expressName;

@property (nonatomic, strong) NSString *expressID;

- (void)setExpressList:(NSArray *)expressData;

- (void)hiddenKeyboard;
@end
