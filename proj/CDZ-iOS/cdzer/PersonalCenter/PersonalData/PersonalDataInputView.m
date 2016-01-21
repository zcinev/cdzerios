//
//  PersonalDataInputView.m
//  cdzer
//
//  Created by KEns0n on 4/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vPWTypeContentHeight 260.0f
#define vNormalTypeContentHeight 160.0f
#define vNoneTypeContentHeight 110.0f
#import "PersonalDataInputView.h"
#import "InsetsTextField.h"
#import "InsetsLabel.h"
#import "UIView+ShareAction.h"
#import "AFViewShaker.h"
#import <UIView+Borders/UIView+Borders.h>

@interface PersonalDataInputView () <UITextFieldDelegate>

@property (nonatomic, strong) AFViewShaker *viewShaker;

@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, strong) InsetsLabel *titleLabel;

@property (nonatomic, strong) InsetsTextField *commonTextField;

@property (nonatomic, strong) InsetsTextField *fnewPWTextField;

@property (nonatomic, strong) InsetsTextField *renewPWTextField;

@property (nonatomic, strong) UISegmentedControl *genderControl;

@property (nonatomic, copy) PDCompletionBlock completionBlock;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UIView *contentsView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation PersonalDataInputView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (instancetype)init {
    if (self = [self initWithFrame:CGRectZero]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        [self initializationUI];
        self.inputType = PDInputTypeOfNone;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)initializationUI {
    @autoreleasepool {
        self.alpha = 0.0f;
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.65f];
        
        UIEdgeInsets insetValueLeft = UIEdgeInsetsMake(0.0f, 12.0f, 0.0f, 0.0f);
        UIEdgeInsets insetValueRight = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 12.0f);
        UIEdgeInsets insetValueCenter = UIEdgeInsetsMake(0.0f, 12.0f, 0.0f, 12.0f);
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.scrollEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = CDZColorOfClearColor;
        [self addSubview:_scrollView];
        self.contentsView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 260.0f)];
        _contentsView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f);
        _contentsView.backgroundColor = CDZColorOfWhite;
        [_contentsView setViewCornerWithRectCorner:UIRectCornerAllCorners
                                        cornerSize:5.0f];
        [_scrollView addSubview:_contentsView];
        
        self.titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                                CGRectGetWidth(_contentsView.frame), 50.0f)
                                                           andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 12.0f, 0.0f, 12.0f)];
        _titleLabel.font = systemFontBoldWithoutRatio(22.0f);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = getLocalizationString(@"over_speed_setting");
        [_contentsView addSubview:_titleLabel];
        
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        CGFloat textFieldHeight = 50.0f;
        self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 44.0f)];
        [_toolbar setBarStyle:UIBarStyleDefault];
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:self
                                                                                    action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"finish")
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(hiddenKeyboard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButton,doneButton,nil];
        [_toolbar setItems:buttonsArray];
        
        
        InsetsLabel *commonTitleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0f, textFieldHeight)
                                                                 andEdgeInsetsValue:insetValueLeft];
        commonTitleLabel.tag = 101;
        commonTitleLabel.text = getLocalizationString(@"old_password");
        UIEdgeInsets tmpInsets1 = insetValueCenter;
        tmpInsets1.left = CGRectGetWidth(commonTitleLabel.frame);
        self.commonTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_contentsView.frame), textFieldHeight)
                                                           andEdgeInsetsValue:tmpInsets1];
        _commonTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _commonTextField.textAlignment = NSTextAlignmentLeft;
        _commonTextField.returnKeyType = UIReturnKeyDone;
        _commonTextField.delegate = self;
        _commonTextField.inputAccessoryView = _toolbar;
        [_contentsView addSubview:_commonTextField];
        [_commonTextField addSubview:commonTitleLabel];

        
        
        
        
        InsetsLabel *fnewPWTitleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0f, textFieldHeight)
                                                                 andEdgeInsetsValue:insetValueLeft];
        fnewPWTitleLabel.tag = 101;
        fnewPWTitleLabel.text = getLocalizationString(@"new_password");
        UIEdgeInsets tmpInsets2 = insetValueCenter;
        tmpInsets2.left = CGRectGetWidth(fnewPWTitleLabel.frame);
        self.fnewPWTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_commonTextField.frame), CGRectGetWidth(_contentsView.frame), textFieldHeight)
                                                           andEdgeInsetsValue:tmpInsets2];
        _fnewPWTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _fnewPWTextField.textAlignment = NSTextAlignmentLeft;
        _fnewPWTextField.returnKeyType = UIReturnKeyDone;
        _fnewPWTextField.delegate = self;
        _fnewPWTextField.inputAccessoryView = _toolbar;
        _fnewPWTextField.secureTextEntry = YES;
        _fnewPWTextField.keyboardType = UIKeyboardTypeDefault;
        [_fnewPWTextField addTopBorderWithHeight:1 color:CDZColorOfDeepGray
                                      leftOffset:insetValueLeft.left
                                     rightOffset:0.0f andTopOffset:0.0f];
        [_contentsView addSubview:_fnewPWTextField];
        [_fnewPWTextField addSubview:fnewPWTitleLabel];
        
        
        
        
        InsetsLabel *renewPWTitleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 120.0f, textFieldHeight)
                                                                  andEdgeInsetsValue:insetValueLeft];
        renewPWTitleLabel.tag = 101;
        renewPWTitleLabel.text = getLocalizationString(@"confirm_new_password");
        UIEdgeInsets tmpInsets3 = insetValueCenter;
        tmpInsets3.left = CGRectGetWidth(renewPWTitleLabel.frame);
        self.renewPWTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_fnewPWTextField.frame), CGRectGetWidth(_contentsView.frame), textFieldHeight)
                                                           andEdgeInsetsValue:tmpInsets3];
        _renewPWTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _renewPWTextField.textAlignment = NSTextAlignmentLeft;
        _renewPWTextField.returnKeyType = UIReturnKeyDone;
        _renewPWTextField.delegate = self;
        _renewPWTextField.inputAccessoryView = _toolbar;
        _renewPWTextField.keyboardType = UIKeyboardTypeDefault;
        _renewPWTextField.secureTextEntry = YES;
        [_renewPWTextField addTopBorderWithHeight:1 color:CDZColorOfDeepGray
                                      leftOffset:insetValueLeft.left
                                     rightOffset:0.0f andTopOffset:0.0f];
        [_contentsView addSubview:_renewPWTextField];
        [_renewPWTextField addSubview:renewPWTitleLabel];
        
        
        
        self.viewShaker = [[AFViewShaker alloc] initWithView:_contentsView];
        
        
        CGRect genderControlRect = _commonTextField.frame;
        genderControlRect.origin.x = insetValueLeft.left;
        genderControlRect.size.width = CGRectGetWidth(genderControlRect)-insetValueLeft.left*2.0f;
        genderControlRect.size.height = CGRectGetHeight(genderControlRect)*0.8;
        self.genderControl = [[UISegmentedControl alloc] initWithItems:@[getLocalizationString(@"female"), getLocalizationString(@"male")]];
        _genderControl.frame = genderControlRect;
        _genderControl.selectedSegmentIndex = 0;
        _genderControl.center = _commonTextField.center;
        _genderControl.tintColor = CDZColorOfDefaultColor;
        [_contentsView addSubview:_genderControl];
        
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
        dateComponents.year -= 100;
        self.datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.maximumDate = [NSDate date];
        _datePicker.minimumDate = [calendar dateFromComponents:dateComponents];
        _datePicker.date = _datePicker.maximumDate;
        [_datePicker addTarget:self action:@selector(datePickeValeChange:) forControlEvents:UIControlEventValueChanged];
        
        
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame = CGRectMake(0, CGRectGetHeight(_contentsView.frame)-50.0f, CGRectGetWidth(_contentsView.frame)/2.0f, 50.0f);
        _cancelButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _cancelButton.titleLabel.font = systemFontWithoutRatio(16.0f);
        [_cancelButton setTitle:getLocalizationString(@"cancel") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(hiddenSelfView) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton addTopBorderWithHeight:1 andColor:CDZColorOfDeepGray];
        [_cancelButton addRightBorderWithWidth:0.5 andColor:CDZColorOfDeepGray];
        [_contentsView addSubview:_cancelButton];
        
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.frame = CGRectMake(CGRectGetWidth(_contentsView.frame)/2.0f, CGRectGetHeight(_contentsView.frame)-50.0f, CGRectGetWidth(_contentsView.frame)/2.0f, 50.0f);
        _confirmButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _confirmButton.titleLabel.font = systemFontBoldWithoutRatio(16.0f);
        [_confirmButton setTitle:getLocalizationString(@"ok") forState:UIControlStateNormal];
        [_confirmButton setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmSetting) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton addTopBorderWithHeight:1 andColor:CDZColorOfDeepGray];
        [_confirmButton addLeftBorderWithWidth:0.5 andColor:CDZColorOfDeepGray];
        [_contentsView addSubview:_confirmButton];
    }
}

- (void)setInputType:(PDInputType)inputType {
    [self setInputType:inputType withOriginalValue:nil];
}

- (void)setInputType:(PDInputType)inputType withOriginalValue:(NSString *)originalValue {
    if (!originalValue) originalValue = @"";
    CGRect contentRect = _contentsView.frame;
    _commonTextField.edgeInsets = UIEdgeInsetsMake(0.0f, 12.0f, 0.0f, 12.0f);
    InsetsLabel *titleLabel = (InsetsLabel *)[_commonTextField viewWithTag:101];
    _commonTextField.textAlignment = NSTextAlignmentCenter;
    _commonTextField.inputView = nil;
    _commonTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    contentRect.size.height = vNormalTypeContentHeight;
    titleLabel.hidden = YES;
    _commonTextField.hidden = NO;
    _commonTextField.text = originalValue;
    _fnewPWTextField.hidden = YES;
    _fnewPWTextField.text = @"";
    _renewPWTextField.hidden = YES;
    _fnewPWTextField.text = @"";
    _genderControl.hidden = YES;
    _commonTextField.secureTextEntry = NO;
    _commonTextField.keyboardType = UIKeyboardTypeDefault;
    
    switch (inputType) {
        case PDInputTypeOfPasswordChange:
            [self setTitle:@"pwd_change"];
            _commonTextField.placeholder = @"";
            _commonTextField.textAlignment = NSTextAlignmentLeft;
            _commonTextField.secureTextEntry = YES;
            _commonTextField.hidden = NO;
            _fnewPWTextField.hidden = NO;
            _renewPWTextField.hidden = NO;
            titleLabel.hidden = NO;
            contentRect.size.height = vPWTypeContentHeight;
            _commonTextField.edgeInsets = UIEdgeInsetsMake(0.0f, CGRectGetWidth(titleLabel.frame), 0.0f, 12.0f);
            break;

        case PDInputTypeOfGenderSelection:
            _commonTextField.text = nil;
            _genderControl.selectedSegmentIndex = 0;
            if ([originalValue isEqualToString:getLocalizationString(@"male")]) {
            _genderControl.selectedSegmentIndex = 1;
            }
            [self setTitle:@"gender"];
            _genderControl.hidden = NO;
            _commonTextField.hidden = YES;
            break;
            
        case PDInputTypeOfEmailChange:
            [self setTitle:@"email"];
            _commonTextField.keyboardType = UIKeyboardTypeEmailAddress;
            _commonTextField.placeholder = getLocalizationString(@"input_email");
            break;
        
        case PDInputTypeOfDOBChange:{
            _datePicker.date = _datePicker.maximumDate;
            if (originalValue) {
                NSDate *date = nil;
                date = [_dateFormatter dateFromString:originalValue];
                NSLog(@"%@",date);
                if (date) {
                    _datePicker.date = date;
                }
            }
            [self setTitle:@"dob"];
            _commonTextField.inputView = _datePicker;
            _commonTextField.clearButtonMode = UITextFieldViewModeNever;
            _commonTextField.placeholder = getLocalizationString(@"select_dob");
        }
            break;
            
        case PDInputTypeOfQQChange:
            [self setTitle:@"qq_number"];
            _commonTextField.keyboardType = UIKeyboardTypeNumberPad;
            _commonTextField.placeholder = getLocalizationString(@"input_qq");

            break;
            
        case PDInputTypeOfUserNameChange:
            [self setTitle:@"user_name"];
            _commonTextField.placeholder = getLocalizationString(@"input_user_name");
            break;
            
        case PDInputTypeOfNone:
        default:
            contentRect.size.height = vNoneTypeContentHeight;
            _commonTextField.hidden = YES;
            [self setTitle:@""];
            break;
    }
    _contentsView.frame = contentRect;
    _contentsView.center = CGPointMake(_contentsView.center.x, CGRectGetHeight(_scrollView.frame)/2.0f);
    _inputType = inputType;
}

- (void)setTitle:(NSString *)title {
    if (!title||[title isEqualToString:@""]){
        _titleLabel.text = @"未命名";
        return;
    }
    _titleLabel.text = [getLocalizationString(title) stringByReplacingOccurrencesOfString:@"：" withString:@""];
}

- (void)hiddenSelfAndSuccess:(BOOL)isSuccess {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.alpha = 0.0f;
        [self hiddenKeyboard];
    }];
}

- (void)hiddenSelfView {
    [self hiddenSelfAndSuccess:NO];
}

- (void)showView {
//    if (_inputType==PDInputTypeOfNone) return;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.alpha = 1.0f;
        [self hiddenKeyboard];
    }];
}

- (void)setPDCompletionBlock:(PDCompletionBlock)completionBlock {
    self.completionBlock = completionBlock;
}

- (void)datePickeValeChange:(UIDatePicker *)datePicker {
    self.commonTextField.text = [_dateFormatter stringFromDate:datePicker.date];
}

- (void)confirmSetting {
    if (_inputType==PDInputTypeOfNone) return;
    
    if (_inputType==PDInputTypeOfPasswordChange)
    {
        if(!_commonTextField.text||[_commonTextField.text isEqualToString:@""]){
            [_viewShaker shake];
            return;
        }else if(!_fnewPWTextField.text||[_fnewPWTextField.text isEqualToString:@""]){
            [_viewShaker shake];
            return;
        }else if(!_renewPWTextField.text||[_renewPWTextField.text isEqualToString:@""]){
            [_viewShaker shake];
            return;
        }else if(![_fnewPWTextField.text isEqualToString:_renewPWTextField.text]){
            [_viewShaker shake];
            return;
        }
        
        [self updateUserPassword];
        return;
    }
    
    if (_inputType!=PDInputTypeOfGenderSelection) {
        if (!_commonTextField.text||[_commonTextField.text isEqualToString:@""]) {
            [_viewShaker shake];
            return;
        }
    }
    [self updateUserInfomation];
}

- (void)responseDataUpdate {
    @autoreleasepool {
        if (_completionBlock&&_inputType!=PDInputTypeOfNone) {
            NSDictionary *resultData = nil;
            switch (_inputType) {
                case PDInputTypeOfEmailChange:
                case PDInputTypeOfDOBChange:
                case PDInputTypeOfQQChange:
                case PDInputTypeOfUserNameChange:
                    resultData = @{PDInputKeyFirstValue:_commonTextField.text};
                    break;
                    
                case PDInputTypeOfPasswordChange:
                    resultData = @{PDInputKeyFirstValue:_commonTextField.text,
                                   PDInputKeySecondValue:_fnewPWTextField.text,
                                   PDInputKeyThirdValue:_renewPWTextField.text};
                    break;
                    
                case PDInputTypeOfGenderSelection:
                    resultData = @{PDInputKeyFirstValue:getLocalizationString((_genderControl.selectedSegmentIndex)?@"male":@"female")};
                    break;
                    
                default:
                    break;
            }
            if (resultData) {
                self.completionBlock(_inputType, resultData);
                [self hiddenSelfView];
            }else {
                NSLog(@"Error!! No Data Return!!!");
            }
        }
    }
    
}

//Handle Keyboard Appear
- (void)hiddenKeyboard {
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        [self.commonTextField resignFirstResponder];
        [self.fnewPWTextField resignFirstResponder];
        [self.renewPWTextField resignFirstResponder];
        self.scrollView.contentOffset = CGPointMake(0.0f, 0.0f);

    }];
}

- (void)shiftScrollViewWithAnimation:(UITextField *)textField {
    if (!textField) return;
    CGPoint point = CGPointZero;
    CGFloat contanierViewMaxY = CGRectGetMinY(_contentsView.frame)+CGRectGetMidY(textField.frame);
    CGFloat visibleContentsHeight = (CGRectGetHeight(_scrollView.frame)-CGRectGetHeight(_keyboardRect))/2.0f;
    if (contanierViewMaxY > visibleContentsHeight) {
        CGFloat offsetY = contanierViewMaxY-visibleContentsHeight;
        point.y = offsetY;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = point;
    }];
    
}
    
- (void)keyboardWillAppear:(NSNotification *)notiObject {
    CGRect rect = [notiObject.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        self.keyboardRect = rect;
        UITextField *textField = _commonTextField;
        if ([_fnewPWTextField isFirstResponder]) textField = _fnewPWTextField;
        if ([_renewPWTextField isFirstResponder]) textField = _renewPWTextField;
        [self shiftScrollViewWithAnimation:textField];
    }
}

#pragma mark- UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self hiddenKeyboard];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        [self shiftScrollViewWithAnimation:textField];
    }
    return YES;
}


- (void)showLoadingInPickerSuperview:(NSString *)title {
    @autoreleasepool {
        UIView *view = _toolbar.superview.superview;
        if (view) {
            [ProgressHUDHandler showHUDWithTitle:title onView:view];
        }else {
            [ProgressHUDHandler showHUDWithTitle:title onView:nil];
        }
    }
}
#pragma mark- APIs Access Request
- (void)updateUserInfomation {
    if (!vGetUserToken) return;
    [self showLoadingInPickerSuperview:@"更新资料中...."];
    NSString *userName = (_inputType==PDInputTypeOfUserNameChange)?_commonTextField.text:nil;
    NSNumber *gender = (_inputType==PDInputTypeOfGenderSelection)?@(_genderControl.selectedSegmentIndex):nil;
    NSString *dob = (_inputType==PDInputTypeOfDOBChange)?_commonTextField.text:nil;
    NSNumber *qqNumber = (_inputType==PDInputTypeOfQQChange)?@(_commonTextField.text.integerValue):nil;
    NSString *email = (_inputType==PDInputTypeOfEmailChange)?_commonTextField.text:nil;
    
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPatchUserPersonalInformationWithAccessToken:vGetUserToken byPortraitPath:nil autoInfo:nil mobileNumber:nil nickName:userName sexual:gender bod:dob  qqNumber:qqNumber email:email success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self)
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [ProgressHUDHandler showSuccessWithStatus:@"更新成功"  onView:nil completion:^{
            [self responseDataUpdate];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"更新资料失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
           
        }];
    }];
}

- (void)updateUserPassword {
    if (!vGetUserToken) return;
    [self showLoadingInPickerSuperview:@"更新密码中...."];
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPostUserChangePasswordWithAccessToken:vGetUserToken oldPassword:_commonTextField.text newPassword:_fnewPWTextField.text newPasswordAgain:_renewPWTextField.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self)
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [ProgressHUDHandler showSuccessWithStatus:@"更新成功"  onView:nil completion:^{
            [self responseDataUpdate];
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"更新密码失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
