//
//  MCSCAddressView.h
//  cdzer
//
//  Created by KEns0n on 7/17/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCSCAddressView : UIView

@property (nonatomic, readonly) NSString *addressID;

- (void)shakeView;

- (void)setSuperContainer:(id)container;

@end
