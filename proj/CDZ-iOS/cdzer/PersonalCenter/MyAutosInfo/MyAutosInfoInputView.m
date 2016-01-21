//
//  MyAutosInfoInputView.m
//  cdzer
//
//  Created by KEns0n on 4/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vSelectionTypeContentHeight 310.0f
#define vNormalTypeContentHeight 160.0f
#define vNoneTypeContentHeight 110.0f
#define vBaseTagForTF 200
#define kObjNameKey @"name"
#define kObjIDKey @"id"
#define kObjIconKey @"icon"
#import "MyAutosInfoInputView.h"
#import "InsetsTextField.h"
#import "InsetsLabel.h"
#import "UIView+ShareAction.h"
#import "AFViewShaker.h"
#import <UIView+Borders/UIView+Borders.h>

@interface MyAutosInfoInputView () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) AFViewShaker *viewShaker;

@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, strong) InsetsLabel *titleLabel;

@property (nonatomic, strong) InsetsTextField *commonTextField;

@property (nonatomic, strong) InsetsTextField *autosDealershipTextField;

@property (nonatomic, strong) InsetsTextField *autosSeriesTextField;

@property (nonatomic, strong) InsetsTextField *autosModelTextField;

@property (nonatomic, copy) MAICompletionBlock completionBlock;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UIView *contentsView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIPickerView *autosPicker;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSMutableArray *autosDataList, *selectedIndex;

@property (nonatomic, strong) NSMutableArray *defaultAutosDataList, *defaultSelectedIndex;

@property (nonatomic, strong) NSArray *autosTitle;

@property (nonatomic, strong) NSArray *theIDsList;

@property (nonatomic, assign) NSInteger currentIdx;

@property (nonatomic, assign) NSInteger initialUpdate;

@end

@implementation MyAutosInfoInputView

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
        
        self.currentIdx = 0;
        self.autosDataList = [@[@[], @[], @[], @[]] mutableCopy];
        self.selectedIndex = [@[@(-1), @(-1), @(-1), @(-1)] mutableCopy];
        self.inputType = MAIInputTypeOfNone;
        self.autosTitle = @[getLocalizationString(@"please_select_auto_brand"),
                            getLocalizationString(@"please_select_auto_dealership"),
                            getLocalizationString(@"please_select_auto_series"),
                            getLocalizationString(@"please_select_auto_model"),];
        [self initializationUI];
        [self getAutoBrandListAndInitialLoading:NO];
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
//        UIEdgeInsets insetValueRight = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 12.0f);
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
        _titleLabel.font = systemFontBoldWithoutRatio(19.0f);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = getLocalizationString(@"over_speed_setting");
        [_contentsView addSubview:_titleLabel];
        
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[NSDate date]];
        dateComponents.year -= 100;
        self.datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(datePickerValeChange:) forControlEvents:UIControlEventValueChanged];
        
        
        self.autosPicker = [[UIPickerView alloc] init];
        _autosPicker.delegate = self;
        _autosPicker.dataSource = self;
        
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        CGFloat textFieldHeight = 50.0f;
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 44.0f)];
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
        

        self.commonTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_contentsView.frame), textFieldHeight)
                                                           andEdgeInsetsValue:insetValueCenter];
        _commonTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _commonTextField.textAlignment = NSTextAlignmentLeft;
        _commonTextField.returnKeyType = UIReturnKeyDone;
        _commonTextField.delegate = self;
        _commonTextField.tag = vBaseTagForTF;
        _commonTextField.inputAccessoryView = toolbar;
        _autosModelTextField.placeholder = getLocalizationString(@"please_select_auto_brand");
        [_contentsView addSubview:_commonTextField];

        
        
        
        self.autosDealershipTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_commonTextField.frame), CGRectGetWidth(_contentsView.frame), textFieldHeight)
                                                           andEdgeInsetsValue:insetValueCenter];
        _autosDealershipTextField.textAlignment = NSTextAlignmentCenter;
        _autosDealershipTextField.delegate = self;
        _autosDealershipTextField.inputView = _autosPicker;
        _autosDealershipTextField.inputAccessoryView = toolbar;
        _autosDealershipTextField.placeholder = getLocalizationString(@"please_select_auto_dealership");
        _autosDealershipTextField.tag = vBaseTagForTF+1;
        [_autosDealershipTextField addTopBorderWithHeight:1 color:CDZColorOfDeepGray
                                      leftOffset:insetValueLeft.left
                                     rightOffset:0.0f andTopOffset:0.0f];
        [_contentsView addSubview:_autosDealershipTextField];
        
        
        
        self.autosSeriesTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_autosDealershipTextField.frame), CGRectGetWidth(_contentsView.frame), textFieldHeight)
                                                           andEdgeInsetsValue:insetValueCenter];
        _autosSeriesTextField.textAlignment = NSTextAlignmentCenter;
        _autosSeriesTextField.delegate = self;
        _autosSeriesTextField.inputView = _autosPicker;
        _autosSeriesTextField.inputAccessoryView = toolbar;
        _autosSeriesTextField.placeholder = getLocalizationString(@"please_select_auto_series");
        _autosSeriesTextField.tag = vBaseTagForTF+2;
        [_autosSeriesTextField addTopBorderWithHeight:1 color:CDZColorOfDeepGray
                                      leftOffset:insetValueLeft.left
                                     rightOffset:0.0f andTopOffset:0.0f];
        [_contentsView addSubview:_autosSeriesTextField];
        
        
   
        self.autosModelTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_autosSeriesTextField.frame), CGRectGetWidth(_contentsView.frame), textFieldHeight)
                                                        andEdgeInsetsValue:insetValueCenter];
        _autosModelTextField.textAlignment = NSTextAlignmentCenter;
        _autosModelTextField.delegate = self;
        _autosModelTextField.inputView = _autosPicker;
        _autosModelTextField.inputAccessoryView = toolbar;
        _autosModelTextField.placeholder = getLocalizationString(@"please_select_auto_model");
        _autosModelTextField.tag = vBaseTagForTF+3;
        [_autosModelTextField addTopBorderWithHeight:1 color:CDZColorOfDeepGray
                                           leftOffset:insetValueLeft.left
                                          rightOffset:0.0f andTopOffset:0.0f];
        [_contentsView addSubview:_autosModelTextField];
        
        
        
        self.viewShaker = [[AFViewShaker alloc] initWithView:_contentsView];
        
        
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
    
    [self setReactiveRules];
}

- (void)setInputType:(MAIInputType)inputType {
    [self setInputType:inputType withOriginalValue:nil];
}

- (void)setInputType:(MAIInputType)inputType withOriginalValue:(NSString *)originalValue {
    if (!originalValue) originalValue = @"";
    self.initialUpdate = NO;
    CGRect contentRect = _contentsView.frame;
    _datePicker.minimumDate = nil;
    _datePicker.maximumDate = nil;
    _commonTextField.text = @"";
    _commonTextField.edgeInsets = UIEdgeInsetsMake(0.0f, 12.0f, 0.0f, 12.0f);
    _commonTextField.textAlignment = NSTextAlignmentCenter;
    _commonTextField.inputView = nil;
    _commonTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _commonTextField.hidden = NO;
    _commonTextField.secureTextEntry = NO;
    _commonTextField.keyboardType = UIKeyboardTypeDefault;
    if (inputType!=MAIInputTypeOfAutosSelection) {
        _commonTextField.text = originalValue;
    }
    _autosDealershipTextField.hidden = YES;
    _autosDealershipTextField.text = @"";
    _autosSeriesTextField.hidden = YES;
    _autosSeriesTextField.text = @"";
    _autosModelTextField.hidden = YES;
    _autosModelTextField.text = @"";
    contentRect.size.height = vNormalTypeContentHeight;
    _inputType = inputType;
    
    
    switch (inputType) {
        case MAIInputTypeOfLicensePlate:
            [self setTitle:@"myautos_number"];
            _commonTextField.placeholder = getLocalizationString(@"input_autos_licence");
            break;
        case MAIInputTypeOfAutosBodyColor:
            [self setTitle:@"myautos_color"];
            _commonTextField.placeholder = getLocalizationString(@"input_autos_body_color");
            break;
        case MAIInputTypeOfAutosFrameNumber:
            [self setTitle:@"myautos_frame_no"];
            _commonTextField.placeholder = getLocalizationString(@"input_autos_frame");
            break;
        case MAIInputTypeOfAutosEngineNumber:
            [self setTitle:@"myautos_engine_code"];
            _commonTextField.placeholder = getLocalizationString(@"input_autos_engine");
            break;
        case MAIInputTypeOfInitialMileage:
            [self setTitle:@"myautos_start_mile"];
            _commonTextField.keyboardType = UIKeyboardTypeNumberPad;
            _commonTextField.placeholder = getLocalizationString(@"input_autos_initial_mileage");
            break;
        case MAIInputTypeOfAutosInsuranceNumber:
            [self setTitle:@"myautos_insurance_num"];
            _commonTextField.placeholder = getLocalizationString(@"input_next_insurance_number");
            _commonTextField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case MAIInputTypeOfAutosInsuranceDate:{
            _datePicker.minimumDate = [NSDate date];
            _datePicker.date = _datePicker.minimumDate;
            if (originalValue) {
                NSDate *date = nil;
                date = [_dateFormatter dateFromString:originalValue];
                NSLog(@"%@",date);
                if (date) {
                    _datePicker.date = date;
                }
            }
            [self setTitle:@"myautos_insure_date"];
            _commonTextField.inputView = _datePicker;
            _commonTextField.clearButtonMode = UITextFieldViewModeNever;
            _commonTextField.placeholder = getLocalizationString(@"input_next_insurance_date");
        }
            break;
        case MAIInputTypeOfAutosAnniversaryCheckDate:{
            _datePicker.minimumDate = [NSDate date];
            _datePicker.date = _datePicker.minimumDate;
            if (originalValue) {
                NSDate *date = nil;
                date = [_dateFormatter dateFromString:originalValue];
                NSLog(@"%@",date);
                if (date) {
                    _datePicker.date = date;
                }
            }
            [self setTitle:@"myautos_annual_date"];
            _commonTextField.inputView = _datePicker;
            _commonTextField.clearButtonMode = UITextFieldViewModeNever;
            _commonTextField.placeholder = getLocalizationString(@"input_next_anniversary_check_date");
        }
            break;
        case MAIInputTypeOfAutosMaintenanceDate:{
            _datePicker.maximumDate = [NSDate date];
            _datePicker.date = _datePicker.maximumDate;
            if (originalValue) {
                NSDate *date = nil;
                date = [_dateFormatter dateFromString:originalValue];
                NSLog(@"%@",date);
                if (date) {
                    _datePicker.date = date;
                }
            }
            [self setTitle:@"myautos_maintenance_date"];
            _commonTextField.inputView = _datePicker;
            _commonTextField.clearButtonMode = UITextFieldViewModeNever;
            _commonTextField.placeholder = getLocalizationString(@"input_next_maintenance_date");
        }
            break;
        case MAIInputTypeOfAutosRegisterDate:{
            _datePicker.maximumDate = [NSDate date];
            _datePicker.date = _datePicker.maximumDate;
            if (originalValue) {
                NSDate *date = nil;
                date = [_dateFormatter dateFromString:originalValue];
                NSLog(@"%@",date);
                if (date) {
                    _datePicker.date = date;
                }
            }
            [self setTitle:@"myautos_register_date"];
            _commonTextField.inputView = _datePicker;
            _commonTextField.clearButtonMode = UITextFieldViewModeNever;
            _commonTextField.placeholder = getLocalizationString(@"input_register_date");
        }
            break;
        case MAIInputTypeOfAutosSelection:
            self.currentIdx = 0;
            [self setTitle:@"input_select_auto"];
            _commonTextField.clearButtonMode = UITextFieldViewModeNever;
            _commonTextField.placeholder = getLocalizationString(@"please_select_auto_brand");
            _commonTextField.textAlignment = NSTextAlignmentCenter;
            _commonTextField.hidden = NO;
            _commonTextField.inputView = _autosPicker;
            _autosDealershipTextField.hidden = NO;
            _autosSeriesTextField.hidden = NO;
            _autosModelTextField.hidden = NO;
            contentRect.size.height = vSelectionTypeContentHeight;
            [self handleTFValueWith:originalValue];
            break;
            
            
        default:
            break;
    }
    
    _contentsView.frame = contentRect;
    _contentsView.center = CGPointMake(_contentsView.center.x, CGRectGetHeight(_scrollView.frame)/2.0f);
}

- (void)handleTFValueWith:(NSString* )originalValue {
    
    @autoreleasepool {
        if ([originalValue rangeOfString:@"-1"].location!=NSNotFound) {
            _commonTextField.text = @"";
            _autosDealershipTextField.text = @"";
            _autosSeriesTextField.text = @"";
            _autosModelTextField.text = @"";
        }else {
            NSInteger brandSelectIdx = [_selectedIndex[0] integerValue]+1;
            NSInteger dealershipSelectIdx = [_selectedIndex[1] integerValue]+1;
            NSInteger seriesSelectIdx = [_selectedIndex[2] integerValue]+1;
            NSInteger modelSelectIdx = [_selectedIndex[3] integerValue]+1;
            
            _commonTextField.text = @"";
            if ([_autosDataList[0] count]!=0&&brandSelectIdx!=0) {
                _commonTextField.text = [[_autosDataList[0] objectAtIndex:brandSelectIdx] objectForKey:kObjNameKey];
            }
            
            _autosDealershipTextField.text = @"";
            if ([_autosDataList[1] count]!=0&&dealershipSelectIdx!=0) {
                _autosDealershipTextField.text = [[_autosDataList[1] objectAtIndex:dealershipSelectIdx] objectForKey:kObjNameKey];
            }
            
            _autosSeriesTextField.text = @"";
            if ([_autosDataList[2] count]!=0&&seriesSelectIdx!=0) {
                _autosSeriesTextField.text = [[_autosDataList[2] objectAtIndex:seriesSelectIdx] objectForKey:kObjNameKey];
            }
            
            _autosModelTextField.text = @"";
            if ([_autosDataList[3] count]!=0&&modelSelectIdx!=0) {
                _autosModelTextField.text = [[_autosDataList[3] objectAtIndex:modelSelectIdx] objectForKey:kObjNameKey];
            }
        }
    }
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, autosDataList) subscribeNext:^(NSArray *autosDataList) {
        @strongify(self)
        if ((self.inputType==MAIInputTypeOfAutosSelection||self.initialUpdate)&&autosDataList.count==4) {
            self.autosDealershipTextField.enabled = ([autosDataList[1] count]!=0);
            self.autosSeriesTextField.enabled = ([autosDataList[2] count]!=0);
            self.autosModelTextField.enabled = ([autosDataList[3] count]!=0);
        }
    
    }];
    
    
    [RACObserve(self, selectedIndex) subscribeNext:^(NSArray *selectedIndex) {
        @strongify(self)
        if ((self.inputType==MAIInputTypeOfAutosSelection||self.initialUpdate)&&selectedIndex.count==4) {
            NSInteger brandSelectIdx = [selectedIndex[0] integerValue]+1;
            NSInteger dealershipSelectIdx = [selectedIndex[1] integerValue]+1;
            NSInteger seriesSelectIdx = [selectedIndex[2] integerValue]+1;
            NSInteger modelSelectIdx = [selectedIndex[3] integerValue]+1;
            
            self.commonTextField.text = @"";
            if ([self.autosDataList[0] count]!=0&&brandSelectIdx!=0) {
                self.commonTextField.text = [[self.autosDataList[0] objectAtIndex:brandSelectIdx] objectForKey:kObjNameKey];
            }
            
            self.autosDealershipTextField.text = @"";
            if ([self.autosDataList[1] count]!=0&&dealershipSelectIdx!=0) {
                self.autosDealershipTextField.text = [[self.autosDataList[1] objectAtIndex:dealershipSelectIdx] objectForKey:kObjNameKey];
            }
            
            self.autosSeriesTextField.text = @"";
            if ([self.autosDataList[2] count]!=0&&seriesSelectIdx!=0) {
                self.autosSeriesTextField.text = [[self.autosDataList[2] objectAtIndex:seriesSelectIdx] objectForKey:kObjNameKey];
            }
            
            self.autosModelTextField.text = @"";
            if ([self.autosDataList[3] count]!=0&&modelSelectIdx!=0) {
                self.autosModelTextField.text = [[self.autosDataList[3] objectAtIndex:modelSelectIdx] objectForKey:kObjNameKey];
            }

        }
    }];
    
    [RACObserve(self, defaultAutosDataList) subscribeNext:^(NSArray *defaultAutosDataList) {
        @strongify(self)
        if (self.initialUpdate) {
            NSMutableArray *array = [self mutableArrayValueForKey:@"autosDataList"];
            [array removeAllObjects];
            [array addObjectsFromArray:defaultAutosDataList];
        }
        
    }];
    
    [RACObserve(self, defaultSelectedIndex) subscribeNext:^(NSArray *defaultSelectedIndex) {
        @strongify(self)
        if (self.initialUpdate) {
            NSMutableArray *array = [self mutableArrayValueForKey:@"selectedIndex"];
            [array removeAllObjects];
            [array addObjectsFromArray:defaultSelectedIndex];
        }
        
    }];
    
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
    if (_inputType==MAIInputTypeOfAutosSelection) {
        [_autosDataList removeAllObjects];
        [_autosDataList addObjectsFromArray:_defaultAutosDataList];
        [_selectedIndex removeAllObjects];
        [_selectedIndex addObjectsFromArray:_defaultSelectedIndex];
    }
    [self hiddenSelfAndSuccess:NO];
}

- (void)showView {
//    if (_inputType==MAIInputTypeOfNone) return;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.alpha = 1.0f;
        [self hiddenKeyboard];
    }];
}

- (void)setMAICompletionBlock:(MAICompletionBlock)completionBlock {
    self.completionBlock = completionBlock;
}

- (void)autosPickerViewValeChange:(UIPickerView *)pickerView {
    InsetsTextField *textField = (InsetsTextField *)[_contentsView viewWithTag:vBaseTagForTF+_currentIdx];
    if (textField) {
        NSDictionary *detail = [_autosDataList[_currentIdx] objectAtIndex:[pickerView selectedRowInComponent:0]];
        textField.text = detail[kObjNameKey];
    }
}

- (void)datePickerValeChange:(UIDatePicker *)datePicker {
    self.commonTextField.text = [_dateFormatter stringFromDate:datePicker.date];
}

- (void)confirmSetting {
    if (_inputType==MAIInputTypeOfNone) return;
    
    if(!_commonTextField.text||[_commonTextField.text isEqualToString:@""]){
        [_viewShaker shake];
        return;
    }
    
    if (_inputType==MAIInputTypeOfAutosSelection) {
       if(!_autosDealershipTextField.text||[_autosDealershipTextField.text isEqualToString:@""]){
            [_viewShaker shake];
            return;
        }else if(!_autosSeriesTextField.text||[_autosSeriesTextField.text isEqualToString:@""]){
            [_viewShaker shake];
            return;
        }else if(!_autosModelTextField.text||[_autosModelTextField.text isEqualToString:@""]){
            [_viewShaker shake];
            return;
        }
    }
    NSDictionary *result = nil;
    if (_inputType==MAIInputTypeOfAutosSelection) {
        NSString *brandID = @"";
        NSString *brandIcon = @"";
        NSString *dealershipID = @"";
        NSString *seriesID = @"";
        NSString *modelID = @"";
        
        NSInteger brandIdx = [_selectedIndex[0] integerValue]+1;
        brandID = [[_autosDataList[0] objectAtIndex:brandIdx] objectForKey:kObjIDKey];
        brandIcon = [[_autosDataList[0] objectAtIndex:brandIdx] objectForKey:kObjIconKey];
        
        NSInteger dealershipIdx = [_selectedIndex[1] integerValue]+1;
        dealershipID = [[_autosDataList[1] objectAtIndex:dealershipIdx] objectForKey:kObjIDKey];
        
        NSInteger seriesIdx = [_selectedIndex[2] integerValue]+1;
        seriesID = [[_autosDataList[2] objectAtIndex:seriesIdx] objectForKey:kObjIDKey];
        
        NSInteger modelIdx = [_selectedIndex[3] integerValue]+1;
        modelID = [[_autosDataList[3] objectAtIndex:modelIdx] objectForKey:kObjIDKey];
        
        result = @{MAIInputKeyFirstValue:@{@"title":_commonTextField.text, @"keyID":brandID, @"icon":brandIcon},
                   MAIInputKeySecondValue:@{@"title":_autosDealershipTextField.text, @"keyID":dealershipID},
                   MAIInputKeyThirdValue:@{@"title":_autosSeriesTextField.text, @"keyID":seriesID},
                   MAIInputKeyFourthValue:@{@"title":_autosModelTextField.text, @"keyID":modelID}};
        
        [_defaultAutosDataList removeAllObjects];
        [_defaultAutosDataList addObjectsFromArray:_autosDataList];
        [_defaultSelectedIndex removeAllObjects];
        [_defaultSelectedIndex addObjectsFromArray:_selectedIndex];
    }else {
        result = @{MAIInputKeyFirstValue:_commonTextField.text};

    }
    
    _completionBlock(_inputType, result);
    [self hiddenSelfView];
    
//    [self updateAutosInfomation];
}

//Handle Keyboard Appear
- (void)hiddenKeyboard {
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        [self.commonTextField resignFirstResponder];
        [self.autosDealershipTextField resignFirstResponder];
        [self.autosSeriesTextField resignFirstResponder];
        [self.autosModelTextField resignFirstResponder];
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
        if ([_autosDealershipTextField isFirstResponder]) textField = _autosDealershipTextField;
        if ([_autosSeriesTextField isFirstResponder]) textField = _autosSeriesTextField;
        if ([_autosModelTextField isFirstResponder]) textField = _autosModelTextField;
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
    if (_inputType==MAIInputTypeOfAutosSelection) {
        [self reloadPickerData:textField];
    }
    return YES;
}

- (void)reloadPickerData:(UITextField *)textField {
    self.currentIdx = textField.tag-vBaseTagForTF;
    NSInteger idx = [_selectedIndex[_currentIdx] integerValue]+1;
    [_autosPicker reloadComponent:0];
    [_autosPicker selectRow:idx inComponent:0 animated:NO];
    
}

#pragma mark- UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_autosDataList[_currentIdx] count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    @autoreleasepool {
        UILabel *labelText = [UILabel new];
        [labelText setTextAlignment:NSTextAlignmentCenter];
        labelText.backgroundColor = [UIColor clearColor];
        labelText.font = [UIFont boldSystemFontOfSize:20.0];
        labelText.textColor = [UIColor blackColor];
        NSDictionary *detail = [_autosDataList[_currentIdx] objectAtIndex:row];
        [labelText setText:detail[kObjNameKey]];
        
        if (row == 0)
        {
            labelText.font = [UIFont boldSystemFontOfSize:30.0];
            labelText.textColor = [UIColor lightGrayColor];
        }
        return labelText;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    @autoreleasepool {
        NSMutableArray *selectedIndex = [self mutableArrayValueForKey:@"selectedIndex"];
        [selectedIndex replaceObjectAtIndex:_currentIdx withObject:@(row-1)];
        
        if (row!=0) {
            NSDictionary *detail = [_autosDataList[_currentIdx] objectAtIndex:row];
            NSString *theID = detail[kObjIDKey];
            if (_currentIdx==0) {
                [self getAutoDealershipListWith:theID isInitialLoading:NO];
            }else if (_currentIdx==1) {
                [self getAutoSeriesListWith:theID isInitialLoading:NO];
            }else if (_currentIdx==2) {
                [self getAutoModelListWith:theID isInitialLoading:NO];
            }
        }
    }
    
    
}

- (void)showLoadingInPickerSuperview {
    @autoreleasepool {
        UIView *view = _autosPicker.superview.superview;
        if (view) {
            [ProgressHUDHandler showHUDWithTitle:nil onView:view];
        }else {
            [ProgressHUDHandler showHUD];
        }
    }
}

- (void)initAutoDataAndSelect:(NSString *)theIDsString {
    self.defaultAutosDataList = nil;
    self.defaultSelectedIndex = nil;
    if ([theIDsString rangeOfString:@"-1"].location==NSNotFound) {
        self.initialUpdate = YES;
        self.defaultAutosDataList = [@[@[], @[], @[], @[]] mutableCopy];
        self.defaultSelectedIndex = [@[@(-1), @(-1), @(-1), @(-1)] mutableCopy];
        self.theIDsList = [theIDsString componentsSeparatedByString:@","];
        [self getAutoBrandListAndInitialLoading:YES];
        [self getAutoDealershipListWith:_theIDsList[0] isInitialLoading:YES];
        [self getAutoSeriesListWith:_theIDsList[1] isInitialLoading:YES];
        [self getAutoModelListWith:_theIDsList[2] isInitialLoading:YES];
    }
}

- (void)initialRequestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    @autoreleasepool {
        
        if (error&&!responseObject) {
            NSLog(@"Error:::>%@",error);
        }else if (!error&&responseObject) {
            NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
            NSInteger identID = [[operation.userInfo objectForKey:@"ident"] integerValue];
            if (errorCode==0) {
                
                NSMutableArray *objectList = [NSMutableArray arrayWithObject:@{kObjNameKey:_autosTitle[identID]}];
                [objectList addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
                
                NSMutableArray *autosDataList = [self mutableArrayValueForKey:@"defaultAutosDataList"];
                autosDataList[identID] = objectList;
                if (_theIDsList&&_theIDsList.count!=0) {
                    
                    NSMutableArray *selectedIndex = [self mutableArrayValueForKey:@"defaultSelectedIndex"];
                    NSString *componentID = _theIDsList[identID];
                    
                    [objectList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSString *thComponentID = obj[kObjIDKey];
                        if ([thComponentID isEqualToString:componentID]) {
                            [selectedIndex replaceObjectAtIndex:identID withObject:@(idx-1)];
                            *stop = YES;
                        }
                    }];
                }
            }
            
        }
    }
}

#pragma mark- APIs Access Request

- (void)getAutoBrandListAndInitialLoading:(BOOL)isInitialLoading {
    [[APIsConnection shareConnection] commonAPIsGetAutoBrandListWithSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(0)};
        if (isInitialLoading) {
            [self initialRequestResultHandle:operation responseObject:responseObject withError:nil];
            return;
        }
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isInitialLoading) {
            [self initialRequestResultHandle:operation responseObject:nil withError:error];
            return;
        }
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)getAutoDealershipListWith:(NSString *)autoBrandID isInitialLoading:(BOOL)isInitialLoading {
    if (!isInitialLoading) {
         [self showLoadingInPickerSuperview];
    }
    [[APIsConnection shareConnection] commonAPIsGetAutoBrandDealershipListWithBrandID:autoBrandID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(1)};
        if (isInitialLoading) {
            [self initialRequestResultHandle:operation responseObject:responseObject withError:nil];
            return;
        }
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isInitialLoading) {
            [self initialRequestResultHandle:operation responseObject:nil withError:error];
            return;
        }
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)getAutoSeriesListWith:(NSString *)autoDealershipID isInitialLoading:(BOOL)isInitialLoading {
    if (!isInitialLoading) {
        [self showLoadingInPickerSuperview];
    }
    [[APIsConnection shareConnection] commonAPIsGetAutoSeriesListWithBrandDealershipID:autoDealershipID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(2)};
        if (isInitialLoading) {
            [self initialRequestResultHandle:operation responseObject:responseObject withError:nil];
            return;
        }
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isInitialLoading) {
            [self initialRequestResultHandle:operation responseObject:nil withError:error];
            return;
        }
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)getAutoModelListWith:(NSString *)autoSeriesID isInitialLoading:(BOOL)isInitialLoading {
    if (!isInitialLoading) {
        [self showLoadingInPickerSuperview];
    }
    [[APIsConnection shareConnection] commonAPIsGetAutoModelListWithAutoSeriesID:autoSeriesID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(3)};
        if (isInitialLoading) {
            [self initialRequestResultHandle:operation responseObject:responseObject withError:nil];
            return;
        }
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (isInitialLoading) {
            [self initialRequestResultHandle:operation responseObject:nil withError:error];
            return;
        }
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    [ProgressHUDHandler dismissHUD];
    if (error&&!responseObject) {
        NSLog(@"Error:::>%@",error);
    }else if (!error&&responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSInteger identID = [[operation.userInfo objectForKey:@"ident"] integerValue];
        if (errorCode!=0) {
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            NSLog(@"%@",message);
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
            [self handleResponseData:@[] withIdent:identID];
            return;
        }
        [self handleResponseData:[responseObject objectForKey:CDZKeyOfResultKey] withIdent:identID];
       
    }
}

- (void)handleResponseData:(NSArray *)responseObject withIdent:(NSInteger)ident{
    @autoreleasepool {
        if (!responseObject) {
            NSString *messageKey = [NSString stringWithFormat:@"auto_data_error_%ld",(long)ident];
            NSString *errorStr = getLocalizationString(messageKey);
            NSLog(@"%@",errorStr);
            return;
        }
        
        NSMutableArray *objectList = [NSMutableArray arrayWithObject:@{kObjNameKey:_autosTitle[ident]}];
        [objectList addObjectsFromArray:responseObject];

        NSMutableArray *autosDataList = [self mutableArrayValueForKey:@"autosDataList"];
        autosDataList[ident] = objectList;
        
        NSMutableArray *selectedIndex = [self mutableArrayValueForKey:@"selectedIndex"];
        if (_currentIdx==0) {
            selectedIndex[1] = @(-1);
            selectedIndex[2] = @(-1);
            selectedIndex[3] = @(-1);
            autosDataList[2] = @[];
            autosDataList[3] = @[];
            
        }
        if (_currentIdx==1) {
            selectedIndex[2] = @(-1);
            selectedIndex[3] = @(-1);
            autosDataList[3] = @[];
        }
        
        if (_currentIdx==2) {
            selectedIndex[3] = @(-1);
        }
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
