//
//  SelfDiagnosisVC.m
//  cdzer
//
//  Created by KEns0n on 6/19/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define stepViewBaseTag 700
#define numLogoBaseTag 600
#define labelBaseTag 500
#define cellHeight 40.0f
#define kTypeKey(typeID) (typeID==0)?@"live_describe":@"major_describe"
#define kObjNameKey @"name"
#define kObjIDKey @"id"
#define kObjParentIDKey @"parent_id"
#define kSelectedIdxKey @"idx"
#define kSelectedStringKey @"string"
#define kConfigTitleKey @"title"


#import "SelfDiagnosisVC.h"
#import "AutosSelectedView.h"
#import "InsetsLabel.h"
#import <UIView+Borders/UIView+Borders.h>
#import "SelfDiagnosisResultVC.h"
#import "SelfDiagnosisCell.h"

@interface SelfDiagnosisVC () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (nonatomic, assign) CGRect keyboardRect;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, strong) NSNumber *currentSelectType;

@property (nonatomic, strong) NSIndexPath *currentStepIndex;
@property (nonatomic, strong) NSMutableArray *totalDataList, *innerDataList, *selectionLists;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AutosSelectedView *ASView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIPickerView *pickerview;
@property (nonatomic, strong) UITextField *infoTextField;

@property (nonatomic, strong) UIBarButtonItem *previousButton, *nextButton, *doneButton;

@property (nonatomic, strong) UIView *typeSelectionView;
@property (nonatomic, strong) UIButton *descSymptoms, *descAutosMalfunction;

@end

@implementation SelfDiagnosisVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"self_analyzation")];
//    [self setRightNavButtonWithTitleOrImage:getLocalizationString(@"finish") style:UIBarButtonItemStyleDone target:self action:@selector(getAutoAnalyztionResult) titleColor:nil isNeedToSet:YES];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self componentSetting];
    [self setReactiveRules];
    [self initializationUI];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([_totalDataList[0] count]==0||[_totalDataList[0] count]==0) {
        [self getAutoSelfAnalyztionAPIsAccessRequestByID:nil requestIdx:_currentStepIndex];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [_ASView reloadUIData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignKeyboard];
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)componentSetting {
    [self setRightNavButtonWithTitleOrImage:@"类型" style:UIBarButtonItemStyleDone target:self action:@selector(showHidenTypeView) titleColor:CDZColorOfWhite isNeedToSet:YES];
    self.currentSelectType = @(-1);
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.innerDataList = [NSMutableArray arrayWithObject:@""];
    self.totalDataList = [NSMutableArray arrayWithCapacity:1];
    [self.totalDataList addObjectsFromArray:@[@[]]];
    self.selectionLists = [NSMutableArray array];
    [self.selectionLists addObjectsFromArray:@[@{kSelectedIdxKey:@(-1),kSelectedStringKey:@"",kConfigTitleKey:@"failure_type"},
                                               @{kSelectedIdxKey:@(-1),kSelectedStringKey:@"",kConfigTitleKey:@"failure_appearance"},
                                               @{kSelectedIdxKey:@(-1),kSelectedStringKey:@"",kConfigTitleKey:@"failure_type_struct"},
                                               @{kSelectedIdxKey:@(-1),kSelectedStringKey:@"",kConfigTitleKey:@"failure_factor_analyze"},
                                               @{kSelectedIdxKey:@(-1),kSelectedStringKey:@"",kConfigTitleKey:@"slove_problem"},
                                               @{kSelectedIdxKey:@(-1),kSelectedStringKey:@"",kConfigTitleKey:@"component_replacement"}]];
    self.currentStepIndex = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, totalDataList) subscribeNext:^(id sender) {
        @strongify(self)
        NSArray *tmpArray = self.selectionLists;
        [tmpArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (self.currentStepIndex.row<idx) {
                NSMutableDictionary *detailData = [obj mutableCopy];
                [detailData setObject:@(-1) forKey:kSelectedIdxKey];
                [detailData setObject:@"" forKey:kSelectedStringKey];
                [self.selectionLists replaceObjectAtIndex:idx withObject:detailData];
            }
        }];
        self.previousButton.enabled = !(self.currentStepIndex.row==0);
        self.nextButton.enabled = !(self.currentStepIndex.row==[(NSArray *)sender count]-1);
        if (self.currentSelectType.integerValue>-1) {
            [self.tableView reloadData];
        }
    }];
    
    [RACObserve(self, currentStepIndex) subscribeNext:^(NSIndexPath *currentStepIndex) {
        @strongify(self)
        self.previousButton.enabled = !(currentStepIndex.row==0);
        self.nextButton.enabled = !(currentStepIndex.row==self.totalDataList.count-1);
    }];
    
    
    [RACObserve(self, tableView.contentSize) subscribeNext:^(id sender) {
        @strongify(self)
        CGFloat height = CGRectGetMinY(self.tableView.frame)+[sender CGSizeValue].height;
        CGSize contentSize = self.scrollView.contentSize;
        contentSize.height = (height<=CGRectGetHeight(self.scrollView.frame))?CGRectGetHeight(self.scrollView.frame):height;
        self.contentSize = contentSize;
    }];
}

- (void)initializationUI {
    @autoreleasepool {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
        [_scrollView setBackgroundColor:self.contentView.backgroundColor];
        [_scrollView setBounces:NO];
        _scrollView.scrollEnabled = YES;
        [self.contentView addSubview:_scrollView];
        
        CGRect bannerRect = CGRectZero;
        UIImage *bannerImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches fileName:@"self_test" type:FMImageTypeOfPNG scaleWithPhone4:NO needToUpdate:NO];
        bannerRect.origin.y = (IS_IPHONE_4_OR_LESS)?(-10.0f):0.0f;
        bannerRect.size = bannerImage.size;
        UIImageView *bannerView = [[UIImageView alloc] initWithFrame:bannerRect];
        [bannerView setImage:bannerImage];
        [_scrollView addSubview:bannerView];
        
        self.ASView = [[AutosSelectedView alloc] initWithOrigin:CGPointMake(0.0f, CGRectGetMaxY(bannerView.frame)) showMoreDeatil:NO onlyForSelection:NO];
        [_scrollView addSubview:_ASView];
        [_ASView addTarget:self action:@selector(pushToVehicleSelectedVC) forControlEvents:UIControlEventTouchUpInside];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        NSString *stepFlowTxt = getLocalizationString(@"setp_flow_title");
        CGRect tableViewRect = self.contentView.bounds;
        tableViewRect.origin.y = CGRectGetMaxY(_ASView.frame);
        tableViewRect.size.height -= CGRectGetMaxY(_ASView.frame);;
        self.tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = CDZColorOfWhite;
        [self.scrollView addSubview:_tableView];
        
        InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableView.frame), 36.0f)
                                                           andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
        titleLabel.text = stepFlowTxt;
        titleLabel.hidden = YES;
        titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
        _tableView.tableHeaderView = titleLabel;
        [titleLabel addBottomBorderWithHeight:1.0f andColor:[UIColor colorWithRed:0.882f green:0.882f blue:0.882f alpha:1.00f]];
        
        [self setupPickerView];
        [self initTypeView];
        
    }
}

- (void)initTypeView {
    CGRect typeRect = self.contentView.bounds;
    typeRect.origin.y = CGRectGetMaxY(_ASView.frame);
    typeRect.size.height = CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(_ASView.frame);
    self.typeSelectionView = [[UIView alloc] initWithFrame:typeRect];
    _typeSelectionView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.88f];
    [self.contentView addSubview:_typeSelectionView];
    
    CGFloat hight = CGRectGetHeight(_typeSelectionView.frame)*0.36f;
    CGFloat offsetY = CGRectGetHeight(_typeSelectionView.frame)*0.07;
    CGFloat width = CGRectGetWidth(_typeSelectionView.frame)*0.8f;
    CGFloat offsetX = CGRectGetWidth(_typeSelectionView.frame)*0.1f;
    
    self.descAutosMalfunction = [UIButton buttonWithType:UIButtonTypeSystem];
    _descAutosMalfunction.titleLabel.numberOfLines = 0;
    _descAutosMalfunction.titleLabel.textAlignment = NSTextAlignmentCenter;
    _descAutosMalfunction.frame = CGRectMake(offsetX, offsetY, width, hight);
    [_descAutosMalfunction setTitleEdgeInsets:DefaultEdgeInsets];
    [_descAutosMalfunction setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
    [_descAutosMalfunction setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
    [_descAutosMalfunction setTitleColor:CDZColorOfWhite forState:UIControlStateSelected];
    [_descAutosMalfunction setTitleColor:CDZColorOfBlack forState:UIControlStateHighlighted];
    [_descAutosMalfunction setTitle:@"如果您知道您的车辆故障所处的车辆部位，您可以点击此处以车辆部位查找问题：" forState:UIControlStateNormal];
    [_descAutosMalfunction setTitle:@"如果您知道您的车辆故障所处的车辆部位，您可以点击此处以车辆部位查找问题：" forState:UIControlStateSelected];
    [_descAutosMalfunction setBackgroundImage:[ImageHandler createImageWithColor:CDZColorOfDefaultColor withRect:_descAutosMalfunction.bounds] forState:UIControlStateNormal];
    [_descAutosMalfunction setBackgroundImage:[ImageHandler createImageWithColor:CDZColorOfOrangeColor withRect:_descAutosMalfunction.bounds] forState:UIControlStateSelected];
    [_descAutosMalfunction addTarget:self action:@selector(typeSelection:) forControlEvents:UIControlEventTouchUpInside];
    [_typeSelectionView addSubview:_descAutosMalfunction];
    
    self.descSymptoms = [UIButton buttonWithType:UIButtonTypeSystem];
    _descSymptoms.titleLabel.numberOfLines = 0;
    _descSymptoms.titleLabel.textAlignment = NSTextAlignmentCenter;
    _descSymptoms.frame = CGRectMake(offsetX, CGRectGetMaxY(_descAutosMalfunction.frame)+offsetY*2.0f, width, hight);
    [_descSymptoms setTitleEdgeInsets:DefaultEdgeInsets];
    [_descSymptoms setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
    [_descSymptoms setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
    [_descSymptoms setTitleColor:CDZColorOfWhite forState:UIControlStateSelected];
    [_descSymptoms setTitleColor:CDZColorOfBlack forState:UIControlStateHighlighted];
    [_descSymptoms setTitle:@"如果您不知道是什么问题，\n请选择点击此处以症状描述查找问题：" forState:UIControlStateNormal];
    [_descSymptoms setTitle:@"如果您不知道是什么问题，\n请选择点击此处以症状描述查找问题：" forState:UIControlStateSelected];
    [_descSymptoms setBackgroundImage:[ImageHandler createImageWithColor:CDZColorOfDefaultColor withRect:_descSymptoms.bounds] forState:UIControlStateNormal];
    [_descSymptoms setBackgroundImage:[ImageHandler createImageWithColor:CDZColorOfOrangeColor withRect:_descSymptoms.bounds] forState:UIControlStateSelected];
    [_descSymptoms addTarget:self action:@selector(typeSelection:) forControlEvents:UIControlEventTouchUpInside];
    [_typeSelectionView addSubview:_descSymptoms];
    
}

- (void)showHidenTypeView {
    
    if (_typeSelectionView.alpha) {
        [self hiddenTypeViewWithAnimation];
    }else {
        [self showTypeViewWithAnimation];
    }
}

- (void)hiddenTypeViewWithAnimation {
    @weakify(self)
    [self resignKeyboard];
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.typeSelectionView.alpha = 0;
        CGRect frame = self.typeSelectionView.frame;
        frame.origin.y = CGRectGetHeight(self.contentView.frame);
        self.typeSelectionView.frame = frame;
        
        self.navigationItem.rightBarButtonItem.tintColor = CDZColorOfWhite;
        self.navigationItem.rightBarButtonItem.enabled = YES;;
    }];
}

- (void)showTypeViewWithAnimation {
    @weakify(self)
    [self resignKeyboard];
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.typeSelectionView.alpha = 1;
        CGRect frame = self.typeSelectionView.frame;
        frame.origin.y = CGRectGetHeight(self.contentView.frame)-CGRectGetHeight(frame);
        self.typeSelectionView.frame = frame;
        
        self.navigationItem.rightBarButtonItem.tintColor = CDZColorOfOrangeColor;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

- (void)typeSelection:(UIButton *)button {
    _tableView.tableHeaderView.hidden = NO;
    _descAutosMalfunction.selected = NO;
    _descSymptoms.selected = NO;
    button.selected = YES;
    [self hiddenTypeViewWithAnimation];
    if ([button isEqual:_descAutosMalfunction]) {
        if (_currentSelectType.integerValue==0) {
            return;
        }
        self.currentSelectType = @(1);
        self.currentStepIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        [self clearLastSelectedData];
        [self handleSwitchInnerData];
    }
    if ([button isEqual:_descSymptoms]) {
        if (_currentSelectType.integerValue==1) {
            return;
        }
        self.currentSelectType = @(0);
        self.currentStepIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        [self clearLastSelectedData];
        [self handleSwitchInnerData];
    }
}

- (void)clearLastSelectedData {
    NSRange range = NSMakeRange(1, _totalDataList.count-1);
    [_totalDataList removeObjectsInRange:range];
    NSArray *tmpArray = self.selectionLists;
    [tmpArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (self.currentStepIndex.row<=idx) {
            NSMutableDictionary *detailData = [obj mutableCopy];
            [detailData setObject:@(-1) forKey:kSelectedIdxKey];
            [detailData setObject:@"" forKey:kSelectedStringKey];
            [self.selectionLists replaceObjectAtIndex:idx withObject:detailData];
        }
    }];
    self.previousButton.enabled = !(self.currentStepIndex.row==0);
    self.nextButton.enabled = !(self.currentStepIndex.row==_totalDataList.count-1);
    [self.tableView reloadData];
}

- (void)pushToVehicleSelectedVC {
    [self pushToAutoSelectionViewWithBackTitle:nil animated:YES onlyForSelection:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupPickerView {
    self.pickerview = [[UIPickerView alloc] init];
    _pickerview.delegate = self;
    _pickerview.dataSource = self;
    
    self.toolBar =  [[UIToolbar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), 40.0f)];
    [_toolBar setBarStyle:UIBarStyleDefault];
    self.doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"cancel")
                                                      style:UIBarButtonItemStyleDone
                                                     target:self
                                                     action:@selector(resignKeyboard)];
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                target:self
                                                                                action:nil];
    self.previousButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:101
                                                                       target:self
                                                                       action:@selector(barButtonAction:)];
    _previousButton.enabled = NO;
    UIBarButtonItem *fixSpaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:self
                                                                                   action:nil];
    fixSpaceButton.width = 10.0f;
    self.nextButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:102
                                                                   target:self
                                                                   action:@selector(barButtonAction:)];
    self.nextButton.enabled = NO;
    NSArray * buttonsArray = [NSArray arrayWithObjects:_doneButton,spaceButton,_previousButton,fixSpaceButton,_nextButton,fixSpaceButton,nil];
    [_toolBar setItems:buttonsArray];
    
    self.infoTextField = [[UITextField alloc] initWithFrame:_ASView.frame];
    _infoTextField.inputView = _pickerview;
    _infoTextField.inputAccessoryView = _toolBar;
    _infoTextField.delegate = self;
    _infoTextField.alpha = 0.0f;
    [_scrollView insertSubview:_infoTextField belowSubview:_ASView];
    
}

#pragma mark- Private Functions
- (NSInteger)getCurrentShowRow {
    NSInteger cID = _totalDataList.count-1;
    if (cID<0) cID = 0;
    return cID;
}

- (void)resignKeyboard {
    [_infoTextField resignFirstResponder];
    _scrollView.contentSize = _contentSize;
    _scrollView.scrollEnabled = (_contentSize.height>CGRectGetHeight(_tableView.frame));
    [_scrollView setContentOffset:CGPointZero animated:YES];
}

- (void)barButtonAction:(UIBarButtonItem *)barButton {
    @autoreleasepool {
        NSInteger currentStep = _currentStepIndex.row;
        if ([barButton isEqual:_nextButton]&&currentStep!=self.getCurrentShowRow) {
            currentStep++;
            
        }else if([barButton isEqual:_previousButton]&&currentStep!=0) {
            currentStep--;
        }
        [self showPickerViewByStepView:[NSIndexPath indexPathForRow:currentStep inSection:_currentStepIndex.section]];
    }
}

- (void)showPickerViewByStepView:(NSIndexPath *)indexPath {
    if(!_infoTextField.isFirstResponder) [_infoTextField becomeFirstResponder];
    if ([_currentStepIndex compare:indexPath]==NSOrderedSame) return;
    self.currentStepIndex = indexPath;
    [self shiftScrollViewWithAnimation];
    [self handleSwitchInnerData];
}

- (void)updatePickerSelection {
    @autoreleasepool {
        NSMutableArray *array = [self mutableArrayValueForKey:@"selectionLists"];
        NSMutableDictionary *dataDetail = [array[_currentStepIndex.row] mutableCopy];
        NSInteger idx = [_pickerview selectedRowInComponent:0];
        [dataDetail setObject:@(idx-1) forKey:kSelectedIdxKey];
        if (idx==0) {
            [dataDetail setObject:@"" forKey:kSelectedStringKey];
        }else {
            [dataDetail setObject:_innerDataList[idx] forKey:kSelectedStringKey];
        }
        [array replaceObjectAtIndex:_currentStepIndex.row withObject:dataDetail];
        
        if (idx!=0) {
            NSString *stringID = @"";
             if (_currentStepIndex.row==0&&_currentSelectType.integerValue>-1)  {
                NSArray *typeList = [_totalDataList[_currentStepIndex.row] objectForKey:kTypeKey(_currentSelectType.integerValue)];
                stringID = [typeList[idx-1] objectForKey:kObjIDKey];
            }else {
                stringID = [_totalDataList[_currentStepIndex.row][idx-1] objectForKey:kObjIDKey];
            }
            [self getAutoSelfAnalyztionAPIsAccessRequestByID:stringID requestIdx:[NSIndexPath indexPathForRow:_currentStepIndex.row+1 inSection:0]];
        }
        
        [_tableView reloadData];
    }
}

- (NSInteger)getCurrentSelectedIdx {
    
    NSInteger idx = [[_selectionLists[_currentStepIndex.row] objectForKey:kSelectedIdxKey] integerValue];
    idx +=1;
    return idx;
}

- (void)reloadPickerData {
    [_pickerview reloadComponent:0];
    NSInteger idx = [self getCurrentSelectedIdx];
    [_pickerview selectRow:idx inComponent:0 animated:NO];
    
}

// 键盘处理
- (void)keyboardWillShow:(NSNotification *)notifyObject {
    CGRect keyboardRect = [[notifyObject.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (!CGRectEqualToRect(keyboardRect, _keyboardRect)) {
        self.keyboardRect = keyboardRect;
    }
    [self shiftScrollViewWithAnimation];
    NSLog(@"Step One");
}

- (void)shiftScrollViewWithAnimation{
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:_currentStepIndex];
    CGPoint point = CGPointZero;
    CGFloat contanierViewMaxY = CGRectGetMidY([cell.superview convertRect:cell.frame toView:_scrollView]);
    CGFloat visibleContentsHeight = (CGRectGetHeight(_scrollView.frame)-CGRectGetHeight(_keyboardRect))/2.0f;
    if (contanierViewMaxY > visibleContentsHeight) {
        CGFloat offsetY = contanierViewMaxY-visibleContentsHeight;
        point.y = offsetY;
    }
    
    [_scrollView setContentOffset:point animated:NO];
    
}

- (void)restoreScrollViewToTop {
    [_scrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
}

#pragma mark- UIPickerView & UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!CGRectEqualToRect(CGRectZero, _keyboardRect)) {
        [self shiftScrollViewWithAnimation];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _innerDataList.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    @autoreleasepool {
        UILabel *labelText = [UILabel new];
        [labelText setTextAlignment:NSTextAlignmentCenter];
        labelText.backgroundColor = [UIColor clearColor];
        labelText.font = [UIFont boldSystemFontOfSize:20.0];
        labelText.textColor = [UIColor blackColor];
        labelText.numberOfLines = 0;
        [labelText setText:self.innerDataList[row]];
        
        if (row == 0)
        {
            labelText.font = [UIFont boldSystemFontOfSize:30.0];
            labelText.textColor = [UIColor lightGrayColor];
        }
        return labelText;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self updatePickerSelection];
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (_currentSelectType.integerValue<0) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _totalDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    SelfDiagnosisCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[SelfDiagnosisCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    // Configure the cell...
    cell.titleLabel.text = @"";
    cell.subDetailLabel.text = @"";
    [cell.currentStepLogo setTitle:@(indexPath.row+1).stringValue forState:UIControlStateNormal];
    NSDictionary *data = _selectionLists[indexPath.row];
    if (data) {
        cell.titleLabel.text = [SupportingClass getLocalizationString:data[kConfigTitleKey]];
        cell.subDetailLabel.text = data[kSelectedStringKey];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _selectionLists[indexPath.row];
    if (data) {
        NSString *string = data[kSelectedStringKey];
        UIFont *font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
        CGSize size = [SupportingClass getStringSizeWithString:string font:font widthOfView:CGSizeMake(CGRectGetWidth(tableView.frame)/2.0f-15.0f, CGFLOAT_MAX)];
        NSLog(@"%f",size.height);
        CGFloat height = size.height+22;
        
        if (height>cellHeight) {
            return height;
        }
    }
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [cell.layer.sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[CALayer class]]) {
            CALayer *oldLayer = (CALayer *)obj;
            if ([oldLayer.name isEqualToString:@"bottomBorder"]) {
                [oldLayer removeFromSuperlayer];
                *stop = YES;
            }
        }
    }];
    
    CALayer *layer = [cell createBottomBorderWithHeight:1.0f andColor:[UIColor colorWithRed:0.882f green:0.882f blue:0.882f alpha:1.00f]];
    layer.name = @"bottomBorder";
    [cell.layer addSublayer:layer];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Update the delete button's title based on how many items are selected.
    NSLog(@"%@",[tableView indexPathsForSelectedRows]);
    [self showPickerViewByStepView:indexPath];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)showAletViewWhenSelectionDone {
    @autoreleasepool {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:getLocalizationString(@"alert_remind")
                                                        message:@"诊断步骤已经完成，点击确定生成结果，或者取消选择其他！"
                                                       delegate:self cancelButtonTitle:getLocalizationString(@"cancel")
                                              otherButtonTitles:getLocalizationString(@"ok") , nil];
        [alert show];
    }
}

- (void)showLoadingInPickerSuperview {
    @autoreleasepool {
        UIView *view = _toolBar.superview.superview;
        if (view) {
            [ProgressHUDHandler showHUDWithTitle:nil onView:view];
        }else {
            [ProgressHUDHandler showHUD];
        }
    }
}

#pragma network data Handle Section
// 处理结果
- (void)handleDataList:(id)responseObject withIdent:(NSInteger)ident {
    @autoreleasepool {
        if (!responseObject) {
            NSLog(@"DataList Error at %@",NSStringFromClass(self.class));
            return;
        }
        if ([responseObject count]==0) {
            NSString *message = @"没有更多选择";
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            }];
            return;
        }
//    fct: "874",
//    speci: "1969",
//    major_describe:[]
//    live_describe:[]
        NSMutableArray *totalData = [self mutableArrayValueForKey:@"totalDataList"];
        if (ident==0) {
            [totalData replaceObjectAtIndex:ident withObject:responseObject];
        }else {
            if (totalData.count>=(ident+1)) {
                NSRange range = NSMakeRange(ident, totalData.count-ident);
                [totalData removeObjectsInRange:range];
            }
            [totalData addObject:responseObject];
        }
    }
}
// 处理内部列表结果
- (void)handleSwitchInnerData {
    @autoreleasepool {
        NSMutableArray *innerData = [self mutableArrayValueForKey:@"innerDataList"];
        NSArray *dataNameArray = @[];
        if (_currentStepIndex.row==0&&_currentSelectType.integerValue>-1) {
             dataNameArray = [_totalDataList[_currentStepIndex.row] objectForKey:kTypeKey(_currentSelectType.integerValue)];
        }else {
             dataNameArray = [_totalDataList objectAtIndex:_currentStepIndex.row];
        }
        NSString *firstObjTitleKey = [NSString stringWithFormat:@"please_select_failure_titile_id_%ld",(long)_currentStepIndex.row];
        
        [innerData replaceObjectAtIndex:0 withObject:getLocalizationString(firstObjTitleKey)];
        [innerData removeObjectsInRange:NSMakeRange(1, innerData.count-1)];
        [innerData addObjectsFromArray:[dataNameArray valueForKey:kObjNameKey]];
        if (_currentSelectType.integerValue>-1&&_currentStepIndex.row==0) {
            [_tableView reloadData];
        }
    }
    [self reloadPickerData];
}
// 提示提交完成
- (void)confirmBtnActionGetResult:(NSDictionary *)resultData {
    @autoreleasepool {
        SelfDiagnosisResultVC *sdrVC = [[SelfDiagnosisResultVC alloc] init];
        sdrVC.resultData = resultData;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:sdrVC animated:YES];
    }
}

#pragma mark- APIs Access Request
- (void)getAutoSelfAnalyztionAPIsAccessRequestByID:(NSString *)theIDString requestIdx:(NSIndexPath *)indexPath {
    [self showLoadingInPickerSuperview];
    switch (indexPath.row) {
        case 0:
            // 请求故障种类
            NSLog(@"%@ accessing Autos failure type list request",NSStringFromClass(self.class));
            break;
        case 1:
            // 请求故障现象
            NSLog(@"%@ accessing Autos fault symptom list request",NSStringFromClass(self.class));
            break;
        case 2:
            // 请求故障架构
            NSLog(@"%@ accessing Autos fault structure list request",NSStringFromClass(self.class));
            break;
        case 3:
            // 请求原因分析
            NSLog(@"%@ accessing Diagnosis result list request",NSStringFromClass(self.class));
            break;
        case 4:
            // 请求故障解决方案
            NSLog(@"%@ accessing solution plan list request",NSStringFromClass(self.class));
            break;
//        case 5:
//            // 请求配件更换建议
//            NSLog(@"%@ accessing proposed replacement parts list request",NSStringFromClass(self.class));
            break;
        default:
            NSLog(@"Not find APIs Request Functon");
            break;
    }
    AFHTTPRequestOperation *operations = [[APIsConnection shareConnection] commonAPIsGetAutoSelfDiagnosisStepListWithStep:indexPath.row previousStepID:theIDString seriesID:_ASView.autoData.seriesID modelID:_ASView.autoData.modelID typeID:_currentSelectType success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [operation setUserInfo:@{@"iden":@(indexPath.row)}];
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
    if (!operations) {
        [self resignKeyboard];
        [self showAletViewWhenSelectionDone];
    }
}

- (void)getDiagnosisResult {
    [self showLoadingInPickerSuperview];
    NSString *reasonName = [_selectionLists[_currentStepIndex.row] objectForKey:kSelectedStringKey];
    if (!reasonName) {
        [ProgressHUDHandler showErrorWithStatus:@"Missing Part Name" onView:nil completion:^{
        }];
        return;
    }
    NSNumber *brandId = _ASView.autoData.brandID;
    NSNumber *pageNums = @(1);
    NSNumber *pageSize = @(10);
    NSNumber *longitude = @(112.979353);
    NSNumber *latitude = @(28.213478);
    NSNumber *cityID = @(197);
    @weakify(self)
    [[APIsConnection shareConnection] selfDiagnoseAPIsGetDiagnoseResultListWithReasonName:reasonName brandId:brandId pageNums:pageNums pageSize:pageSize longitude:longitude latitude:latitude cityID:cityID success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
         NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
         if (errorCode!=0) {
             [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
             }];
             return ;
         }
        @strongify(self)
        NSLog(@"%@",responseObject[CDZKeyOfResultKey]);
        [self confirmBtnActionGetResult:responseObject];
        
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
         [ProgressHUDHandler dismissHUD];
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
        if (errorCode!=0) {
            if (errorCode==1&&([message rangeOfString:@"商家"].location!=NSNotFound||[message rangeOfString:@"接口"].location!=NSNotFound)) {
                [self resignKeyboard];
                [self showAletViewWhenSelectionDone];
                return;
            }
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {[ProgressHUDHandler dismissHUD];}];
            return;
        }
        [ProgressHUDHandler dismissHUD];
        [self handleDataList:[responseObject objectForKey:CDZKeyOfResultKey] withIdent:idenNumber.integerValue];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        [self showPickerViewByStepView:_currentStepIndex];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [ProgressHUDHandler dismissHUD];
    if (buttonIndex==1) {
        [self getDiagnosisResult];
    }
}


@end
