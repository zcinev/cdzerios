//
//  MyCouponVC.m
//  cdzer
//
//  Created by KEns0n on 10/31/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "MyCouponVC.h"
#import "MyCouponCell.h"
#import "InsetsLabel.h"
#import <ODRefreshControl/ODRefreshControl.h>
#import <MJRefresh/MJRefresh.h>

@interface MyCouponVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) InsetsLabel *totalCouponLabel;

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) NSMutableArray *myCouponList;

@property (nonatomic, strong) ODRefreshControl *refreshControl;


@end
@implementation MyCouponVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    self.title = getLocalizationString(@"my_coupon");
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getMyCollectedCouponListWithRefreshView:nil isReloadAll:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);
    self.myCouponList = [NSMutableArray array];
    
}

- (void)initializationUI {
    @autoreleasepool {
        
//        UIView *filterContainerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), 36.0f)];
//        filterContainerView.backgroundColor = CDZColorOfGray;
//        [filterContainerView setViewBorderWithRectBorder:UIRectBorderBottom borderSize:0.5f withColor:CDZColorOfSeperateLineDeepColor withBroderOffset:nil];
//        [self.contentView addSubview:filterContainerView];
        
        self.totalCouponLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), 36.0f)
                                 andEdgeInsetsValue:DefaultEdgeInsets];
        _totalCouponLabel.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.00f];
        [self.contentView addSubview:_totalCouponLabel];
        
        
        
        NSMutableAttributedString* totalItemString = [NSMutableAttributedString new];
        [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:@"现有优惠劵总数："
                                                 attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                              NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO)}]];
        
        [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:@"0"
                                                 attributes:@{NSForegroundColorAttributeName:CDZColorOfWeiboColor,
                                                              NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO)}]];
        _totalCouponLabel.attributedText = totalItemString;
        
        
        CGRect tableViewFrame = self.contentView.bounds;
        tableViewFrame.origin.y = CGRectGetMaxY(_totalCouponLabel.frame);
        tableViewFrame.size.height -= CGRectGetMaxY(_totalCouponLabel.frame);
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
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, tableView.bounces) subscribeNext:^(NSNumber *bounces) {
        @strongify(self)
        if (bounces.boolValue) {
            self.navigationItem.rightBarButtonItem = nil;
        }else {
            [self setRightNavButtonWithSystemItemStyle:UIBarButtonSystemItemRefresh target:self action:@selector(reloadDataFromNet) isNeedToSet:YES];
        }
    }];
}

- (void)reloadDataFromNet {
    [self getMyCollectedCouponListWithRefreshView:nil isReloadAll:YES];
}

- (void)hiddenRefreshView:(id)refreshView {
    [refreshView endRefreshing];
}

- (void)refreshView:(id)refresh {
    BOOL isRefreshing = NO;
    BOOL isFirstRequest = NO;
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


- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}



- (void)delayRunData:(NSArray *)arguments {
    [self getMyCollectedCouponListWithRefreshView:[arguments objectAtIndex:0] isReloadAll:[[arguments objectAtIndex:1] boolValue]];
}


#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return (_myCouponList.count==0)?1:_myCouponList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MyCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyCouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.remindLabel.hidden = NO;
    if (_myCouponList.count>0) {
        cell.remindLabel.hidden = YES;
        NSDictionary *couponDetail = _myCouponList[indexPath.row];
        [cell updateUIDataWithData:couponDetail];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_myCouponList.count==0) return CGRectGetHeight(tableView.frame);
    UIImage *image = ImageHandler.getCouponOffImage;
    return image.size.height+50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)getMyCollectedCouponListWithRefreshView:(id)refreshView isReloadAll:(BOOL)isReloadAll {
    if (!self.accessToken) return;
    if(!refreshView){
        [ProgressHUDHandler showHUD];
    }
    
    if (isReloadAll){
        self.pageNum = @(1);
        self.pageSize = @(10);
        self.totalPageNum = @(0);
        [self.myCouponList removeAllObjects];
    }
    
    @weakify(self)
    [APIsConnection.shareConnection personalCenterAPIsGetMyCouponCollectedListWithAccessToken:self.accessToken pageNums:_pageNum pageSize:_pageSize success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        @strongify(self)
        if(refreshView){
            [self hiddenRefreshView:refreshView];
        }else {
            [ProgressHUDHandler dismissHUD];
        }
        self.tableView.bounces = YES;
        if(errorCode==0){
            [self.myCouponList addObjectsFromArray:[responseObject[CDZKeyOfResultKey] objectForKey:@"prefer_list"]];
            if (self.myCouponList.count==0) self.tableView.bounces = NO;
        }else {
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
            if (self.myCouponList.count!=0) self.tableView.bounces = NO;
        }
        
        if (self.totalPageNum.integerValue==0) {
            self.totalPageNum = [SupportingClass verifyAndConvertDataToNumber:responseObject[CDZKeyOfTotalPageSizeKey]];
        }
        NSMutableAttributedString* totalItemString = [NSMutableAttributedString new];
        [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:@"现有优惠劵总数："
                                                 attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                              NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO)}]];
        
        [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:self.totalPageNum.stringValue
                                                 attributes:@{NSForegroundColorAttributeName:CDZColorOfWeiboColor,
                                                              NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO)}]];
        self.totalCouponLabel.attributedText = totalItemString;
        
        self.pageNum = responseObject[CDZKeyOfPageNumKey];
        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
        self.tableView.footer.hidden = ((self.pageNum.intValue*self.pageSize.intValue)>self.totalPageNum.intValue);
        
        [self.tableView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        @strongify(self)
        if (isReloadAll) {
            
            if (self.myCouponList.count==0) self.tableView.bounces = NO;
        }else {
            
            if (self.myCouponList.count!=0) self.tableView.bounces = NO;
        }
        [self.tableView reloadData];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"不明错误" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            if(refreshView){
                [self hiddenRefreshView:refreshView];
            }else {
                [ProgressHUDHandler dismissHUD];
            }
        }];
    }];
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
