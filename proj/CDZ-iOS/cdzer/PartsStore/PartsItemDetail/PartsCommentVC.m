//
//  PartsCommentVC.m
//  cdzer
//
//  Created by KEns0n on 9/25/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "PartsCommentVC.h"
#import "PartsCommentCell.h"
#import <ODRefreshControl/ODRefreshControl.h>
#import <MJRefresh/MJRefresh.h>

@interface PartsCommentVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) NSMutableArray *commentList;

@end

@implementation PartsCommentVC


- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户评论";
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getPartsCommentList:nil isAllReload:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)componentSetting {
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);
    self.commentList = [@[] mutableCopy];
}

- (void)setReactiveRules {

}

- (void)initializationUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame))];
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
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayHandleData:(id)refresh {
    
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        if ([(ODRefreshControl *)refresh refreshing]) {
            self.totalPageNum = @(0);
            self.pageNum = @(1);
            self.pageSize = @(10);
            [self getPartsCommentList:refresh isAllReload:YES];
        }
        
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]){
        if ([(MJRefreshAutoNormalFooter *)refresh isRefreshing]) {
            self.pageNum = @(self.pageNum.integerValue+1);
            [self getPartsCommentList:refresh isAllReload:NO];
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
    return _commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    PartsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[PartsCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell initializationUI];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    [cell updateUIDataWithData:_commentList[indexPath.row]];
    // Configure the cell...
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120.0f;
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
- (void)getPartsCommentList:(id)refreshView isAllReload:(BOOL)isAllReload {
    if (!self.partsID) {
        if (refreshView){
            [self stopRefresh:refreshView];
        }else {
             [ProgressHUDHandler showHUD];
        }
        return;
    }
    if (!refreshView) [ProgressHUDHandler showHUD];
    
    
    @weakify(self)
    [[APIsConnection shareConnection] autosPartsAPIsGetAutosPartsCommnetListWithProductID:self.partsID pageNums:_pageNum pageSize:_pageSize success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        if (isAllReload) [self.commentList removeAllObjects];
        [self.commentList addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
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
