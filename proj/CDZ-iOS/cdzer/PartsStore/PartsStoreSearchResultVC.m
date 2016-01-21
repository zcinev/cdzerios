//
//  RepairShopSearchResultVC.m
//  cdzer
//
//  Created by KEns0n on 3/6/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define kObjID @"id"
#define kObjName @"name"
#define kObjImage @"imgurl"

#import "PartsStoreSearchResultVC.h"
#import "PSSearchFilterView.h"
#import "PartsStoreResultCell.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "InsetsLabel.h"
#import "PartsItemDetailVC.h"
#import "RepairShopDetailVC.h"
#import "UserSelectedAutosInfoDTO.h"
#import "PartsEnquiryPriceView.h"
#import "CitySelectionVC.h"
#import "KeyCityDTO.h"
#import "PartsSearchReferenceObject.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FixImageTVCell : UITableViewCell
@end
@implementation FixImageTVCell


- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15.0f, 0.0f, 70.0f, 70.0f);
    self.imageView.center = CGPointMake(self.imageView.center.x, CGRectGetHeight(self.frame)/2.0f);
    
    CGRect textFrame = self.textLabel.frame;
    textFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10.0f;
    textFrame.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(self.imageView.frame)-25.0f;
    self.textLabel.frame = textFrame;
    
    CGRect detailTextFrame = self.detailTextLabel.frame;
    detailTextFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10.0f;
    detailTextFrame.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(self.imageView.frame)-25.0f;
    self.detailTextLabel.frame = detailTextFrame;
    
    [self.imageView setAutoresizingMask:UIViewAutoresizingNone];
}
@end

@interface PartsStoreSearchResultVC () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, assign) BOOL needReload;

@property (nonatomic, assign) BOOL showFilter;

@property (nonatomic, strong) PSSearchFilterView *searchFilter;

@property (nonatomic, strong) UITableView *resultTableView;

@property (nonatomic, strong) InsetsLabel *autoSelectView;

@property (nonatomic, strong) NSMutableArray *partsStoreList;

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) UserSelectedAutosInfoDTO *autoData;

@property (nonatomic, strong) PartsEnquiryPriceView *enquiryPriceView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, assign) BOOL searchBarIsEditting;

@property (nonatomic, assign) BOOL isEnquiryPrice;

@property (nonatomic, strong) NSString *lastSearchKW;

@property (nonatomic, strong) InsetsLabel *reminderLabel;

@end

@implementation PartsStoreSearchResultVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    self.partsStoreList = [NSMutableArray array];
    self.title = getLocalizationString(@"auto_parts");
    [self initializationUI];
    [self componentSetting];
    [self setReactiveRules];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self];
    self.autoData = [[DBHandler shareInstance] getSelectedAutoData];
    _enquiryPriceView.autoData = _autoData;
    if (_needReload) {
        [self reloadDataByFilterWithrefresh:nil isReload:YES];
    }else {
        self.needReload = YES;
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushPartItemDetailViewWithItemDetail:(id)detail {
    if (!detail||![detail isKindOfClass:[NSDictionary class]]) {
        return;
    }
    @autoreleasepool {
        self.needReload = NO;
        PartsItemDetailVC *vc = [PartsItemDetailVC new];
        vc.itemDetail = detail;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)pushCitySelectionView {
    @autoreleasepool {
        self.needReload = NO;
        CitySelectionVC *vc = [CitySelectionVC new];
        vc.selectedCity = _enquiryPriceView.selectedcity;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(updateLocation:) name:CDZNotiKeyOfUpdateLocation object:nil];
    }
}

- (void)initializationUI {
    @autoreleasepool {
        
        CGRect titleViewRect = CGRectZero;
        titleViewRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame)*0.7f, 40.0f);
        UIView *titleView = [[UIView alloc] initWithFrame:titleViewRect];
        self.navigationItem.titleView = titleView;
        
        self.searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];
        _searchBar.barTintColor = CDZColorOfDefaultColor;
        _searchBar.text = _searchReference.keyword;
        _searchBar.placeholder = @"请输入配件关键词";
        _searchBar.contentMode = UIViewContentModeLeft;
        _searchBar.delegate = self;
        [_searchBar setViewBorderWithRectBorder:UIRectBorderAllBorderEdge borderSize:1.0f withColor:CDZColorOfDefaultColor withBroderOffset:nil];
        [titleView addSubview:_searchBar];
        
        CGRect frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, vAdjustByScreenRatio(46.0f));
        UIControl *view = [[UIControl alloc] initWithFrame:frame];
        view.backgroundColor = CDZColorOfWhite;
        [view setBorderWithColor:[UIColor lightGrayColor] borderWidth:(0.5f)];
        [view addTarget:self action:@selector(showAutoSelectVC) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:view];
        
        NSString *title = getLocalizationString(@"auto_model_with_symbol");
        UIFont *font = systemFontBold(15.0f);
        CGSize size = [SupportingClass getStringSizeWithString:title font:font widthOfView:CGSizeMake(CGRectGetWidth(frame),CGRectGetHeight(frame))];
        InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width+10.0f, CGRectGetHeight(frame))
                                                           andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f)];
        titleLabel.font = font;
        titleLabel.text = title;
        titleLabel.textColor = [UIColor colorWithRed:0.353f green:0.345f blue:0.349f alpha:1.00f];
        [view addSubview:titleLabel];
        
        CGFloat width = 12.0f*vWidthRatio;
        UIImageView *arrowIV= [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(view.frame)-width-vAdjustByScreenRatio(14.0f),
                                                                            (CGRectGetHeight(view.frame)-width)/2.0f,
                                                                            width,
                                                                            width)];
        arrowIV.image = ImageHandler.getRightArrow;
        [view addSubview:arrowIV];
        
        CGRect autoSelectViewRect = view.bounds;
        autoSelectViewRect.size.width = CGRectGetWidth(frame)-CGRectGetWidth(titleLabel.frame)-CGRectGetWidth(arrowIV.frame);
        autoSelectViewRect.origin.x = CGRectGetMaxX(titleLabel.frame);
        
        self.autoSelectView = [[InsetsLabel alloc] initWithFrame:autoSelectViewRect
                                                       andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, CGRectGetWidth(view.frame)-CGRectGetMinX(arrowIV.frame))];
        _autoSelectView.font = font;
        _autoSelectView.text = title;
        _autoSelectView.textColor = CDZColorOfBlack;
        _autoSelectView.numberOfLines = 0;
        [view addSubview:_autoSelectView];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        UIButton *maskBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect maskRect = self.contentView.bounds;
        maskRect.origin.y = CGRectGetMaxY(_autoSelectView.frame);
        maskRect.size.height -= CGRectGetMaxY(_autoSelectView.frame);
        [maskBtnView setFrame:maskRect];
        [maskBtnView setAlpha:0];
        [maskBtnView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4]];
        [self.contentView addSubview:maskBtnView];
        
        [self setSearchFilter:[[PSSearchFilterView alloc] initWithOrigin:CGPointMake(0.0, CGRectGetMaxY(_autoSelectView.frame))]];
        [_searchFilter initializationUIWithMaskView:maskBtnView];
        [view addTarget:_searchFilter action:@selector(unfoldingFilterView) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_searchFilter];
        @weakify(self)
        [self.searchFilter setSelectionResponseBlock:^() {
            @strongify(self)
            if (![self.searchBar.text isEqualToString:self.lastSearchKW]&&![self.lastSearchKW isEqualToString:@""]) {
                self.searchBar.text = self.lastSearchKW;
            }
            [self reloadDataByFilterWithrefresh:nil isReload:YES];
        }];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        CGRect resultTVRect = CGRectZero;
        resultTVRect.origin.y = CGRectGetMaxY(_searchFilter.frame);
        resultTVRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(_searchFilter.frame));
        self.resultTableView = [[UITableView alloc] initWithFrame:resultTVRect style:UITableViewStylePlain];
        [_resultTableView setDelegate:self];
        [_resultTableView setRowHeight:vAdjustByScreenRatio(90.0f)];
        [_resultTableView setDataSource:self];
        [_resultTableView setBounces:YES];
        [_resultTableView setScrollsToTop:YES];
        _resultTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_resultTableView.frame), 30.0f)];
        [self.contentView insertSubview:_resultTableView belowSubview:maskBtnView];
        
//        UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
//        refresh.tintColor = [UIColor lightGrayColor];
//        refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉更新"];
//        [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
//        [_resultTableView addSubview:refresh];
//        [_resultTableView sendSubviewToBack:refresh];

        ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:_resultTableView];
        [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
        
        _resultTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshView:)];
        _resultTableView.footer.automaticallyHidden = NO;
        _resultTableView.footer.hidden = YES;
        
        self.reminderLabel = [[InsetsLabel alloc] initWithFrame:self.contentView.bounds
                                             andEdgeInsetsValue:DefaultEdgeInsets];
        _reminderLabel.textAlignment = NSTextAlignmentCenter;
        _reminderLabel.backgroundColor = CDZColorOfWhite;
        _reminderLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 18.0f, NO);
        _reminderLabel.hidden = YES;
        _reminderLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:_reminderLabel];
        
        self.enquiryPriceView = [[PartsEnquiryPriceView alloc] initWithFrame:self.contentView.bounds];
        _enquiryPriceView.alpha = 0;
        _enquiryPriceView.productID = _searchReference.partsID;
        [_enquiryPriceView initializationUI];
        [_enquiryPriceView setupCitySelectionBtnAction:@selector(pushCitySelectionView) target:self forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_enquiryPriceView];
    }
    
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayRequestData:(id)refresh {
    @autoreleasepool {
        
        if (![self.searchBar.text isEqualToString:self.lastSearchKW]&&![self.lastSearchKW isEqualToString:@""]) {
            self.searchBar.text = self.lastSearchKW;
        }
        if ([refresh isKindOfClass:[ODRefreshControl class]]) {
            if ([(ODRefreshControl *)refresh refreshing]) {
                [self reloadDataByFilterWithrefresh:refresh isReload:YES];
            }
        }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
            if ([(MJRefreshAutoNormalFooter *)refresh isRefreshing]&&_totalPageNum.intValue>(_pageNum.intValue*_pageSize.intValue)) {
                self.pageNum = @(_pageNum.intValue+1);
                
                [self reloadDataByFilterWithrefresh:refresh isReload:NO];
            }
        }
        
    }
    
}

- (void)refreshView:(id)refresh {
    [self performSelector:@selector(delayRequestData:) withObject:refresh afterDelay:1.5f];
}

- (void)resetPageComponentSetting {
    self.totalPageNum = @0;
    self.pageNum = @1;
    self.pageSize = @10;
}

- (void)componentSetting {
    self.needReload = YES;
    [self resetPageComponentSetting];
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, partsStoreList) subscribeNext:^(id x) {
        @strongify(self)
        [self.resultTableView reloadData];
    }];
    
    [RACObserve(self, enquiryPriceView.alpha) subscribeNext:^(NSNumber *alpha) {
        @strongify(self)
        
        BOOL isShow = (alpha.floatValue>=1.0f);
        if (isShow) {
            self.navigationItem.titleView = nil;
        }else {
            CGRect titleViewRect = CGRectZero;
            titleViewRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame)*0.7f, 40.0f);
            UIView *titleView = [[UIView alloc] initWithFrame:titleViewRect];
            self.navigationItem.titleView = titleView;
            [self.navigationItem.titleView addSubview:self.searchBar];
        }
    }];
    
    [RACObserve(self, showFilter) subscribeNext:^(NSNumber *showFilter) {
        @strongify(self)
        BOOL isShow = showFilter.boolValue;
        CGRect frame = self.resultTableView.frame;
        self.searchFilter.alpha = isShow;
        frame.origin.y = CGRectGetMaxY(isShow?self.searchFilter.frame:self.autoSelectView.superview.frame);
        frame.size.height = CGRectGetHeight(self.contentView.frame)-CGRectGetMinY(frame);
        self.resultTableView.frame = frame;
    }];
    
    [RACObserve(self, autoData) subscribeNext:^(UserSelectedAutosInfoDTO *autoData) {
        @strongify(self)
        if (autoData) {
            NSString *carDetail = [NSString stringWithFormat:@"%@ %@\n%@",
                                   autoData.dealershipName,
                                   autoData.seriesName,
                                   autoData.modelName];
            self.autoSelectView.text = carDetail;
        }else {
            self.autoSelectView.text = getLocalizationString(@"carSelectRemind2");
        }
    }];
}

- (void)showAutoSelectVC {
    self.needReload = NO;
    [self resignSearchBarFirstResponder];
    [self pushToAutoSelectionViewWithBackTitle:nil animated:YES onlyForSelection:NO];
}

- (void)showEnquiryPriceView {
    [UIView animateWithDuration:0.25 animations:^{
        self.enquiryPriceView.alpha = 1;
    }];
}

- (void)initEnquiryPrice {
    @autoreleasepool {
        if (_searchReference) {
            FixImageTVCell *view = [[FixImageTVCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
            view.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(_resultTableView.frame), 70.0f);
            view.detailTextLabel.text = @"配件暂时缺货，请点击“询价”查询价格！";
            view.detailTextLabel.numberOfLines = 0;
            view.detailTextLabel.textColor = CDZColorOfRed;
            
            view.imageView.image = [ImageHandler getWhiteLogo];
            NSString *imageUrl = _searchReference.partsImagePath;
            if ([imageUrl rangeOfString:@"http"].location!=NSNotFound) {
                [view.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[ImageHandler getWhiteLogo]];
                view.textLabel.text = _searchReference.keyword;
                _resultTableView.tableHeaderView = view;
            }
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(0.0f, 0.0f, 80, 40);
            button.backgroundColor = CDZColorOfDefaultColor;
            [button setTitle:@"询价" forState:UIControlStateNormal];
            [button setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
            [button setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
            [button addTarget:self action:@selector(showEnquiryPriceView) forControlEvents:UIControlEventTouchUpInside];
            view.accessoryView = button;
        }
    }
    
}

- (void)updateLocation:(NSNotification *)notif {
    KeyCityDTO *dto = (KeyCityDTO *)notif.object;
    if (dto&&[notif.object isKindOfClass:KeyCityDTO.class]) {
        self.enquiryPriceView.selectedcity = dto;
    }
}

//由Filter更新列表
- (void)reloadDataByFilterWithrefresh:(id)refresh isReload:(BOOL)isReload {
    if (isReload) {
        [self resetPageComponentSetting];
    }
    [self resignSearchBarFirstResponder];
    NSString *priceOrder = [NSString stringWithFormat:@"%d",[(NSIndexPath *)_searchFilter.selectedList[0] row]];
    NSString *salesVolumeOrder = [NSString stringWithFormat:@"%d",[(NSIndexPath *)_searchFilter.selectedList[1] row]];
    BOOL searchTextEqual = [_searchBar.text isEqualToString:_searchReference.keyword];
    if (_searchReference.partsID&&![_searchReference.partsID isEqualToString:@""]&&searchTextEqual) {
        [self getPartsLastLevelListWithThirdLevelID:_searchReference.partsID
                                        autoModelID:_autoData.modelID.stringValue
                                         priceOrder:priceOrder
                                   salesVolumeOrder:salesVolumeOrder
                                           pageNums:self.pageNum.stringValue
                                           pageSize:self.pageSize.stringValue
                                        refreshView:refresh];
    }else {
        NSString *keyword = searchTextEqual?_searchReference.keyword:_searchBar.text;
        [self getPartsSearchResultWithKeyword:keyword
                                  autoModelID:_autoData.modelID.stringValue
                                   priceOrder:priceOrder
                             salesVolumeOrder:salesVolumeOrder
                                     pageNums:self.pageNum.stringValue
                                     pageSize:self.pageSize.stringValue
                                  refreshView:refresh];
    }
}


#pragma mark- UISearchBarDelegate
- (void)resignSearchBarFirstResponder {
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchBar resignFirstResponder];
    _searchBarIsEditting = NO;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    [_searchFilter unfoldingFilterView];
    _searchBarIsEditting = YES;
    for (UIView *view in [searchBar subviews]) {
        for (UIView *subview in [view subviews]) {
            if ([subview isKindOfClass:[UIButton class]] && [[(UIButton *)subview currentTitle] isEqualToString:@"Cancel"] ) {
                [(UIButton*)subview setTitle:getLocalizationString(@"cancel") forState:UIControlStateNormal];
            }
        }
    }
    return YES;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@" "]) {
        return NO;
    }
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self resignSearchBarFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self resignSearchBarFirstResponder];
    [self reloadDataByFilterWithrefresh:nil isReload:YES];
};

#pragma -mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_partsStoreList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isEnquiryPrice) {
        static NSString *ident = @"cells";
        FixImageTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (!cell) {
            cell = [[FixImageTVCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
            cell.textLabel.numberOfLines = 0;
            cell.detailTextLabel.numberOfLines = 0;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailTextLabel.textColor = CDZColorOfRed;
            cell.detailTextLabel.text = @"配件暂时缺货！如需询价，\n你可点此申请提交价格查询！";
            if (SCREEN_WIDTH>320.0f) {
                cell.detailTextLabel.text = @"配件暂时缺货！如需询价，你可点此申请提交价格查询！";
            }
            
        }
        NSDictionary *productDetail = _partsStoreList[indexPath.row];
        cell.textLabel.text = productDetail[@"name"];
        
        cell.imageView.image = [ImageHandler getWhiteLogo];
        NSString *imageUrl = productDetail[@"image"];
        if ([imageUrl rangeOfString:@"http"].location!=NSNotFound) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[ImageHandler getWhiteLogo]];
        }
        return cell;
    }
    static NSString *ident = @"cell";
    PartsStoreResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[PartsStoreResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell initializationUI];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:CDZColorOfWhite];
    }
    // Configure the cell...
    NSDictionary *productDetail = _partsStoreList[indexPath.row];
    [cell setUIDataWithDetailData:productDetail];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isEnquiryPrice) return 100.0f;
    return vAdjustByScreenRatio(130.0f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//        addtime = "2015-03-31 10:28:43";
//        "comment_size" = 0;
//        factory = 15033110185678601620;
//        "factory_name" = "\U5cb3\U9e93\U533a\U751f\U4ea7\U5546";
//        id = 15033110284317800115;
//        image = "http://he.bccar.net:80/imgUpload/demo/common/product/1503311028177SGXnCguuA.gif";
//        memberprice = 739;
//        name = "\U53d8\U901f\U5668\U65e0\U654c\U7248";
//        number = PD150331102843566717;
//        star = 1;
//        stocknum = 888;
    
    if (_isEnquiryPrice) {
        NSString *productID = [SupportingClass verifyAndConvertDataToString:[_partsStoreList[indexPath.row] objectForKey:@"id"]];
        _enquiryPriceView.productID = productID;
        [self showEnquiryPriceView];
        return;
    }
    
    NSString *string = [_partsStoreList[indexPath.row] objectForKey:@"number"];
    [self getPartsDetailWithPartsID:string];
    
    
}


#pragma mark- Data Receive Handle
- (void)handleReceivedData:(id)responseObject withRefreshView:(id)refreshView{
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Data Error!");
        return;
    }
    @autoreleasepool {
        _resultTableView.bounces = YES;
        NSMutableArray *dataArray = [self mutableArrayValueForKey:@"partsStoreList"];
        if (_totalPageNum.intValue==0) [dataArray removeAllObjects];
        [dataArray addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
        self.showFilter = (dataArray.count>0&&!_isEnquiryPrice);
        self.totalPageNum = @([responseObject[CDZKeyOfTotalPageSizeKey] integerValue]);
        self.pageNum = responseObject[CDZKeyOfPageNumKey];
        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
        self.lastSearchKW = self.searchBar.text;
        if(!refreshView){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refreshView];
        }
        _resultTableView.footer.hidden = ((_pageNum.intValue*_pageSize.intValue)>_totalPageNum.intValue);
        
    }
}

#pragma mark- API Access Code Section
- (void)getPartsLastLevelListWithThirdLevelID:(NSString *)thirdLevelID autoModelID:(NSString *)autoModelID priceOrder:(NSString *)priceOrder salesVolumeOrder:(NSString *)salesVolumeOrder pageNums:(NSString *)pageNums pageSize:(NSString *)pageSize refreshView:(id)refreshView{
    if(!refreshView) [ProgressHUDHandler showHUD];
    
    [[APIsConnection shareConnection] autosPartsAPIsGetPartsLastLevelListWithThirdLevelID:thirdLevelID
                                                                              autoModelID:(NSString *)autoModelID
                                                                               priceOrder:(NSString *)priceOrder
                                                                         salesVolumeOrder:(NSString *)salesVolumeOrder
                                                                                 pageNums:(NSString *)pageNums
                                                                                 pageSize:(NSString *)pageSize
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(refreshView) operation.userInfo = @{@"refreshView":refreshView};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(refreshView) operation.userInfo = @{@"refreshView":refreshView};
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}


- (void)getPartsSearchResultWithKeyword:(NSString *)keyword autoModelID:(NSString *)autoModelID priceOrder:(NSString *)priceOrder salesVolumeOrder:(NSString *)salesVolumeOrder pageNums:(NSString *)pageNums pageSize:(NSString *)pageSize refreshView:(id)refreshView {
    if(!autoModelID) return;
    if(!refreshView) [ProgressHUDHandler showHUD];
    
    [[APIsConnection shareConnection] autosPartsAPIsGetAutosPartsSearchListWithKeyword:keyword autoModelID:autoModelID priceOrder:priceOrder salesVolumeOrder:salesVolumeOrder pageNums:@(pageNums.longLongValue) pageSize:@(pageSize.longLongValue)  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(refreshView) operation.userInfo = @{@"refreshView":refreshView};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(refreshView) operation.userInfo = @{@"refreshView":refreshView};
        [self requestResultHandle:operation responseObject:nil withError:error];
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


- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    id refreshView = operation.userInfo[@"refreshView"];
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        
        if(!refreshView){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refreshView];
        }
    }else if (!error&&responseObject) {
        self.reminderLabel.hidden = YES;
        self.resultTableView.bounces = YES;
        self.isEnquiryPrice = NO;
        
        NSInteger errorCode = [SupportingClass verifyAndConvertDataToString:[responseObject objectForKey:CDZKeyOfErrorCodeKey]].integerValue;
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        
        if (errorCode!=0) {
            if (errorCode==1) {
                self.isEnquiryPrice = YES;
                self.resultTableView.bounces = NO;
                [self handleReceivedData:responseObject withRefreshView:refreshView];
                return;
            }
            
            self.reminderLabel.hidden = NO;
            self.reminderLabel.numberOfLines = 0;
            self.reminderLabel.text = @"没有找到你需要的配件，\n请重新搜索！";
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                if(!refreshView){
                    [ProgressHUDHandler dismissHUD];
                }else{
                    [self stopRefresh:refreshView];
                }
            }];
            return;
        }
        [self handleReceivedData:responseObject withRefreshView:refreshView];
        
    }
    
}

@end
