//
//  UserLoginVC.m
//  cdzer
//
//  Created by KEns0n on 4/15/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "UserLoginVC.h"
#import "InsetsTextField.h"
#import <FXBlurView/FXBlurView.h>
#import "AFViewShaker.h"
#import <UIView+Borders/UIView+Borders.h>
#import "UserAutosInfoDTO.h"
#import "UserRegisterVC.h"

@interface UserLoginVC () <UITextFieldDelegate>

@property (nonatomic, strong) AFViewShaker *viewShaker;

@property (nonatomic, strong) InsetsTextField * phoneNumTextField;

@property (nonatomic, strong) InsetsTextField * passwordTextField;

@property (nonatomic, strong) UILabel *textAlertLabel;

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation UserLoginVC

- (void)dealloc {
    self.viewShaker = nil;
    self.phoneNumTextField = nil;
    self.passwordTextField = nil;
    self.textAlertLabel = nil;
    self.blurView = nil;
    self.toolBar = nil;
    self.loginButton = nil;
    if (_timer && [_timer isValid]){
        [_timer invalidate];
        self.timer = nil;
    }
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.contentView setBackgroundColor:CDZColorOfDefaultColor];
//    UIImage *image = [UIImage imageNamed:@"LaunchImage"];
//    [self.contentView setBackgroundImageByCALayerWithImage:image];
    [self initializationUI];   // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Action
- (void)dismissSelf {
    if (self.accessToken||[UserBehaviorHandler.shareInstance.getUserID isEqualToString:@"0"]) {
        [UserBehaviorHandler.shareInstance userLogoutWasPopupDialog:NO andCompletionBlock:^{}];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)resignKeyboard {
    [_phoneNumTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
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
        [backPreviousBtn setFrame:CGRectMake(0.0f, 0.0f, 70.0f, 50.0f)];
        [backPreviousBtn setTintColor:CDZColorOfClearColor];
        [backPreviousBtn setTitle:@"X" forState:UIControlStateNormal];
        [backPreviousBtn setTitle:@"X" forState:UIControlStateHighlighted];
        [backPreviousBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [backPreviousBtn setTitleColor:CDZColorOfWhite forState:UIControlStateHighlighted];
        [backPreviousBtn.titleLabel setFont:systemFont(24.0f)];
        [backPreviousBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -25.0f, 0.0f, 0.0f)];
        [backPreviousBtn addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        [_blurView addSubview:backPreviousBtn];
        
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [registerBtn setFrame:CGRectMake(CGRectGetWidth(self.contentView.frame)-90.0f, 0.0f, 80.0f, 50.0f)];
        [registerBtn setTintColor:CDZColorOfClearColor];
        [registerBtn setTitle:getLocalizationString(@"register") forState:UIControlStateNormal];
        [registerBtn setTitle:getLocalizationString(@"register") forState:UIControlStateHighlighted];
        [registerBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [registerBtn setTitleColor:CDZColorOfWhite forState:UIControlStateHighlighted];
        [registerBtn.titleLabel setFont:systemFont(24.0f)];
//        [registerBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, -10.0f)];
        [registerBtn addTarget:self action:@selector(showRegisterView) forControlEvents:UIControlEventTouchUpInside];
        [_blurView addSubview:registerBtn];
        

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame)*0.75f, 120.0f)];
        [containerView setBackgroundColor:[UIColor colorWithRed:0.800f green:0.800f blue:0.800f alpha:0.00f]];
        [containerView setCenter:CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0f, CGRectGetHeight(self.contentView.frame)/2.0f-vAdjustByScreenRatio(80.0f))];
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
        UIImage *pwImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                               fileName:@"password"
                                                                                   type:FMImageTypeOfPNG
                                                                        scaleWithPhone4:NO
                                                                           needToUpdate:NO];
        NSAttributedString * placeholderStringPW = [[NSAttributedString alloc] initWithString:getLocalizationString(@"password")
                                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1.0f alpha:0.8f]}];
        self.passwordTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_phoneNumTextField.frame), CGRectGetWidth(containerView.frame), 40.0f) andEdgeInsetsValue:insetValue];
        [_passwordTextField setBackgroundColor:CDZColorOfClearColor];
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
        self.textAlertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_passwordTextField.frame),
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
        
        self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_loginButton setFrame:CGRectMake(0.0f, CGRectGetMaxY(containerView.frame), CGRectGetWidth(containerView.frame)*1.25f, 40.0f)];
        [_loginButton setCenter:CGPointMake(containerView.center.x, _loginButton.center.y)];
        [_loginButton setTitle:getLocalizationString(@"login") forState:UIControlStateNormal];
        [_loginButton setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_loginButton setTitleColor:CDZColorOfDefaultColor forState:UIControlStateDisabled];
        [_loginButton.layer setCornerRadius:10.0f];
        [_loginButton.titleLabel setFont:systemFontBold(20.0f)];
        [_loginButton addTarget:self action:@selector(submitLogin) forControlEvents:UIControlEventTouchUpInside];
        [self.blurView addSubview:_loginButton];
        
        
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        [self setTextFieldRelativeRule];
    }
}

- (void)setTextFieldRelativeRule {
    
    RACSignal *validUsernameSignal = [self.phoneNumTextField.rac_textSignal
                                      map:^id(NSString *text) {
                                          return @(text.length>=11);
                                      }];
    
    RACSignal *validPasswordSignal = [self.passwordTextField.rac_textSignal
                                      map:^id(NSString *text) {
                                          return @(text.length>=6);
                                      }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
                                                      reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid) {
                                                          return @([usernameValid boolValue] && [passwordValid boolValue]);
                                                      }];
    @weakify(self)
    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        @strongify(self)
        self.loginButton.enabled = [signupActive boolValue];
        [self.loginButton setBorderWithColor:[signupActive boolValue]?CDZColorOfWhite:CDZColorOfDefaultColor borderWidth:1.0f];
    }];
    
    _phoneNumTextField.text = @"18900777877";//@"18570399156";//@"15674914800";
    _passwordTextField.text = @"123456";

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
- (void)submitLogin {
    [self resignKeyboard];
    [ProgressHUDHandler showHUD];
    
    [UserBehaviorHandler.shareInstance userLoginWithUserPhone:_phoneNumTextField.text password:_passwordTextField.text success:^{
        @weakify(self)
        [ProgressHUDHandler showSuccessWithStatus:getLocalizationString(@"login_success") onView:nil completion:^{
            @strongify(self)
            [self dismissSelf];
            [[NSNotificationCenter defaultCenter] postNotificationName:CDZNotiKeyOfTokenUpdate object:nil];
        }];
    } failure:^(NSString *errorMessage, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [self showAlertLabel:errorMessage];
    }];
    
    
}

- (void)showRegisterView {
    @autoreleasepool {
        UserRegisterVC *vc = [UserRegisterVC new];
        vc.isRegisterType = YES;
        [self presentViewController:vc animated:YES completion:nil];
    }
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
