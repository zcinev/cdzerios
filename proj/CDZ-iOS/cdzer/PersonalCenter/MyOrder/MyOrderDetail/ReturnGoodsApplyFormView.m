//
//  ReturnGoodsApplyFormView.m
//  cdzer
//
//  Created by KEns0n on 6/11/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#import "ReturnGoodsApplyFormView.h"
#import "InsetsTextField.h"
#import "InsetsTextField.h"
#import "AFViewShaker.h"
#define vContentViewOffsetValue ((IS_IPHONE_6||IS_IPHONE_6P)?600.0f:480.0f)*0.7f

@interface ReturnGoodsApplyFormView ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) InsetsTextField *textField;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *contentsView;

@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) RGAPCompletionBlock completionBlock;

@property (nonatomic, strong) AFViewShaker *viewShaker;

@property (nonatomic, assign) BOOL isTextFieldReady;

@property (nonatomic, assign) BOOL isTextViewReady;

@end

@implementation ReturnGoodsApplyFormView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (instancetype)init {
    if (self = [super init]){
        [self initializationUI];
        [self setReactiveRules];
    }
    return self;
}

- (void)setReactiveRules {
    @weakify(self)
    [_textField sendActionsForControlEvents:UIControlEventEditingChanged];
    self.textView.text = @"";
    self.isTextFieldReady = NO;
    self.isTextViewReady = NO;
    [_textField.rac_textSignal subscribeNext:^(NSString *string) {
        @strongify(self)
        NSString *trimedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.isTextFieldReady = (trimedString.length>7);
    }];
    
    [_textView.rac_textSignal subscribeNext:^(NSString *string) {
        @strongify(self)
        NSString *trimedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.isTextViewReady = (trimedString.length>12);
    }];
}

- (void)initializationUI {
    @autoreleasepool {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _scrollView.scrollEnabled = NO;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)*2.0f);
        _scrollView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
        _scrollView.alpha = 0.0f;
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_scrollView.frame), 44.0f)];
        [toolbar setBarStyle:UIBarStyleDefault];
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:self
                                                                                    action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"finish")
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(hiddenKeyboard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButton,doneButton,nil];
        [toolbar setItems:buttonsArray];
        
        CGRect contentViewRect = _scrollView.bounds;
        contentViewRect.origin.y = CGRectGetHeight(_scrollView.frame);
        contentViewRect.origin.x = CGRectGetWidth(_scrollView.frame)*0.05;
        contentViewRect.size.width -= CGRectGetWidth(_scrollView.frame)*0.1;
        self.contentsView = [[UIView alloc] initWithFrame:contentViewRect];
        _contentsView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.85];
        _contentsView.alpha = 0.0f;
        [_contentsView setViewCornerWithRectCorner:UIRectCornerTopLeft|UIRectCornerTopRight cornerSize:5.0f];
        [_scrollView addSubview:_contentsView];
        
        CGFloat offset = CGRectGetWidth(_contentsView.frame)*0.05f;
        CGFloat width = CGRectGetWidth(_contentsView.frame)-offset*2.0f;
        
        UILabel *reasonLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset, offset, width, 30.f)];
        reasonLabel.text = @"退货理由：";
        [_contentsView addSubview:reasonLabel];
        
        self.textField = [[InsetsTextField alloc] initWithFrame:CGRectMake(offset, CGRectGetMaxY(reasonLabel.frame), width, 40.0f)
                                                     andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 5.0f)];
        _textField.font = systemFontWithoutRatio(17.0f);
        _textField.backgroundColor = CDZColorOfWhite;
        _textField.delegate = self;
        _textField.inputAccessoryView = toolbar;
        [_textField setBorderWithColor:nil borderWidth:0.5f];
        [_textField setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [_contentsView addSubview:_textField];
        
        
        UILabel *returnDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset, CGRectGetMaxY(_textField.frame)+offset, width, 30.f)];
        returnDetailLabel.text = @"退货详情：";
        [_contentsView addSubview:returnDetailLabel];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(offset, CGRectGetMaxY(returnDetailLabel.frame),
                                                                     width, (IS_IPHONE_6||IS_IPHONE_6P)?180.0f:120.0f)];
        _textView.font = systemFontWithoutRatio(15.0f);
        _textView.delegate = self;
        _textView.inputAccessoryView = toolbar;
        [_textView setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [_textView setBorderWithColor:nil borderWidth:0.5f];
        [_contentsView addSubview:_textView];
        
        
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame = CGRectMake(0, CGRectGetMaxY(_textView.frame)+offset, CGRectGetWidth(_contentsView.frame)/2.0f, 40.0f);
        _cancelButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _cancelButton.titleLabel.font = systemFontWithoutRatio(16.0f);
        [_cancelButton setTitle:getLocalizationString(@"cancel") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(hiddenSelfView) forControlEvents:UIControlEventTouchUpInside];
        [_contentsView addSubview:_cancelButton];
        
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmButton.frame = CGRectMake(CGRectGetWidth(_contentsView.frame)/2.0f, CGRectGetMaxY(_textView.frame)+offset, CGRectGetWidth(_contentsView.frame)/2.0f, 40.0f);
        _confirmButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        _confirmButton.titleLabel.font = systemFontBoldWithoutRatio(16.0f);
        [_confirmButton setTitle:getLocalizationString(@"ok") forState:UIControlStateNormal];
        [_confirmButton setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmSetting) forControlEvents:UIControlEventTouchUpInside];
        [_contentsView addSubview:_confirmButton];
        
        self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:@[_textView,_textField]];
    }
}

- (void)hiddenSelfView {
    _textView.text = @"";
    _textField.text = @"";
    [self dismissViewWithCompletionBlock:nil];
}

- (void)confirmSetting {
    
    if (_isTextFieldReady&&_isTextViewReady) {
        [self applyReturnGoods];
        [self hiddenKeyboard];
    }else {
        
        if (!_isTextFieldReady&&!_isTextViewReady) {
            [_viewShaker shake];
            return;
        }
        
        if (!_isTextFieldReady) {
            [_viewShaker shakeByView:_textField];
            [_textField becomeFirstResponder];
        }
        
        if (!_isTextViewReady) {
            [_viewShaker shakeByView:_textView];
            [_textView becomeFirstResponder];
        }
    }
}

- (void)setupCompletionBlock:(RGAPCompletionBlock)completionBlock {
    self.completionBlock = completionBlock;
}

//Handle Keyboard Appear
- (void)hiddenKeyboard {
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        [self.textField resignFirstResponder];
        [self.textView resignFirstResponder];
        self.scrollView.contentOffset = CGPointMake(0.0f, vContentViewOffsetValue);
        
    }];
}

- (void)shiftScrollViewWithAnimation:(UIView *)textInputView {
    if (!textInputView) return;
    CGPoint point = CGPointZero;
    CGFloat contanierViewMaxY = CGRectGetMinY(_contentsView.frame)+CGRectGetMidY(textInputView.frame);
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
        UIView *textInputView = _textField;
        if ([_textView isFirstResponder]) {
            textInputView = _textView;
        }
        [self shiftScrollViewWithAnimation:textInputView];
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


#pragma mark- UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (!CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        [self shiftScrollViewWithAnimation:textView];
    }
    return YES;
}

- (void)showView {    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    if (self.scrollView.superview) {
        [self.scrollView removeFromSuperview];
        self.scrollView.alpha = 0.0f;
    }
    [UIApplication.sharedApplication.keyWindow addSubview:self.scrollView];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.alpha = 1.0f;
        self.contentsView.alpha = 1.0f;
        self.scrollView.contentOffset = CGPointMake(0.0f, vContentViewOffsetValue);
    }];
}

- (void)dismissViewWithCompletionBlock:(void (^)(void))completion {
    [self hiddenKeyboard];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.alpha = 0.0f;
        self.contentsView.alpha = 0.0f;
        self.scrollView.contentOffset = CGPointMake(0.0f, 0.0f);
    } completion:^(BOOL finished) {
        [self.scrollView removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}

- (void)applyReturnGoods {
    if (!vGetUserToken||!_mainOrderID) return;
    [ProgressHUDHandler showHUD];
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPostUserApplyReturnedPurchaseWithAccessToken:vGetUserToken
                                                                                         orderMainID:_mainOrderID
                                                                                              reason:_textField.text
                                                                                             content:_textView.text
                                                                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                @strongify(self)
                self.completionBlock([NSError errorWithDomain:message code:1 userInfo:nil]);
            }];
            return;
        }
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"成功申请退货！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            @strongify(self)
            [self dismissViewWithCompletionBlock:^{
                self.completionBlock(nil);
            }];
        }];
        [ProgressHUDHandler dismissHUD];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"申请退货失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            @strongify(self)
            self.completionBlock([NSError errorWithDomain:@"申请退货失败，请稍后再试！" code:1 userInfo:nil]);
        }];
        
    }];
}

@end
