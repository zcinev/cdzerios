//
//  MessageAlertVC.m
//  cdzer
//
//  Created by KEns0n on 6/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MessageAlertVC.h"
#import "MessageAlertCell.h"
#import <ODRefreshControl/ODRefreshControl.h>
#import <MJRefresh/MJRefresh.h>

@interface MessageAlertVC ()

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *retryButton;

@property (nonatomic, assign) BOOL wasReaded;

@end

@implementation MessageAlertVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = getLocalizationString(@"message_alert_vc");
    // Do any additional setup after loading the view.
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_dataArray.count==0) {
        [self getMessageAlertListWithRefreshView:nil isRelaodAll:YES];
    }
}

- (void)setReactiveRules {
//    @weakify(self)
//    [RACObserve(self, titleList) subscribeNext:^(NSArray *titleList) {
//        @strongify(self)
//    }];
}

- (void)componentSetting {
    self.pageNum = @(1);
    self.pageSize = @(10);
    self.totalPageNum = @(0);
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    [_dataArray removeAllObjects];
    self.wasReaded = YES;
    [self setRightNavButtonWithTitleOrImage:@"已读" style:UIBarButtonItemStyleDone target:self action:@selector(switchMessageStatus) titleColor:nil isNeedToSet:YES];
}

- (void)switchMessageStatus {
    self.wasReaded = !_wasReaded;
    self.navigationItem.rightBarButtonItem.title = _wasReaded?@"已读":@"未读";
    [self getMessageAlertListWithRefreshView:nil isRelaodAll:YES];
}

- (void)initializationUI {
    @autoreleasepool {
        
        ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
        [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
        
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshView:)];
        self.tableView.footer.automaticallyHidden = NO;
        self.tableView.footer.hidden = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.retryButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _retryButton.frame = self.view.bounds;
        _retryButton.hidden = YES;
        [_retryButton setTitle:@"没有更多消息，点此重新载入！" forState:UIControlStateNormal];
        [_retryButton setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
        [_retryButton addTarget:self action:@selector(retryReload) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_retryButton];
    }
    
}

- (void)retryReload {
    [self getMessageAlertListWithRefreshView:nil isRelaodAll:YES];
}

- (void)refreshView:(id)refresh {
    BOOL isRefreshing = NO;
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        isRefreshing = [(ODRefreshControl *)refresh refreshing];
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
        isRefreshing = [(MJRefreshAutoNormalFooter *)refresh isRefreshing];
    }
    if (isRefreshing) {
        [self performSelector:@selector(delayUpdateList:) withObject:refresh afterDelay:1];
    }
}

- (void)delayUpdateList:(id)refresh {
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        self.pageNum = @(1);
        self.pageSize = @(10);
        self.totalPageNum = @(0);
        [self getMessageAlertListWithRefreshView:refresh isRelaodAll:YES];
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
        [self getMessageAlertListWithRefreshView:refresh isRelaodAll:NO];
    }
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // NSInteger the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MessageAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MessageAlertCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setBackgroundColor:CDZColorOfWhite];
    }
    // Configure the cell...
    [cell updateUIDataWithData:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MessageAlertCell getDynamicHeight:_dataArray[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma -mark Address List Request functions
- (void)getMessageAlertListWithRefreshView:(id)refresh isRelaodAll:(BOOL)reloadAll{
    if (!self.accessToken)return;
    if (!refresh) {
        [ProgressHUDHandler showHUD];
    }
    @weakify(self)
    NSLog(@"%@ accessing network request",NSStringFromClass(self.class));
    [[APIsConnection shareConnection] personalGPSAPIsGetMessageAlertListWithAccessToken:self.accessToken pageNums:_pageNum pageSize:_pageSize plateName:nil typeName:nil isMessWasReaded:_wasReaded  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(!refresh){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refresh];
        }
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if(errorCode!=0){
            self.retryButton.hidden = NO;
            self.tableView.bounces = NO;
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        @strongify(self)
        if (reloadAll) [self.dataArray removeAllObjects];
        self.totalPageNum = @([responseObject[CDZKeyOfTotalPageSizeKey] integerValue]);
        self.pageNum = responseObject[CDZKeyOfPageNumKey];
        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
        self.tableView.footer.hidden = ((self.pageNum.intValue*self.pageSize.intValue)>self.totalPageNum.intValue);
        [self.dataArray addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
        [self.tableView reloadData];
        self.retryButton.hidden = YES;
        self.tableView.bounces = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        @strongify(self)
        if(!refresh){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refresh];
        }
        self.retryButton.hidden = NO;
        self.tableView.bounces = NO;
        [SupportingClass showAlertViewWithTitle:@"error" message:@"信息更新失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
    }];
}




@end
