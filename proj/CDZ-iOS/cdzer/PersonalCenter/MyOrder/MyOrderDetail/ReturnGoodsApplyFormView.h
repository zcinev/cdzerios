//
//  ReturnGoodsApplyFormView.h
//  cdzer
//
//  Created by KEns0n on 6/11/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

typedef void (^RGAPCompletionBlock)(NSError *error);
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ReturnGoodsApplyFormView : NSObject

@property (nonatomic, strong) NSString *mainOrderID;

- (void)showView;

- (void)setupCompletionBlock:(RGAPCompletionBlock)completionBlock;

@end
