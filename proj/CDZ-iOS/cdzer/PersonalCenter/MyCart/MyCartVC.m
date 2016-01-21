//
//  MyCollectionVC.m
//  cdzer
//
//  Created by KEns0n on 3/28/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define defaultBtnTags 300
#define vStartSpace vAdjustByScreenRatio(10.0f)
#import "MyCartVC.h"
#import "InsetsLabel.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "MyCartProductCell.h"
#import "CheckBoxBtn.h"
#import "PartsItemDetailVC.h"
#import "MyCartSubmitConfirmVC.h"

@interface MyCartVC () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *cartList;

@property (nonatomic, strong) NSArray *indexPathsForSelectedRows;

@property (nonatomic, strong) NSNumber *totalPageNum;
@property (nonatomic, strong) NSNumber *pageNum;
@property (nonatomic, strong) NSNumber *pageSize;


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) UIButton *selectAllBtn;
@property (nonatomic, strong) UIView *bottomDetailView;

@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIButton *checkAll4DeleteBtn;
@property (nonatomic, strong) UIView *bottomBtnsView;

@property (nonatomic, strong) InsetsLabel *quantityLabel;

@property (nonatomic, assign) BOOL isEditingMode;

@property (nonatomic, strong) CheckBoxBtn *cbBtn;

@property (nonatomic, strong) UIControl *reminderView;

@property (nonatomic, strong) InsetsLabel *reminderLabel;

@property (nonatomic, strong) InsetsLabel *totalPriceLabel;

@property (nonatomic, assign) BOOL needReload;

@end

@implementation MyCartVC


- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [self setIsEditingMode:NO];
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    self.cartList = [NSMutableArray array];
    [self setTitle:getLocalizationString(@"my_cart_vc")];
    
    self.editButtonItem.title = getLocalizationString(@"edit");
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = nil;
    if (_popBackRootVC) {
        // 设置返回按钮的文本
        UIImage *image = [UIImage imageNamed:@"Icon-Back"];
        NSString *title = getLocalizationString(@"back");
        UIFont *font = systemFontWithoutRatio(16.0f);
        CGSize titleSize = [SupportingClass getStringSizeWithString:title font:font widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        CGRect frame = CGRectZero;
        frame.size.width = titleSize.width+image.size.width;
        frame.size.height = image.size.height;
        if (titleSize.height>image.size.height) frame.size.height = titleSize.height;
        
        UIButton *button =  [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = frame;
        button.titleLabel.font = font;
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(backToRootVC) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:image forState:UIControlStateNormal];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backButton;
//        button.titleEdgeInsets = UIEdgeInsetsMake(-2, -20, 2, 20);
        button.imageEdgeInsets = UIEdgeInsetsMake(1.0f, -12.0f, 0.0f, 0.0f);
    }
    
    [self initializationUI];
//    [self componentSetting];
    [self setReactiveRules];
    [self updateButtonsToMatchTableState];
    // Do any additional setup after loading the view.
}

- (void)backToRootVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_cartList.count==0||_needReload) {
        [self getCartListWithRefreshView:nil isAllReload:YES];
        self.needReload = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, indexPathsForSelectedRows) subscribeNext:^(NSArray *indexPathsForSelectedRows) {
        @strongify(self);
        self.totalPriceLabel.text = @"合计：¥0.00\n不含运费";
        if (indexPathsForSelectedRows&&indexPathsForSelectedRows.count>0) {
            __block double totalPrice = 0.00f;
            [indexPathsForSelectedRows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSDictionary *data = self.cartList[[(NSIndexPath *)obj row]];
                totalPrice += [data[@"subTotal"] doubleValue];
            }];
            self.totalPriceLabel.text = [NSString stringWithFormat:@"合计：¥%.02f\n不含运费",totalPrice];
        }
    }];
    
    [RACObserve(self, cartList) subscribeNext:^(NSArray *cartList) {
        @strongify(self);
        NSMutableAttributedString *textString = [NSMutableAttributedString new];
        [textString appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:@"你的购物车里面共有"
                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                         NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO)}]];
        [textString appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:@(cartList.count).stringValue
                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                         NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO)}]];
        [textString appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:@"件商品"
                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                         NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO)}]];
        
        self.quantityLabel.attributedText = textString;
        
        self.reminderView.hidden = (cartList.count!=0);
    }];
}

- (void)componentSetting {
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);
    self.needReload = NO;
}

- (void)initializationUI {
    @autoreleasepool {
 
        CGRect quantityRect = self.contentView.bounds;
        quantityRect.size.height = vAdjustByScreenRatio(24.0f);
        
        self.quantityLabel = [[InsetsLabel alloc] initWithFrame:quantityRect andEdgeInsetsValue:UIEdgeInsetsMake(0.0f,  vAdjustByScreenRatio(14.0f), 0.0f, 0.0f)];
        
        NSMutableAttributedString *textString = [NSMutableAttributedString new];
        [textString appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:@"你的购物车里面共有"
                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                         NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO)}]];
        [textString appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:@"0"
                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                         NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO)}]];
        [textString appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:@"件商品"
                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                         NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO)}]];
        _quantityLabel.attributedText = textString;
        [self.contentView addSubview:_quantityLabel];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
        CGRect bottmViewRect = self.contentView.bounds;
        bottmViewRect.size.height = vAdjustByScreenRatio(50.0f);
        bottmViewRect.origin.y = CGRectGetHeight(self.contentView.bounds)-CGRectGetHeight(bottmViewRect);
        self.bottomDetailView = [[UIView alloc] initWithFrame:bottmViewRect];
        [self.contentView addSubview:_bottomDetailView];
        
        CGRect selectAllRect = _bottomDetailView.bounds;
        selectAllRect.size.width = vAdjustByScreenRatio(80.0f);
        self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_selectAllBtn setFrame:selectAllRect];
        [_selectAllBtn setBackgroundColor:CDZColorOfDefaultColor];
        [_selectAllBtn setTintColor:CDZColorOfDefaultColor];
        [_selectAllBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_selectAllBtn setTitleColor:CDZColorOfWhite forState:UIControlStateSelected];
        [_selectAllBtn setTitle:getLocalizationString(@"check_all") forState:UIControlStateNormal];
        [_selectAllBtn setTitle:getLocalizationString(@"cancel_check_all") forState:UIControlStateSelected];
        [_selectAllBtn.titleLabel setFont:systemFontBold(16.0f)];
        [_selectAllBtn addTarget:self action:@selector(checkAllAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomDetailView addSubview:_selectAllBtn];
        
        CGRect submitBtnRect = _bottomDetailView.bounds;
        submitBtnRect.size.width = vAdjustByScreenRatio(100.0f);
        submitBtnRect.origin.x = CGRectGetWidth(bottmViewRect)-CGRectGetWidth(submitBtnRect);
        
        self.submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_submitBtn setFrame:submitBtnRect];
        [_submitBtn setBackgroundColor:CDZColorOfRed];
        [_submitBtn setTitle:getLocalizationString(@"submit_order") forState:UIControlStateNormal];
        [_submitBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_submitBtn.titleLabel setFont:systemFontBold(16.0f)];
        [_submitBtn setBackgroundColor:CDZColorOfLightGray];
        [_submitBtn addTarget:self action:@selector(confirmCartOrder) forControlEvents:UIControlEventTouchUpInside];
        [_bottomDetailView addSubview:_submitBtn];
        
        
        UIEdgeInsets priceInsets = UIEdgeInsetsMake(0.0f, CGRectGetWidth(_selectAllBtn.frame)+6.0f, 0.0f, CGRectGetWidth(_submitBtn.frame)+6.0f);
        self.totalPriceLabel = [[InsetsLabel alloc] initWithFrame:_bottomDetailView.bounds andEdgeInsetsValue:priceInsets];
        _totalPriceLabel.text = @"合计：¥0.00\n不含运费";
        _totalPriceLabel.numberOfLines = 0;
        _totalPriceLabel.font = systemFontWithoutRatio(15.0f);
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
        _totalPriceLabel.textColor = CDZColorOfRed;
        [_bottomDetailView addSubview:_totalPriceLabel];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        
        CGRect tableViewRect = self.contentView.bounds;
        tableViewRect.origin.y = CGRectGetMaxY(quantityRect);
        tableViewRect.size.height -= (CGRectGetMaxY(quantityRect)+CGRectGetHeight(_bottomDetailView.frame));
        
        self.tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
        [_tableView setBackgroundColor:sCommonBGColor];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setShowsHorizontalScrollIndicator:NO];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setBounces:YES];
        [_tableView setDelegate:self];
        [_tableView setAllowsMultipleSelectionDuringEditing:NO];
        [_tableView setAllowsMultipleSelection:YES];
        [_tableView setAllowsSelectionDuringEditing:NO];
        [_tableView setAllowsSelection:YES];
        [_tableView setDataSource:self];
        [self.contentView addSubview:_tableView];
        
        ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableView];
        [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];

//        _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshView:)];
//        _tableView.footer.automaticallyHidden = NO;


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        self.bottomBtnsView = [[UIView alloc] initWithFrame:bottmViewRect];
        [_bottomBtnsView setHidden:YES];
        [self.contentView addSubview:_bottomBtnsView];
        
        CGRect checkAllRect = _bottomBtnsView.bounds;
        checkAllRect.size.width = vAdjustByScreenRatio(80.0f);
        [self setCheckAll4DeleteBtn:[UIButton buttonWithType:UIButtonTypeSystem]];
        [_checkAll4DeleteBtn setFrame:checkAllRect];
        [_checkAll4DeleteBtn setBackgroundColor:CDZColorOfDefaultColor];
        [_checkAll4DeleteBtn setTintColor:CDZColorOfDefaultColor];
        [_checkAll4DeleteBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_checkAll4DeleteBtn setTitleColor:CDZColorOfWhite forState:UIControlStateSelected];
        [_checkAll4DeleteBtn setTitle:getLocalizationString(@"check_all") forState:UIControlStateNormal];
        [_checkAll4DeleteBtn setTitle:getLocalizationString(@"cancel_check_all") forState:UIControlStateSelected];
        [_checkAll4DeleteBtn.titleLabel setFont:systemFontBold(16.0f)];
        [_checkAll4DeleteBtn addTarget:self action:@selector(checkAllAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomBtnsView addSubview:_checkAll4DeleteBtn];
        
        CGRect deleteBtnRect = _bottomBtnsView.bounds;
        deleteBtnRect.origin.x = CGRectGetMaxX(checkAllRect);
        deleteBtnRect.size.width = CGRectGetWidth(self.contentView.frame)-CGRectGetMinX(deleteBtnRect);
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_deleteBtn setFrame:deleteBtnRect];
        [_deleteBtn setBackgroundColor:CDZColorOfLightGray];
        [_deleteBtn setTitle:getLocalizationString(@"delete") forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_deleteBtn.titleLabel setFont:systemFontBold(16.0f)];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setEnabled:NO];
        [_bottomBtnsView addSubview:_deleteBtn];

        self.reminderView = [[UIControl alloc] initWithFrame:self.contentView.bounds];
        _reminderView.hidden = YES;
        _reminderView.backgroundColor = CDZColorOfWhite;
//        [_reminderView addTarget:self action:@selector(reloadDataForReminderView) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_reminderView];
        
        self.reminderLabel = [[InsetsLabel alloc] initWithFrame:_reminderView.bounds];
        _reminderLabel.text = @"购物车里面空空如也！\n请到配件商店购买配件。";//\n或点击此处重新加载！";
        _reminderLabel.numberOfLines = 0;
        _reminderLabel.textAlignment = NSTextAlignmentCenter;
        [_reminderView addSubview:_reminderLabel];
        
    }
}

- (void)getCellResponse:(NSIndexPath *)indexPath {
    NSLog(@"%@___Next Page Index",indexPath);
    [self getPartsDetailWithPartsID:[_cartList[indexPath.row] objectForKey:@"productId"]];
}

- (void)pushPartItemDetailViewWithItemDetail:(id)detail {
    if (!detail||![detail isKindOfClass:[NSDictionary class]]) {
        return;
    }
    @autoreleasepool {
        PartsItemDetailVC *vc = [PartsItemDetailVC new];
        vc.itemDetail = detail;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)reloadDataForReminderView {
    [self getCartListWithRefreshView:nil isAllReload:YES];
}

- (void)checkAllAction:(UIButton *)sender {
    for (int i = 0; i<[_cartList count]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if (sender.selected) {
            [_tableView deselectRowAtIndexPath:indexPath animated:NO];
            MyCartProductCell *cell = (MyCartProductCell *)[_tableView cellForRowAtIndexPath:indexPath];
            [cell.checkBtn setSelected:NO];
        }else{
            [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            MyCartProductCell *cell = (MyCartProductCell *)[_tableView cellForRowAtIndexPath:indexPath];
            [cell.checkBtn setSelected:YES];
        }
    }
    
    self.indexPathsForSelectedRows = self.tableView.indexPathsForSelectedRows;
    [self updateButtonsToMatchTableState];
}

- (void)deleteAction:(id)sender {
    if (!self.isEditing)return;
    
    // Open a dialog with just an OK button.
    NSString *actionTitle;
    NSString *itemName = getLocalizationString(@"product");
    if (([[self.tableView indexPathsForSelectedRows] count] == [_cartList count] || [[self.tableView indexPathsForSelectedRows] count] == 0)) {
        actionTitle = [NSString stringWithFormat:getLocalizationString(@"delete_all_warning"),itemName];
    }
    else
    {
        actionTitle = [NSString stringWithFormat:getLocalizationString(@"delete_warning"),itemName];
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

#pragma -mark UIActionSheetDelgate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // The user tapped one of the OK/Cancel buttons.
    if (buttonIndex == 0)
    {
        [self deleteCartOrder];
    }
}

- (void)cartDeleteFinalHandle {
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
        @autoreleasepool {
            NSMutableArray *tmpArray = [self mutableArrayValueForKey:@"cartList"];
            [tmpArray removeObjectsAtIndexes:indicesOfItemsToDelete];
        }
        
        
        // Tell the tableView that we deleted the objects
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        // Delete everything, delete the objects from our data model.
        @autoreleasepool {
            NSMutableArray *tmpArray = [self mutableArrayValueForKey:@"cartList"];
            [tmpArray removeAllObjects];
        }
        
        // Tell the tableView that we deleted the objects.
        // Because we are deleting all the rows, just reload the current table section
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    // Exit editing mode after the deletion.
    [self setEditing:NO animated:YES];
    [self updateButtonsToMatchTableState];
    [self updateDeleteButtonTitle];
    self.indexPathsForSelectedRows = self.tableView.indexPathsForSelectedRows;

}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_cartList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MyCartProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyCartProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell initializationUI];
        [cell cellDetailAction:@selector(getCellResponse:) target:self];
        if (!cell.tableView) {
            [cell setTableView:tableView];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    // Configure the cell...
    cell.checkBtn.selected = NO;
    if ([tableView indexPathsForSelectedRows]) {
        @autoreleasepool {
            NSArray *array = [tableView indexPathsForSelectedRows];
            [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([indexPath compare:obj]==NSOrderedSame){
                    cell.checkBtn.selected = YES;
                    *stop = YES;
                }
            }];
        }
    }
    [cell updateUIDataWith:_cartList[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 180.0f;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Update the delete button's title based on how many items are selected.
    [self updateDeleteButtonTitle];
    MyCartProductCell *cell = (MyCartProductCell*) [_tableView cellForRowAtIndexPath:indexPath];
    cell.checkBtn.selected = NO;
    self.indexPathsForSelectedRows = tableView.indexPathsForSelectedRows;
    NSLog(@"%@",[tableView indexPathsForSelectedRows]);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Update the delete button's title based on how many items are selected.
    [self updateButtonsToMatchTableState];
    MyCartProductCell *cell = (MyCartProductCell*) [_tableView cellForRowAtIndexPath:indexPath];
    cell.checkBtn.selected = YES;
    self.indexPathsForSelectedRows = tableView.indexPathsForSelectedRows;
    NSLog(@"%@",[tableView indexPathsForSelectedRows]);
}

#pragma mark- Updating button state
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // Make sure you call super first
    
    editing = !self.isEditingMode;
    [super setEditing:editing animated:animated];
    if (editing)
    {
        self.editButtonItem.title = getLocalizationString(@"cancel");
        [_deleteBtn setBackgroundColor:CDZColorOfLightGray];
        [_deleteBtn setEnabled:NO];
    }
    else
    {
        self.editButtonItem.title = getLocalizationString(@"edit");
    }
    [self.bottomBtnsView setHidden:!editing];
    [self.tableView setBounces:!editing];
    self.tableView.footer.hidden = editing;
    [self updateDeleteButtonTitle];
    self.isEditingMode = editing;

}

- (void)updateButtonsToMatchTableState {
    if (!self.isEditingMode) {
        // Not in editing mode.
        
        // Show the edit button, but disable the edit button if there's nothing to edit.
        if (self.cartList.count > 0)
        {
            self.editButtonItem.enabled = YES;
        }
        else
        {
            self.editButtonItem.enabled = NO;
        }
        
    }
    [self updateDeleteButtonTitle];
}

- (void)updateDeleteButtonTitle {
    // Update the delete button's title, based on how many items are selected
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    
    BOOL allItemsAreSelected = selectedRows.count == self.cartList.count;
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
    [_checkAll4DeleteBtn setSelected:allItemsAreSelected];
    
    [_submitBtn setEnabled:!noItemsAreSelected];
    [_submitBtn setBackgroundColor:noItemsAreSelected?CDZColorOfLightGray:CDZColorOfRed];
    [_selectAllBtn setSelected:allItemsAreSelected];
    
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
        if (isAllReload) [_cartList removeAllObjects];
        [_cartList addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
//        self.totalPageNum = @([responseObject[CDZKeyOfTotalPageSizeKey] integerValue]);
//        self.pageNum = responseObject[CDZKeyOfPageNumKey];
//        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
//        
//        self.tableView.footer.hidden = ((_pageNum.intValue*_pageSize.intValue)>_totalPageNum.intValue);
        [self.tableView reloadData];
        NSMutableAttributedString *textString = [NSMutableAttributedString new];
        [textString appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:@"你的购物车里面共有"
                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                         NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO)}]];
        [textString appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:@(_cartList.count).stringValue
                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                         NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO)}]];
        [textString appendAttributedString:[[NSAttributedString alloc]
                                            initWithString:@"件商品"
                                            attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                         NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15, NO)}]];
        
        _quantityLabel.attributedText = textString;
        
        _reminderView.hidden = (_cartList.count!=0);
        
        [self updateButtonsToMatchTableState];
        [self updateDeleteButtonTitle];
    }
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayHandleData:(id)refresh {
    
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        if ([(ODRefreshControl *)refresh refreshing]) {
            [self getCartListWithRefreshView:refresh isAllReload:YES];
        }
        
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]){
        if ([(MJRefreshAutoNormalFooter *)refresh isRefreshing]) {
//            self.pageNum = @(self.pageNum.integerValue+1);
            [self getCartListWithRefreshView:refresh isAllReload:NO];
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
- (void)getCartListWithRefreshView:(id)refreshView isAllReload:(BOOL)isAllReload {
    if (!self.accessToken) return;
    if (!refreshView) {
        [ProgressHUDHandler showHUDWithTitle:getLocalizationString(@"loading") onView:nil];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObject:@(isAllReload) forKey:@"isAllReload"];
    if (refreshView) {
        [userInfo addEntriesFromDictionary:@{@"refreshView":refreshView}];
    }
    
    [[APIsConnection shareConnection] personalCenterAPIsGetCartListWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)deleteCartOrder {
    if (!self.accessToken) return;
        [ProgressHUDHandler showHUD];
    NSMutableArray *list = [@[] mutableCopy];
    @autoreleasepool {
        NSArray *partsIDList = [_cartList valueForKey:@"id"];
        [_tableView.indexPathsForSelectedRows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:NSIndexPath.class]) {
                NSIndexPath *indexPath = obj;
                [list addObject:partsIDList[indexPath.row]];
            }
        }];
    }
    [[APIsConnection shareConnection] personalCenterAPIsPostDeleteProductFormTheCartWithAccessToken:self.accessToken productIDList:list success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if(errorCode!=0){
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [self cartDeleteFinalHandle];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)confirmCartOrder {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUD];
    NSMutableArray *productslist = [@[] mutableCopy];
    NSMutableArray *countslist = [@[] mutableCopy];
    @autoreleasepool {
        [_tableView.indexPathsForSelectedRows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:NSIndexPath.class]) {
                NSIndexPath *indexPath = obj;
                [productslist addObject:[self.cartList[indexPath.row] objectForKey:@"productId"]];
                [countslist addObject:[self.cartList[indexPath.row] objectForKey:@"buyCount"]];
            }
        }];
    }
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPostOrderSubmitWithAccessToken:self.accessToken productIDList:productslist productCountList:countslist success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if(errorCode!=0){
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        
        @strongify(self)
        NSMutableArray *stockList = [NSMutableArray array];
        [self.tableView.indexPathsForSelectedRows enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSIndexPath *indexPath = (NSIndexPath *)obj;
            NSDictionary *data = self.cartList[indexPath.row];
            NSDictionary *detail = @{@"productId":data[@"productId"], @"stocknum":data[@"stocknum"]};
            [stockList addObject:detail];
        }];
        
        MyCartSubmitConfirmVC *vc = [MyCartSubmitConfirmVC new];
        vc.infoConfirmData = responseObject[CDZKeyOfResultKey];
        vc.stockCountList = stockList;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)getPartsDetailWithPartsID:(NSString *)partsID {
    [ProgressHUDHandler showHUDWithTitle:getLocalizationString(@"loading") onView:nil];
    [[APIsConnection shareConnection] theSelfMaintenanceAPIsGetItemDetailWithProductID:partsID success:^(AFHTTPRequestOperation *operation, id responseObject) {

        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if(errorCode!=0){
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [ProgressHUDHandler dismissHUDWithCompletion:^{
            [self pushPartItemDetailViewWithItemDetail:responseObject[CDZKeyOfResultKey]];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"不明错误，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
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
        [_cartList removeAllObjects];
        [self.tableView reloadData];
    }else if (!error&&responseObject) {
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if(!refreshView){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refreshView];
        }
        if(errorCode!=0){
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        
        [self handleReceivedData:responseObject withRefreshView:refreshView isAllReload:isAllReload];
    }
    
}



@end
