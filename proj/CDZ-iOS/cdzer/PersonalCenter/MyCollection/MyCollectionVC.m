//
//  MyCollectionVC.m
//  cdzer
//
//  Created by KEns0n on 3/28/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define defaultBtnTags 300
#define vStartSpace vAdjustByScreenRatio(10.0f)
#import "MyCollectionVC.h"
#import "InsetsLabel.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "MyCollectionProductCell.h"
#import "MyCollectionStoreCell.h"
#import "RepairShopDetailVC.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MyCollectionVC () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UIView *optionView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIButton *checkAllBtn;

@property (nonatomic, strong) UIView *bottmBtnsView;

@property (nonatomic, strong) InsetsLabel *remindView;

@property (nonatomic, strong) InsetsLabel *quantityLabel;

@property (nonatomic, assign) BOOL isTypeOfStore;

@property (nonatomic, strong) NSString *pageNum;

@property (nonatomic, strong) NSString *pageSize;

@property (nonatomic, strong) NSString *totalPageSize;

@end

@implementation MyCollectionVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [self setDataList:[NSMutableArray array]];
    [self setIsTypeOfStore:NO];
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"my_collection")];
    
    self.editButtonItem.title = getLocalizationString(@"edit");
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = nil;
    
    [self initializationUI];
    [self updateButtonsToMatchTableState];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_dataList) {
        [self setDataList:[NSMutableArray array]];
    }
    if (_dataList.count == 0) {
        [self getCollectedList:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializationUI {
    @autoreleasepool {
        
        CGRect optionViewRect = self.contentView.bounds;
        optionViewRect.size.height = vAdjustByScreenRatio(46.0f);
        
        [self setOptionView:[[UIView alloc] initWithFrame:optionViewRect]];
        [_optionView setBorderWithColor:nil borderWidth:(0.5f)];
        [_optionView setBackgroundColor:sCommonBGColor];
        [self.contentView addSubview:_optionView];
        
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        NSArray *titleArray = @[@"product", @"store"];
        CGFloat width = CGRectGetWidth(optionViewRect)/[titleArray count];
        [titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BOOL isFirstObj = (idx==0);
            CGRect btnRect = CGRectZero;
            btnRect.origin.x = width*idx;
            btnRect.size = CGSizeMake(width, CGRectGetHeight(optionViewRect));
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setFrame:btnRect];
            [btn setSelected:isFirstObj];
            [btn setUserInteractionEnabled:!isFirstObj];
            [btn setTag:defaultBtnTags+idx];
            [btn setTintColor:[UIColor clearColor]];
            [btn setTitle:getLocalizationString(obj) forState:UIControlStateNormal];
            [btn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.976f green:0.490f blue:0.184f alpha:1.00f] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorWithRed:0.976f green:0.490f blue:0.184f alpha:1.00f] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
            [btn addTarget:self action:@selector(optionActionWithBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:systemFont(18.0f)];
            [self.optionView addSubview:btn];
        }];
        
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect quantityRect = self.contentView.bounds;
        quantityRect.origin.y = CGRectGetMaxY(optionViewRect);
        quantityRect.size.height = vAdjustByScreenRatio(24.0f);
        
        [self setQuantityLabel:[[InsetsLabel alloc] initWithFrame:quantityRect andEdgeInsetsValue:UIEdgeInsetsMake(0.0f,  vAdjustByScreenRatio(14.0f), 0.0f, 0.0f)]];
        [self.contentView addSubview:_quantityLabel];
        
        CGRect tableViewRect = self.contentView.bounds;
        tableViewRect.origin.y = CGRectGetMaxY(quantityRect);
        tableViewRect.size.height -= CGRectGetMaxY(quantityRect);
        
        [self setTableView:[[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain]];
        [_tableView setBackgroundColor:sCommonBGColor];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setShowsHorizontalScrollIndicator:NO];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setBounces:YES];
        [_tableView setDelegate:self];
        [_tableView setAllowsMultipleSelectionDuringEditing:YES];
        [_tableView setAllowsMultipleSelection:NO];
        [_tableView setAllowsSelectionDuringEditing:YES];
        [_tableView setAllowsSelection:YES];
        [_tableView setDataSource:self];
        [self.contentView addSubview:_tableView];
        
        ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableView];
        [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
        
        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshView:)];
        _tableView.footer.automaticallyHidden = NO;
        _tableView.footer.hidden = YES;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect bottmViewRect = self.contentView.bounds;
        bottmViewRect.size.height = vAdjustByScreenRatio(40.0f);
        bottmViewRect.origin.y = CGRectGetHeight(self.contentView.bounds)-CGRectGetHeight(bottmViewRect);
        [self setBottmBtnsView:[[UIView alloc] initWithFrame:bottmViewRect]];
        [_bottmBtnsView setHidden:YES];
        [self.contentView addSubview:_bottmBtnsView];
        
        CGRect checkAllRect = _bottmBtnsView.bounds;
        checkAllRect.size.width = vAdjustByScreenRatio(80.0f);
        [self setCheckAllBtn:[UIButton buttonWithType:UIButtonTypeSystem]];
        [_checkAllBtn setFrame:checkAllRect];
        [_checkAllBtn setBackgroundColor:CDZColorOfDefaultColor];
        [_checkAllBtn setTintColor:CDZColorOfDefaultColor];
        [_checkAllBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_checkAllBtn setTitleColor:CDZColorOfWhite forState:UIControlStateSelected];
        [_checkAllBtn setTitle:getLocalizationString(@"check_all") forState:UIControlStateNormal];
        [_checkAllBtn setTitle:getLocalizationString(@"cancel_check_all") forState:UIControlStateSelected];
        [_checkAllBtn.titleLabel setFont:systemFontBold(16.0f)];
        [_checkAllBtn addTarget:self action:@selector(checkAllAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottmBtnsView addSubview:_checkAllBtn];
        
        CGRect deleteBtnRect = _bottmBtnsView.bounds;
        deleteBtnRect.origin.x = CGRectGetMaxX(checkAllRect);
        deleteBtnRect.size.width = CGRectGetWidth(self.contentView.frame)-CGRectGetMinX(deleteBtnRect);
        
        [self setDeleteBtn:[UIButton buttonWithType:UIButtonTypeSystem]];
        [_deleteBtn setFrame:deleteBtnRect];
        [_deleteBtn setBackgroundColor:CDZColorOfLightGray];
        [_deleteBtn setTitle:getLocalizationString(@"delete") forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:systemFontBold(16.0f)];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setEnabled:NO];
        [_bottmBtnsView addSubview:_deleteBtn];

        
        self.remindView = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_optionView.frame),
                                                                   CGRectGetWidth(self.contentView.frame),
                                                                   CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(_optionView.frame))
                                          andEdgeInsetsValue:DefaultEdgeInsets];
        _remindView.text = @"沒有更多收藏！";
        _remindView.hidden = YES;
        _remindView.userInteractionEnabled = YES;
        _remindView.backgroundColor = CDZColorOfWhite;
        _remindView.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_remindView];
    }
}

#pragma -mark Pirvate Function Section

- (void)clearPageRecord {
    
    self.pageSize = nil;
    self.pageNum = nil;
    self.totalPageSize = nil;
}

- (void)optionActionWithBtn:(UIButton *)button {
    for (int i=0; i<2; i++) {
        UIButton *btn = (UIButton*)[_optionView viewWithTag:defaultBtnTags+i];
        [btn setSelected:NO];
        [btn setUserInteractionEnabled:YES];
    }
    [button setSelected:YES];
    [button setUserInteractionEnabled:NO];
    [self clearPageRecord];
    self.isTypeOfStore = (button.tag == defaultBtnTags+1);
    [self getCollectedList:nil];
    
    
}

- (void)isNeedHiddenPageUpdateView {
    NSUInteger totalPage = _totalPageSize.integerValue;
    NSUInteger cPageSize = _pageSize.integerValue;
    NSUInteger cPageNum = _pageNum.integerValue;
    BOOL isHidden = (cPageNum*cPageSize>totalPage);
    _tableView.footer.hidden = isHidden;
}

// 处理资料更新
- (void)handleData:(id)refresh {
    [_tableView reloadData];
    if (refresh) {
        [refresh endRefreshing];
    }
    for (int i=0; i<2; i++) {
        UIButton *btn = (UIButton*)[_optionView viewWithTag:defaultBtnTags+i];
        [btn setEnabled:YES];
        if (_isTypeOfStore==i) {
            [btn setSelected:YES];
        }
    }
    [self updateButtonsToMatchTableState];
    [self isNeedHiddenPageUpdateView];
}

- (void)refreshView:(id)refresh {
    BOOL isRefreshing = NO;
    BOOL isFirstRequest = NO;
    for (int i=0; i<2; i++) {
        UIButton *btn = (UIButton*)[_optionView viewWithTag:defaultBtnTags+i];
        [btn setEnabled:NO];
        [btn setSelected:NO];
    }
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        isRefreshing = [(ODRefreshControl *)refresh refreshing];
        isFirstRequest = YES;
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
        isRefreshing = [(MJRefreshAutoNormalFooter *)refresh isRefreshing];
    }
    if (isRefreshing) {
        [self performSelector:@selector(delayRunData:) withObject:@[refresh,@(isFirstRequest)] afterDelay:2];
        
    }
}

- (void)delayRunData:(NSArray *)arguments {
    if ([[arguments objectAtIndex:1] boolValue]) {
        [self clearPageRecord];
    }
    if (_isTypeOfStore) {
        [self getCollectedStoreList:[arguments objectAtIndex:0] pageNum:self.pageNum pageSize:self.pageSize];
        
    }else{
        [self getCollectedProductList:[arguments objectAtIndex:0] pageNum:self.pageNum pageSize:self.pageSize];
    }
}

- (void)checkAllAction:(UIButton *)sender {
    for (int i = 0; i<[_dataList count]; i++) {
        if (sender.selected) {
            [_tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO];
        }else{
            [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
    
    [self updateButtonsToMatchTableState];
}

- (void)deleteAction:(id)sender {
    if (!self.tableView.editing)return;
    
    // Open a dialog with just an OK button.
    NSString *actionTitle;
    NSString *itemName = getLocalizationString(_isTypeOfStore?@"product":@"store");
    if (([[self.tableView indexPathsForSelectedRows] count] == [_dataList count] || [[self.tableView indexPathsForSelectedRows] count] == 0)) {
        actionTitle = [NSString stringWithFormat:getLocalizationString(@"delete_all_warning"),itemName];
    }
    else
    {
        actionTitle = [NSString stringWithFormat:getLocalizationString(@"delete_warning"),itemName];
    }
    
    NSString *cancelTitle = getLocalizationString(@"cancel");
    NSString *okTitle = getLocalizationString(@"ok");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle
                                                             delegate:nil
                                                    cancelButtonTitle:cancelTitle
                                               destructiveButtonTitle:okTitle
                                                    otherButtonTitles:nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    // Show from our table view (pops up in the middle of the table).
    [actionSheet showInView:self.view];
    [[actionSheet.rac_buttonClickedSignal filter:^BOOL(NSNumber *btnIdx) {
        // The user tapped one of the OK/Cancel buttons.
        return (btnIdx.integerValue == 0);
    }] subscribeNext:^(NSNumber *isConfirm) {
        if (isConfirm) {
            [self deleteCollectedList];
        }
    }];
}

- (void)executeDetele {
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    BOOL deleteSpecificRows = selectedRows.count > 0;
    if (deleteSpecificRows)
    {
        // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
        NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
        for (NSIndexPath *selectionIndex in selectedRows)
        {
            [indicesOfItemsToDelete addIndex:selectionIndex.row];
        }
        // Delete the objects from our data model.
        [self.dataList removeObjectsAtIndexes:indicesOfItemsToDelete];
        
        // Tell the tableView that we deleted the objects
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        // Delete everything, delete the objects from our data model.
        [self.dataList removeAllObjects];
        
        // Tell the tableView that we deleted the objects.
        // Because we are deleting all the rows, just reload the current table section
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    // Exit editing mode after the deletion.
    [self setEditing:NO animated:YES];
    [self updateButtonsToMatchTableState];
    [self updateDeleteButtonTitle];
    [self setTextOnQuantityLabel:@(_dataList.count).stringValue];
    
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isTypeOfStore) {
        static NSString *ident_store = @"store_cell";
        MyCollectionStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ident_store];
        if (!cell) {
            cell = [[MyCollectionStoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident_store];
            [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            [cell initializationUI];
            
        }
        
        [self startIconDownloadWith:cell forIndexPath:indexPath];
        [cell.typeLabel setText:[_dataList[indexPath.row] objectForKey:@"type_name"]];
        [cell.storeTitleLabel setText:[_dataList[indexPath.row] objectForKey:@"shop_name"]];
        [cell.starRatingView setValue:[[_dataList[indexPath.row] objectForKey:@"shop_good_number"] floatValue]];
        return cell;
    }
    
    
    
    
    // Configure the cell...
    static NSString *ident_product = @"product_cell";
    MyCollectionProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ident_product];
    if (!cell) {
        cell = [[MyCollectionProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident_product];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell initializationUI];
        
    }
    [self startIconDownloadWith:cell forIndexPath:indexPath];
    
    
    cell.productNameLabel.text = [_dataList[indexPath.row] objectForKey:@"goodsName"];
    
    cell.productPriceLabel.text = [_dataList[indexPath.row] objectForKey:@"goodsPrice"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return vAdjustByScreenRatio(100.0f);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Update the delete button's title based on how many items are selected.
    [self updateDeleteButtonTitle];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Update the delete button's title based on how many items are selected.
    if (tableView.editing) {
        [self updateButtonsToMatchTableState];
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        if (_isTypeOfStore) {
            [self getShopDetailDataWithShopID:[_dataList[indexPath.row] objectForKey:@"shop_id"]];
        }else {
            [self getPartsDetailDataWithPartsID:[_dataList[indexPath.row] objectForKey:@"id"]];
        }
    }
}

#pragma mark- Table cell image support
- (void)startIconDownloadWith:(id)cell forIndexPath:(NSIndexPath *)indexPath {
    if (!cell) {
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
    }
    
    if (_isTypeOfStore) {
        NSString *urlString = [_dataList[indexPath.row] objectForKey:@"shop_img"];
        [[(MyCollectionStoreCell *)cell logoImageView] sd_setImageWithURL:[NSURL URLWithString:urlString]
                                                         placeholderImage:[ImageHandler getDefaultWhiteLogo]];
    }else {
        
        NSString *urlString = [_dataList[indexPath.row] objectForKey:@"goodsImg"];
        [[(MyCollectionProductCell *)cell productPortraitIV] sd_setImageWithURL:[NSURL URLWithString:urlString]
                                                               placeholderImage:[ImageHandler getDefaultWhiteLogo]];
    }
}

#pragma -mark Updating button state
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // Make sure you call super first
    [super setEditing:editing animated:animated];
    editing = !self.tableView.editing;
    if (editing)
    {
        self.editButtonItem.title = getLocalizationString(@"cancel");
        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableView.frame), vAdjustByScreenRatio(40.0f))]];
        [_deleteBtn setBackgroundColor:CDZColorOfLightGray];
        [_deleteBtn setEnabled:NO];
    }
    else
    {
        self.editButtonItem.title = getLocalizationString(@"edit");
        [self.tableView setTableFooterView:nil];
    }
    [self.bottmBtnsView setHidden:!editing];
    [self.tableView setBounces:!editing];
    if (editing) {
         self.tableView.footer.hidden = editing;
    }else {
        [self isNeedHiddenPageUpdateView];
    }
    
    [self.tableView setEditing:editing animated:animated];
    for (int i=0; i<2; i++) {
        UIButton *btn = (UIButton*)[_optionView viewWithTag:defaultBtnTags+i];
        [btn setEnabled:!editing];
        if (_isTypeOfStore==i) {
            [btn setSelected:!editing];
        }
    }
    [self updateDeleteButtonTitle];

}

- (void)updateButtonsToMatchTableState {
    if (self.tableView.editing)
    {
        
        [self updateDeleteButtonTitle];
        
    }
    else
    {
        // Not in editing mode.
        
        // Show the edit button, but disable the edit button if there's nothing to edit.
        if (self.dataList.count > 0)
        {
            self.editButtonItem.enabled = YES;
        }
        else
        {
            self.editButtonItem.enabled = NO;
        }
        
    }
}

- (void)updateDeleteButtonTitle {
    // Update the delete button's title, based on how many items are selected
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    
    BOOL allItemsAreSelected = selectedRows.count == self.dataList.count;
    BOOL noItemsAreSelected = selectedRows.count == 0;
    NSString *titleString = nil;
    if (noItemsAreSelected)
    {
        titleString = getLocalizationString(@"delete");
    }else {
        NSString *titleFormatString = [getLocalizationString(@"delete") stringByAppendingString:@" (%d)"];
        titleString = allItemsAreSelected?getLocalizationString(@"delete_all"):[NSString stringWithFormat:titleFormatString, selectedRows.count];
    }
    
    
    [_deleteBtn setBackgroundColor:noItemsAreSelected?CDZColorOfLightGray:CDZColorOfRed];
    [_deleteBtn setEnabled:!noItemsAreSelected];
    [_deleteBtn setTitle:titleString forState:UIControlStateNormal];
    
    [_checkAllBtn setSelected:allItemsAreSelected];
    
}

#pragma -mark Updating Page state

- (void)setTextOnQuantityLabel:(NSString *)quantity {
    NSMutableAttributedString* message = [NSMutableAttributedString new];
    UIFont *font = [UIFont systemFontOfSize:vAdjustByScreenRatio(15.0f)];
    [message appendAttributedString:[[NSAttributedString alloc]
                                     initWithString:getLocalizationString(@"title_head_caption")
                                     attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                  NSFontAttributeName:font
                                                  }]];
    [message appendAttributedString:[[NSAttributedString alloc]
                                     initWithString:quantity
                                     attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                  NSFontAttributeName:font
                                                  }]];
    
    [message appendAttributedString:[[NSAttributedString alloc]
                                     initWithString:getLocalizationString(_isTypeOfStore?@"store_tail_caption":@"product_tail_caption")
                                     attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                  NSFontAttributeName:font
                                                  }]];
    [_quantityLabel setAttributedText:message];
}

- (void)updatePageStateWithPageNum:(NSString *)pageNum pageSize:(NSString *)pageSize totalPageSize:(NSString *)totalPageSize {
    if (totalPageSize) {
        self.totalPageSize = totalPageSize;
        [self setTextOnQuantityLabel:totalPageSize];
    }
    if (pageNum) {
        self.pageNum = pageNum;
    }
    if (pageSize) {
        self.pageSize = pageSize;
    }
}

#pragma -mark Collection List Request functions
- (void)getCollectedList:(id)refresh{
    if(self.isTypeOfStore){
        [self getCollectedStoreList:refresh pageNum:self.pageNum pageSize:self.pageSize];
    }else {
        [self getCollectedProductList:refresh pageNum:self.pageNum pageSize:self.pageSize];
    }
}

// 请求货品收藏列表
- (void)getCollectedProductList:(id)refresh pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize {
    if (!self.accessToken)return;
    if (!refresh) {
        [ProgressHUDHandler showHUD];
    }
    _remindView.hidden = YES;
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
    NSLog(@"%@ accessing network product list request",NSStringFromClass(self.class));
    [[APIsConnection shareConnection] personalCenterAPIsGetProductsCollectionListWithAccessToken:self.accessToken
                                                                                        pageNums:pageNum
                                                                                        pageSize:pageSize
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL isFirstRequest = (!pageSize&&!pageNum);
        operation.userInfo = @{@"isFirstRequest":@(isFirstRequest)};
      [self requestResultHandle:operation responseObject:responseObject withError:nil withRefresh:refresh];
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      [self requestResultHandle:operation responseObject:nil withError:error withRefresh:refresh];
    }];
}

// 请求商店收藏列表
- (void)getCollectedStoreList:(id)refresh pageNum:(NSString *)pageNum pageSize:(NSString *)pageSize {
    if (!self.accessToken)return;
    if (!refresh) {
        [ProgressHUDHandler showHUD];
    }
    _remindView.hidden = YES;
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
    NSLog(@"%@ accessing network store list request",NSStringFromClass(self.class));
    [[APIsConnection shareConnection] personalCenterAPIsGetShopsCollectionListWithAccessToken:self.accessToken
                                                                                     pageNums:pageNum
                                                                                     pageSize:pageSize
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
      BOOL isFirstRequest = (!pageSize&&!pageNum);
      operation.userInfo = @{@"isFirstRequest":@(isFirstRequest)};
      [self requestResultHandle:operation responseObject:responseObject withError:nil withRefresh:refresh];
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      [self requestResultHandle:operation responseObject:nil withError:error withRefresh:refresh];
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error withRefresh:(id)refresh {
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }else if (!error&&responseObject) {
        
        if ([APIsErrorHandler isTokenErrorWithResponseObject:responseObject]) {
            [self setAccessToken:nil];
            return;
        }
        
        [ProgressHUDHandler dismissHUD];
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        BOOL isNoData = [message isEqualToString:@"没有数据"];
        if (errorCode!=0&&!isNoData) {
            NSLog(@"%@",message);
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        
        BOOL isFirstRequest = [[operation.userInfo objectForKey:@"isFirstRequest"] boolValue];
        if (isFirstRequest) {
            [_dataList removeAllObjects];
            
            if (isNoData) {
                
                [self updatePageStateWithPageNum:@"1"
                                        pageSize:@"10"
                                   totalPageSize:@"0"];
            }else {
                
                [self updatePageStateWithPageNum:[responseObject objectForKey:CDZKeyOfPageNumKey]
                                        pageSize:[responseObject objectForKey:CDZKeyOfPageSizeKey]
                                   totalPageSize:[responseObject objectForKey:CDZKeyOfTotalPageSizeKey]];
            }
        }
        if (isNoData) {
            [_dataList removeAllObjects];
        }else {
            [_dataList addObjectsFromArray:[responseObject objectForKey:CDZKeyOfResultKey]];
        }
        
        _remindView.hidden = !(_dataList.count==0);
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [self handleData:refresh];
        [ProgressHUDHandler dismissHUD];
    }
    
}

//删除收藏
- (void)deleteCollectedList{
    if (!self.accessToken)return;
    [ProgressHUDHandler showHUD];
    NSLog(@"%@ accessing network delete collection request",NSStringFromClass(self.class));
    NSMutableArray *colloectList = [NSMutableArray array];
    [[_tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *addressID = [[self.dataList objectAtIndex:[(NSIndexPath *)obj row]] objectForKey:@"id"];
        [colloectList addObject:addressID];
    }];
    if (colloectList.count==0||!self.accessToken) return;
    if (self.isTypeOfStore) {
        [[APIsConnection shareConnection] personalCenterAPIsPostDeleteShopCollectionWithAccessToken:self.accessToken
                                                                                   collectionIDList:colloectList
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self deleteRequestResultHandle:operation responseObject:responseObject withError:nil];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self deleteRequestResultHandle:operation responseObject:nil withError:error];
        }];
    }else {
        [[APIsConnection shareConnection] personalCenterAPIsPostDeleteProductsCollectionWithAccessToken:self.accessToken
                                                                                       collectionIDList:colloectList
        success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self deleteRequestResultHandle:operation responseObject:responseObject withError:nil];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self deleteRequestResultHandle:operation responseObject:nil withError:error];
        }];
    }
}

- (void)deleteRequestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }else if (!error&&responseObject) {
        
        if ([APIsErrorHandler isTokenErrorWithResponseObject:responseObject]) {
            [self setAccessToken:nil];
            return;
        }
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        switch (errorCode) {
            case 0:
                [self executeDetele];
                [ProgressHUDHandler dismissHUD];
                break;
            case 1:
            case 2:{
                [ProgressHUDHandler dismissHUD];
                NSLog(@"%@",message);
                [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                    
                }];
            }
                break;
                
            default:
                break;
        }
    }
    
}

//请求商店详情
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
//请求配件详情
- (void)getPartsDetailDataWithPartsID:(NSString *)partsID {
    if (!partsID) return;
    [[APIsConnection shareConnection] autosPartsAPIsGetPartsDetailWithLastLevelID:partsID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        RepairShopDetailVC *rsdvc = [[RepairShopDetailVC alloc] init];
        rsdvc.detailData = responseObject[CDZKeyOfResultKey];
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [[self navigationController] pushViewController:rsdvc animated:YES];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }];
}

@end
