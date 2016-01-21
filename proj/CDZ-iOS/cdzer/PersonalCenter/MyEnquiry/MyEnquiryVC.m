//
//  MyEnquiryVC.m
//  cdzer
//
//  Created by KEns0n on 5/22/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MyEnquiryVC.h"
#import "MyEnquiryTVCell.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "InsetsLabel.h"

@interface MyEnquiryVC ()

@property (nonatomic, strong) NSMutableArray *enquiryList;

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) UIControl *reminderView;

@property (nonatomic, strong) InsetsLabel *reminderLabel;

- (void)initializationUI;
- (void)componentSetting;
- (void)handleReceivedData:(id)responseObject withRefreshView:(id)refreshView isAllReload:(BOOL)isAllReload;
- (void)stopRefresh:(id)refresh;
- (void)delayHandleData:(id)refresh;
- (void)refreshView:(id)refresh;
- (void)getGetSelfEnquireProductsPriceListWithRefreshView:(id)refreshView isAllReload:(BOOL)isAllReload;
- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error;


@end

@implementation MyEnquiryVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"my_enquiry")];
    self.enquiryList = [NSMutableArray array];
    [self componentSetting];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getGetSelfEnquireProductsPriceListWithRefreshView:nil isAllReload:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializationUI {
    @autoreleasepool {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
        [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
        
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshView:)];
        self.tableView.footer.automaticallyHidden = NO;
        
        self.reminderView = [[UIControl alloc] initWithFrame:self.tableView.bounds];
        _reminderView.hidden = YES;
        _reminderView.backgroundColor = CDZColorOfWhite;
        [_reminderView addTarget:self action:@selector(reloadDataForReminderView) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView addSubview:_reminderView];
        
        self.reminderLabel = [[InsetsLabel alloc] initWithFrame:_reminderView.bounds];
        _reminderLabel.text = @"询价里面空空如也！\n或点击此处重新加载！";
        _reminderLabel.numberOfLines = 0;
        _reminderLabel.textAlignment = NSTextAlignmentCenter;
        [_reminderView addSubview:_reminderLabel];
    }
}

- (void)componentSetting {
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);
}

- (void)reloadDataForReminderView {
    [self getGetSelfEnquireProductsPriceListWithRefreshView:NO isAllReload:YES];
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _enquiryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MyEnquiryTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyEnquiryTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell initializationUI];
        
    }
    // Configure the cell...
    [cell updateUIDataWith:_enquiryList[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return vAdjustByScreenRatio(170.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @autoreleasepool {
        
    }
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
        if (isAllReload) [_enquiryList removeAllObjects];
        [_enquiryList addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
        self.totalPageNum = @([responseObject[CDZKeyOfTotalPageSizeKey] integerValue]);
        self.pageNum = responseObject[CDZKeyOfPageNumKey];
        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
        
        _reminderView.hidden = (_totalPageNum.integerValue!=0);
        self.tableView.bounces = (_totalPageNum.integerValue!=0);
        
        self.tableView.footer.hidden = ((_pageNum.intValue*_pageSize.intValue)>_totalPageNum.intValue);
        [self.tableView reloadData];
    }
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayHandleData:(id)refresh {
    
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        if ([(ODRefreshControl *)refresh refreshing]) {
            [self getGetSelfEnquireProductsPriceListWithRefreshView:refresh isAllReload:YES];
        }
        
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]){
        if ([(MJRefreshAutoNormalFooter *)refresh isRefreshing]) {
            self.pageNum = @(self.pageNum.integerValue+1);
            [self getGetSelfEnquireProductsPriceListWithRefreshView:refresh isAllReload:NO];
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

#pragma mark- API Access Code Section
- (void)getGetSelfEnquireProductsPriceListWithRefreshView:(id)refreshView isAllReload:(BOOL)isAllReload {
    if (!self.accessToken) return;
    if (!refreshView) {
        [ProgressHUDHandler showHUD];
    }

    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:@(isAllReload) forKey:@"isAllReload"];
    if (refreshView) {
        [userInfo addEntriesFromDictionary:@{@"refreshView":refreshView}];
    }
    
    [[APIsConnection shareConnection] personalCenterAPIsGetSelfEnquireProductsPriceWithAccessToken:self.accessToken
                                                                                          pageNums:_pageNum.stringValue
                                                                                          pageSize:_pageSize.stringValue
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:nil withError:error];
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
        [_enquiryList removeAllObjects];
        [self.tableView reloadData];
    }else if (!error&&responseObject) {
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        
        switch (errorCode) {
            case 0:{
                
                [self handleReceivedData:responseObject withRefreshView:refreshView isAllReload:isAllReload];
            }
                break;
            case 1:
            case 2:
                if(!refreshView){
                    [ProgressHUDHandler dismissHUD];
                }else{
                    [self stopRefresh:refreshView];
                }
                [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                    
                }];
                break;
                
            default:
                break;
        }
        
    }
    
}
@end
