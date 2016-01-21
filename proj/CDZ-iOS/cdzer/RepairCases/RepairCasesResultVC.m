//
//  RepairCasesResultVC.m
//  cdzer
//
//  Created by KEns0n on 7/1/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "RepairCasesResultVC.h"
#import "InsetsLabel.h"
#import "RCSearchFilterView.h"
#import "RepairShopDetailVC.h"
#import "RepairCasesResultCell.h"
#import "UserSelectedAutosInfoDTO.h"

@interface RepairCasesResultVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *resultList;

@property (nonatomic, strong) NSMutableArray *repairDetailList;

@property (nonatomic, strong) RCSearchFilterView *searchFilter;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RepairCasesResultVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"cases_result")];
    [self componentSetting];
    [self setReactiveRules];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)componentSetting {
    self.resultList = @[];
    id list = _resultDetail[@"list"];
    if (list&&[list isKindOfClass:NSArray.class]) {
        self.resultList = list;
        self.repairDetailList = [@[] mutableCopy];
        for (int i = 0; i<_resultList.count; i++) {
            [_repairDetailList addObject:@{@"isDisplay":@0,@"detail":[NSNull null]}];
        }
    }
    
}

- (void)setReactiveRules {

}

- (void)initializationUI {
    @autoreleasepool {
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), 60.0f)];
        topView.backgroundColor = CDZColorOfDefaultColor;
        [self.contentView addSubview:topView];
        
        InsetsLabel *titleOne = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(topView.frame)/2.0f)
                                                andEdgeInsetsValue:DefaultEdgeInsets];
        titleOne.textColor = CDZColorOfWhite;
        titleOne.text = _resultDetail[@"selectText1"];
        [topView addSubview:titleOne];
        
        InsetsLabel *titleTwo = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(titleOne.frame),
                                                                              CGRectGetWidth(self.contentView.frame), CGRectGetHeight(topView.frame)/2.0f)
                                                andEdgeInsetsValue:titleOne.edgeInsets];
        titleTwo.text = _resultDetail[@"selectText2"];
        titleTwo.textColor = [UIColor colorWithRed:0.992f green:0.988f blue:0.220f alpha:1.00f];
        [topView addSubview:titleTwo];
        
        
        UIButton *maskBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect maskRect = self.contentView.bounds;
        [maskBtnView setFrame:maskRect];
        [maskBtnView setAlpha:0];
        [maskBtnView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4]];
        [self.contentView insertSubview:maskBtnView belowSubview:topView];

        self.searchFilter = [[RCSearchFilterView alloc] initWithOrigin:CGPointMake(0.0, CGRectGetMaxY(topView.frame))];
        [_searchFilter initializationUIWithMaskView:maskBtnView];
        [self.contentView addSubview:_searchFilter];
        @weakify(self)
        [self.searchFilter setSelectionResponseBlock:^() {
            @strongify(self)
            [self reloadDataByFilter];
        }];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_searchFilter.frame),
                                                                       CGRectGetWidth(self.contentView.frame),
                                                                       CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(_searchFilter.frame))];
        _tableView.bounces = NO;
        _tableView.showsHorizontalScrollIndicator = YES;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableView.frame), 70.0f)];
        [self.contentView insertSubview:_tableView belowSubview:maskBtnView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _resultList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ident = @"cell";
    RepairCasesResultCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[RepairCasesResultCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    [cell updateUIDataWithData:_resultList[indexPath.row]];
     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    @autoreleasepool {
//    wxs_name: "湖南百城网络科技有限公司",
//    project: "发动机不能启动，且无着车征兆",
//    real_name: "小贺",
//    fee: "295.0",
//    add_time: "2015-06-16 11:14:32 ",
//    address: "湖南省长沙市"
        
        NSDictionary *detail = _resultList[indexPath.row];
        CGFloat totalHeight = [RepairCasesResultCell getCellHieght:detail];
        return totalHeight;
        
    }
    
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self getShopDetailDataWithShopID:[_resultList[indexPath.row] objectForKey:@"wxs_id"]];
}


- (void)reloadDataByFilter {
    NSInteger selectID = [(NSIndexPath *)_searchFilter.selectedList[0] row];
    NSString *sortString = @"";
    if (selectID>-1) {
        sortString = @(selectID).stringValue;
    }
    [self getCasesResult:sortString];
}

- (void)getCasesResult:(NSString *)sortString {
    UserSelectedAutosInfoDTO *autoData = [[DBHandler shareInstance]getSelectedAutoData];
    NSString *brandID = autoData.brandID.stringValue;
    NSString *brandDealershipID = autoData.dealershipID.stringValue;
    NSString *seriesID = autoData.seriesID.stringValue;
    NSString *modelID = autoData.modelID.stringValue;
        @weakify(self)
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] casesHistoryAPIsGetHistoryCasesResultListWithTwoStepIDsList:_theIDsList twoStepTextList:_theTextList address:@"" priceSort:sortString brandID:brandID brandDealershipID:brandDealershipID seriesID:seriesID modelID:modelID pageNums:@(1) pageSize:@(10) success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0||[responseObject[CDZKeyOfResultKey] count]==0) {
            if ([responseObject[CDZKeyOfResultKey] count]==0) {
                message = @"没有你所要求的结果";
            }
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            }];
            return ;
        }
        @strongify(self);
        self.resultList = @[];
        [self.repairDetailList removeAllObjects];
        id list = self.resultDetail[@"list"];
        if (list&&[list isKindOfClass:NSArray.class]) {
            self.resultList = list;
            for (int i = 0; i<self.resultList.count; i++) {
                [self.repairDetailList addObject:@{@"isDisplay":@0,@"detail":[NSNull null]}];
            }
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }];
    
}


//请求商店详情
- (void)getShopDetailDataWithShopID:(NSString *)shopID {
    if (!shopID) return;
    [ProgressHUDHandler showHUD];
    @weakify(self)
    [[APIsConnection shareConnection] maintenanceShopsAPIsGetMaintenanceShopsDetailWithShopID:shopID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return ;
        }
        
        @autoreleasepool {
            [ProgressHUDHandler dismissHUDWithCompletion:^{
                @strongify(self)
                RepairShopDetailVC *rsdvc = [[RepairShopDetailVC alloc] init];
                rsdvc.detailData = responseObject[CDZKeyOfResultKey];
                [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
                [[self navigationController] pushViewController:rsdvc animated:YES];
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }];
    
}


- (void)getShopDetailDatasWithSubscribeID:(NSString *)subscribeID withIndex:(NSIndexPath *)indexPath{
    if (!subscribeID) return;
    [[APIsConnection shareConnection] casesHistoryAPIsGetHistoryCasesOfCaseDetailWithSubscribeID:subscribeID  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return ;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
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
