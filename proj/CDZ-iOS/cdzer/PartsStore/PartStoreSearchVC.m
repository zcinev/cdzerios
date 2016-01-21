//
//  PartStoreSearchVC.m
//  cdzer
//
//  Created by KEns0n on 8/11/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#import "InsetsLabel.h"
#import "InsetsTextField.h"
#import "PartStoreSearchVC.h"
#import "PartsStepSelectionView.h"
#import "UserSelectedAutosInfoDTO.h"
#import "PartsStoreSearchResultVC.h"
#import <UIView+Borders/UIView+Borders.h>
#import "PartsItemDetailVC.h"
#import "PartsStoreResultCell.h"
#import "PartsSearchReferenceObject.h"


@interface ArrowTBC : UITableViewCell

@end
@implementation ArrowTBC

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.accessoryView) {
        CGPoint center = self.accessoryView.center;
        center.x = center.x-5.0f;
        self.accessoryView.center = center;
    }
    
    if (self.textLabel) {
        CGPoint center = self.textLabel.center;
        center.y = CGRectGetHeight(self.frame)/2.0f;
        self.textLabel.center = center;
    }
    
    if (self.detailTextLabel) {
        CGRect frame = self.detailTextLabel.frame;
        frame.origin.x = CGRectGetMaxX(self.textLabel.frame);
        self.detailTextLabel.frame = frame;
    }
}

@end

@interface PartStoreSearchVC () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *autoPartsBtn;

@property (nonatomic, strong) ArrowTBC *autoSelectView;

@property (nonatomic, strong) UserSelectedAutosInfoDTO *autoData;

@property (nonatomic, strong) UITableView *resultTableView;

@property (nonatomic, strong) UIView *selectionView;

@property (nonatomic, strong) InsetsTextField *searchTextField;

@property (nonatomic, strong) UIBarButtonItem *kLeftItem;

@property (nonatomic, strong) UIBarButtonItem *kRightItem;

@property (nonatomic, strong) UITableView *searchHistoryTV;

@property (nonatomic, strong) NSArray *historyList;

@property (nonatomic, strong) UIBarButtonItem *pLeftItem;

@property (nonatomic, strong) UIBarButtonItem *pRightItem;

@property (nonatomic, strong) ArrowTBC *partsSelectedView;

@property (nonatomic, strong) PartsStepSelectionView *partsStepView;

@property (nonatomic, strong) UIButton *partsSearchBtn;

@property (nonatomic, strong) NSArray *recommendProductList;

@end

@implementation PartStoreSearchVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = getLocalizationString(@"auto_parts");
    [self initializationUI];
    [self componentSetting];
    [self setReactiveRules];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.autoData = [[DBHandler shareInstance] getSelectedAutoData];
    self.historyList = DBHandler.shareInstance.getPartsSearchHistory;
    [self getRecommendProductList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self hiddenKeyboard];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    self.historyList = @[];
    self.recommendProductList = @[];
    self.kLeftItem = [self setLeftNavButtonWithTitleOrImage:@"" style:UIBarButtonItemStyleDone target:nil action:nil titleColor:nil isNeedToSet:NO];
    self.kRightItem = [self setRightNavButtonWithTitleOrImage:(@"finish") style:UIBarButtonItemStyleDone target:self action:@selector(hiddenKeyboard) titleColor:nil isNeedToSet:NO];
    self.pLeftItem = [self setLeftNavButtonWithTitleOrImage:@"cancel" style:UIBarButtonItemStylePlain target:self action:@selector(hiddenPartsSelectionView) titleColor:nil isNeedToSet:NO];
    self.pRightItem = [self setRightNavButtonWithTitleOrImage:(@"finish") style:UIBarButtonItemStyleDone target:self action:@selector(hiddenPartsSelectionView) titleColor:nil isNeedToSet:NO];
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, autoData) subscribeNext:^(UserSelectedAutosInfoDTO *autoData) {
        @strongify(self)
        if (autoData) {
            NSString *carDetail = [NSString stringWithFormat:@"%@ %@\n%@",
                                   autoData.dealershipName,
                                   autoData.seriesName,
                                   autoData.modelName];
            self.autoSelectView.detailTextLabel.text = carDetail;
        }else {
            self.autoSelectView.detailTextLabel.text = getLocalizationString(@"carSelectRemind2");
        }
    }];
    
    [RACObserve(self, historyList) subscribeNext:^(NSArray *historyList) {
        @strongify(self)
        [self.searchHistoryTV reloadData];
    }];
    
    [RACObserve(self, partsStepView.stepStringList) subscribeNext:^(NSArray *stepStringList) {
        @strongify(self)
        if (stepStringList&&stepStringList.count>=3) {
//            NSString *firstString = stepStringList[0];
            NSString *secondString = stepStringList[1];
            NSString *thirdString = stepStringList[2];
            NSMutableAttributedString *result = [NSMutableAttributedString new];
//            if (firstString&&![firstString isEqualToString:@""]) {
//                [result appendString:firstString];
//            }
            
            if (secondString&&![secondString isEqualToString:@""]) {
                [result appendAttributedString:[[NSAttributedString alloc]
                                                initWithString:[NSString stringWithFormat:@"%@",secondString]
                                                attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray,
                                                             NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14, NO)}]];
            }
            
            if (thirdString&&![thirdString isEqualToString:@""]) {
                [result appendAttributedString:[[NSAttributedString alloc]
                                                initWithString:[NSString stringWithFormat:@"\n%@",thirdString]
                                                attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                             NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 17, NO)}]];
            }
            self.partsSelectedView.detailTextLabel.text = @"";
            self.partsSelectedView.detailTextLabel.attributedText = result;
            
            self.partsSearchBtn.hidden = (!self.partsStepView.lastStepID&&[thirdString isEqualToString:@""]);
            if (self.partsStepView.view.alpha == 1) {
                __block CGPoint offset = CGPointZero;
                __block CGRect frame = self.partsStepView.view.frame;
                if (self.partsStepView.lastStepID&&![thirdString isEqualToString:@""]) {
                    if (self.navigationItem.rightBarButtonItem&&self.navigationItem.rightBarButtonItem==self.pLeftItem) {
                        self.navigationItem.rightBarButtonItem = nil;
                    }
                    self.navigationItem.rightBarButtonItem = self.pRightItem;
                    [UIView animateWithDuration:0.25 animations:^{
                        offset.y = CGRectGetMinY(self.selectionView.frame);
                        frame.size.height = CGRectGetHeight(self.scrollView.frame)-CGRectGetHeight(self.selectionView.frame);
                        self.partsStepView.view.frame = frame;
                        self.scrollView.contentOffset = offset;
                        self.autoPartsBtn.hidden = YES;
                    }];
                }else {
                    offset.y = CGRectGetMaxY(self.selectionView.frame);
                    frame.size.height = CGRectGetHeight(self.scrollView.frame);
                    self.partsStepView.view.frame = frame;
                    self.scrollView.contentOffset = offset;
                    self.autoPartsBtn.hidden = NO;
                    if (self.navigationItem.rightBarButtonItem&&self.navigationItem.rightBarButtonItem==self.pRightItem) {
                        self.navigationItem.rightBarButtonItem = nil;
                    }
                    self.navigationItem.rightBarButtonItem = self.pLeftItem;
                }
                
            }
        }
    }];
}

- (void)initializationUI {
    @autoreleasepool {
        
        UIFont *font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 15.0f, NO);
        UIImage *arrowImage = ImageHandler.getRightArrow;
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
        _scrollView.scrollEnabled = NO;
        [self.contentView addSubview:_scrollView];
        
        CGRect frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, vAdjustByScreenRatio(46.0f));
        UIControl *view = [[UIControl alloc] initWithFrame:frame];
        [view setBackgroundColor:CDZColorOfWhite];
        [view setBorderWithColor:[UIColor lightGrayColor] borderWidth:(0.5f)];
        [view addTarget:self action:@selector(showAutoSelectVC) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:view];
        
        self.autoSelectView = [[ArrowTBC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _autoSelectView.frame = view.bounds;
        _autoSelectView.textLabel.font = font;
        _autoSelectView.textLabel.text = getLocalizationString(@"auto_model_with_symbol");
        _autoSelectView.detailTextLabel.font = font;
        _autoSelectView.detailTextLabel.numberOfLines = 0;
        _autoSelectView.detailTextLabel.textAlignment = NSTextAlignmentLeft;
        _autoSelectView.detailTextLabel.textColor = _autoSelectView.textLabel.textColor;
        _autoSelectView.accessoryView = [[UIImageView alloc] initWithImage:arrowImage];
        _autoSelectView.userInteractionEnabled = NO;
        [view addSubview:_autoSelectView];
        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_scrollView.frame), 44.0f)];
//        [toolbar setBarStyle:UIBarStyleDefault];
//        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                                                    target:self
//                                                                                    action:nil];
//        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"finish")
//                                                                      style:UIBarButtonItemStyleDone
//                                                                     target:self
//                                                                     action:@selector(hiddenKeyboard)];
//        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButton,doneButton,nil];
//        [toolbar setItems:buttonsArray];

        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(frame), CGRectGetWidth(_scrollView.frame), 50.0f)];
//        [searchView setViewBorderWithRectBorder:UIRectBorderBottom borderSize:0.5f withColor:UIColor.lightGrayColor withBroderOffset:nil];
        [_scrollView addSubview:searchView];
        
        
        
        UIImage *iconImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                                 fileName:@"search"
                                                                                     type:FMImageTypeOfPNG
                                                                          scaleWithPhone4:NO
                                                                             needToUpdate:NO];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:iconImage];
        self.searchTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, 5.0f, CGRectGetWidth(searchView.frame)*0.70f, 40.0f)];
        _searchTextField.edgeInsets = UIEdgeInsetsMake(0.0f, CGRectGetWidth(imageView.frame)+20.0f, 0.0, 10.0f);
//        _searchTextField.inputAccessoryView = toolbar;
        _searchTextField.delegate = self;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.placeholder = @"请输入配件关键词";
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        [_searchTextField addBottomBorderWithHeight:1.0f color:CDZColorOfDeepGray
                                   leftOffset:_searchTextField.edgeInsets.left
                                  rightOffset:_searchTextField.edgeInsets.right
                              andBottomOffset:5.0f];
        [searchView addSubview:_searchTextField];
        
        imageView.frame = CGRectMake(15.0f, 0.0f, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame));
        imageView.center = CGPointMake(imageView.center.x, CGRectGetHeight(_searchTextField.frame)/2.0f);
        [_searchTextField addSubview:imageView];
        
        UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        searchBtn.frame = CGRectMake(CGRectGetWidth(searchView.frame)*0.7,
                                     CGRectGetMinY(_searchTextField.frame),
                                     CGRectGetWidth(searchView.frame)*0.3-15.0f,
                                     CGRectGetHeight(_searchTextField.frame));
        [searchBtn setBackgroundColor:CDZColorOfDefaultColor];
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [searchBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [searchBtn setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [searchBtn addTarget:self action:@selector(submitKeywordSearch) forControlEvents:UIControlEventTouchUpInside];
        [searchView addSubview:searchBtn];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        InsetsLabel *separatorView = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(searchView.frame), CGRectGetWidth(_scrollView.frame), 30.0f)];
        separatorView.text = @"--------你可输入关键词／使用配件类型搜索--------";
        separatorView.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14.0f, NO);
        separatorView.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:separatorView];
        
        self.selectionView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(separatorView.frame), CGRectGetWidth(_scrollView.frame), 60.0f)];
        [_selectionView setViewBorderWithRectBorder:UIRectBorderBottom borderSize:0.5f withColor:UIColor.lightGrayColor withBroderOffset:nil];
        [_scrollView addSubview:_selectionView];
       
        
        self.partsSelectedView = [[ArrowTBC alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        _partsSelectedView.frame = _selectionView.bounds;
        _partsSelectedView.textLabel.font = font;
        _partsSelectedView.textLabel.text = @"你已选择：";
        _partsSelectedView.textLabel.numberOfLines = 0;
        _partsSelectedView.detailTextLabel.font = font;
        _partsSelectedView.detailTextLabel.text = @"";
        _partsSelectedView.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        _partsSelectedView.detailTextLabel.numberOfLines = 0;
        [_selectionView addSubview:_partsSelectedView];
        
        
        self.autoPartsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _autoPartsBtn.frame = _selectionView.bounds;
        _autoPartsBtn.backgroundColor = CDZColorOfWhite;
        _autoPartsBtn.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 18.0f, NO);
        [_autoPartsBtn setTitle:@"点此选择配件" forState:UIControlStateNormal];
        [_autoPartsBtn setTitleColor:CDZColorOfBlack forState:UIControlStateNormal];
        [_autoPartsBtn addTarget:self action:@selector(showPartsSelectionView) forControlEvents:UIControlEventTouchUpInside];
        [_autoPartsBtn setViewBorderWithRectBorder:UIRectBorderBottom borderSize:0.5f withColor:UIColor.lightGrayColor withBroderOffset:nil];
        [_selectionView addSubview:_autoPartsBtn];
        
        CGRect resultTVRect = CGRectZero;
        resultTVRect.origin.y = CGRectGetMaxY(_selectionView.frame);
        resultTVRect.size = CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)-CGRectGetMaxY(_selectionView.frame));
        self.resultTableView = [[UITableView alloc] initWithFrame:resultTVRect];
        _resultTableView.delegate = self;
        _resultTableView.dataSource = self;
        _resultTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_resultTableView.frame), 10.0f)];
        [_scrollView insertSubview:_resultTableView belowSubview:_selectionView];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        self.partsStepView = [[PartsStepSelectionView alloc] init];
        _partsStepView.view.frame = CGRectMake(0.0f, CGRectGetMaxY(_selectionView.frame),
                                               CGRectGetWidth(_scrollView.frame),
                                               CGRectGetHeight(_scrollView.frame));
        _partsStepView.view.alpha = 0;
        [_scrollView addSubview:_partsStepView.view];
        
        
        self.partsSearchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _partsSearchBtn.hidden = YES;
        _partsSearchBtn.frame = CGRectMake(CGRectGetWidth(_selectionView.frame)*0.7f, 0.0f, CGRectGetWidth(_selectionView.frame)*0.3-15.0f, 40.0f);
        _partsSearchBtn.center = CGPointMake(_partsSearchBtn.center.x, CGRectGetHeight(_selectionView.frame)/2.0f);
        [_partsSearchBtn setBackgroundColor:CDZColorOfDefaultColor];
        [_partsSearchBtn setTitle:@"搜索配件" forState:UIControlStateNormal];
        [_partsSearchBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_partsSearchBtn setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [_partsSearchBtn addTarget:self action:@selector(submitPartsSelectionSearch) forControlEvents:UIControlEventTouchUpInside];
        [_selectionView addSubview:_partsSearchBtn];
        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        self.searchHistoryTV = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(searchView.frame),
                                                                             CGRectGetWidth(searchView.frame),
                                                                             CGRectGetHeight(_scrollView.frame)-CGRectGetHeight(searchView.frame))];
        _searchHistoryTV.delegate = self;
        _searchHistoryTV.dataSource = self;
        _searchHistoryTV.bounces = NO;
        _searchHistoryTV.alpha = 0;
        [_searchHistoryTV setViewBorderWithRectBorder:UIRectBorderTop borderSize:1.0f withColor:CDZColorOfLightGray withBroderOffset:nil];
        [_scrollView addSubview:_searchHistoryTV];

    }
}

- (void)showAlertDidNotSelectAutos {
    [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"请先选择车系车型" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
       
    }];
}

- (void)submitKeywordSearch {
    if (!_autoData.modelID) {
        [self showAlertDidNotSelectAutos];
        [self hiddenKeyboard];
        return;
    }
    if (_searchTextField.text&&![_searchTextField.text isEqualToString:@""]) {
        BOOL success = [DBHandler.shareInstance updatePartsSearchHistory:_searchTextField.text];
        NSLog(@"history save suceess %d", success);
        if (success) {
            self.historyList = DBHandler.shareInstance.getPartsSearchHistory;
        }
        @autoreleasepool {
            PartsStoreSearchResultVC *vc = [PartsStoreSearchResultVC new];
            PartsSearchReferenceObject *searchReference = [PartsSearchReferenceObject new];
            searchReference.isSearchFromKeyword = YES;
            searchReference.keyword = _searchTextField.text;
            vc.searchReference = searchReference;
            [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [self hiddenKeyboard];
        }
    }else {
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"请先输入关键字" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
    }
}

- (void)submitPartsSelectionSearch {
    if (!_autoData.modelID) {
        [self showAlertDidNotSelectAutos];
        return;
    }
    if (_partsStepView.lastStepID) {
        NSString *string = @"";
        if (_partsStepView.stepStringList.count>=3) {
            string = _partsStepView.stepStringList[2];
        }
        [self hiddenKeyboard];
        [self hiddenPartsSelectionView];
        @autoreleasepool {
            PartsStoreSearchResultVC *vc = [PartsStoreSearchResultVC new];
            PartsSearchReferenceObject *searchReference = [PartsSearchReferenceObject new];
            searchReference.keyword = string;
            searchReference.partsID = _partsStepView.lastStepID;
            [searchReference processDataToObject:_partsStepView.searchReference];
            vc.searchReference = searchReference;
            [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}



#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView==_resultTableView) {
        return _recommendProductList.count;
    }
    if (_historyList.count==0) return 1;
    return _historyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==_resultTableView) {
        static NSString *idents = @"cell";
        PartsStoreResultCell *cell = [tableView dequeueReusableCellWithIdentifier:idents];
        if (!cell) {
            cell = [[PartsStoreResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idents];
            [cell initializationUI];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell setBackgroundColor:CDZColorOfWhite];
        }
        // Configure the cell...
        NSDictionary *shopDetail = _recommendProductList[indexPath.row];
        [cell setUIDataWithDetailData:shopDetail];
        
        return cell;
    }
    static NSString *ident = @"ShopAppointmentTVC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        cell.contentView.backgroundColor = CDZColorOfWhite;
        cell.textLabel.text = @"";
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.text = @"";
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor = CDZColorOfDeepGray;
        cell.detailTextLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16.0f, NO);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView = nil;
    cell.contentMode = UIViewContentModeLeft;
    if (_historyList.count==0) {
    cell.contentMode = UIViewContentModeCenter;
        cell.detailTextLabel.text = @"没有更多历史数据";
    }else {
        cell.textLabel.text = _historyList[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==_resultTableView) return vAdjustByScreenRatio(130.0f);
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    if ([tableView isEqual:_resultTableView]) {
        NSString *string = [_recommendProductList[indexPath.row] objectForKey:@"number"];
        [self getPartsDetailWithPartsID:string];
        return;
    }
    _searchTextField.text = _historyList[indexPath.row];
}

#pragma mark- Autos Parts Selection

- (void)showPartsSelectionView {
    [_searchTextField resignFirstResponder];
    @weakify(self)
    NSString *lastStepString = self.partsStepView.stepStringList[2];
    self.autoPartsBtn.hidden = NO;
    self.partsSearchBtn.hidden = YES;
    self.navigationItem.leftBarButtonItem = self.kLeftItem;
    self.navigationItem.rightBarButtonItem = self.pLeftItem;
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        
        self.partsStepView.view.alpha = 1;
        CGPoint offset = CGPointZero;
        offset.y = CGRectGetMaxY(self.selectionView.frame);
        if (self.partsStepView.lastStepID&&![lastStepString isEqualToString:@""]) {
            offset.y = CGRectGetMinY(self.selectionView.frame);
            CGRect frame = self.partsStepView.view.frame;
            frame.size.height = CGRectGetHeight(self.scrollView.frame)- CGRectGetHeight(self.selectionView.frame);
            self.partsStepView.view.frame = frame;
            self.autoPartsBtn.hidden = YES;
        }
        self.scrollView.contentOffset = offset;
    }];
    if (self.partsStepView.lastStepID&&![lastStepString isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = self.pRightItem;
        self.partsSearchBtn.hidden = NO;
        self.partsSearchBtn.hidden = NO;
        
    }
}

- (void)hiddenPartsSelectionView {
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.partsStepView.view.alpha = 0;
        self.scrollView.contentOffset = CGPointZero;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
    }];
    self.autoPartsBtn.hidden = NO;
    _autoPartsBtn.backgroundColor = CDZColorOfWhite;
    [_autoPartsBtn setTitle:@"点此选择配件" forState:UIControlStateNormal];
    NSString *lastStepString = self.partsStepView.stepStringList[2];
    if (self.partsStepView.lastStepID&&![lastStepString isEqualToString:@""]) {
        _autoPartsBtn.backgroundColor = CDZColorOfClearColor;
        [_autoPartsBtn setTitle:@"" forState:UIControlStateNormal];
    }
    self.partsSearchBtn.hidden = (!self.partsStepView.lastStepID&&[lastStepString isEqualToString:@""]);
}

#pragma mark- UITextFieldDelegate
- (void)hiddenKeyboard {
    [_searchTextField resignFirstResponder];
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        self.searchHistoryTV.alpha = 0;
        self.scrollView.contentOffset = CGPointZero;
        CGRect frame = self.searchHistoryTV.frame;
        frame.size.height = CGRectGetHeight(self.scrollView.frame)-CGRectGetHeight(self.searchTextField.superview.frame);
        self.searchHistoryTV.frame = frame;
    }];
}

- (void)keyboardWillShow:(NSNotification *)notifyObject {
    if ([_searchTextField isFirstResponder]) {
        CGRect keyboardRect = [[notifyObject.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        if (!CGRectEqualToRect(keyboardRect, _keyboardRect)) {
            self.keyboardRect = keyboardRect;
        }
        [self shiftScrollViewWithAnimation:_searchTextField];
        NSLog(@"Step One");
    }
}

- (void)shiftScrollViewWithAnimation:(UIView *)view {
    CGRect frame = view.frame;
    if ([view isEqual:_searchTextField]) {
        frame = view.superview.frame;
    }
    
    CGPoint point = _scrollView.contentOffset;
    point.y = CGRectGetMinY(frame);
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.scrollView.contentOffset = point;
        self.searchHistoryTV.alpha = 1;
        CGRect theFrame = self.searchHistoryTV.frame;
        theFrame.size.height = CGRectGetHeight(self.scrollView.frame)-CGRectGetHeight(self.searchTextField.superview.frame)-CGRectGetHeight(self.keyboardRect);
        self.searchHistoryTV.frame = theFrame;
    }completion:^(BOOL finished) {
    }];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.navigationItem.leftBarButtonItem = self.kLeftItem;
    self.navigationItem.rightBarButtonItem = self.kRightItem;
    if (!CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        [self shiftScrollViewWithAnimation:textField];
    }
    return YES;
}

- (void)showAutoSelectVC {
    [self pushToAutoSelectionViewWithBackTitle:nil animated:YES onlyForSelection:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self submitKeywordSearch];
    return YES;
}

- (void)getRecommendProductList{
    [APIsConnection.shareConnection autosPartsAPIsGetRecommendProductWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return;
        }
        [ProgressHUDHandler dismissHUD];
        self.recommendProductList = responseObject[CDZKeyOfResultKey];
        [self.resultTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }];
}

- (void)getPartsDetailWithPartsID:(NSString *)partsID {
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] theSelfMaintenanceAPIsGetItemDetailWithProductID:partsID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if(errorCode!=0){
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [ProgressHUDHandler dismissHUDWithCompletion:^{
            [self pushPartItemDetailViewWithItemDetail:responseObject[CDZKeyOfResultKey]];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
    }];
}

- (void)pushPartItemDetailViewWithItemDetail:(id)detail {
    if (!detail||![detail isKindOfClass:[NSDictionary class]]) {
        return;
    }
    @autoreleasepool {
        PartsItemDetailVC *vc = [PartsItemDetailVC new];
        vc.itemDetail = detail;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
