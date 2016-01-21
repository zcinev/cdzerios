//
//  ValidCodeButton.m
//  cdzer
//
//  Created by KEns0n on 7/10/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define kDefaultTitle @"获取验证码"
#define kCountDownTitle(count) [NSString stringWithFormat:@"%d秒后再获取",count]
#define kLastRegisterValidCodeDate @"LastRegisterValidCodeDate"
#define kLastForgetPWValidCodeDate @"LastForgetPWValidCodeDate"
#define kLastOrderCreditValidCodeDate @"LastOrderCreditValidCodeDate"

#import "ValidCodeButton.h"

@interface ValidCodeButton ()
{
    NSTimer *_timer;
    NSTimeInterval _timeInterval;
    NSInteger _totalCount;
    BOOL _isRequested;
}
@property (nonatomic, assign) VCBType VCBButtonType;

@end

@implementation ValidCodeButton
@synthesize requestedValidCode = _isRequested;

- (void)buttonSettingWithType:(VCBType)buttonType {
    self.VCBButtonType = buttonType;
    self.isRequested = NO;
    [self setTitle:kDefaultTitle forState:UIControlStateNormal];
    [self setTitle:kDefaultTitle forState:UIControlStateHighlighted];
    [self setTitleColor:CDZColorOfBlack forState:UIControlStateNormal];
    [self setTitleColor:CDZColorOfBlack forState:UIControlStateHighlighted];
    [self setTitle:kDefaultTitle forState:UIControlStateDisabled];
    [self setTitleColor:CDZColorOfDeepGray forState:UIControlStateDisabled];
    UIControlContentHorizontalAlignment contentAlignment = UIControlContentHorizontalAlignmentCenter;
    if (buttonType==VCBTypeOfPWForgetValid||buttonType==VCBTypeOfRegisterValid) {
        contentAlignment = UIControlContentHorizontalAlignmentRight;
    }
    self.contentHorizontalAlignment = contentAlignment;
    self.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
    
    NSNumber *timeNumber = [NSUserDefaults.standardUserDefaults objectForKey:self.getObjKey];
    _totalCount = -1;
    if (timeNumber) {
        _timeInterval = timeNumber.doubleValue;
        NSTimeInterval newInterval = [[NSDate date] timeIntervalSince1970];
        NSInteger result = newInterval-_timeInterval;
        if (result<60) {
            [self startCountDown];
        }
    }
    [self addTarget:self action:@selector(startCountDown) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(getValidCode) forControlEvents:UIControlEventTouchUpInside];
    
}

- (NSString *)getObjKey {
    if (_VCBButtonType==VCBTypeOfPWForgetValid) return kLastForgetPWValidCodeDate;
    
    if (_VCBButtonType==VCBTypeOfOrderCreditValid) return kLastOrderCreditValidCodeDate;
    
    return kLastRegisterValidCodeDate;
}

- (void)startCountDown{
    if (!_userPhone) {
        return;
    }
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
    _totalCount = 60;
    if (_timeInterval!=0) {
        NSTimeInterval newInterval = [[NSDate date] timeIntervalSince1970];
        NSInteger result = newInterval-_timeInterval;
        if (result<60) {
            _totalCount = 60-result;
        }
    }else {
        NSTimeInterval newInterval = [[NSDate date] timeIntervalSince1970];
        _timeInterval = newInterval;
        [NSUserDefaults.standardUserDefaults setObject:@(newInterval) forKey:self.getObjKey];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDown) userInfo:nil repeats:YES];
    [self setTitle:kCountDownTitle(_totalCount) forState:UIControlStateDisabled];
    [self setTitleColor:CDZColorOfDeepGray forState:UIControlStateDisabled];
    self.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14.0f, NO);
    self.enabled = NO;
    self.isRequested = YES;
}

- (void)updateCountDown {
    _totalCount--;
    if (_totalCount<0) {
        [self stopCountDown];
        return;
    }
    [self setTitle:kCountDownTitle(_totalCount) forState:UIControlStateDisabled];
}

- (void)stopCountDown{
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
    _totalCount = -1;
    self.enabled = YES;
    self.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
    [self setTitle:kDefaultTitle forState:UIControlStateNormal];
    [self setTitle:kDefaultTitle forState:UIControlStateHighlighted];
    [self setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
    [self setTitleColor:CDZColorOfWhite forState:UIControlStateHighlighted];
    [self setTitle:kDefaultTitle forState:UIControlStateDisabled];
    [self setTitleColor:CDZColorOfDeepGray forState:UIControlStateDisabled];
    [NSUserDefaults.standardUserDefaults removeObjectForKey:self.getObjKey];
    if (_VCBButtonType==VCBTypeOfOrderCreditValid) {
        self.isReady = YES;
    }
}

- (void)setIsRequested:(BOOL)isRequested {
    _isRequested = isRequested;
}

- (BOOL)isRequested {
    return _isRequested;
}

- (void)setEnabled:(BOOL)enabled {
    if (_totalCount>=0||!_isReady) {
        enabled = NO;
    }
    [super setEnabled:enabled];
}

- (void)getValidCode {
    if (!_userPhone&&_VCBButtonType!=VCBTypeOfOrderCreditValid) {
        return;
    }
    if (_VCBButtonType==VCBTypeOfRegisterValid) {
        
        [UserBehaviorHandler.shareInstance userRequestRegisterValidCodeWithUserPhone:_userPhone.stringValue success:^{
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"验证码请求成功"
                                    isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil
                      clickedButtonAtIndexWithBlock:nil];
            
        } failure:^(NSString *errorMessage, NSError *error) {
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:errorMessage
                                    isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil
                      clickedButtonAtIndexWithBlock:nil];
            [self stopCountDown];
            self.isRequested = NO;
        }];
        
    }else if(_VCBButtonType==VCBTypeOfPWForgetValid) {
        
        [UserBehaviorHandler.shareInstance userRequestForgotPasswordValidCodeWithUserPhone:_userPhone.stringValue success:^{
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"验证码请求成功"
                                    isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil
                      clickedButtonAtIndexWithBlock:nil];
            
        } failure:^(NSString *errorMessage, NSError *error) {
            
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:errorMessage
                                    isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil
                      clickedButtonAtIndexWithBlock:nil];
            [self stopCountDown];
            self.isRequested = NO;
        }];
        
    }else if(_VCBButtonType==VCBTypeOfOrderCreditValid){
        
        [UserBehaviorHandler.shareInstance userRequestCreditValidCodeWithSuccessBlock:^{
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"验证码请求成功"
                                    isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil
                      clickedButtonAtIndexWithBlock:nil];
            
        } failure:^(NSString *errorMessage, NSError *error) {
            
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:errorMessage
                                    isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil
                      clickedButtonAtIndexWithBlock:nil];
            [self stopCountDown];
            self.isRequested = NO;
        }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
