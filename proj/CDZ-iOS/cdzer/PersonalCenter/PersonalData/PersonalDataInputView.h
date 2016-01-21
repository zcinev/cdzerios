//
//  PersonalDataInputView.h
//  cdzer
//
//  Created by KEns0n on 4/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

typedef NS_ENUM(NSInteger, PDInputType) {
    PDInputTypeOfNone,
    PDInputTypeOfPasswordChange,
    PDInputTypeOfUserNameChange,
    PDInputTypeOfGenderSelection,
    PDInputTypeOfDOBChange,
    PDInputTypeOfQQChange,
    PDInputTypeOfEmailChange,
};

typedef void (^PDCompletionBlock)(PDInputType type, NSDictionary *result);
#import <UIKit/UIKit.h>

static NSString * const PDInputKeyFirstValue = @"PDInputKeyFirstValue";
static NSString * const PDInputKeySecondValue = @"PDInputKeySecondValue";
static NSString * const PDInputKeyThirdValue = @"PDInputKeyThirdValue";

@interface PersonalDataInputView : UIControl

@property (nonatomic, assign) PDInputType inputType;

- (void)setInputType:(PDInputType)inputType withOriginalValue:(NSString *)originalValue;

- (void)setPDCompletionBlock:(PDCompletionBlock)completionBlock;

- (void)showView;

@end
