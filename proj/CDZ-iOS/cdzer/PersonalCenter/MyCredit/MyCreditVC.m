//
//  MyCreditVC.m
//  cdzer
//
//  Created by KEns0n on 6/19/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MyCreditVC.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "InsetsLabel.h"
#import "MyCreditCell.h"

@interface MyCreditVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) NSNumber *totalCredits;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *creditList;

@property (nonatomic, strong) InsetsLabel *totalCreditsLabel;



@end

@implementation MyCreditVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"my_credit")];
    
    [self initializationUI];
    [self componentSetting];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserCreditListWithRefreshView:nil isAllReload:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    
//    self.editButtonItem.title = getLocalizationString(@"edit");
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);
    self.creditList = [NSMutableArray array];
}

- (void)initializationUI {
    @autoreleasepool {
        self.totalCreditsLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.bounds), 30.0f)
                                                 andEdgeInsetsValue:DefaultEdgeInsets];
        _totalCreditsLabel.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.00f];
        _totalCreditsLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14.0f, NO);
        [self.contentView addSubview:_totalCreditsLabel];
        
        NSMutableAttributedString* totalItemString = [NSMutableAttributedString new];
        [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:@"积分总数："
                                                 attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                              NSFontAttributeName:_totalCreditsLabel.font
                                                              }]];
        [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                                 initWithString:@"0"
                                                 attributes:@{NSForegroundColorAttributeName:CDZColorOfWeiboColor,
                                                              NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO)
                                                              }]];
        _totalCreditsLabel.attributedText = totalItemString;
        

        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_totalCreditsLabel.frame),
                                                                       CGRectGetWidth(self.contentView.frame),
                                                                       CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(_totalCreditsLabel.frame))];
        _tableView.backgroundColor = sCommonBGColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        _tableView.allowsMultipleSelection = YES;
        _tableView.allowsSelectionDuringEditing = NO;
        _tableView.allowsSelection = YES;
        [self.contentView addSubview:_tableView];
        
        ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableView];
        [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshView:)];
        _tableView.footer.automaticallyHidden = NO;
        _tableView.footer.hidden = YES;
        
//        self.creditDetailView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableView.frame), 90)];
//        _tableView.tableHeaderView = _creditDetailView;
//        
//        UIEdgeInsets insetsValue = DefaultEdgeInsets;
//        self.userRemainCredit = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
//                                                                              CGRectGetWidth(_creditDetailView.frame),
//                                                                              CGRectGetHeight(_creditDetailView.frame)/3.0f)
//                                                         andEdgeInsetsValue:insetsValue];
//        [_creditDetailView addSubview:_userRemainCredit];
//        
//        self.userStarCredit = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_userRemainCredit.frame),
//                                                                            CGRectGetWidth(_creditDetailView.frame),
//                                                                            CGRectGetHeight(_creditDetailView.frame)/3.0f)
//                                                         andEdgeInsetsValue:insetsValue];
//        [_creditDetailView addSubview:_userStarCredit];
//        
//        self.userUnknowCredit = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_userStarCredit.frame),
//                                                                              CGRectGetWidth(_creditDetailView.frame),
//                                                                              CGRectGetHeight(_creditDetailView.frame)/3.0f)
//                                                         andEdgeInsetsValue:insetsValue];
//        [_creditDetailView addSubview:_userUnknowCredit];
        
        
            }
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayHandleData:(id)refresh {
    
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        if ([(ODRefreshControl *)refresh refreshing]) {
            [self getUserCreditListWithRefreshView:refresh isAllReload:YES];
        }
        
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]){
        if ([(MJRefreshAutoNormalFooter *)refresh isRefreshing]) {
            //            self.pageNum = @(self.pageNum.integerValue+1);
            [self getUserCreditListWithRefreshView:refresh isAllReload:NO];
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

- (void)updateTotalCredit {
    
    NSMutableAttributedString* totalItemString = [NSMutableAttributedString new];
    [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:@"积分总数："
                                             attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                          NSFontAttributeName:_totalCreditsLabel.font
                                                          }]];
    [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:_totalCredits.stringValue
                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfWeiboColor,
                                                          NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO)
                                                          }]];
    
    _totalCreditsLabel.attributedText = totalItemString;
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _creditList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MyCreditCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyCreditCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), [MyCreditCell cellHeight])];
        [cell initializationUI];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    [cell updateUIData:_creditList[indexPath.row]];
    [cell setViewBorderWithRectBorder:UIRectBorderBottom borderSize:1.0 withColor:cell.getDefaultSeparatorLineDarkColor withBroderOffset:nil];
    // Configure the cell...
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [MyCreditCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Update the delete button's title based on how many items are selected.
  
    NSLog(@"%@",[tableView indexPathsForSelectedRows]);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Update the delete button's title based on how many items are selected.
    NSLog(@"%@",[tableView indexPathsForSelectedRows]);
}

#pragma mark- API Access Code Section
- (void)getUserCreditListWithRefreshView:(id)refreshView isAllReload:(BOOL)isAllReload {
    if (!self.accessToken) return;
    if (!refreshView) [ProgressHUDHandler showHUD];
    
    
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsGetCreditPointsHistoryWithAccessToken:self.accessToken pageNums:_pageNum pageSize:_pageSize success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(!refreshView){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refreshView];
        }
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if(errorCode!=0){
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        self.totalPageNum = @([responseObject[CDZKeyOfTotalPageSizeKey] integerValue]);
        self.pageNum = responseObject[CDZKeyOfPageNumKey];
        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
        self.tableView.footer.hidden = ((self.pageNum.intValue*self.pageSize.intValue)>self.totalPageNum.intValue);
        @strongify(self)
        if (isAllReload) [self.creditList removeAllObjects];
        NSDictionary* detailData = responseObject[CDZKeyOfResultKey];

        
        
        self.totalCredits = @([detailData[@"credits_all"] doubleValue]);
        [self updateTotalCredit];
        [self.creditList addObjectsFromArray:detailData[@"credits_list"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(!refreshView){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refreshView];
        }
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
