//
//  MCSCCreditView.h
//  cdzer
//
//  Created by KEns0n on 7/21/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCSCCreditView : UIView

@property (nonatomic, readonly, assign) BOOL isUseCredit;

@property (nonatomic, readonly, strong) NSString *usedCredit;

@property (nonatomic, readonly, strong) NSString *verifyCode;

- (void)shakeView;

- (void)hiddenKeyboard;

- (void)setTotalPrice:(NSString *)totalPrice currenCredit:(NSString *)credit withRatio:(NSString *)ratio;
@end
