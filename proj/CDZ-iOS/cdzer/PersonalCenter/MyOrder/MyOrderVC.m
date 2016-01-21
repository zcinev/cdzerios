//
//  MyOrderVC.m
//  cdzer
//
//  Created by KEns0n on 3/28/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vStartSpace vAdjustByScreenRatio(10.0f)
#import "MyOrderVC.h"
#import "InsetsLabel.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "MyOrderTVCell.h"
#import "MyOrderDetailByStatusVC.h"
#import "MyOrderConfig.h"
#import "MOSearchFilterView.h"
#import "OrderStatusDTO.h"

@interface MyOrderVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) NSArray *stateList;

@property (nonatomic, strong) NSArray *stateParameterList;

@property (nonatomic, strong) NSMutableArray *orderList;

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) UIButton *loginRemindView;

@property (nonatomic, strong) MOSearchFilterView *statusFilterView;

@property (nonatomic, assign) BOOL isBeforePush;

@end

@implementation MyOrderVC


- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"my_order")];
    [self componentSetting];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!self.isBeforePush) {
        [_orderList removeAllObjects];
        [self componentSetting];
    }
    [_statusFilterView unfoldingFilterView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _loginRemindView.hidden = !(!self.accessToken);
    if (self.accessToken&&!self.isBeforePush) {
        [self getPurchaseOrderListWithRefreshView:nil isAllReload:YES];
    }
    self.isBeforePush = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadPageData {
    
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);
}

- (void)componentSetting {
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);
    self.isBeforePush = NO;
    self.stateParameterList = [DBHandler.shareInstance getPurchaseOrderStatusList];
    
    self.orderList = [NSMutableArray array];
    self.stateList = @[getLocalizationString(@"all_order_list"),
                       getLocalizationString(@"wait4payment"),
                       getLocalizationString(@"deliveries"),
                       getLocalizationString(@"wait4comment")];
    if (!_currentStatusName) {
        self.currentStatusName = @"";
    }
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(setReloadFlag) name:CDZNotiKeyOfReloadOrderList object:nil];
}

- (void)initializationUI {
    @autoreleasepool {
        
        UIButton *maskBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect maskRect = self.contentView.bounds;
        [maskBtnView setFrame:maskRect];
        [maskBtnView setAlpha:0];
        [maskBtnView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4]];
        [self.contentView addSubview:maskBtnView];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        NSArray *titleArray = @[@"all_order_list", @"wait4payment", @"deliveries", @"wait4comment"];
        self.statusFilterView = [[MOSearchFilterView alloc] initWithOrigin:CGPointMake(0.0f, 0.0f)];
        if (_currentStatusName) {
            _statusFilterView.statusString = _currentStatusName;
        }
        [_statusFilterView initializationUIWithMaskView:maskBtnView];
        [self.contentView addSubview:_statusFilterView];
        @weakify(self)
        [self.statusFilterView setSelectionResponseBlock:^() {
            @strongify(self)
            self.currentStatusName = self.statusFilterView.statusString;
            [self filterAction];
        }];
        
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect tableViewRect = self.contentView.bounds;
        tableViewRect.origin.y = CGRectGetMaxY(_statusFilterView.frame);
        tableViewRect.size.height -= CGRectGetMaxY(_statusFilterView.frame);
//        if(self.tabBarController){
//            tableViewRect.size.height -= CGRectGetHeight(self.tabBarController.tabBar.frame);
//        }
        [self setTableView:[[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain]];
        [_tableView setBackgroundColor:sCommonBGColor];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setShowsHorizontalScrollIndicator:NO];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setBounces:YES];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [self.contentView insertSubview:_tableView belowSubview:maskBtnView];
        
        ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableView];
        [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
        
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshView:)];
        _tableView.footer.automaticallyHidden = NO;
        
        
        self.loginRemindView = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginRemindView.frame = self.contentView.bounds;
        _loginRemindView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
        [_loginRemindView setTitle:getLocalizationString(@"order_login_remind") forState:UIControlStateNormal];
        [_loginRemindView addTarget:self action:@selector(showLoginView) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_loginRemindView];

    }
}

- (void)showLoginView {
    [self presentLoginViewAtViewController:self backTitle:nil animated:YES completion:^{
        
    }];
}

- (void)filterAction {
    
    if (!self.accessToken) return;
    [self reloadPageData];
    [self getPurchaseOrderListWithRefreshView:nil isAllReload:YES];
}

- (void)pushToOrderDetail:(id)detail {
    if (!detail||![detail isKindOfClass:[NSDictionary class]]) {
        return;
    }
    @autoreleasepool {
        self.isBeforePush = YES;
        NSString *stateName = [_orderList[_tableView.indexPathForSelectedRow.row] objectForKey:@"state_name"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"stateName = %@",stateName];
        OrderStatusDTO *stateDetail = [[_stateParameterList filteredArrayUsingPredicate:predicate] firstObject];
        if (stateDetail) {
            MyOrderDetailByStatusVC *vc = [MyOrderDetailByStatusVC new];
            [vc setupOrderDetail:detail withOrderStatus:stateDetail];
            [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
            [self.navigationController pushViewController:vc animated:YES];

        }
    }
}

- (void)setReloadFlag {
    self.isBeforePush = NO;
}

#pragma mark- Data Receive Handle
- (void)handleReceivedData:(id)responseObject withRefreshView:(id)refreshView isAllReload:(BOOL)isAllReload {
    if(!refreshView){
        [ProgressHUDHandler dismissHUD];
    }else{
        [self stopRefresh:refreshView];
    }
    if (!responseObject||![responseObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Data Error!");
        return;
    }

    @autoreleasepool {
        if (isAllReload) {
            [_orderList removeAllObjects];
            _tableView.contentOffset = CGPointZero;
        }
        [_orderList addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
        self.totalPageNum = @([responseObject[CDZKeyOfTotalPageSizeKey] integerValue]);
        self.pageNum = responseObject[CDZKeyOfPageNumKey];
        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
        
        _tableView.footer.hidden = ((_pageNum.intValue*_pageSize.intValue)>_totalPageNum.intValue);
        [_tableView reloadData];
        
    }
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayHandleData:(id)refresh {
    
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        if ([(ODRefreshControl *)refresh refreshing]) {
            [self reloadPageData];
            [self getPurchaseOrderListWithRefreshView:refresh isAllReload:YES];
        }
        
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]){
        if ([(MJRefreshAutoNormalFooter *)refresh isRefreshing]) {
            self.pageNum = @(self.pageNum.integerValue+1);
            [self getPurchaseOrderListWithRefreshView:refresh isAllReload:NO];
        }
    }
}

- (void)refreshView:(id)refresh {
    if (!self.accessToken) {
        [self stopRefresh:refresh];
        return;
    }
    [self performSelector:@selector(delayHandleData:) withObject:refresh afterDelay:1.5];
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (_orderList.count==0) {
        return 1;
    }
    return _orderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MyOrderTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyOrderTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell initializationUI];
        
    }
    // Configure the cell...
    if (_orderList.count==0) {
        [cell updateUIDataWith:nil];
    }else {
        [cell updateUIDataWith:_orderList[indexPath.row]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = 0;
    if (_orderList.count!=0) {
        
        count = [[_orderList[indexPath.row] objectForKey:@"lmap"] count];
    }
    return count*80+120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @autoreleasepool {
        if (_orderList.count!=0) {
            [self getPurchaseOrderDetailWithOrderID:[_orderList[indexPath.row] objectForKey:@"order_main_id"]];
        }
    }
}



#pragma mark- API Access Code Section
/* 获取订单列表 */
- (void)getPurchaseOrderListWithRefreshView:(id)refreshView isAllReload:(BOOL)isAllReload {
    if (!self.accessToken) return;
    if (!refreshView) {
        [ProgressHUDHandler showHUD];
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:@(isAllReload) forKey:@"isAllReload"];
    if (refreshView) {
        [userInfo addEntriesFromDictionary:@{@"refreshView":refreshView}];
    }
    
    [[APIsConnection shareConnection] personalCenterAPIsGetPurchaseOrderListWithAccessToken:self.accessToken
                                                                                   pageNums:_pageNum.stringValue
                                                                                   pageSize:_pageSize.stringValue
                                                                                  stateName:_currentStatusName
    success:^(AFHTTPRequestOperation *operation, id responseObject) {        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

/* 获取订单详情 */
- (void)getPurchaseOrderDetailWithOrderID:(NSString *)orderID {
    if (!self.accessToken||!orderID) return;
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] personalCenterAPIsGetPurchaseOrderDetailWithAccessToken:self.accessToken orderMainID:orderID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        [self pushToOrderDetail:responseObject[CDZKeyOfResultKey]];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"连接逾时！请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
        
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    id refreshView = operation.userInfo[@"refreshView"];
    BOOL isAllReload = [operation.userInfo[@"isAllReload"] boolValue];
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        if(!refreshView){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refreshView];
        }
        [_orderList removeAllObjects];
        [_tableView reloadData];
        self.totalPageNum = @(0);
        self.pageNum = @(1);
        self.pageSize = @(10);
        _tableView.footer.hidden = ((_pageNum.intValue*_pageSize.intValue)>_totalPageNum.intValue);
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
        }
        
        [self handleReceivedData:responseObject withRefreshView:refreshView isAllReload:isAllReload];
        
    }
    
}

@end
