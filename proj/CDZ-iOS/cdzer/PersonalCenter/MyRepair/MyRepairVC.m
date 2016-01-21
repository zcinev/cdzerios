//
//  MyRepairVC.m
//  cdzer
//
//  Created by KEns0n on 3/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vStartSpace vAdjustByScreenRatio(10.0f)
#import "MyRepairVC.h"
#import "InsetsLabel.h"
#import "InsetsTextField.h"
#import "ODRefreshControl.h"
#import "MJRefresh.h"
#import "MyRepairTVCell.h"
#import "MyRepairDetailVC.h"
#import "RepairDetailDToModel.h"

@interface MyRepairVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableView *filterTableView;

@property (nonatomic, strong) UIButton *typeBtn;

@property (nonatomic, strong) InsetsTextField *searchTextField;

@property (nonatomic, strong) NSMutableArray *repairOrderList;

@property (nonatomic, strong) NSNumber *totalPageNum;

@property (nonatomic, strong) NSNumber *pageNum;

@property (nonatomic, strong) NSNumber *pageSize;

@property (nonatomic, strong) UIButton *loginRemindView;

@property (nonatomic, strong) NSArray *stateList;

@property (nonatomic, strong) UIControl *maskView;

@property (nonatomic, assign) CDZMaintenanceStatusType currentStatusType;

@property (nonatomic, strong) UIControl *reminderView;

@property (nonatomic, strong) InsetsLabel *reminderLabel;


@end

@implementation MyRepairVC


- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"repair_management")];
    self.stateList = @[getLocalizationString(@"repair_appointment"),
                       getLocalizationString(@"repair_analysis"),
                       getLocalizationString(@"repair_authorization"),
                       getLocalizationString(@"repair_checkout")];
    self.currentStatusType = CDZMaintenanceStatusTypeOfAppointment;
    [self componentSetting];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_repairOrderList.count==0) {
        [self getMaintenanceStatusListWithRefreshView:nil isAllReload:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    self.repairOrderList = [NSMutableArray array];
    self.totalPageNum = @(0);
    self.pageNum = @(1);
    self.pageSize = @(10);
}

- (void)initializationUI {
    @autoreleasepool {
        
        CGRect optionViewRect = self.contentView.bounds;
        optionViewRect.size.height = vAdjustByScreenRatio(46.0f);
        
        UIView *optionView = [[UIView alloc] initWithFrame:optionViewRect];
        [optionView setBorderWithColor:nil borderWidth:(0.5f)];
        [optionView setBackgroundColor:CDZColorOfWhite];
        [self.contentView addSubview:optionView];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        NSString *repairTypeString = @"状态：";
        UIFont *repairTypeFont = [UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)];
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vStartSpace, 0.0f, 0.0f);
        CGFloat StringWidth = [SupportingClass getStringSizeWithString:repairTypeString
                                                                  font:repairTypeFont
                                                           widthOfView:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(optionViewRect))].width;
        CGRect repairTypeRect = optionView.bounds;
        repairTypeRect.size.height = CGRectGetHeight(optionViewRect);
        repairTypeRect.size.width = insetsValue.left+insetsValue.right+StringWidth;
        InsetsLabel *repairTypeLabel = [[InsetsLabel alloc] initWithFrame:repairTypeRect andEdgeInsetsValue:insetsValue];
        [repairTypeLabel setText:repairTypeString];
        [repairTypeLabel setFont:repairTypeFont];
        [optionView addSubview:repairTypeLabel];
        
        
        UIImage *arrowImage = ImageHandler.getRightArrow;
        CGFloat centerPointY = CGRectGetHeight(optionViewRect)/2.0f;
        CGRect typeBtnRect = CGRectZero;
        typeBtnRect.size = CGSizeMake(vAdjustByScreenRatio(120.0f),vAdjustByScreenRatio(34.0f));
        typeBtnRect.origin.x = CGRectGetMaxX(repairTypeRect);
        [self setTypeBtn:[UIButton buttonWithType:UIButtonTypeCustom]];
        [_typeBtn setFrame:typeBtnRect];
        [_typeBtn setBackgroundColor:sCommonBGColor];
        [_typeBtn setCenter:CGPointMake(_typeBtn.center.x, centerPointY)];
        [_typeBtn setTitleColor:CDZColorOfBlack  forState:UIControlStateNormal];
        [_typeBtn setTitle:_stateList[0] forState:UIControlStateNormal];
        [_typeBtn setImage:arrowImage forState:UIControlStateNormal];
        [_typeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_typeBtn.titleLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)]];
        [_typeBtn addTarget:self action:@selector(stateBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_typeBtn.layer setCornerRadius:5.0f];
        [optionView addSubview:_typeBtn];
        
        CGFloat stringWidth = [SupportingClass getStringSizeWithString:_stateList[2] font:_typeBtn.titleLabel.font widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        [_typeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, -arrowImage.size.width+10.0f, 0.0f, arrowImage.size.width)];
        [_typeBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0f, stringWidth+15.0f, 0.0f, -stringWidth)];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        
        CGRect searchTFRect = typeBtnRect;
        searchTFRect.origin.x = CGRectGetMaxX(typeBtnRect)+vAdjustByScreenRatio(10.0f);
        searchTFRect.origin.y = CGRectGetMinY(_typeBtn.frame);
        searchTFRect.size = CGSizeMake(vAdjustByScreenRatio(124.0f), vAdjustByScreenRatio(34.0f));
        
        [self setSearchTextField:[[InsetsTextField alloc] initWithFrame:searchTFRect andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, vAdjustByScreenRatio(5.0f), 0.0f, 0.0f)]];
        [_searchTextField setBackgroundColor:sCommonBGColor];
        [_searchTextField setPlaceholder:getLocalizationString(@"repair_tfsp")];
        [_searchTextField setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)]];
        [_searchTextField setReturnKeyType:UIReturnKeySearch];
        [_searchTextField setDelegate:self];
        [self.contentView addSubview:_searchTextField];
        
        
        UIToolbar * toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), 40.0f)];
        [toolbar setBarStyle:UIBarStyleDefault];
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:self
                                                                                    action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"cancel")
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:_searchTextField
                                                                     action:@selector(resignFirstResponder)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButton,doneButton,nil];
        [toolbar setItems:buttonsArray];
        _searchTextField.inputAccessoryView = toolbar;
    
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        CGRect tableViewRect = self.contentView.bounds;
        tableViewRect.origin.y = CGRectGetMaxY(optionViewRect);
        tableViewRect.size.height -= CGRectGetMaxY(optionViewRect);
        
        [self setTableView:[[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain]];
        [_tableView setBackgroundColor:sCommonBGColor];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView setShowsHorizontalScrollIndicator:NO];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [_tableView setBounces:YES];
        [_tableView setDelegate:self];
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
        
        
        self.reminderView = [[UIControl alloc] initWithFrame:self.tableView.frame];
        _reminderView.hidden = YES;
        _reminderView.backgroundColor = CDZColorOfWhite;
        [self.contentView addSubview:_reminderView];
        
        self.reminderLabel = [[InsetsLabel alloc] initWithFrame:_reminderView.bounds];
        _reminderLabel.text = @"没有更多的预约维修信息！";
        _reminderLabel.numberOfLines = 0;
        _reminderLabel.textAlignment = NSTextAlignmentCenter;
        [_reminderView addSubview:_reminderLabel];
        
        [self initFilterView:optionView];
    }

}

- (void)initFilterView:(UIView *)optionView {
    CGRect maskRect = self.contentView.bounds;
    maskRect.origin.y = CGRectGetMaxY(optionView.frame);
    maskRect.size.height -= maskRect.origin.y;
    self.maskView = [[UIControl alloc] initWithFrame:maskRect];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    self.maskView.alpha = 0.0f;
    [self.maskView addTarget:self action:@selector(hideMaskView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.maskView];
    
    self.filterTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.maskView.frame), 0.0f)];
    self.filterTableView.bounces = NO;
    self.filterTableView.delegate = self;
    self.filterTableView.dataSource = self;
    self.filterTableView.allowsSelection = YES;
    self.filterTableView.allowsMultipleSelection = NO;
    self.filterTableView.allowsSelectionDuringEditing = NO;
    self.filterTableView.allowsMultipleSelectionDuringEditing = NO;
    [self.filterTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self.maskView addSubview:self.filterTableView];
}

- (void)stateBtnAction {
    if (self.maskView.alpha==1) {
        [self hideMaskView];
    }else {
        [self showMaskView];
    }
}

- (void)showMaskView {
    self.typeBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    [_searchTextField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect ftvRect = self.filterTableView.frame;
        ftvRect.size.height = 200.0f;
        self.filterTableView.frame = ftvRect;
        self.maskView.alpha = 1;
    }];
}

- (void)hideMaskView {
    self.typeBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    [UIView animateWithDuration:0.2 animations:^{
        CGRect ftvRect = self.filterTableView.frame;
        ftvRect.size.height = 0.0f;
        self.filterTableView.frame = ftvRect;
        self.maskView.alpha = 0;
    }];
}

#pragma mark- UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
//    if ([tableView isEqual:self.filterTableView]) return 1;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([tableView isEqual:self.filterTableView]) return _stateList.count;
    return _repairOrderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.filterTableView]) {
        static NSString *ident = @"cell-filter";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            
        }
        cell.textLabel.text = _stateList[indexPath.row];
        return cell;
        
    }
    
    static NSString *ident = @"cell";
    MyRepairTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyRepairTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell initializationUI];
        
    }
    if (_repairOrderList.count!=0) {
        [cell updateUIDataWithData:_repairOrderList[indexPath.row] withStatusType:_currentStatusType];
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
    if ([tableView isEqual:self.filterTableView]) return 50.0f;
    return vAdjustByScreenRatio(190.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_searchTextField resignFirstResponder];
    if ([tableView isEqual:self.filterTableView]) {
        self.currentStatusType = indexPath.row;
        [_typeBtn setTitle:_stateList[indexPath.row] forState:UIControlStateNormal];
        [self hideMaskView];
        [self getMaintenanceStatusListWithRefreshView:nil isAllReload:YES];
        return;
    }
    [self getMaintenanceStatusDetail:indexPath];
}


#pragma mark- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self hideMaskView];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self getMaintenanceStatusListWithRefreshView:nil isAllReload:YES];
    return YES;
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
        if (isAllReload){
            [_repairOrderList removeAllObjects];
        }
        [_repairOrderList addObjectsFromArray:responseObject[CDZKeyOfResultKey]];
        self.totalPageNum = @([responseObject[CDZKeyOfTotalPageSizeKey] integerValue]);
        self.pageNum = responseObject[CDZKeyOfPageNumKey];
        self.pageSize = responseObject[CDZKeyOfPageSizeKey];
        _reminderView.hidden = (_totalPageNum.integerValue!=0);
        _tableView.footer.hidden = ((_pageNum.intValue*_pageSize.intValue)>_totalPageNum.intValue);
        [_tableView reloadData];
    }
}

- (void)stopRefresh:(id)refresh {
    [refresh endRefreshing];
}

- (void)delayHandleData:(id)refresh {
    
    if ([refresh isKindOfClass:[ODRefreshControl class]]) {
        if ([(ODRefreshControl *)refresh refreshing]) {
            [self getMaintenanceStatusListWithRefreshView:refresh isAllReload:YES];
        }
        
    }else if ([refresh isKindOfClass:[MJRefreshAutoNormalFooter class]]){
        if ([(MJRefreshAutoNormalFooter *)refresh isRefreshing]) {
            self.pageNum = @(self.pageNum.integerValue+1);
            [self getMaintenanceStatusListWithRefreshView:refresh isAllReload:NO];
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
- (void)getMaintenanceStatusListWithRefreshView:(id)refreshView isAllReload:(BOOL)isAllReload {
    [_searchTextField resignFirstResponder];
    if (!self.accessToken) return;
    if (!refreshView) {
        [ProgressHUDHandler showHUD];
    }
    if (isAllReload) {
        self.totalPageNum = @(0);
        self.pageNum = @(1);
        self.pageSize = @(10);
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:@{@"isAllReload":@(isAllReload),
                                                                                    @"MaintenanceStatusType":@(self.currentStatusType)}];
    if (refreshView) {
        [userInfo addEntriesFromDictionary:@{@"refreshView":refreshView}];
    }

    [[APIsConnection shareConnection] personalCenterAPIsGetMaintenanceStatusListByStatusType:self.currentStatusType
                                                                                 accessToken:self.accessToken
                                                                                    pageNums:_pageNum
                                                                                    pageSize:_pageSize
                                                                             shopNameOrKeyID:_searchTextField.text
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)getMaintenanceStatusDetail:(NSIndexPath *)indexPath{
    if (!self.accessToken) return;
    
    [ProgressHUDHandler showHUD];
    NSString *key = (_currentStatusType==CDZMaintenanceStatusTypeOfDiagnosis)?@"diacaplan":@"id";
    NSLog(@"%@", _repairOrderList[indexPath.row]);
    NSString *keyID = [_repairOrderList[indexPath.row] objectForKey:key];
    NSString *repairID = [_repairOrderList[indexPath.row] objectForKey:@"id"];
    NSString *statusName = [_repairOrderList[indexPath.row] objectForKey:@"state_name"];
    NSNumber *paymentStatus = @(0);
    if (_currentStatusType==CDZMaintenanceStatusTypeOfHasBeenClearing) {
        if ([[_repairOrderList[indexPath.row] objectForKey:@"process"] isKindOfClass:NSString.class]) {
            paymentStatus = @([[_repairOrderList[indexPath.row] objectForKey:@"process"] integerValue]);
        }else {
            paymentStatus = [_repairOrderList[indexPath.row] objectForKey:@"process"];
        }
    }
    [[APIsConnection shareConnection] personalCenterAPIsGetMaintenanceStatusDetailByStatusType:self.currentStatusType
                                                                                   accessToken:self.accessToken
                                                                                         keyID:keyID
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
         NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
         NSLog(@"%@",message);
         [ProgressHUDHandler dismissHUD];
         
         if (errorCode!=0) {
             [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                 
             }];
             return;
         }
         
         MyRepairDetailVC *vc = [MyRepairDetailVC new];
         vc.repairDetail = [RepairDetailDToModel createModelWithStatus:self.currentStatusType andData:responseObject[CDZKeyOfResultKey]];
         vc.statusName = statusName;
         vc.repairID = repairID;
         vc.paymentStatus = paymentStatus;
         [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
         [self.navigationController pushViewController:vc animated:YES];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [ProgressHUDHandler dismissHUD];
         [SupportingClass showAlertViewWithTitle:@"error" message:@"连接超时，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
             
         }];
     }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    id refreshView = operation.userInfo[@"refreshView"];
    BOOL isAllReload = [operation.userInfo[@"isAllReload"] boolValue];
//    CDZMaintenanceStatusType currentStatusType = [operation.userInfo[@"MaintenanceStatusType"] integerValue];
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        if(!refreshView){
            [ProgressHUDHandler dismissHUD];
        }else{
            [self stopRefresh:refreshView];
        }
        [SupportingClass showAlertViewWithTitle:@"error" message:@"连接超时，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
        }];
        [_repairOrderList removeAllObjects];
        [_tableView reloadData];
    }else if (!error&&responseObject) {
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        
        if (errorCode!=0) {
            if(!refreshView){
                [ProgressHUDHandler dismissHUD];
            }else{
                [self stopRefresh:refreshView];
            }
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            return;
        }
        [self handleReceivedData:responseObject withRefreshView:refreshView isAllReload:isAllReload];
    }
    
}




@end
