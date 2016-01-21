//
//  MyAddressEditWithInsertVC.m
//  cdzer
//
//  Created by KEns0n on 4/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vContanierTagID 100
#define vTFTagID 200
#define vBarBtnItemTagID 300
#define kResultKeyID @"region_id"
#define kResultKeyName @"region_name"
#define kDataEmpty @"#000000"
#import "MyAddressEditWithInsertVC.h"
#import "IQDropDownTextField.h"
#import "PCDDataModel.h"
#import "AddressDTO.h"


@interface MyAddressEditWithInsertVC () <IQDropDownTextFieldDelegate>

@property (nonatomic, assign) MyAddressDisplayMode displayMode;

@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, strong) AddressDTO *addressDetail;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) NSMutableArray *tfSettingList;

@property (nonatomic, strong) PCDDataModel *dataModel;

@property (nonatomic, strong) UITextField *consigneeNameTF;

@property (nonatomic, strong) UITextField *mobileNumberTF;

@property (nonatomic, strong) UITextField *postCodeTF;

@property (nonatomic, strong) IQDropDownTextField *provinceTF;

@property (nonatomic, strong) IQDropDownTextField *cityTF;

@property (nonatomic, strong) IQDropDownTextField *districtTF;

@property (nonatomic, strong) UITextField *detailAddressTF;

@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) UIButton *addDefaultBtn;
@property (nonatomic, assign) NSNumber *isCheckDefaultSelection;

@property (nonatomic, assign) BOOL isDistrictDataEmpty;

@property (nonatomic, strong) PCDDataModel *originalDataModel;


@end

@implementation MyAddressEditWithInsertVC

- (instancetype)init {
    self = [self initWithDisplayMode:MyAddressDisplayTypeOfNormal withAddressData:nil];
    if (self) {
    }
    return self;
}

- (instancetype)initWithDisplayMode:(MyAddressDisplayMode)displayMode withAddressData:(AddressDTO *)addressData{
    self = [super init];
    if (self) {
        [self setDisplayMode:displayMode];
        self.dataModel = [PCDDataModel new];
        if (displayMode!=MyAddressDisplayTypeOfInsert) {
            self.addressDetail = addressData;
        }
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil displayMode:MyAddressDisplayTypeOfNormal withAddressData:nil];
    if (self) {
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil displayMode:(MyAddressDisplayMode)displayMode withAddressData:(AddressDTO *)addressData {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil] ;
    if (self) {
        [self setDisplayMode:displayMode];
        self.dataModel = [PCDDataModel new];
        if (displayMode!=MyAddressDisplayTypeOfInsert) {
            self.addressDetail = addressData;
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    if (_displayMode==MyAddressDisplayTypeOfInsert) {
        [self getProvinceList];
    }else {
//        [self performSelector:@selector(delayRunData) withObject:nil afterDelay:1.5];
        [self delayRunData];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"view_address_detail")];
    
    if (_displayMode==MyAddressDisplayTypeOfInsert) {
        [self setTitle:getLocalizationString(@"add_new_address")];
    }else{
        [self setRightNavButtonWithTitleOrImage:@"edit" style:UIBarButtonItemStyleDone target:self action:@selector(changeEditMode) titleColor:nil isNeedToSet:YES];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [self dataModelRACConstraintSetting];
        self.originalDataModel = [PCDDataModel new];
    }
    
    self.keyboardRect = CGRectZero;
    [self uiConfigSetup];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

#pragma -mark Private Functions
// delay Run Data on MyAddressDisplayTypeOfNormal
- (void)delayRunData {
    [self getProvinceList];
    [self getCityList:_addressDetail.provinceID];
    [self getDistrictList:_addressDetail.cityID];
}
// 键盘处理
- (void)keyboardWillShow:(NSNotification *)notifyObject {
    CGRect keyboardRect = [[notifyObject.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (!CGRectEqualToRect(keyboardRect, _keyboardRect)) {
        self.keyboardRect = keyboardRect;
//        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.frame), <#CGFloat height#>)];
        [self shiftScrollViewWithAnimation:[self getFirstResponderTextField]];
    }
    NSLog(@"Step One");
}

- (id)getTextFieldByID:(NSUInteger)theID {
    
    return [[self.scrollView viewWithTag:theID+vContanierTagID] viewWithTag:theID+vTFTagID];
}

- (void)addAddressToDefault {
    BOOL isSuccess = NO;
    if (_addressDetail) {
         isSuccess = [[DBHandler shareInstance] updateUserDefaultAddress:_addressDetail];
    }
    @weakify(self)
    [SupportingClass showAlertViewWithTitle:@"alert_remind" message:isSuccess?@"已设置为默认地址":@"设置失败！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
        @strongify(self)
        AddressDTO *dto = [[DBHandler shareInstance] getUserDefaultAddress];
        if (dto.addressID&&[dto.addressID isEqualToString:self.addressDetail.addressID]) {
            self.isCheckDefaultSelection = @(NO);
        }else {
            self.isCheckDefaultSelection = @(YES);
        }
    }];
}

#pragma data Handle Section
// 处理省列表结果
- (void)handleProvinceList:(id)objectList {
    @autoreleasepool {
        if (![objectList isKindOfClass:NSArray.class]) {
            return;
        }
        if (self.dataModel.provinceList) {
            [self.dataModel setProvinceList:nil];
        }
        [self.dataModel setProvinceList:objectList];
        [_provinceTF setUserInteractionEnabled:(_displayMode!=MyAddressDisplayTypeOfNormal)];
        [_provinceTF setItemList:[objectList valueForKey:kResultKeyName]];
        if (_displayMode!=MyAddressDisplayTypeOfNormal) {
            [_cityTF setUserInteractionEnabled:NO];
            [_cityTF setText:@""];
            [_cityTF setItemList:[NSArray array]];
            
            [_districtTF setUserInteractionEnabled:NO];
            [_districtTF setText:@""];
            [_districtTF setItemList:[NSArray array]];
        }else if(_displayMode==MyAddressDisplayTypeOfNormal){
            if (!self.originalDataModel.provinceList) {
                [self.originalDataModel setProvinceList:objectList];
            }
            
            NSString *searchString = _addressDetail.provinceID;
            NSUInteger index = [_dataModel.provinceList indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                NSString *compareStr = [(NSDictionary *)obj objectForKey:kResultKeyID];
                BOOL isSame = [compareStr isEqualToString: searchString];
                *stop = isSame;
                return isSame;
                
            }];
            if (_provinceTF.isOptionalDropDown) {
                index++;
            }
            [_provinceTF setSelectedRow:index];
            
        }
        
        
        
    }
}
// 处理城市列表结果
- (void)handleCityList:(id)objectList {
    @autoreleasepool {
        if (![objectList isKindOfClass:NSArray.class]) {
            return;
        }
        if (self.dataModel.cityList) {
            [self.dataModel setCityList:nil];
        }
        [self.dataModel setCityList:objectList];
        [_cityTF setUserInteractionEnabled:YES];
        [_cityTF setItemList:[objectList valueForKey:kResultKeyName]];
        [_cityTF sendActionsForControlEvents:UIControlEventEditingChanged];
        [_districtTF sendActionsForControlEvents:UIControlEventEditingChanged];
        if(_displayMode==MyAddressDisplayTypeOfNormal){
            if (!self.originalDataModel.cityList) {
                [self.originalDataModel setCityList:objectList];
            }
            
            NSString *searchString = _addressDetail.cityID;
            NSUInteger index = [_dataModel.cityList indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                NSString *compareStr = [(NSDictionary *)obj objectForKey:kResultKeyID];
                BOOL isSame = [compareStr isEqualToString: searchString];
                *stop = isSame;
                return isSame;
                
            }];
            if (_cityTF.isOptionalDropDown) {
                index++;
            }
            [_cityTF setSelectedRow:index];
        }
    }
}
// 处理地区列表结果
- (void)handleDistrictList:(id)objectList {
    @autoreleasepool {
        if (![objectList isKindOfClass:NSArray.class]) {
            return;
        }
        if (self.dataModel.districtList) {
            [self.dataModel setDistrictList:nil];
        }
        self.isDistrictDataEmpty = NO;
        if ([objectList count]==1&&[[objectList[0] objectForKey:kResultKeyID] isEqualToString:kDataEmpty]) {
            self.isDistrictDataEmpty = YES;
        }
        [self.dataModel setDistrictList:objectList];
        [_districtTF setUserInteractionEnabled:!self.isDistrictDataEmpty];
        [_districtTF setIsOptionalDropDown:!self.isDistrictDataEmpty];
        [_districtTF setItemList:[objectList valueForKey:kResultKeyName]];
        if (self.isDistrictDataEmpty) {
            [_districtTF setText:[objectList[0] objectForKey:kResultKeyName]];
        }
        [_districtTF sendActionsForControlEvents:UIControlEventEditingChanged];
        
        if(_displayMode==MyAddressDisplayTypeOfNormal){
            if (!self.originalDataModel.districtList) {
                [self.originalDataModel setDistrictList:objectList];
            }
            
            NSString *searchString = _addressDetail.regionID;
            NSUInteger index = [_dataModel.districtList indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
                NSString *compareStr = [(NSDictionary *)obj objectForKey:kResultKeyID];
                BOOL isSame = [compareStr isEqualToString: searchString];
                *stop = isSame;
                return isSame;
                
            }];
            if (_districtTF.isOptionalDropDown) {
                index++;
            }
            [_districtTF setSelectedRow:index];
        }
    }
}
// 提示提交完成
- (void)submitFinish:(NSString *)title {
    @autoreleasepool {
        [ProgressHUDHandler showSuccessWithStatus:title onView:nil completion:^{
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (void)textField:(IQDropDownTextField *)textField didSelectItem:(NSString *)item {

    if ([textField isEqual:_provinceTF]) {
        [_cityTF setUserInteractionEnabled:NO];
        [_cityTF setText:@""];
        [_cityTF setItemList:[NSArray array]];
        
        [_districtTF setUserInteractionEnabled:NO];
        [_districtTF setText:@""];
        [_districtTF setItemList:[NSArray array]];
        if(textField.selectedRow>=0) {
            [self getCityList:[[_dataModel.provinceList objectAtIndex:textField.selectedRow] objectForKey:kResultKeyID]];
        }
        
    }else if ([textField isEqual:_cityTF]) {
        [_districtTF setUserInteractionEnabled:NO];
        [_districtTF setText:@""];
        [_districtTF setItemList:[NSArray array]];
        
        if (textField.selectedRow>=0) {
            [self getDistrictList:[[_dataModel.cityList objectAtIndex:textField.selectedRow] objectForKey:kResultKeyID]];
        }
    }
    [_provinceTF sendActionsForControlEvents:UIControlEventEditingChanged];
    [_cityTF sendActionsForControlEvents:UIControlEventEditingChanged];
    [_districtTF sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)showLoadingInPickerSuperview {
    @autoreleasepool {
        UIView *view = _toolBar.superview.superview;
        [ProgressHUDHandler showHUDWithTitle:nil onView:view];
    }
}

#pragma address edit mode
- (void)changeEditMode {
    [self setEditing:!self.isEditing animated:YES];
    [self resignKeyboard];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // Make sure you call super first
    [super setEditing:editing animated:animated];
    self.navigationItem.rightBarButtonItem.title = getLocalizationString(editing?@"cancel":@"change");
    self.submitBtn.hidden = !editing;
    self.displayMode = editing?MyAddressDisplayTypeOfEdit:MyAddressDisplayTypeOfNormal;
    [_tfSettingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField *textField = [self getTextFieldByID:idx];
        [textField setUserInteractionEnabled:editing];
        if ([textField isEqual:self.districtTF]) {
            [textField setUserInteractionEnabled:(editing&&!self.isDistrictDataEmpty)];
        }
    }];
    
    if (!editing) {
        [self setAllTextToTextField];
        [self handleProvinceList:_originalDataModel.provinceList];
        [self handleCityList:_originalDataModel.cityList];
        [self handleDistrictList:_originalDataModel.districtList];
        
    }
}

#pragma RAC Constraint Section
- (void)tfRACConstraintSetting{
    @autoreleasepool {
        @weakify(self)
        NSMutableArray *racArray = [NSMutableArray array];
        [_tfSettingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @strongify(self)
            UITextField *textField = [self getTextFieldByID:idx];
            NSUInteger requestLength = ([textField isEqual:self.mobileNumberTF])?11:(([textField isEqual:self.postCodeTF])?6:2);
            RACSignal *racSignal = [textField.rac_textSignal
                         map:^id(NSString *text) {
                             return @(text.length>=requestLength);
                         }];
            [racArray addObject:racSignal];
            
        }];
        
        id block = ^id(NSNumber *single1, NSNumber *single2,
                       NSNumber *single3, NSNumber *single4,
                       NSNumber *single5, NSNumber *single6){
            
            @strongify(self)
            return @(single1.boolValue && single2.boolValue &&
                     single3.boolValue && single4.boolValue &&
                     (self.isDistrictDataEmpty||single5.boolValue) && single6.boolValue );
        };
        
        if (_postCodeTF) {
            block = ^id(NSNumber *single1, NSNumber *single2,
                        NSNumber *single3, NSNumber *single4,
                        NSNumber *single5, NSNumber *single6,
                        NSNumber *single7){
                
                @strongify(self)
                return @(single1.boolValue && single2.boolValue &&
                         single3.boolValue && single4.boolValue &&
                         single5.boolValue && (self.isDistrictDataEmpty||single6.boolValue) &&
                         single7.boolValue);
            };

        }
        RACSignal *combineSingnal = [RACSignal combineLatest:racArray reduce:block];
        [combineSingnal subscribeNext:^(NSNumber *isDone) {
            @strongify(self)
            [self.submitBtn setEnabled:isDone.boolValue];
            [self.submitBtn setBackgroundColor:isDone.boolValue?CDZColorOfRed:CDZColorOfDeepGray];
        }];
        if (_displayMode==MyAddressDisplayTypeOfNormal) {
            [self setReactiveRules];
        }
    }
}

- (void)setReactiveRules {
    
    @weakify(self)
    self.isCheckDefaultSelection = @(YES);
    [RACObserve(self, isCheckDefaultSelection) subscribeNext:^(NSNumber *isDefault) {
        @strongify(self)
        self.addDefaultBtn.enabled = isDefault.boolValue;
        self.addDefaultBtn.backgroundColor = (isDefault.boolValue)?CDZColorOfDefaultColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.3f];
    }];
    AddressDTO *dto = [[DBHandler shareInstance] getUserDefaultAddress];
    if (dto.addressID&&[dto.addressID isEqualToString:_addressDetail.addressID]) {
        self.isCheckDefaultSelection = @(NO);
    }
}

- (void)dataModelRACConstraintSetting {
    RACSignal *provinceSignal = [self.dataModel rac_valuesAndChangesForKeyPath:@"provinceList" options:NSKeyValueObservingOptionNew observer:self];
    RACSignal *citySignal = [self.dataModel rac_valuesAndChangesForKeyPath:@"cityList" options:NSKeyValueObservingOptionNew observer:self];
    RACSignal *districtSignal = [self.dataModel rac_valuesAndChangesForKeyPath:@"districtList" options:NSKeyValueObservingOptionNew observer:self];
    
    @weakify(self)
    [[RACSignal combineLatest:@[provinceSignal,citySignal,districtSignal]reduce:^id(RACTuple *tuple1, RACTuple *tuple2, RACTuple *tuple3){
        id newObject1 = tuple1.first;
        id newObject2 = tuple2.first;
        id newObject3 = tuple3.first;
        return @((newObject1!=nil&&[newObject1 count]!=0)&&
                 (newObject2!=nil&&[newObject2 count]!=0)&&
                 (newObject3!=nil&&[newObject3 count]!=0));
    }] subscribeNext:^(NSNumber *boolNumber) {
        @strongify(self)
        self.navigationItem.rightBarButtonItem.enabled = boolNumber.boolValue;
    }];
}
#pragma -mark UI Setting
- (CGFloat)initTextFieldWithOrigin:(CGPoint)origin settingData:(NSDictionary *)detailData currentTagID:(NSUInteger)tagID {
    @autoreleasepool {
        CGRect rect = CGRectZero;
        rect.origin = origin;
        rect.size = CGSizeMake(CGRectGetWidth(_scrollView.frame), vAdjustByScreenRatio(40.0f));
        UIView *view = [[UIView alloc] initWithFrame:rect];
        [view setBackgroundColor:CDZColorOfWhite];
        [view setBorderWithColor:nil borderWidth:0.5f];
        [view setTag:vContanierTagID+tagID];
        [_scrollView addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, vAdjustByScreenRatio(120.0f), CGRectGetHeight(rect))];
        [titleLabel setFont:systemFont(16.0f)];
        [titleLabel setTextColor:[UIColor colorWithRed:0.290f green:0.286f blue:0.271f alpha:1.00f]];
        [titleLabel setText:getLocalizationString([detailData objectForKey:@"title"])];
        [titleLabel setTextAlignment:NSTextAlignmentRight];
        [view addSubview:titleLabel];
        
        BOOL isTextField = [[detailData objectForKey:@"isTextField"] boolValue];
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        CGRect textFieldRect = view.bounds;
        textFieldRect.origin.x = CGRectGetMaxX(titleLabel.frame);
        textFieldRect.size.width = CGRectGetWidth(rect)-CGRectGetMaxX(titleLabel.frame)-vAdjustByScreenRatio(20.f);
        id textField = nil;
        if (isTextField) {
            textField = [[InsetsTextField alloc] initWithFrame:textFieldRect andEdgeInsetsValue:insetsValue];
            [textField setKeyboardType:[[detailData objectForKey:@"keyboardType"] integerValue]];
            [(InsetsTextField *)textField setDelegate:self];
            [(InsetsTextField *)textField setClearButtonMode:UITextFieldViewModeWhileEditing];
            [textField setReturnKeyType:[[detailData objectForKey:@"returnKey"] integerValue]];
            [(InsetsTextField *)textField addTarget:self action:@selector(textFieldDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
            
        }else {
            textField = [[IQDropDownTextField alloc] initWithFrame:textFieldRect andEdgeInsetsValue:insetsValue];
            [textField setIsOptionalDropDown:YES];
            [(IQDropDownTextField *)textField setDelegate:self];
            [textField setUserInteractionEnabled:NO];
            NSString *placeholder = [getLocalizationString([detailData objectForKey:@"placeHolder"]) stringByReplacingOccurrencesOfString:@"：" withString:@""];
            [textField setPlaceholder:placeholder];
            if ([[detailData objectForKey:@"orderNumber"] integerValue]==1) {
                [textField setUserInteractionEnabled:YES];
            }

        }
        if ([detailData objectForKey:@"withPointer"]) {
            NSString *selectorString = [detailData objectForKey:@"withPointer"];
            SEL theSelector = NSSelectorFromString(selectorString);
            [self performSelectorInBackground:theSelector withObject:textField];
        }
        if (_displayMode!=MyAddressDisplayTypeOfInsert) {
            [textField setUserInteractionEnabled:NO];
        }
        [view addSubview:textField];
        [textField setTag:vTFTagID+tagID];
        [textField setInputAccessoryView:_toolBar];
        return CGRectGetMaxY(rect);
    }
}

- (void)uiConfigSetup {
    @autoreleasepool {
        NSArray *tmpArray = @[@{@"isTextField":@YES,@"title":@"consignee_name",@"placeHolder":@"full_name",
                                @"keyboardType":[NSNumber numberWithInt:UIKeyboardTypeDefault],@"returnKey":[NSNumber numberWithInt:UIReturnKeyNext],
                                @"withPointer":NSStringFromSelector(@selector(setConsigneeNameTF:))},
                              @{@"isTextField":@YES,@"title":@"phone_number",@"placeHolder":@"phone_number",
                                @"keyboardType":[NSNumber numberWithInt:UIKeyboardTypeNumberPad],@"returnKey":[NSNumber numberWithInt:UIReturnKeyNext],
                                @"withPointer":NSStringFromSelector(@selector(setMobileNumberTF:))},
                              
                              //////////////////////////////////////////////////
                              @{@"isTextField":@NO,@"title":@"current_province",@"placeHolder":@"please_select_province",@"orderNumber":@1,
                                @"withPointer":NSStringFromSelector(@selector(setProvinceTF:))},
                              ////////////////////////////////////////
                              @{@"isTextField":@NO,@"title":@"current_city",@"placeHolder":@"please_select_city",@"orderNumber":@2,
                                @"withPointer":NSStringFromSelector(@selector(setCityTF:))},
                              ////////////////////////////////////////
                              @{@"isTextField":@NO,@"title":@"current_district",@"placeHolder":@"please_select_district",@"orderNumber":@3,
                                @"withPointer":NSStringFromSelector(@selector(setDistrictTF:))},
                              //////////////////////////////////////////////////
                              
                              @{@"isTextField":@YES,@"title":@"address_detail",@"placeHolder":@"address_detail",
                                @"keyboardType":[NSNumber numberWithInt:UIKeyboardTypeDefault],@"returnKey":[NSNumber numberWithInt:UIReturnKeyDone],
                                @"withPointer":NSStringFromSelector(@selector(setDetailAddressTF:))}];
        
        self.tfSettingList = [NSMutableArray arrayWithArray:tmpArray];
        BOOL isRun = NO;
        if (isRun) {
            [_tfSettingList addObject: @{@"isTextField":@YES,@"title":@"post_number",@"placeHolder":@"post_number",
                                         @"keyboardType":[NSNumber numberWithInt:UIKeyboardTypeNumberPad],
                                         @"returnKey":[NSNumber numberWithInt:UIReturnKeyNext],
                                         @"withPointer":NSStringFromSelector(@selector(setPostCodeTF:))}];
        }
    }
}

- (void)initializationUI {
    @autoreleasepool {
        
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
        [_scrollView setBackgroundColor:sCommonBGColor];
        [_scrollView setBounces:NO];
        [_scrollView setScrollEnabled:NO];
        [self.contentView addSubview:_scrollView];
        
        
        self.toolBar =  [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40)];
        [_toolBar setBarStyle:UIBarStyleDefault];
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                  target:self
                                                                                  action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"finish")
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(resignKeyboard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButton,doneButton,nil];
        [_toolBar setItems:buttonsArray];
        
        
        __block CGPoint origin = CGPointZero;
        __block CGFloat maxY = 0;
        [_tfSettingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            origin.y = maxY;
            maxY = [self initTextFieldWithOrigin:origin settingData:obj currentTagID:idx];
        }];
        
        CGRect submitBtnRect = CGRectZero;
        submitBtnRect.origin.x = CGRectGetWidth(_scrollView.frame)*0.1f;
        submitBtnRect.origin.y = maxY+vAdjustByScreenRatio(25.0f);
        submitBtnRect.size.width = CGRectGetWidth(_scrollView.frame)*0.8f;
        submitBtnRect.size.height = vAdjustByScreenRatio(35.0f);
        
        
        if (_displayMode==MyAddressDisplayTypeOfNormal) {
            self.addDefaultBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [_addDefaultBtn setFrame:submitBtnRect];
            [_addDefaultBtn setTitle:getLocalizationString(@"设置为默认地址") forState:UIControlStateNormal];
            [_addDefaultBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
            [_addDefaultBtn setTitle:getLocalizationString(@"已设置为默认地址") forState:UIControlStateDisabled];
            [_addDefaultBtn setTitleColor:CDZColorOfWhite forState:UIControlStateDisabled];
            [_addDefaultBtn.titleLabel setFont:systemFontBold(16.0f)];
            [_addDefaultBtn.layer setCornerRadius:vAdjustByScreenRatio(7.0f)];
            [_addDefaultBtn.layer setMasksToBounds:YES];
            [_addDefaultBtn setBorderWithColor:CDZColorOfBlack borderWidth:1.0f];
            [_addDefaultBtn addTarget:self action:@selector(addAddressToDefault) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:_addDefaultBtn];
        }
        
        
        [self setSubmitBtn:[UIButton buttonWithType:UIButtonTypeSystem]];
        [_submitBtn setFrame:submitBtnRect];
        [_submitBtn setTitle:getLocalizationString(@"ok") forState:UIControlStateNormal];
        [_submitBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_submitBtn setTitle:getLocalizationString(@"ok") forState:UIControlStateDisabled];
        [_submitBtn setTitleColor:CDZColorOfWhite forState:UIControlStateDisabled];
        [_submitBtn.titleLabel setFont:systemFontBold(16.0f)];
        [_submitBtn.layer setCornerRadius:vAdjustByScreenRatio(7.0f)];
        [_submitBtn.layer setMasksToBounds:YES];
        [_submitBtn setBorderWithColor:CDZColorOfBlack borderWidth:1.0f];
        [_scrollView addSubview:_submitBtn];
        if (_displayMode==MyAddressDisplayTypeOfInsert) {
            [_submitBtn addTarget:self action:@selector(submitAddressForm) forControlEvents:UIControlEventTouchUpInside];
        }else {
            
            [_submitBtn addTarget:self action:@selector(submitEditAddressForm) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self tfRACConstraintSetting];
        
        if (_displayMode==MyAddressDisplayTypeOfNormal) {
            [self setAllTextToTextField];
            [_submitBtn setHidden:YES];
        }
    }
}

- (void)setAllTextToTextField {
    [_consigneeNameTF setText:_addressDetail.consigneeName];
    
    [_mobileNumberTF setText:_addressDetail.telNumber];
    
    [_detailAddressTF setText:_addressDetail.address];
    
    [_provinceTF setText:_addressDetail.provinceName];
    
    [_cityTF setText:_addressDetail.cityName];
    
    [_districtTF setText:_addressDetail.regionName];
    if (([_addressDetail.regionID isEqualToString:kDataEmpty])) {
        [_districtTF setText:getLocalizationString(@"no_more_district_option")];
    }
    
    [_consigneeNameTF  sendActionsForControlEvents:UIControlEventEditingChanged];
    [_mobileNumberTF sendActionsForControlEvents:UIControlEventEditingChanged];
    [_detailAddressTF sendActionsForControlEvents:UIControlEventEditingChanged];
    [_provinceTF sendActionsForControlEvents:UIControlEventEditingChanged];
    [_cityTF sendActionsForControlEvents:UIControlEventEditingChanged];
    [_districtTF  sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark UITextFieldDelegate With Private Functions

- (id)getFirstResponderTextField {
    __block id textField = nil;
    [_tfSettingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id tmpTextField = [self getTextFieldByID:idx];
        if ([tmpTextField isFirstResponder]) {
            textField = tmpTextField;
            *stop = YES;
        }
    }];
    return textField;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        [self shiftScrollViewWithAnimation:textField];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}

- (void)shiftScrollViewWithAnimation:(UITextField *)textField {
    CGPoint point = CGPointZero;
    CGFloat contanierViewMaxY = CGRectGetMidY(textField.superview.frame);
    CGFloat visibleContentsHeight = (CGRectGetHeight(_scrollView.frame)-CGRectGetHeight(_keyboardRect))/2.0f;
    if (contanierViewMaxY > visibleContentsHeight) {
        CGFloat offsetY = contanierViewMaxY-visibleContentsHeight;
        point.y = offsetY;
    }
    
    [_scrollView setContentOffset:point animated:YES];
}

- (void)resignKeyboard {
    id textField = [self getFirstResponderTextField];
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    [textField resignFirstResponder];
    
}

- (void)clearAllText {
    id textField = [self getFirstResponderTextField];
    [(InsetsTextField *)textField setText:@""];
}

- (void)textFieldDidEndOnExit:(UITextField *)textField {
    if (textField.tag==([_tfSettingList count]-1+vTFTagID)) {
        [self resignKeyboard];
    }
}

- (void)showHUDInKeyboardSuperview:(BOOL)inSuperView{
    if (_displayMode==MyAddressDisplayTypeOfInsert) {
        if (inSuperView) {
            [self showLoadingInPickerSuperview];
        }else{
            [ProgressHUDHandler showHUD];
        }
    }
    
}

// 请求省列表
- (void)getProvinceList {
    [self showHUDInKeyboardSuperview:NO];
    NSLog(@"%@ accessing province list request",NSStringFromClass(self.class));
    [[APIsConnection shareConnection] commonAPIsGetProvinceListWithSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [operation setUserInfo:@{@"iden":@0}];
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}
// 请求城市列表
- (void)getCityList:(NSString *)provinceID {
    [self showHUDInKeyboardSuperview:YES];
    NSLog(@"%@ accessing city list request",NSStringFromClass(self.class));
    [[APIsConnection shareConnection] commonAPIsGetCityListWithProvinceID:provinceID isKeyCity:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [operation setUserInfo:@{@"iden":@1}];
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}
// 请求地区列表
- (void)getDistrictList:(NSString *)cityID {
    [self showHUDInKeyboardSuperview:YES];
    NSLog(@"%@ accessing district list request",NSStringFromClass(self.class));
    [[APIsConnection shareConnection] commonAPIsGetDistrictListWithCityID:cityID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [operation setUserInfo:@{@"iden":@2}];
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}
// 确认增加地址
- (void)submitAddressForm {
    if (!self.accessToken)return;
    
    [ProgressHUDHandler showHUDWithTitle:nil onView:[UIApplication sharedApplication].keyWindow];
    [self resignKeyboard];
    NSLog(@"%@ accessing submit Address request",NSStringFromClass(self.class));
    NSString *postCode = (_postCodeTF)?[_postCodeTF text]:nil;
    NSString *provinceID = [[_dataModel.provinceList objectAtIndex:_provinceTF.selectedRow] objectForKey:kResultKeyID];
    NSString *cityID = [[_dataModel.cityList objectAtIndex:_cityTF.selectedRow] objectForKey:kResultKeyID];
    NSString *districtID = [[_dataModel.districtList objectAtIndex:_districtTF.selectedRow] objectForKey:kResultKeyID];

    [[APIsConnection shareConnection] personalCenterAPIsPostInsertShippingAddressWithAccessToken:self.accessToken
                                                                                   consigneeName:_consigneeNameTF.text
                                                                                    mobileNumber:_mobileNumberTF.text
                                                                                        postCode:postCode
                                                                                      provinceID:provinceID
                                                                                          cityID:cityID
                                                                                      districtID:districtID
                                                                                   detailAddress:_detailAddressTF.text
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [operation setUserInfo:@{@"iden":@3}];
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
    
}
// 确认更改地址
- (void)submitEditAddressForm {
    if (!self.accessToken)return;
    [ProgressHUDHandler showHUDWithTitle:nil onView:[UIApplication sharedApplication].keyWindow];
    [self resignKeyboard];
    NSLog(@"%@ accessing submit Edit Address request",NSStringFromClass(self.class));
    NSString *addressID = _addressDetail.addressID;
    NSString *postCode = (_postCodeTF)?[_postCodeTF text]:nil;
    NSString *provinceID = [[_dataModel.provinceList objectAtIndex:_provinceTF.selectedRow] objectForKey:kResultKeyID];
    NSString *cityID = [[_dataModel.cityList objectAtIndex:_cityTF.selectedRow] objectForKey:kResultKeyID];
    NSString *districtID = [[_dataModel.districtList objectAtIndex:_districtTF.selectedRow] objectForKey:kResultKeyID];
    
    [[APIsConnection shareConnection] personalCenterAPIsPatchShippingAddressWithAccessToken:self.accessToken
                                                                                       addressID:addressID
                                                                                   consigneeName:_consigneeNameTF.text
                                                                                    mobileNumber:_mobileNumberTF.text
                                                                                        postCode:postCode
                                                                                      provinceID:provinceID
                                                                                          cityID:cityID
                                                                                      districtID:districtID
                                                                                   detailAddress:_detailAddressTF.text
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
     [operation setUserInfo:@{@"iden":@4}];
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
        NSNumber *idenNumber = [operation.userInfo objectForKey:@"iden"];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if ([idenNumber integerValue]!=3 || [idenNumber integerValue]!=4) {
            [ProgressHUDHandler dismissHUD];
        }
        
        switch (errorCode) {
            case 0:
                switch ([idenNumber integerValue]) {
                    case 0:
                        [self handleProvinceList:[responseObject objectForKey:CDZKeyOfResultKey]];
                        break;
                    case 1:
                        [self handleCityList:[responseObject objectForKey:CDZKeyOfResultKey]];
                        break;
                    case 2:
                        [self handleDistrictList:[responseObject objectForKey:CDZKeyOfResultKey]];
                        break;
                    case 3:
                        [self submitFinish:getLocalizationString(@"success_submit")];
                        return;
                    case 4:
                        [self submitFinish:getLocalizationString(@"success_update")];
                        return;
                        break;
                        
                    default:
                        NSLog(@"default");
                        break;
                }
                break;
            case 1:
            case 2:
                switch ([idenNumber integerValue]) {
                    case 2:
                        if (errorCode==1||[message isEqualToString:@"没有数据"]) {
                            [self handleDistrictList:@[@{@"region_name": getLocalizationString(@"no_more_district_option"),
                                                       @"region_id": kDataEmpty}]];
                        }
                        break;
                        
                    default:
                        [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                            
                        }];
                        break;
                }
                break;
                
            default:
                break;
        }

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
