//
//  PartsEnquiryPriceView.m
//  cdzer
//
//  Created by KEns0n on 8/19/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "InsetsLabel.h"
#import "InsetsTextField.h"
#import "PartsEnquiryPriceView.h"
#import "KeyCityDTO.h"
#import "UserSelectedAutosInfoDTO.h"

@interface PEPVInternalTVC : UITableViewCell

@end
@implementation PEPVInternalTVC

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGPoint textCenter = self.textLabel.center;
    textCenter.y = CGRectGetHeight(self.frame)/2.0f;
    self.textLabel.center = textCenter;
    
    CGFloat textMaxX = CGRectGetMaxX(self.textLabel.frame);
    CGFloat xOffset = (CGRectGetMinX(self.accessoryView.frame)-textMaxX)/2+textMaxX;
    CGPoint detailTextCenter = self.detailTextLabel.center;
    detailTextCenter.y = CGRectGetHeight(self.frame)/2.0f;
    detailTextCenter.x = xOffset;
    self.detailTextLabel.center = detailTextCenter;
    
}

@end
@interface PartsEnquiryPriceView ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) InsetsLabel *titleLabel;

@property (nonatomic, strong) InsetsTextField *nameTextField;

@property (nonatomic, strong) InsetsTextField *telTextField;

@property (nonatomic, strong) InsetsTextField *centerTextField;

@property (nonatomic, strong) PEPVInternalTVC *citySelectionView;

@property (nonatomic, strong) PEPVInternalTVC *purchaseCenterView;

@property (nonatomic, strong) UITableView *purchaseCenterTV;

@property (nonatomic, strong) NSMutableArray *purchaseCenterList;

@property (nonatomic, strong) UIButton *citySelectionBtn;

@property (nonatomic, strong) UIButton *purchaseCenterBtn;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) NSIndexPath *indexPathForSelectedRow;


@end

@implementation PartsEnquiryPriceView

- (instancetype)init {
    self = [self initWithFrame:CGRectZero];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.purchaseCenterList = [@[] mutableCopy];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)componentSetting {
    @autoreleasepool {
        
    }
    
}

- (void)setReactiveRules {
    @autoreleasepool {
        @weakify(self)
        
        [RACObserve(self, selectedcity) subscribeNext:^(KeyCityDTO *selectedcity) {
            @strongify(self)
            self.citySelectionView.detailTextLabel.text = @"请选择城市";
            if (selectedcity) {
                self.purchaseCenterView.detailTextLabel.text = @"请选择采购中心";
                self.citySelectionView.detailTextLabel.text = selectedcity.cityName;
                [self getPurchaseCenterListWithCityID:selectedcity.cityID.stringValue];
            }else {
                if (self.purchaseCenterList.count==0) {
                    self.purchaseCenterView.detailTextLabel.text = @"请先选择城市";
                }
            }
        }];
        
        RACSignal *nameSignal = [_nameTextField.rac_textSignal map:^id(NSString *text) {
            return @(text&&![text isEqualToString:@""]);
        }];
        
        RACSignal *telSignal = [_telTextField.rac_textSignal map:^id(NSString *text) {
            return @(text&&![text isEqualToString:@""]);
        }];
        
        
        RACSignal *citySignal = [RACObserve(self, selectedcity) map:^id(KeyCityDTO *selectedcity) {
            return @(selectedcity&&selectedcity.cityID);
        }];
        
        RACSignal *centerSignal = [RACObserve(self, indexPathForSelectedRow) map:^id(NSIndexPath *indexPathForSelectedRow) {
            return @(indexPathForSelectedRow!=nil);
        }];
        
        [[RACSignal combineLatest:@[nameSignal, telSignal, citySignal, centerSignal] reduce:^id(NSNumber *isDone1, NSNumber *isDone2, NSNumber *isDone3, NSNumber *isDone4){
            return @(isDone1.boolValue&&isDone2.boolValue&&isDone3.boolValue&&isDone4.boolValue);
        }] subscribeNext:^(NSNumber *isReady) {
            @strongify(self)
            self.submitButton.enabled = isReady.boolValue;
        }];
        
    }
}

- (void)initializationUI {
    
    @autoreleasepool {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
        self.scrollEnabled = NO;
        
        CGRect contentViewFrame = self.bounds;
        contentViewFrame.origin = CGPointMake(CGRectGetWidth(self.frame)*0.1f, CGRectGetHeight(self.frame)*0.1f);
        contentViewFrame.size = CGSizeMake(CGRectGetWidth(self.frame)*0.8f, CGRectGetHeight(self.frame)*0.8f);
        
        self.contentView = [[UIView alloc] initWithFrame:contentViewFrame];
        _contentView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.85f];
        [_contentView setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [self addSubview:_contentView];
        
        self.titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_contentView.frame), 50.0f)
                                          andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"询价";
        _titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16.0f, NO);
        [_titleLabel setViewBorderWithRectBorder:UIRectBorderBottom borderSize:1.0f withColor:CDZColorOfBlack withBroderOffset:nil];
        [_contentView addSubview:_titleLabel];
        
        
        UIToolbar *toolBar =  [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40.0f)];
        [toolBar setBarStyle:UIBarStyleDefault];
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:self
                                                                                    action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"finish")
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(hiddenKeyboard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButton,doneButton,nil];
        [toolBar setItems:buttonsArray];
        
        

        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        UIFont *font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 18.0f, NO);
        UIEdgeInsets titleInsetsValue = UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f);
        BorderOffsetObject *offsetObject = [BorderOffsetObject new];
        offsetObject.bottomLeftOffset = titleInsetsValue.left;
        offsetObject.bottomRightOffset = titleInsetsValue.left;
        
        NSString *name = @"姓名：";
        CGFloat nameSize = [SupportingClass getStringSizeWithString:name font:font widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        InsetsLabel *nameLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, nameSize+titleInsetsValue.left, 40.0f)
                                                 andEdgeInsetsValue:titleInsetsValue];
        nameLabel.text = name;
        self.nameTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_titleLabel.frame)+10.0f, CGRectGetWidth(_contentView.frame), 40.0f)
                                                 andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, CGRectGetWidth(nameLabel.frame), 0.0f, 10.0f)];
        _nameTextField.placeholder = @"请输入姓名";
        _nameTextField.font = font;
        _nameTextField.delegate = self;
        _nameTextField.inputAccessoryView = toolBar;
        [_nameTextField addSubview:nameLabel];
        [_contentView addSubview:_nameTextField];
        [_nameTextField setViewBorderWithRectBorder:UIRectBorderBottom borderSize:1.0f withColor:CDZColorOfBlack withBroderOffset:offsetObject];
        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        NSString *tel = @"手机号：";
        CGFloat telSize = [SupportingClass getStringSizeWithString:tel font:font widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        InsetsLabel *telLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, telSize+titleInsetsValue.left, 40.0f)
                                                 andEdgeInsetsValue:titleInsetsValue];
        telLabel.text = tel;
        self.telTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_nameTextField.frame)+10.0f, CGRectGetWidth(_contentView.frame), 40.0f)
                                                 andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, CGRectGetWidth(telLabel.frame), 0.0f, 10.0f)];
        _telTextField.placeholder = @"请输入手机号";
        _telTextField.font = font;
        _telTextField.delegate = self;
        _telTextField.inputAccessoryView = toolBar;
        _telTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_telTextField addSubview:telLabel];
        [_contentView addSubview:_telTextField];
        [_telTextField setViewBorderWithRectBorder:UIRectBorderBottom borderSize:1.0f withColor:CDZColorOfBlack withBroderOffset:offsetObject];
        
        
        UIImage *arrowImage = ImageHandler.getRightArrow;
        
        
        self.citySelectionView = [[PEPVInternalTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _citySelectionView.frame = CGRectMake(0.0f, CGRectGetMaxY(_telTextField.frame)+10.0f, CGRectGetWidth(_contentView.frame), 40.0f);
        _citySelectionView.accessoryView = [[UIImageView alloc] initWithImage:arrowImage];
        _citySelectionView.textLabel.text = @"询价城市：";
        _citySelectionView.detailTextLabel.text = @"";
        _citySelectionView.detailTextLabel.numberOfLines = 0;
        _citySelectionView.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        _citySelectionView.textLabel.textAlignment = NSTextAlignmentLeft;
        _citySelectionView.detailTextLabel.textColor = CDZColorOfDeepGray;
        [_contentView addSubview:_citySelectionView];
        self.citySelectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _citySelectionBtn.frame = _citySelectionView.bounds;
        [_citySelectionBtn addTarget:self action:@selector(hiddenKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [_citySelectionView addSubview:_citySelectionBtn];
        
        self.purchaseCenterView = [[PEPVInternalTVC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _purchaseCenterView.frame = CGRectMake(0.0f, CGRectGetMaxY(_citySelectionView.frame)+10.0f, CGRectGetWidth(_contentView.frame), 40.0f);
        _purchaseCenterView.accessoryView = [[UIImageView alloc] initWithImage:arrowImage];
        _purchaseCenterView.textLabel.text = @"采购中心：";
        _purchaseCenterView.detailTextLabel.text = @"";
        _purchaseCenterView.detailTextLabel.numberOfLines = 0;
        _purchaseCenterView.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        _purchaseCenterView.textLabel.textAlignment = NSTextAlignmentLeft;
        _purchaseCenterView.detailTextLabel.textColor = CDZColorOfDeepGray;
        [_contentView addSubview:_purchaseCenterView];
        self.purchaseCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _purchaseCenterBtn.frame = _purchaseCenterView.bounds;
        [_purchaseCenterBtn addTarget:self action:@selector(showCenterSelectView) forControlEvents:UIControlEventTouchUpInside];
        [_purchaseCenterView addSubview:_purchaseCenterBtn];

        
        
        self.purchaseCenterTV = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(UIScreen.mainScreen.bounds), 250)];
        _purchaseCenterTV.delegate = self;
        _purchaseCenterTV.dataSource = self;
        _purchaseCenterTV.bounces = NO;
        _purchaseCenterTV.allowsMultipleSelection = NO;
        _purchaseCenterTV.allowsSelection = YES;
        _purchaseCenterTV.showsVerticalScrollIndicator = NO;
        
        self.centerTextField = [[InsetsTextField alloc] initWithFrame:_purchaseCenterView.frame];
        _centerTextField.delegate = self;
        _centerTextField.alpha = 0.01;
        _centerTextField.inputAccessoryView = toolBar;
        _centerTextField.inputView = _purchaseCenterTV;
        [_contentView insertSubview:_centerTextField belowSubview:_purchaseCenterView];

        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        cancelButton.frame = CGRectMake(0.0f, CGRectGetHeight(_contentView.frame)-50.0f, CGRectGetWidth(_contentView.frame)/2.0f, 50.0f);
        cancelButton.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 18, NO);
        [cancelButton setTitle:getLocalizationString(@"cancel") forState:UIControlStateNormal];
        [cancelButton setTitleColor:CDZColorOfBlack forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelSelf) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setViewBorderWithRectBorder:UIRectBorderTop|UIRectBorderRight borderSize:1.0f withColor:CDZColorOfBlack withBroderOffset:nil];
        [_contentView addSubview:cancelButton];
        
        
        self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _submitButton.frame = CGRectMake(CGRectGetMaxX(cancelButton.frame), CGRectGetHeight(_contentView.frame)-50.0f, CGRectGetWidth(_contentView.frame)/2.0f, 50.0f);
        _submitButton.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 18, NO);
        [_submitButton setTitle:getLocalizationString(@"submit") forState:UIControlStateNormal];
        [_submitButton setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
        [_submitButton setTitle:getLocalizationString(@"submit") forState:UIControlStateDisabled];
        [_submitButton setTitleColor:CDZColorOfDeepGray forState:UIControlStateDisabled];
        [_submitButton addTarget:self action:@selector(submitEnquiryRequest) forControlEvents:UIControlEventTouchUpInside];
        [_submitButton setViewBorderWithRectBorder:UIRectBorderTop|UIRectBorderLeft borderSize:1.0f withColor:CDZColorOfBlack withBroderOffset:nil];
        [_contentView addSubview:_submitButton];
        
        
        [self setReactiveRules];
    }
    
}

- (void)cancelSelf {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self cleanAllValue];
    }];
}

- (void)cleanAllValue {
    self.nameTextField.text = @"";
    self.telTextField.text = @"";
    [self.purchaseCenterList removeAllObjects];
    [self.purchaseCenterTV reloadData];
    self.indexPathForSelectedRow = nil;
    self.selectedcity = nil;
}

- (void)setupCitySelectionBtnAction:(SEL)action target:(id)target forControlEvents:(UIControlEvents)controlEvents {
    [_citySelectionBtn addTarget:target action:action forControlEvents:controlEvents];
}

- (void)setupPurchaseCenterBtnAction:(SEL)action target:(id)target forControlEvents:(UIControlEvents)controlEvents {
    [_purchaseCenterBtn addTarget:target action:action forControlEvents:controlEvents];
}

- (void)showCenterSelectView {
    if (_purchaseCenterList.count>0) {
        [_centerTextField becomeFirstResponder];
    }
}

- (void)hiddenKeyboard {
    [_nameTextField resignFirstResponder];
    [_telTextField resignFirstResponder];
    [_centerTextField resignFirstResponder];
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.contentOffset = CGPointZero;
    }];
}

- (void)keyboardWillShow:(NSNotification *)notifyObject {
    CGRect keyboardRect = [[notifyObject.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (!CGRectEqualToRect(keyboardRect, _keyboardRect)) {
        self.keyboardRect = keyboardRect;
    }
    InsetsTextField *textField = _nameTextField;
    if ([_telTextField isFirstResponder]) {
        textField = nil;
        textField = _telTextField;
    }else if ([_centerTextField isFirstResponder]) {
        textField = nil;
        textField = _centerTextField;
    }
    [self shiftScrollViewWithAnimation:textField];
    NSLog(@"Step One");
}

- (void)shiftScrollViewWithAnimation:(UITextField *)textField {
    @autoreleasepool {
        CGPoint point = CGPointZero;
        CGRect tfConvertedRect = [_contentView convertRect:textField.frame toView:self];
        CGFloat contanierViewMaxY = CGRectGetMinY(tfConvertedRect);
        CGFloat visibleContentsHeight = (CGRectGetHeight(self.superview.frame)-CGRectGetHeight(_keyboardRect))/2.0f;
        if (contanierViewMaxY > visibleContentsHeight) {
            CGFloat offsetY = contanierViewMaxY-visibleContentsHeight;
            point.y = offsetY;
        }
        @weakify(self)
        [UIView animateWithDuration:0.25 animations:^{
            @strongify(self)
            self.contentOffset = point;
        }];
    }
    
}

- (void)submitEnquiryRequest {
    [self submitEnquiryPrice];
}

#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _purchaseCenterList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setBackgroundColor:CDZColorOfWhite];
        
    }
    NSString *title = [_purchaseCenterList[indexPath.row] objectForKey:@"name"];
    cell.textLabel.text = title;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if ([tableView.indexPathForSelectedRow isEqual:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    _purchaseCenterView.detailTextLabel.text = [_purchaseCenterList[indexPath.row] objectForKey:@"name"];
    self.indexPathForSelectedRow = indexPath;
}

-  (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark- UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (!CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        [self shiftScrollViewWithAnimation:textField];
    }
    return YES;
}

- (void)submitEnquiryPrice {
    [ProgressHUDHandler showHUD];
    if (UserBehaviorHandler.shareInstance.getUserToken) {
        NSString *centerID = [_purchaseCenterList[_indexPathForSelectedRow.row] objectForKey:@"id"];
        if ([[_purchaseCenterList[_indexPathForSelectedRow.row] objectForKey:@"id"] isKindOfClass:NSNumber.class]) {
            centerID = [[_purchaseCenterList[_indexPathForSelectedRow.row] objectForKey:@"id"] stringValue];
        }
        [[APIsConnection shareConnection] personalCenterAPIsPostSelfEnquireProductsPriceWithAccessToken:UserBehaviorHandler.shareInstance.getUserToken
                                                                                                brandID:_autoData.brandID.stringValue
                                                                                      brandDealershipID:_autoData.dealershipID.stringValue
                                                                                               seriesID:_autoData.seriesID.stringValue
                                                                                                modelID:_autoData.modelID.stringValue
                                                                                               centerID:centerID
                                                                                           mobileNumber:_telTextField.text
                                                                                               userName:_nameTextField.text
                                                                                           productionID:_productID
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            NSLog(@"%@",message);
            [ProgressHUDHandler dismissHUD];
            if (errorCode!=0) {
                if (errorCode&&[message isEqualToString:@"该城市没有采购中心"]) {
                    self.purchaseCenterView.detailTextLabel.text = message;
                    return;
                }
                
                [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                    
                }];
                return;
            }
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                [self cancelSelf];
            }];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SupportingClass showAlertViewWithTitle:@"error" message:@"不明错误，请稍候尝试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
        }];
    }
}

- (void)getPurchaseCenterListWithCityID:(NSString *)cityID {
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] personalCenterAPIsGetPurchaseCenterListWithCityID:cityID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }else if (!error&&responseObject) {
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            if (errorCode&&[message isEqualToString:@"该城市没有采购中心"]) {
                self.purchaseCenterView.detailTextLabel.text = message;
                return;
            }
            
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [self.purchaseCenterList removeAllObjects];
        NSLog(@"%@",[_purchaseCenterList class]);
        NSLog(@"%@",[responseObject[CDZKeyOfResultKey] class]);
        NSArray *tmpArray = responseObject[CDZKeyOfResultKey];
        [self.purchaseCenterList addObjectsFromArray:tmpArray];
        [_purchaseCenterTV reloadData];
        
    }
    
}

@end
