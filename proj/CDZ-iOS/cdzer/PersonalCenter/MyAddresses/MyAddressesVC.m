//
//  MyAddressesVC.m
//  cdzer
//
//  Created by KEns0n on 4/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MyAddressesVC.h"
#import "MyAddressesTVCell.h"
#import "MyAddressEditWithInsertVC.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "AddressDTO.h"

@interface MyAddressesVC ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIButton *addRowBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, strong) UIButton *checkAllBtn;

@property (nonatomic, strong) UIView *bottmBtnsView;

@property (nonatomic) AFHTTPRequestOperation *request;

@property (nonatomic, strong) NSIndexPath *indexPathForSelectedRow;

@end

@implementation MyAddressesVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isForSelection) {
        [self setRightNavButtonWithTitleOrImage:@"ok" style:UIBarButtonItemStyleDone target:self action:@selector(confirmAddressSelection) titleColor:nil isNeedToSet:YES];
        
    }else{
        self.editButtonItem.title = getLocalizationString(@"edit");
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    [self setDataList:[NSMutableArray array]];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"my_address")];
    [self initializationUI];
    [self setReactiveRules];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserAddressList:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 初始化UI
- (void)initializationUI {
    @autoreleasepool {
        
        CGRect tableViewRect = self.contentView.bounds;
        
        self.tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
        _tableView.editing = _isForSelection;
        [_tableView setBackgroundColor:sCommonBGColor];
        [_tableView setShowsHorizontalScrollIndicator:NO];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setBounces:!_isForSelection];
        [_tableView setAllowsMultipleSelectionDuringEditing:YES];
        [_tableView setAllowsMultipleSelection:NO];
        [_tableView setAllowsSelectionDuringEditing:YES];
        [_tableView setAllowsSelection:YES];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [self.contentView addSubview:_tableView];
        
        if (!_isForSelection) {
            ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableView];
            [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
        }
        
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableView.bounds), 60.0f)];
        [_headerView setBackgroundColor:sCommonBGColor];
        [_tableView setTableHeaderView:_headerView];
        
        self.addRowBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_addRowBtn setFrame:_headerView.bounds];
        [_addRowBtn setTitle:getLocalizationString(@"add_new_address") forState:UIControlStateNormal];
        [_addRowBtn setTintColor:CDZColorOfDefaultColor];
        [_addRowBtn setContentEdgeInsets:UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 0.0f)];
        [_addRowBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_addRowBtn addTarget:self action:@selector(addNewAddress) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:_addRowBtn];
        
        
        if (_isForSelection) return;
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
        [_deleteBtn addTarget:self action:@selector(deleteActionConfirm:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setEnabled:NO];
        [_bottmBtnsView addSubview:_deleteBtn];
        
    
    }
}
// 增加地址
- (void)addNewAddress {
    @autoreleasepool {
        MyAddressEditWithInsertVC *vc = [[MyAddressEditWithInsertVC alloc] initWithDisplayMode:MyAddressDisplayTypeOfInsert withAddressData:nil];
        [self setNavBarBackButtonTitleOrImage:getLocalizationString(@"cancel") titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)viewDetailAddress:(AddressDTO *)addressDTO {
    @autoreleasepool {
        if (!addressDTO) {
            return;
        }
        MyAddressEditWithInsertVC *vc = [[MyAddressEditWithInsertVC alloc] initWithDisplayMode:MyAddressDisplayTypeOfNormal withAddressData:addressDTO];
        [self setNavBarBackButtonTitleOrImage:getLocalizationString(@"cancel") titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)setReactiveRules {
    if (_isForSelection) {
        [RACObserve(self, indexPathForSelectedRow) subscribeNext:^(NSIndexPath *indexPath) {
            BOOL isReady = !!indexPath;
            self.navigationItem.rightBarButtonItem.enabled = isReady;
        }];
    }
}

- (void)confirmAddressSelection {
    AddressDTO *dto = _dataList[_tableView.indexPathForSelectedRow.row];
    
    if (!DBHandler.shareInstance.getUserDefaultAddress) {
        BOOL isSuccess = NO;
        if (dto) {
            isSuccess = [[DBHandler shareInstance] updateUserDefaultAddress:dto];
        }
        NSLog(@"success insert default address at %@:::::::::: %d", NSStringFromClass(self.class), isSuccess);
    }
    
    [NSNotificationCenter.defaultCenter postNotificationName:CDZNotiKeyOfSelectedAddress object:dto];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark Pirvate Function Section

// 处理资料更新
- (void)handleData:(id)refresh {
    if (refresh) {
        [refresh endRefreshing];
    }
    [_tableView reloadData];
    [self updateButtonsToMatchTableState];
}

- (void)refreshView:(id)refresh {
    BOOL isRefreshing = NO;
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        isRefreshing = [(ODRefreshControl *)refresh refreshing];
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
        isRefreshing = [(MJRefreshAutoNormalFooter *)refresh isRefreshing];
    }
    if (isRefreshing) {
        [self performSelector:@selector(getUserAddressList:) withObject:refresh afterDelay:1.5];
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

- (void)deleteActionConfirm:(id)sender {
    if (!self.tableView.editing)return;
    
    // Open a dialog with just an OK button.
    NSString *actionTitle;
    if (([[self.tableView indexPathsForSelectedRows] count] == [_dataList count] || [[self.tableView indexPathsForSelectedRows] count] == 0)) {
        actionTitle = getLocalizationString(@"delete_all_adr_warning");
    }
    else
    {
        actionTitle = getLocalizationString(@"delete_adr_warning");
    }
    
    NSString *cancelTitle = getLocalizationString(@"cancel");
    NSString *okTitle = getLocalizationString(@"ok");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle
                                                             delegate:self
                                                    cancelButtonTitle:cancelTitle
                                               destructiveButtonTitle:okTitle
                                                    otherButtonTitles:nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    // Show from our table view (pops up in the middle of the table).
    [actionSheet showInView:self.view];
}

- (void)executeDeleteAction {
    // Delete what the user selected.
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
        [_dataList removeObjectsAtIndexes:indicesOfItemsToDelete];
        
        // Tell the tableView that we deleted the objects
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        // Delete everything, delete the objects from our data model.
        [_dataList removeAllObjects];
        
        // Tell the tableView that we deleted the objects.
        // Because we are deleting all the rows, just reload the current table section
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    // Exit editing mode after the deletion.
    [self setEditing:NO animated:YES];
    [self updateButtonsToMatchTableState];
    [self updateDeleteButtonTitle];
}

#pragma -mark UIActionSheetDelgate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // The user tapped one of the OK/Cancel buttons.
    if (buttonIndex == 0)
    {
        [self deleteUserAddressList];
    }
}

/*
#pragma mark- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma -mark Address List Request functions
// 请求地址列表
- (void)getUserAddressList:(id)refresh {
    if (!self.accessToken)return;
    if (!refresh) {
        [ProgressHUDHandler showHUD];
    }
    [_tableView setDelegate:nil];
    [_tableView setDataSource:nil];
    NSLog(@"%@ accessing network request",NSStringFromClass(self.class));
    [[APIsConnection shareConnection] personalCenterAPIsGetShippingAddressListWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil isDeletAddress:NO withRefresh:refresh];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error isDeletAddress:NO withRefresh:refresh];
    }];
}

// 删除地址
- (void)deleteUserAddressList {
    if (!self.accessToken)return;
    [ProgressHUDHandler showHUD];
    NSLog(@"%@ delete address accessing network request",NSStringFromClass(self.class));
    NSMutableArray *addressList = [NSMutableArray array];
    @autoreleasepool {
        
        [[_tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            AddressDTO *dto = self.dataList[[(NSIndexPath *)obj row]];
            NSString *addressID = dto.addressID;
            [addressList addObject:addressID];
        }];
    }
    [[APIsConnection shareConnection] personalCenterAPIsPostDeleteShippingAddressWithAccessToken:self.accessToken addressIDList:addressList success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil isDeletAddress:YES withRefresh:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error isDeletAddress:YES withRefresh:nil];
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error
             isDeletAddress:(BOOL)isDelete withRefresh:(id)refresh {
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }else if (!error&&responseObject) {
        
        if ([APIsErrorHandler isTokenErrorWithResponseObject:responseObject]) {
            [ProgressHUDHandler dismissHUD];
            [self setAccessToken:nil];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode==2) {
            [ProgressHUDHandler dismissHUD];
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            NSLog(@"%@",message);
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        NSArray *array = [AddressDTO handleDataListToDTOList:[responseObject objectForKey:CDZKeyOfResultKey]];
        
        if (isDelete) {
            [ProgressHUDHandler showSuccessWithStatus:getLocalizationString(@"success_delete") onView:nil completion:^{
                [self executeDeleteAction];
            }];
        }else {
            [_dataList removeAllObjects];
            [_dataList addObjectsFromArray:array];
            [_tableView setDelegate:self];
            [_tableView setDataSource:self];
            [self handleData:refresh];
            [ProgressHUDHandler dismissHUD];
        }
    }
    
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
    static NSString *ident = @"cell";
    MyAddressesTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyAddressesTVCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell initializationUI];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    @autoreleasepool {
        if (_dataList||[_dataList count]>0) {
            AddressDTO *dto = _dataList[indexPath.row];
            cell.provinceString = dto.provinceName;
            cell.cityString = dto.cityName;
            cell.districtString = dto.regionName;
            cell.addressString = dto.address;
            cell.userNameString = dto.consigneeName;
            cell.phoneNumberString = dto.telNumber;
//            cell.postNumberString = @"";
            
            if (_isForSelection) {
                if (_selectedDTO.addressID&&[_selectedDTO.addressID isEqualToString:dto.addressID]) {
                    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
                    self.indexPathForSelectedRow = indexPath;
                }
            }else {
                [cell.contentView setViewBorderWithRectBorder:UIRectBorderAllBorderEdge borderSize:0.0f withColor:CDZColorOfClearColor withBroderOffset:nil];
                AddressDTO *defaultDto = [[DBHandler shareInstance] getUserDefaultAddress];
                if (defaultDto.addressID&&[defaultDto.addressID isEqualToString:dto.addressID]) {
                    [cell.contentView setViewBorderWithRectBorder:UIRectBorderAllBorderEdge borderSize:3.0f withColor:CDZColorOfDefaultColor withBroderOffset:nil];
                }
            }
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90.0f;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Update the delete button's title based on how many items are selected.
    [self updateDeleteButtonTitle];
    if (_isForSelection) {
        self.indexPathForSelectedRow = nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Update the delete button's title based on how many items are selected.
    [self updateButtonsToMatchTableState];
    
    if (!tableView.isEditing) {
        [self viewDetailAddress:[_dataList objectAtIndex:indexPath.row]];
    }
    if (_isForSelection) {
        [tableView.indexPathsForSelectedRows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![indexPath isEqual:obj]) {
                [tableView deselectRowAtIndexPath:obj animated:NO];
            }
        }];
        self.indexPathForSelectedRow = tableView.indexPathForSelectedRow;
    }
}

#pragma mark- Updating button state
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // Make sure you call super first
    [super setEditing:editing animated:animated];
    editing = !self.tableView.editing;
    if (editing)
    {
        @autoreleasepool {
            UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableView.frame), vAdjustByScreenRatio(50.f))];
            [tmpView setBackgroundColor:CDZColorOfWhite];
            self.editButtonItem.title = getLocalizationString(@"cancel");
            self.tableView.tableFooterView = tmpView;
            [_deleteBtn setBackgroundColor:CDZColorOfLightGray];
            [_deleteBtn setEnabled:NO];
        }
    }
    else
    {
        self.editButtonItem.title = getLocalizationString(@"edit");
        self.tableView.tableFooterView = nil;
    }
    self.tableView.tableHeaderView = editing?nil:_headerView;
    self.bottmBtnsView.hidden = !editing;
    self.tableView.bounces = !editing;
//    self.tableView.footer.hidden = editing;
    [self.tableView setEditing:editing animated:animated];
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
        if (_dataList.count > 0)
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
    
    BOOL allItemsAreSelected = selectedRows.count == _dataList.count;
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

@end
