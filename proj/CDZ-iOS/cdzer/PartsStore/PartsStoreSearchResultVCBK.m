//
//  PartsStoreSearchResultVCBK.m
//  cdzer
//
//  Created by KEns0n on 3/6/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "PartsStoreSearchResultVCBK.h"
#import "PSSearchFilterView.h"
#import "PartsStoreResultCell.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "InsetsLabel.h"
#import "PartsItemDetailVC.h"
#import "RepairShopDetailVC.h"
#import "UserSelectedAutosInfoDTO.h"

@interface PartsStoreSearchResultVCBK () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) PSSearchFilterView *searchFilter;

@property (nonatomic, strong) UITableView *resultTableView;

@property (nonatomic, strong) InsetsLabel *autoSelectView;

@property (nonatomic, strong) NSMutableArray *partsStoreList;

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) UserSelectedAutosInfoDTO *autoData;


@end

@implementation PartsStoreSearchResultVCBK

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
    self.autoData = [[DBHandler shareInstance] getSelectedAutoData];
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
        PartsItemDetailVC *vc = [PartsItemDetailVC new];
        vc.itemDetail = detail;
        [self setNavBarBackButtonTitle:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)initializationUI {
    @autoreleasepool {
        CGRect frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, vAdjustByScreenRatio(46.0f));
        UIControl *view = [[UIControl alloc] initWithFrame:frame];
        [view setBackgroundColor:CDZColorOfWhite];
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
        [arrowIV setImage:[ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                              fileName:@"right_arrow"
                                                                                  type:FMImageTypeOfPNG
                                                                       scaleWithPhone4:NO needToUpdate:NO]];
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
            [self reloadDataByFilter];
        }];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        
        CGRect resultTVRect = CGRectZero;
        resultTVRect.origin.y = CGRectGetMaxY(_searchFilter.frame);
        resultTVRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(_searchFilter.frame));
        [self setResultTableView:[[UITableView alloc] initWithFrame:resultTVRect style:UITableViewStylePlain]];
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
    }
    
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayRequestData:(id)refresh {
    @autoreleasepool {
        
        if ([refresh isKindOfClass:[ODRefreshControl class]]) {
            if ([(ODRefreshControl *)refresh refreshing]) {
                [self componentSetting];
                NSString *priceOrder = [NSString stringWithFormat:@"%d",[(NSIndexPath *)_searchFilter.selectedList[0] row]];
                NSString *timeOrder = [NSString stringWithFormat:@"%d",[(NSIndexPath *)_searchFilter.selectedList[1] row]];
                [self getPartsLastLevelListWithThirdLevelID:self.partsID
                                                   pageNums:_pageNum.stringValue
                                                   pageSize:_pageSize.stringValue
                                                 priceOrder:priceOrder
                                                  timeOrder:timeOrder
                                                autoModelID:_autoData.modelID.stringValue
                                            withrefreshView:refresh];
                
            }
        }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
            if ([(MJRefreshAutoNormalFooter *)refresh isRefreshing]&&_totalPageNum.intValue>(_pageNum.intValue*_pageSize.intValue)) {
                self.pageNum = @(_pageNum.intValue+1);
                NSString *priceOrder = [NSString stringWithFormat:@"%d",[(NSIndexPath *)_searchFilter.selectedList[0] row]];
                NSString *timeOrder = [NSString stringWithFormat:@"%d",[(NSIndexPath *)_searchFilter.selectedList[1] row]];
                [self getPartsLastLevelListWithThirdLevelID:self.partsID
                                                   pageNums:_pageNum.stringValue
                                                   pageSize:_pageSize.stringValue
                                                 priceOrder:priceOrder
                                                  timeOrder:timeOrder
                                                autoModelID:_autoData.modelID.stringValue
                                            withrefreshView:refresh];
            }
        }
    }
    
}

- (void)refreshView:(id)refresh {
    [self performSelector:@selector(delayRequestData:) withObject:refresh afterDelay:1.5f];
}

- (void)componentSetting {
    self.totalPageNum = @0;
    self.pageNum = @1;
    self.pageSize = @10;
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, partsStoreList) subscribeNext:^(id x) {
        @strongify(self)
        [self.resultTableView reloadData];
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
    [self pushToAutoSelectionViewWithBackTitle:nil animated:YES];
}

//由Filter更新列表
- (void)reloadDataByFilter {
    [self componentSetting];
    NSLog(@"%@",_autoData.modelID.stringValue);
    NSString *priceOrder = [NSString stringWithFormat:@"%d",[(NSIndexPath *)_searchFilter.selectedList[0] row]];
    NSString *timeOrder = [NSString stringWithFormat:@"%d",[(NSIndexPath *)_searchFilter.selectedList[1] row]];
    [self getPartsLastLevelListWithThirdLevelID:self.partsID
                                       pageNums:self.pageNum.stringValue
                                       pageSize:self.pageSize.stringValue
                                     priceOrder:priceOrder
                                      timeOrder:timeOrder
                                    autoModelID:_autoData.modelID.stringValue
                                withrefreshView:nil];
}

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
    static NSString *ident = @"cell";
    PartsStoreResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[PartsStoreResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell initializationUI];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:CDZColorOfWhite];
    }
    // Configure the cell...
    NSDictionary *shopDetail = _partsStoreList[indexPath.row];
    [cell setUIDataWithDetailData:shopDetail];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
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
        NSMutableArray *dataArray = [self mutableArrayValueForKey:@"partsStoreList"];
        if (_totalPageNum.intValue==0) [dataArray removeAllObjects];
        [dataArray addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
        self.totalPageNum = @([responseObject[CDZKeyOfTotalPageSizeKey] integerValue]);
        self.pageNum = responseObject[CDZKeyOfPageNumKey];
        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
        if(!refreshView){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refreshView];
        }
        _resultTableView.footer.hidden = ((_pageNum.intValue*_pageSize.intValue)>_totalPageNum.intValue);
        
    }
}

#pragma mark- API Access Code Section
- (void)getPartsLastLevelListWithThirdLevelID:(NSString *)thirdLevelID pageNums:(NSString *)pageNums pageSize:(NSString *)pageSize
                                   priceOrder:(NSString *)priceOrder timeOrder:(NSString *)timeOrder autoModelID:(NSString *)autoModelID
                              withrefreshView:(id)refreshView {
    if(!refreshView) [ProgressHUDHandler showHUD];
    
    [[APIsConnection shareConnection] autosPartsAPIsGetPartsLastLevelListWithThirdLevelID:thirdLevelID
                                                                              autoModelID:(NSString *)autoModelID
                                                                               priceOrder:(NSString *)priceOrder
                                                                         salesVolumeOrder:(NSString *)timeOrder
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
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            
            if(!refreshView){
                [ProgressHUDHandler dismissHUD];
            }else{
                [self stopRefresh:refreshView];
            }
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [self handleReceivedData:responseObject withRefreshView:refreshView];
        
    }
    
}

@end
