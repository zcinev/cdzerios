//
//  RepairShopSelectionVC.m
//  cdzer
//
//  Created by KEns0n on 3/6/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "RepairShopSelectionVC.h"
#import "SearchFilterView.h"
#import "RepairShopResultCell.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "KeyCityDTO.h"
#import "UserSelectedAutosInfoDTO.h"
#import "RepairShopDetailVC.h"
#import "ShopMapDetailView.h"
#import "UserLocationHandler.h"

@interface RepairShopSelectionVC () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *mapContainerView;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) SearchFilterView *searchFilter;

@property (nonatomic, strong) UITableView *resultTableView;

@property (nonatomic, strong) NSMutableArray *repairShopList;

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) UIImage *mapPinImage;

@property (nonatomic, strong) UserSelectedAutosInfoDTO *autoData;

@property (nonatomic, assign) BOOL searchBarIsEditting;

@property (nonatomic, assign) BOOL isShowMapView;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;


@end

@implementation RepairShopSelectionVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];

    self.repairShopList = [NSMutableArray array];
    [self initializationUI];
    [self componentSetting];
    [self setReactiveRules];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignSearchBarFirstResponder) name:@"resignSearchBarFirstResponder" object:nil];
    if (_totalPageNum.intValue == 0) {
        
        NSString *cityID = @"";
        if (self.selectedCity&&self.selectedCity.cityID&&self.selectedCity.cityID<=0) {
            cityID = self.selectedCity.cityID.stringValue;
        }
        [self getMaintenanceShopsAPIsGetMaintenanceShopsListWithPageNums:nil
                                                                pageSize:nil
                                                                 ranking:nil
                                                               serviceID:_searchFilter.shopServiceTypeString
                                                                shopType:_searchFilter.shopTypeString
                                                                shopName:_searchBar.text
                                                                  cityID:cityID
                                                                 address:nil
                                                               autoBrand:_autoData.brandID.stringValue
                                                                latitude:@(self.coordinate.latitude).stringValue
                                                               longitude:@(self.coordinate.longitude).stringValue
                                                             isCertified:_searchFilter.isValid.boolValue
                                                             refreshView:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"resignSearchBarFirstResponder" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializationUI {
    @autoreleasepool {
        
        CGRect searchBarRect = CGRectZero;
        searchBarRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame), 40.0f);
        self.searchBar = [[UISearchBar alloc] initWithFrame:searchBarRect];
        _searchBar.barTintColor = CDZColorOfDefaultColor;
        _searchBar.text = _keywordString;
        _searchBar.placeholder = getLocalizationString(@"store_name");
        _searchBar.contentMode = UIViewContentModeLeft;
        _searchBar.delegate = self;
        [_searchBar setViewBorderWithRectBorder:UIRectBorderAllBorderEdge borderSize:1.0f withColor:CDZColorOfDefaultColor withBroderOffset:nil];
        [self.navigationItem setTitleView:_searchBar];
        
        UIButton *maskBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        [maskBtnView setFrame:self.contentView.bounds];
        [maskBtnView setAlpha:0];
        [maskBtnView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4]];
        [self.contentView addSubview:maskBtnView];
        
        [self setSearchFilter:[[SearchFilterView alloc] initWithOrigin:CGPointMake(0.0, 0.0)]];
        if (_shopTypeString&&![_shopTypeString isEqualToString:@""]) {
            _searchFilter.shopTypeString = _shopTypeString;
        }
        if (_shopServiceTypeString&&![_shopServiceTypeString isEqualToString:@""]) {
            _searchFilter.shopServiceTypeString = _shopServiceTypeString;
        }
        [_searchFilter initializationUIWithMaskView:maskBtnView];
        [self.contentView addSubview:_searchFilter];
        
        CGRect resultTVRect = CGRectZero;
        resultTVRect.origin.y = CGRectGetMaxY(_searchFilter.frame);
        resultTVRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame)-CGRectGetHeight(_searchFilter.frame));
        [self setResultTableView:[[UITableView alloc] initWithFrame:resultTVRect style:UITableViewStylePlain]];
        [_resultTableView setDelegate:self];
        [_resultTableView setRowHeight:90.0f];
        [_resultTableView setDataSource:self];
        [_resultTableView setBounces:YES];
        [_resultTableView setScrollsToTop:YES];
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
        
        
        self.mapContainerView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [self.view insertSubview:_mapContainerView belowSubview:self.contentView];
        
    }
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayRequestData:(id)refresh {
    NSString *cityID = @"";
    if (self.selectedCity&&self.selectedCity.cityID&&self.selectedCity.cityID<=0) {
        cityID = self.selectedCity.cityID.stringValue;
    }
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        if ([(ODRefreshControl *)refresh refreshing]) {
            [self componentSetting];
            [self getMaintenanceShopsAPIsGetMaintenanceShopsListWithPageNums:nil
                                                                    pageSize:nil
                                                                     ranking:nil
                                                                   serviceID:_searchFilter.shopServiceTypeString
                                                                    shopType:_searchFilter.shopTypeString
                                                                    shopName:_searchBar.text
                                                                      cityID:cityID
                                                                     address:nil
                                                                   autoBrand:_autoData.brandID.stringValue
                                                                    latitude:@(self.coordinate.latitude).stringValue
                                                                   longitude:@(self.coordinate.longitude).stringValue
                                                                 isCertified:_searchFilter.isValid.boolValue
                                                                 refreshView:refresh];
        }
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
        if ([(MJRefreshAutoNormalFooter *)refresh isRefreshing]&&_totalPageNum.intValue>(_pageNum.intValue*_pageSize.intValue)) {
            NSString *pageNum = [NSString stringWithFormat:@"%d",_pageNum.intValue+1];
            [self getMaintenanceShopsAPIsGetMaintenanceShopsListWithPageNums:pageNum
                                                                    pageSize:_pageSize.stringValue
                                                                     ranking:nil
                                                                   serviceID:_searchFilter.shopServiceTypeString
                                                                    shopType:_searchFilter.shopTypeString
                                                                    shopName:_searchBar.text
                                                                      cityID:cityID
                                                                     address:nil
                                                                   autoBrand:_autoData.brandID.stringValue
                                                                    latitude:@(self.coordinate.latitude).stringValue
                                                                   longitude:@(self.coordinate.longitude).stringValue
                                                                 isCertified:_searchFilter.isValid.boolValue
                                                                 refreshView:refresh];
        }
    }

    
    
}

- (void)refreshView:(id)refresh {
    [self performSelector:@selector(delayRequestData:) withObject:refresh afterDelay:1.5f];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if (_searchBarIsEditting && [touch view] != _searchBar)
    {
        [self resignSearchBarFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)componentSetting {
    self.totalPageNum = @0;
    self.pageNum = @0;
    self.pageSize = @0;
    self.isShowMapView = NO;
    self.autoData = DBHandler.shareInstance.getSelectedAutoData;
    CLLocation *zeroLocation = [[CLLocation alloc]initWithLatitude:0.0f longitude:0.0f];
    CLLocation *currentLocation = [[CLLocation alloc]initWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
    CLLocationDistance dist = [currentLocation distanceFromLocation:zeroLocation];
    
    
    if (dist==0) {
        _coordinate = UserLocationHandler.shareInstance.coordinate;
    }
    
    @weakify(self)
    [_searchFilter setSelectedResponseBlock:^{
        @strongify(self)
        self.totalPageNum = @0;
        self.pageNum = @0;
        self.pageSize = @0;
        NSString *cityID = @"";
        if (self.selectedCity&&self.selectedCity.cityID&&self.selectedCity.cityID<=0) {
            cityID = self.selectedCity.cityID.stringValue;
        }
        [self getMaintenanceShopsAPIsGetMaintenanceShopsListWithPageNums:nil
                                                                pageSize:nil
                                                                 ranking:nil
                                                               serviceID:self.searchFilter.shopServiceTypeString
                                                                shopType:self.searchFilter.shopTypeString
                                                                shopName:self.searchBar.text
                                                                  cityID:cityID
                                                                 address:nil
                                                               autoBrand:self.autoData.brandID.stringValue
                                                                latitude:@(self.coordinate.latitude).stringValue
                                                               longitude:@(self.coordinate.longitude).stringValue
                                                             isCertified:self.searchFilter.isValid.boolValue
                                                             refreshView:nil];
    }];
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, repairShopList) subscribeNext:^(id x) {
        @strongify(self)
        [self.resultTableView reloadData];
    }];
}

#pragma -mark UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self resignSearchBarFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_repairShopList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    RepairShopResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[RepairShopResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell initializationUI];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.contentView.backgroundColor = CDZColorOfWhite;
    }
    // Configure the cell...
    NSDictionary *shopDetail = _repairShopList[indexPath.row];
    [cell setUIDataWithDetailData:shopDetail];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self resignSearchBarFirstResponder];
    [ProgressHUDHandler showHUD];
    [self getShopDetailDataWithShopID:[_repairShopList[indexPath.row] objectForKey:@"id"]];
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

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self resignSearchBarFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self resignSearchBarFirstResponder];
    [self componentSetting];
    NSString *cityID = @"";
    if (self.selectedCity&&self.selectedCity.cityID&&self.selectedCity.cityID<=0) {
        cityID = self.selectedCity.cityID.stringValue;
    }
    [self getMaintenanceShopsAPIsGetMaintenanceShopsListWithPageNums:nil
                                                            pageSize:nil
                                                             ranking:nil
                                                           serviceID:_searchFilter.shopServiceTypeString
                                                            shopType:_searchFilter.shopTypeString
                                                            shopName:_searchBar.text
                                                              cityID:cityID
                                                             address:nil
                                                           autoBrand:_autoData.brandID.stringValue
                                                            latitude:@(self.coordinate.latitude).stringValue
                                                           longitude:@(self.coordinate.longitude).stringValue
                                                         isCertified:_searchFilter.isValid.boolValue
                                                         refreshView:nil];
};

#pragma mark- Data Receive Handle
- (void)handleReceivedData:(id)responseObject withRefreshView:(id)refreshView{
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Data Error!");
        return;
    }
    @autoreleasepool {
        NSMutableArray *dataArray = [self mutableArrayValueForKey:@"repairShopList"];
        if (_totalPageNum.intValue==0) [dataArray removeAllObjects];
        [dataArray addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
//        [dataArray addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
//        NSUInteger index = 4;
//        if (dataArray.count>index) {
//            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, dataArray.count-index)];
//            [dataArray removeObjectsAtIndexes:indexSet];
//        }
        self.pageNum = responseObject[CDZKeyOfPageNumKey];
        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
        self.totalPageNum = @([responseObject[CDZKeyOfTotalPageSizeKey] integerValue]);
        _resultTableView.footer.hidden = ((_pageNum.intValue*_pageSize.intValue)>_totalPageNum.intValue);
        
    }
}

#pragma mark- API Access Code Section
- (void)getShopDetailDataWithShopID:(NSString *)shopID {
    if (!shopID) return;
    [[APIsConnection shareConnection] maintenanceShopsAPIsGetMaintenanceShopsDetailWithShopID:shopID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return ;
        }
        
        @autoreleasepool {
            RepairShopDetailVC *rsdvc = [[RepairShopDetailVC alloc] init];
            rsdvc.detailData = responseObject[CDZKeyOfResultKey];
            [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
            [[self navigationController] pushViewController:rsdvc animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }];

}

- (void)getMaintenanceShopsAPIsGetMaintenanceShopsListWithPageNums:(NSString *)pageNums
                                                          pageSize:(NSString *)pageSize
                                                           ranking:(NSString *)rankValue
                                                         serviceID:(NSString *)serviceID
                                                          shopType:(NSString *)shopType
                                                          shopName:(NSString *)shopName
                                                            cityID:(NSString *)cityID
                                                           address:(NSString *)address
                                                         autoBrand:(NSString *)autoBrand
                                                          latitude:(NSString *)latitude
                                                         longitude:(NSString *)longitude
                                                       isCertified:(BOOL)isCertified
                                                       refreshView:(id)refreshView {
   
    if (!refreshView) {
        [ProgressHUDHandler showHUD];
    }
    [[APIsConnection shareConnection] maintenanceShopsAPIsGetMaintenanceShopsListWithPageNums:pageNums
                                                                                     pageSize:pageSize
                                                                                      ranking:rankValue
                                                                                    serviceID:serviceID
                                                                                     shopType:shopType
                                                                                     shopName:shopName
                                                                                       cityID:cityID
                                                                                      address:address
                                                                                    autoBrand:autoBrand
                                                                                    longitude:longitude
                                                                                     latitude:latitude
                                                                                  isCertified:isCertified
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (refreshView) {
            operation.userInfo = @{@"refreshView":refreshView};
        }
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (refreshView) {
            operation.userInfo = @{@"refreshView":refreshView};
        }
        [self requestResultHandle:operation responseObject:nil withError:error];
        
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
        if(!refreshView){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refreshView];
        }
        if (errorCode!=0) {
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [self handleReceivedData:responseObject withRefreshView:refreshView];
    }
    
}
@end

