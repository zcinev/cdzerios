//
//  UserRegisterVC.m
//  cdzer
//
//  Created by KEns0n on 4/15/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "UserRegisterVC.h"
#import "InsetsTextField.h"
#import <FXBlurView/FXBlurView.h>
#import "AFViewShaker.h"
#import "UserAutosInfoDTO.h"
#import <UIView+Borders/UIView+Borders.h>


@interface UserRegisterVC () <UITextFieldDelegate>

@property (nonatomic, strong) AFViewShaker *viewShaker;

@property (nonatomic, strong) InsetsTextField * phoneNumTextField;

@property (nonatomic, strong) InsetsTextField * validNumTextField;

@property (nonatomic, strong) InsetsTextField * passwordTextField;

@property (nonatomic, strong) InsetsTextField * repasswordTextField;

@property (nonatomic, strong) UILabel *textAlertLabel;

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) ValidCodeButton *validCodeBtn;

@property (nonatomic, strong) NSTimer *timer;



@end

@implementation UserRegisterVC

- (void)dealloc {
    self.viewShaker = nil;
    self.phoneNumTextField = nil;
    self.passwordTextField = nil;
    self.textAlertLabel = nil;
    self.blurView = nil;
    self.toolBar = nil;
    self.registerButton = nil;
    if (_timer && [_timer isValid]){
        [_timer invalidate];
        self.timer = nil;
    }
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.contentView setBackgroundColor:CDZColorOfDefaultColor];
    [self initializationUI];
    [self setTextFieldRelativeRule];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Action
- (void)dismissSelf {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)resignKeyboard {
    [_phoneNumTextField resignFirstResponder];
    [_validNumTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_repasswordTextField resignFirstResponder];
}

- (void)showAlertLabel:(NSString *)message {
    if (_timer && [_timer isValid]){
        [_timer invalidate];
        self.timer = nil;
    }
    _textAlertLabel.text = message;
    @weakify(self)
    [UIView animateWithDuration:0.2 animations:^{
    @strongify(self)
        self.textAlertLabel.alpha = 1.0f;
    }completion:^(BOOL finished) {
        [self.viewShaker shake];
    }];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(hideAlertLabel) userInfo:nil repeats:NO];
}

- (void)hideAlertLabel{
    if (_textAlertLabel.alpha != 0.0f) {
        [UIView animateWithDuration:0.25 animations:^{
            self.textAlertLabel.alpha = 0.0f;
        }];
    }
    if (_timer && [_timer isValid]){
        [_timer invalidate];
        self.timer = nil;
    }
}

#pragma mark UI Init
- (void)initializationUI {
    @autoreleasepool {
        
        self.blurView = [[FXBlurView alloc] initWithFrame:self.contentView.bounds];
        [_blurView setDynamic:NO];
        [self.contentView addSubview:_blurView];
        
        
        UILabel *Label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), 40.0f)];
        [Label setBackgroundColor:CDZColorOfClearColor];
        [Label setFont:systemFontWithoutRatio(20.0f)];
        [Label setTextColor:CDZColorOfWhite];
        [Label setText:getLocalizationString(_isRegisterType?@"register":@"forget_password")];
        [Label setTextAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:Label];
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        self.toolBar =  [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40)];
        [_toolBar setBarStyle:UIBarStyleDefault];
        UIBarButtonItem * spaceButton = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:self
                                                                                      action:nil];
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"finish")
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(resignKeyboard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButton,doneButton,nil];
        [_toolBar setItems:buttonsArray];
        
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        UIButton *backPreviousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backPreviousBtn setFrame:CGRectMake(0.0f, 0.0f, 70.0f, 40.0f)];
        [backPreviousBtn setTintColor:CDZColorOfClearColor];
        [backPreviousBtn setTitle:getLocalizationString(@"cancel") forState:UIControlStateNormal];
        [backPreviousBtn setTitle:getLocalizationString(@"cancel") forState:UIControlStateHighlighted];
        [backPreviousBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [backPreviousBtn setTitleColor:CDZColorOfWhite forState:UIControlStateHighlighted];
        [backPreviousBtn.titleLabel setFont:systemFont(18.0f)];
        [backPreviousBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -20.0f, 0.0f, 0.0f)];
        [backPreviousBtn addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        [_blurView addSubview:backPreviousBtn];
        

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame)*0.75f, 200.0f)];
        [containerView setBackgroundColor:[UIColor colorWithRed:0.800f green:0.800f blue:0.800f alpha:0.00f]];
        [containerView setCenter:CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0f, CGRectGetHeight(self.contentView.frame)/2.0f-50.0f)];
        [containerView setBackgroundColor:CDZColorOfClearColor];
        [_blurView addSubview:containerView];
        
        
        
        UIEdgeInsets insetValue = UIEdgeInsetsMake(0.0f, 40.0f, 0.0f, 0.0f);
        UIImage *phoneImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                                  fileName:@"phone"
                                                                                      type:FMImageTypeOfPNG
                                                                           scaleWithPhone4:NO
                                                                              needToUpdate:NO];
        NSAttributedString * placeholderStringPN = [[NSAttributedString alloc] initWithString:[getLocalizationString(@"phone_number") stringByReplacingOccurrencesOfString:@"：" withString:@""] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0f alpha:0.8f]}];
        self.phoneNumTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(containerView.frame), 40.0f) andEdgeInsetsValue:insetValue];
        [_phoneNumTextField setBackgroundColor:CDZColorOfClearColor];
        [_phoneNumTextField setTextAlignment:NSTextAlignmentLeft];
        [_phoneNumTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [_phoneNumTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_phoneNumTextField setReturnKeyType:UIReturnKeyNext];
        [_phoneNumTextField setEnablesReturnKeyAutomatically:YES];
        [_phoneNumTextField setAttributedPlaceholder:placeholderStringPN];
        [_phoneNumTextField setInputAccessoryView:_toolBar];
        [_phoneNumTextField setDelegate:self];
        [_phoneNumTextField.layer addSublayer:[_phoneNumTextField createBottomBorderWithHeight:1.0f color:CDZColorOfWhite leftOffset:0.0f rightOffset:0.0f andBottomOffset:0.0f]];
        [containerView addSubview:_phoneNumTextField];
        
        UIImageView *phoneIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
        [phoneIcon setImage:phoneImage];
        [_phoneNumTextField addSubview:phoneIcon];
        
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        UIImage *validCodeImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                                  fileName:@"validCode"
                                                                                      type:FMImageTypeOfPNG
                                                                           scaleWithPhone4:NO
                                                                              needToUpdate:NO];
        NSAttributedString * placeholderStringVCO = [[NSAttributedString alloc] initWithString:[getLocalizationString(@"valid_code") stringByReplacingOccurrencesOfString:@"：" withString:@""] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0f alpha:0.8f]}];
        self.validNumTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_phoneNumTextField.frame), CGRectGetWidth(containerView.frame), 40.0f) andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, insetValue.left, 0.0f, 90.0f)];
        [_validNumTextField setBackgroundColor:CDZColorOfClearColor];
        [_validNumTextField setTextAlignment:NSTextAlignmentLeft];
        [_validNumTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [_validNumTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_validNumTextField setReturnKeyType:UIReturnKeyNext];
        [_validNumTextField setEnablesReturnKeyAutomatically:YES];
        [_validNumTextField setAttributedPlaceholder:placeholderStringVCO];
        [_validNumTextField setInputAccessoryView:_toolBar];
        [_validNumTextField setDelegate:self];
        [_validNumTextField.layer addSublayer:[_validNumTextField createBottomBorderWithHeight:1.0f color:CDZColorOfWhite leftOffset:0.0f rightOffset:0.0f andBottomOffset:0.0f]];
        [containerView addSubview:_validNumTextField];
        
        UIImageView *validCodeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
        [validCodeIcon setImage:validCodeImage];
        [_validNumTextField addSubview:validCodeIcon];
        
        self.validCodeBtn = [ValidCodeButton buttonWithType:UIButtonTypeCustom];
        [_validCodeBtn buttonSettingWithType:_isRegisterType?VCBTypeOfRegisterValid:VCBTypeOfPWForgetValid];
        _validCodeBtn.frame = CGRectMake(CGRectGetWidth(_validNumTextField.frame)-90.0f, CGRectGetMinY(_validNumTextField.frame), 90.0f, CGRectGetHeight(_validNumTextField.frame));
        [containerView addSubview:_validCodeBtn];
        
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        UIImage *pwImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                               fileName:@"password"
                                                                                   type:FMImageTypeOfPNG
                                                                        scaleWithPhone4:NO
                                                                           needToUpdate:NO];
        NSAttributedString * placeholderStringPW = [[NSAttributedString alloc] initWithString:getLocalizationString(@"password")
                                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0f alpha:0.8f]}];
        self.passwordTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_validNumTextField.frame), CGRectGetWidth(containerView.frame), 40.0f) andEdgeInsetsValue:insetValue];
        [_passwordTextField setBackgroundColor:CDZColorOfClearColor];
        [_passwordTextField setTextAlignment:NSTextAlignmentLeft];
        [_passwordTextField setKeyboardType:UIKeyboardTypeDefault];
        [_passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_passwordTextField setReturnKeyType:UIReturnKeyDone];
        [_passwordTextField setEnablesReturnKeyAutomatically:YES];
        [_passwordTextField setSecureTextEntry:YES];
        [_passwordTextField setDelegate:self];
        [_passwordTextField setAttributedPlaceholder:placeholderStringPW];
        [_passwordTextField setInputAccessoryView:_toolBar];
        [_passwordTextField.layer addSublayer:[_passwordTextField createBottomBorderWithHeight:1.0f color:CDZColorOfWhite leftOffset:0.0f rightOffset:0.0f andBottomOffset:0.0f]];
        [containerView addSubview:_passwordTextField];
        
        UIImageView *pwIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
        [pwIcon setImage:pwImage];
        [_passwordTextField addSubview:pwIcon];
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        UIImage *repwImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                               fileName:@"repassword"
                                                                                   type:FMImageTypeOfPNG
                                                                        scaleWithPhone4:NO
                                                                           needToUpdate:NO];
        NSAttributedString * placeholderStringREPW = [[NSAttributedString alloc] initWithString:getLocalizationString(@"confirm_password")
                                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0f alpha:0.8f]}];
        self.repasswordTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_passwordTextField.frame), CGRectGetWidth(containerView.frame), 40.0f) andEdgeInsetsValue:insetValue];
        [_repasswordTextField setBackgroundColor:CDZColorOfClearColor];
        [_repasswordTextField setTextAlignment:NSTextAlignmentLeft];
        [_repasswordTextField setKeyboardType:UIKeyboardTypeDefault];
        [_repasswordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_repasswordTextField setReturnKeyType:UIReturnKeyDone];
        [_repasswordTextField setEnablesReturnKeyAutomatically:YES];
        [_repasswordTextField setSecureTextEntry:YES];
        [_repasswordTextField setDelegate:self];
        [_repasswordTextField setAttributedPlaceholder:placeholderStringREPW];
        [_repasswordTextField setInputAccessoryView:_toolBar];
        [_repasswordTextField.layer addSublayer:[_repasswordTextField createBottomBorderWithHeight:1.0f color:CDZColorOfWhite leftOffset:0.0f rightOffset:0.0f andBottomOffset:0.0f]];
        [containerView addSubview:_repasswordTextField];
        
        UIImageView *repwIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
        [repwIcon setImage:repwImage];
        [_repasswordTextField addSubview:repwIcon];

        
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        self.textAlertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_repasswordTextField.frame),
                                                                        CGRectGetWidth(containerView.frame), 40.0f)];
        [_textAlertLabel setBackgroundColor:CDZColorOfClearColor];
        [_textAlertLabel setFont:systemFont(16.0f)];
        [_textAlertLabel setTextColor:CDZColorOfRed];
        [_textAlertLabel setText:@"aaaaà"];
        [_textAlertLabel setAlpha:0];
        [_textAlertLabel setTextAlignment:NSTextAlignmentCenter];
        [containerView addSubview:_textAlertLabel];
        
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        self.viewShaker = [[AFViewShaker alloc] initWithView:containerView];
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        self.registerButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_registerButton setFrame:CGRectMake(0.0f, CGRectGetMaxY(containerView.frame), CGRectGetWidth(containerView.frame)*1.25f, 40.0f)];
        [_registerButton setCenter:CGPointMake(containerView.center.x, _registerButton.center.y)];
        [_registerButton setTitle:getLocalizationString(_isRegisterType?@"register":@"ok") forState:UIControlStateNormal];
        [_registerButton setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_registerButton setTitleColor:CDZColorOfDefaultColor forState:UIControlStateDisabled];
        [_registerButton.layer setCornerRadius:10.0f];
        [_registerButton.titleLabel setFont:systemFontBold(20.0f)];
        [_registerButton addTarget:self
                            action:(_isRegisterType)?@selector(submitRegister):@selector(submitForgetPW)
                  forControlEvents:UIControlEventTouchUpInside];
        [self.blurView addSubview:_registerButton];
        
        
    }
}

- (void)setTextFieldRelativeRule {
    
    @weakify(self)
    RACSignal *validUserPhoneSignal = [self.phoneNumTextField.rac_textSignal
                                      map:^id(NSString *text) {
                                          NSScanner *scanner = [NSScanner scannerWithString:text];
                                          BOOL isNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
                                          BOOL phoneStrReady = text.length>=11&&isNumeric;
                                          @strongify(self)
                                          self.validCodeBtn.userPhone = phoneStrReady?@(text.longLongValue):nil;
                                          return @(phoneStrReady);
                                      }];
    
    RACSignal *validValidCodeSignal = [self.validNumTextField.rac_textSignal
                                      map:^id(NSString *text) {
                                          NSScanner *scanner = [NSScanner scannerWithString:text];
                                          BOOL isNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
                                          return @((text.length>=4||text.length<=6)&&isNumeric);
                                      }];
    

    
    RACSignal *passwordMatchSignal = [RACSignal combineLatest:@[self.passwordTextField.rac_textSignal, self.repasswordTextField.rac_textSignal]
                                                      reduce:^id(NSString *password, NSString *repassword ) {
                                                          @strongify(self)
                                                          BOOL isMatchLengthRequest = (password.length>=6 && repassword.length>=6);
                                                          BOOL isStringMatch = [password isEqualToString:repassword];
                                                          self.textAlertLabel.alpha = 0.0f;
                                                          if (isMatchLengthRequest) {
                                                              self.textAlertLabel.alpha = isStringMatch?0.0f:1.0f;
                                                              self.textAlertLabel.text = isStringMatch?@"":@"密码不相称";
                                                          }
                                                          return @(isMatchLengthRequest && isStringMatch);
                                                      }];
    
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUserPhoneSignal, validValidCodeSignal, passwordMatchSignal]
                                                      reduce:^id(NSNumber *userPhoneValid, NSNumber *validCodeValid, NSNumber *passwordMatchValid) {
                                                          return @(userPhoneValid.boolValue && validCodeValid.boolValue && passwordMatchValid.boolValue);
                                                      }];
    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        @strongify(self)
        self.registerButton.enabled = [signupActive boolValue];
        [self.registerButton setBorderWithColor:[signupActive boolValue]?CDZColorOfWhite:CDZColorOfDefaultColor borderWidth:1.0f];
    }];
    
    [RACObserve(self, validCodeBtn.isRequested) subscribeNext:^(NSNumber *isRequested) {
        @strongify(self)
        self.validNumTextField.enabled = isRequested.boolValue;
    }];
    
    [validUserPhoneSignal subscribeNext:^(NSNumber *userPhoneValid) {
        self.validCodeBtn.isReady = userPhoneValid.boolValue;
        self.validCodeBtn.enabled = (userPhoneValid.boolValue||self.validCodeBtn.isRequested);
    }];

    if (!_isRegisterType) {
        [_phoneNumTextField setText:@"18570399156"];
        [_phoneNumTextField sendActionsForControlEvents:UIControlEventEditingChanged];
    }
}

#pragma mark- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self hideAlertLabel];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignKeyboard];
    return YES;
}

#pragma mark- Loging Action Section
- (void)submitRegister {
    [self resignKeyboard];
    [ProgressHUDHandler showHUD];
    
    [UserBehaviorHandler.shareInstance userRegisterWithUserPhone:_phoneNumTextField.text validCode:_validNumTextField.text password:_passwordTextField.text repassword:_repasswordTextField.text success:^{
        @weakify(self)
        [ProgressHUDHandler showSuccessWithStatus:getLocalizationString(@"register_success") onView:nil completion:^{
            @strongify(self)
            [self dismissSelf];
        }];
    } failure:^(NSString *errorMessage, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [self showAlertLabel:errorMessage];
    }];
    
    
}


- (void)submitForgetPW {
    [self resignKeyboard];
    [ProgressHUDHandler showHUD];
    [UserBehaviorHandler.shareInstance userForgotPasswordWithUserPhone:_phoneNumTextField.text validCode:_validNumTextField.text password:_passwordTextField.text repassword:_repasswordTextField.text success:^{
        @weakify(self)
        [ProgressHUDHandler showSuccessWithStatus:getLocalizationString(@"pw_update_success") onView:nil completion:^{
            @strongify(self)
            [self dismissSelf];
        }];
    } failure:^(NSString *errorMessage, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [self showAlertLabel:errorMessage];
    }];
    
    
}

/*
#pragma mark- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
