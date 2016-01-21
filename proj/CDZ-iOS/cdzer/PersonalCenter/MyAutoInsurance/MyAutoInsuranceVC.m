//
//  MyAutoInsuranceVC.m
//  cdzer
//
//  Created by KEns0n on 10/12/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "MyAutoInsuranceVC.h"
#import "MyAutoInsuranceInfoFormVC.h"
#import "MAIVCTableViewCell.h"
#import "MyAutoInsuranceApplyFormVC.h"
#import "MyAutoInsuranceDetailVC.h"
#import <ODRefreshControl/ODRefreshControl.h>
#import <MJRefresh/MJRefresh.h>

@interface MyAutoInsuranceVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *appointmentBtn;

@property (nonatomic, strong) UIButton *purchasedBtn;

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) NSMutableArray *insuranceList;

@property (nonatomic, assign) BOOL isPurchasedList;

@property (nonatomic, strong) ODRefreshControl *refreshControl;

@end

@implementation MyAutoInsuranceVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    self.title = getLocalizationString(@"my_insurance_list");
    [self checkUserInsuranceInfoExsit];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);
    self.isPurchasedList = NO;
    self.insuranceList = [NSMutableArray array];
    [self setRightNavButtonWithTitleOrImage:@"添加预约" style:UIBarButtonItemStyleDone target:self action:@selector(showMAIDViewController) titleColor:nil isNeedToSet:YES];
    
}

- (void)initializationUI {
    UIView *filterContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), 36.0f)];
    filterContainerView.backgroundColor = CDZColorOfGray;
    [filterContainerView setViewBorderWithRectBorder:UIRectBorderBottom borderSize:0.5f withColor:CDZColorOfSeperateLineDeepColor withBroderOffset:nil];
    [self.contentView addSubview:filterContainerView];
    
    
    BorderOffsetObject *offset = [BorderOffsetObject new];
    offset.rightBottomOffset = 5.0f;
    offset.rightUpperOffset = 5.0f;
    offset.leftBottomOffset = 5.0f;
    offset.leftUpperOffset = 5.0f;
    NSString *appointmentTitle = @"已预约";
    self.appointmentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _appointmentBtn.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(filterContainerView.frame)/2.0f, CGRectGetHeight(filterContainerView.bounds));
    _appointmentBtn.selected = YES;
    _appointmentBtn.userInteractionEnabled = NO;
    _appointmentBtn.tintColor = CDZColorOfClearColor;
    [_appointmentBtn setTitle:appointmentTitle forState:UIControlStateNormal];
    [_appointmentBtn setTitle:appointmentTitle forState:UIControlStateSelected];
    [_appointmentBtn setTitle:appointmentTitle forState:UIControlStateDisabled];
    [_appointmentBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
    [_appointmentBtn setTitleColor:CDZColorOfOrangeColor forState:UIControlStateSelected];
    [_appointmentBtn setTitleColor:CDZColorOfTxtDeepGaryColor forState:UIControlStateDisabled];
    [_appointmentBtn addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    [_appointmentBtn setViewBorderWithRectBorder:UIRectBorderRight borderSize:0.5f withColor:CDZColorOfSeperateLineDeepColor withBroderOffset:offset];
    [filterContainerView addSubview:_appointmentBtn];
    
    NSString *purchasedTitle = @"已购买";
    self.purchasedBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _purchasedBtn.tintColor = CDZColorOfClearColor;
    _purchasedBtn.frame = CGRectMake(CGRectGetWidth(filterContainerView.frame)/2.0f, 0.0f, CGRectGetWidth(filterContainerView.frame)/2.0f, CGRectGetHeight(filterContainerView.bounds));
    [_purchasedBtn setTitle:purchasedTitle forState:UIControlStateNormal];
    [_purchasedBtn setTitle:purchasedTitle forState:UIControlStateSelected];
    [_purchasedBtn setTitle:purchasedTitle forState:UIControlStateDisabled];
    [_purchasedBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
    [_purchasedBtn setTitleColor:CDZColorOfOrangeColor forState:UIControlStateSelected];
    [_purchasedBtn setTitleColor:CDZColorOfTxtDeepGaryColor forState:UIControlStateDisabled];
    [_purchasedBtn addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    [_purchasedBtn setViewBorderWithRectBorder:UIRectBorderLeft borderSize:0.5f withColor:CDZColorOfSeperateLineDeepColor withBroderOffset:offset];
    [filterContainerView addSubview:_purchasedBtn];
    
    CGRect tableViewFrame = self.contentView.bounds;
    tableViewFrame.origin.y = CGRectGetMaxY(filterContainerView.frame);
    tableViewFrame.size.height -= CGRectGetMaxY(filterContainerView.frame);
    self.tableView = [[UITableView alloc] initWithFrame:tableViewFrame];
    _tableView.backgroundColor = [UIColor colorWithRed:0.937f green:0.937f blue:0.957f alpha:1.00f];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollsToTop = YES;
    _tableView.bounces = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_tableView];

    
    self.refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableView];
    [_refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshView:)];
    _tableView.footer.automaticallyHidden = NO;
    _tableView.footer.hidden = YES;
}

- (void)setReactiveRules {
    
}

- (void)changeType:(UIButton *)button {
    if (button.selected) {
        return;
    }
    self.isPurchasedList = YES;
    if (button==_appointmentBtn) {
        self.isPurchasedList = NO;;
    }
    
    _appointmentBtn.selected = !_isPurchasedList;
    _purchasedBtn.selected = _isPurchasedList;
    _appointmentBtn.userInteractionEnabled = _isPurchasedList;
    _purchasedBtn.userInteractionEnabled = !_isPurchasedList;
    [self clearPageRecord];
    
    [self getAppointmentOrPurchasedListWasPurchasedList:_isPurchasedList isReloadAll:YES refreshView:NO];
    
    
}

- (void)refreshView:(id)refresh {
    BOOL isRefreshing = NO;
    BOOL isFirstRequest = NO;
    _appointmentBtn.enabled = NO;
    _purchasedBtn.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        isRefreshing = [(ODRefreshControl *)refresh refreshing];
        isFirstRequest = YES;
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
        isRefreshing = [(MJRefreshAutoNormalFooter *)refresh isRefreshing];
        self.pageNum = @(_pageNum.unsignedIntegerValue+1);
    }
    if (isRefreshing) {
        [self performSelector:@selector(delayRunData:) withObject:@[refresh, @(isFirstRequest)] afterDelay:2];
        
    }
}

- (void)clearPageRecord {
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);

}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayRunData:(NSArray *)arguments {
    if ([[arguments objectAtIndex:1] boolValue]) {
        [self clearPageRecord];
    }
    [self getAppointmentOrPurchasedListWasPurchasedList:_isPurchasedList isReloadAll:[[arguments objectAtIndex:1] boolValue] refreshView:[arguments objectAtIndex:0]];
}

- (void)showMAIDViewController {
    
    @autoreleasepool {
        MyAutoInsuranceApplyFormVC *vc = [MyAutoInsuranceApplyFormVC new];
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (_insuranceList.count==0) {
        return 1;
    }
    return _insuranceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MAIVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MAIVCTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:CDZColorOfWhite];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.numberOfLines = 0;
        
    }
    if(_insuranceList.count>0){
        [cell showAllView];
        [cell updateUIDataWithDate:_insuranceList[indexPath.row]];
        cell.textLabel.text = @"";
    }else {
        [cell clearAllsetting];
        cell.textLabel.text = [NSString stringWithFormat:@"抱歉，暂无更多\n已%@的保险信息", _isPurchasedList?@"购买":@"预约"];
    }
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_insuranceList.count==0) return CGRectGetHeight(tableView.frame);
    return 160.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", _insuranceList[indexPath.row]);
    NSDictionary *detail = _insuranceList[indexPath.row];
    NSString *premiumID = detail[@"pid"];
    [self getInsuranceDetail:premiumID];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)pushToInsuranceFormVCWithTitle:(NSString *)title isFirstTime:(BOOL)isFirstTime isShowCancelBtn:(BOOL)isShowCancelBtn {
    
    @autoreleasepool {
        MyAutoInsuranceInfoFormVC *vc = [MyAutoInsuranceInfoFormVC new];
        vc.isShowCancelBtn = isShowCancelBtn;
        vc.isFirstTime = isFirstTime;
        [self setNavBarBackButtonTitleOrImage:title titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)pushToInsuranceDetailWithData:(id)responseObject {
    
    @autoreleasepool {
        MyAutoInsuranceDetailVC *vc = [MyAutoInsuranceDetailVC new];
        vc.insuranceDetail = responseObject;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)checkUserInsuranceInfoExsit {
    if (!self.accessToken) {
        return;
    }
    [ProgressHUDHandler showHUD];
    @weakify(self)
    [APIsConnection.shareConnection personalCenterAPIsGetUserInsuranceInfoCheckWithtAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if(errorCode!=0){
            BOOL isNodata = ([message rangeOfString:@"没有数据"].location!=NSNotFound);
            NSString *cancelBtn = @"ok";
            NSString *confirmBtn = nil;
            if (isNodata) {
                cancelBtn = @"cancel";
                confirmBtn = @"ok";
                message = @"你还有有完善个人车辆保险信息，现在去完善吗？";
                [ProgressHUDHandler dismissHUD];
            }
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:cancelBtn otherButtonTitles:confirmBtn clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
                @strongify(self)
                if (isNodata) {
                    if (btnIdx.unsignedIntegerValue==0) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                    if (btnIdx.unsignedIntegerValue==1) {
                        [self pushToInsuranceFormVCWithTitle:nil isFirstTime:YES isShowCancelBtn:YES];
                    }
                }else {
                    [ProgressHUDHandler dismissHUD];
                }
            }];
            return;
        }
        [ProgressHUDHandler dismissHUDWithCompletion:^{
            @strongify(self)
            [self getAppointmentOrPurchasedListWasPurchasedList:self.isPurchasedList isReloadAll:YES refreshView:nil];
        }];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SupportingClass showAlertViewWithTitle:@"error" message:@"不明错误" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            [ProgressHUDHandler dismissHUD];
        }];
    }];
}

- (void)updateDateWithResponseObject:(id)responseObject isReloadAll:(BOOL)isReloadAll refreshView:(id)refreshView {
    
    if (isReloadAll) {
        [self.insuranceList removeAllObjects];
    }
    if(!refreshView){
        [ProgressHUDHandler dismissHUD];
    }else{
        [self stopRefresh:refreshView];
    }
    [self.insuranceList addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
    self.pageNum = [SupportingClass verifyAndConvertDataToNumber:responseObject[CDZKeyOfPageNumKey]];
    self.pageSize = [SupportingClass verifyAndConvertDataToNumber:responseObject[CDZKeyOfPageSizeKey]];
    self.totalPageNum = [SupportingClass verifyAndConvertDataToNumber:responseObject[CDZKeyOfTotalPageSizeKey]];
    self.tableView.footer.hidden = ((self.pageSize.integerValue*self.pageNum.integerValue)>self.totalPageNum.integerValue);
    
    [self.tableView reloadData];
}

- (void)getAppointmentOrPurchasedListWasPurchasedList:(BOOL)isPurchasedList isReloadAll:(BOOL)isReloadAll refreshView:(id)refreshView {
    if (!self.accessToken) {
        return;
    }
    if(!refreshView){
        [ProgressHUDHandler showHUD];
    }
    @weakify(self)
    [APIsConnection.shareConnection personalCenterAPIsGetUserInsuranceAppointmentAndPurchasedListWasPurchasedList:isPurchasedList accessToken:self.accessToken pageNums:_pageNum pageSize:_pageSize success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        @strongify(self)
        self.appointmentBtn.selected = !self.isPurchasedList;
        self.purchasedBtn.selected = self.isPurchasedList;
        self.appointmentBtn.userInteractionEnabled = self.isPurchasedList;
        self.purchasedBtn.userInteractionEnabled = !self.isPurchasedList;
        self.appointmentBtn.enabled = YES;
        self.purchasedBtn.enabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        if(errorCode!=0){
            BOOL isKindNoData = ([message rangeOfString:@"没有第"].location!=NSNotFound);
            if(!refreshView){
                [ProgressHUDHandler dismissHUD];
            }else{
                [self stopRefresh:refreshView];
            }
            self.tableView.footer.hidden = YES;
            if (isKindNoData){
                if (isReloadAll) {
                    [self.insuranceList removeAllObjects];
                }
                [self.tableView reloadData];
            }else {
                [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                    @strongify(self)
                    if (isReloadAll) {
                        [self.insuranceList removeAllObjects];
                    }
                    [self.tableView reloadData];
                    
                }];
            }
            return;
        }
        [self updateDateWithResponseObject:responseObject isReloadAll:isReloadAll refreshView:refreshView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SupportingClass showAlertViewWithTitle:@"error" message:@"不明错误" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            @strongify(self)
            if(!refreshView){
                [ProgressHUDHandler dismissHUD];
            }else{
                [self stopRefresh:refreshView];
            }
            self.appointmentBtn.selected = !self.isPurchasedList;
            self.purchasedBtn.selected = self.isPurchasedList;
            self.appointmentBtn.userInteractionEnabled = self.isPurchasedList;
            self.purchasedBtn.userInteractionEnabled = !self.isPurchasedList;
            self.appointmentBtn.enabled = YES;
            self.purchasedBtn.enabled = YES;
            self.navigationItem.rightBarButtonItem.enabled = YES;
            self.tableView.footer.hidden = YES;
        }];
    }];
}

- (void)getInsuranceDetail:(NSString *)premiumID {
    if (!self.accessToken||!premiumID) return;
    [ProgressHUDHandler showHUD];
    @weakify(self)
    [APIsConnection.shareConnection personalCenterAPIsGetUserInsuranceAutosInsuranceDetailWithAccessToken:self.accessToken premiumID:premiumID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if(errorCode!=0){
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                [ProgressHUDHandler dismissHUD];
            }];
            return;
        }
        @strongify(self)
        [ProgressHUDHandler dismissHUDWithCompletion:^{
            [self pushToInsuranceDetailWithData:responseObject[CDZKeyOfResultKey]];
        }];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SupportingClass showAlertViewWithTitle:@"error" message:@"不明错误" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            [ProgressHUDHandler dismissHUDWithCompletion:^{
             
            }];
        }];

    }];
}

@end
