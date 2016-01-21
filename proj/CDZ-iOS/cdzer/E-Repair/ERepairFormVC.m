//
//  ERepairFormVC.m
//  cdzer
//
//  Created by KEns0n on 11/4/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#define kTitle @"title"
#define kValue @"value"
#define kType @"type"
#define kPlaceHolder @"placeHolder"
#define kSeletor @"seletor"


#import "ERepairFormVC.h"
#import "ERepairFormCell.h"
#import "UserAutosInfoDTO.h"
#import "UserInfosDTO.h"
#import "MyAutosInfoVC.h"
#import "RepairShopSelectionVC.h"
@interface ERepairFormVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *configList;

@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, assign) BOOL keyboardWasShow;

@property (nonatomic, assign) BOOL isMissingAutosData;

@property (nonatomic, assign) BOOL isNeedReload;

@property (nonatomic, assign) BOOL viewWasAppear;

@end

@implementation ERepairFormVC


- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置返回按钮的文本
    self.title = getLocalizationString(@"e_repair");
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
    // Do any additional setup after loading the view.
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    self.title = getLocalizationString(@"e_repair");
    // Do any additional setup after loading the view.
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(updateScrollViewOffset:) name:CDZNotiKeyOfUpdateScrollViewOffset object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewWasAppear = YES;
    if (self.isNeedReload) {
        self.isNeedReload = NO;
        self.isMissingAutosData = NO;
        [self componentSetting];
        return;
    }
    if (self.isMissingAutosData) {
        [self showEditAutoInfoDetailVC];
        return;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.viewWasAppear = NO;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    @autoreleasepool {
        
        if (!self.configList) self.configList = [@[] mutableCopy];
        [self.configList removeAllObjects];
        
        UserInfosDTO *userDTO = DBHandler.shareInstance.getUserInfo;
        UserAutosInfoDTO *userAutosDTO = DBHandler.shareInstance.getUserAutosDetail;
        if (!userAutosDTO.modelID||userAutosDTO.modelID.integerValue==0||!userAutosDTO.modelName||[userAutosDTO.modelName isEqualToString:@""]) {
            self.isMissingAutosData = YES;
        }
        NSString *selectorString = NSStringFromSelector(@selector(pushToRepairShopSelection));
        [_configList addObjectsFromArray:@[@{kTitle:@"姓名：", kType:@"tf", kValue:userDTO.nichen, kPlaceHolder:@"请输入姓名"},
                                           @{kTitle:@"电话：", kType:@"tf", kValue:userDTO.telphone, kPlaceHolder:@"请输入联系电话"},
                                           @{kTitle:@"始发地：", kType:@"tf", kValue:@"", kPlaceHolder:@"请输入地址或者点击定位"},
                                           @{kTitle:@"车型：", kType:@"dp", kValue:userAutosDTO.modelName, kPlaceHolder:@"请选择车型"},
                                           
                                           @{kTitle:@"维修商：", kType:@"sel", kValue:@"", kPlaceHolder:@"请选择维修商", kSeletor:selectorString},
                                           @{kTitle:@"预约时间：", kType:@"dt", kValue:@"", kPlaceHolder:@"请选择日期"},
                                           @{kTitle:@"维修项目：", kType:@"tf", kValue:@"", kPlaceHolder:@"请输入维修项目"},]];
        if (self.tableView) [self.tableView reloadData];
        
        if (self.viewWasAppear) {
            self.viewWasAppear = NO;
            if (self.isMissingAutosData) {
                [self showEditAutoInfoDetailVC];
            }
        }
    }
    
    
}

- (void)pushToRepairShopSelection {
    @autoreleasepool {
        NSLog(@"pushToRepairShopSelection");
    }
}

- (void)pushToRepairShopSelectionVC {
    @autoreleasepool {
        RepairShopSelectionVC *vc = RepairShopSelectionVC.new;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)cancelSubmitForm {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)showEditAutoInfoDetailVC {
    @weakify(self)
    [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"预约前，需要完善个人车辆信息，现在去完善吗？" isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"ok" clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
        @strongify(self)
        if (btnIdx.unsignedIntegerValue==0) {
            [self cancelSubmitForm];
        }
        
        if (btnIdx.unsignedIntegerValue==1) {
            @autoreleasepool {
                self.isNeedReload = YES;
                MyAutosInfoVC *vc = [MyAutosInfoVC new];
                vc.wasBackRootView = YES;
                [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }];
}

- (void)initializationUI {
    @autoreleasepool {
        CGRect tableViewFrame = self.contentView.bounds;
        self.tableView = [[UITableView alloc] initWithFrame:tableViewFrame];
        _tableView.backgroundColor = CDZColorOfClearColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = YES;
        _tableView.bounces = NO ;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_tableView];
        
        UIImage *image = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches fileName:@"main_bg" type:FMImageTypeOfPNG scaleWithPhone4:YES needToUpdate:YES];
        [_tableView setBackgroundImageByCALayerWithImage:image];

    }
}

- (void)setReactiveRules {
    
}

- (void)updateScrollViewOffset:(NSNotification *)notiObject {
    
    if (notiObject.userInfo&&notiObject.userInfo.count) {
        NSIndexPath *indexPath = notiObject.userInfo[@"indexPath"];
        ERepairFormCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        BOOL resignResponder = [notiObject.userInfo[@"resignResponder"] boolValue];
        self.tableView.scrollEnabled = resignResponder;
        if (resignResponder) {
            @weakify(self)
            [UIView animateWithDuration:0.25 animations:^{
                @strongify(self)
                self.tableView.contentOffset = CGPointZero;
            }];
        }else {
            if (!cell.textField.isFirstResponder&&!cell.dateTimeTextField.isFirstResponder) return;
            if (notiObject.userInfo[@"keyboardRect"]) {
                self.keyboardRect = [notiObject.userInfo[@"keyboardRect"] CGRectValue];
                [self shiftScrollViewWithAnimation:cell];
            }
        }
    }
    
    
}

- (void)shiftScrollViewWithAnimation:(ERepairFormCell *)cell {
    CGPoint point = CGPointZero;
    CGFloat contanierViewMaxY = CGRectGetMidY(cell.frame);
    CGFloat visibleContentsHeight = (CGRectGetHeight(_tableView.frame)-CGRectGetHeight(_keyboardRect))/2.0f;
    if (contanierViewMaxY > visibleContentsHeight) {
        CGFloat offsetY = contanierViewMaxY-visibleContentsHeight;
        point.y = offsetY;
    }
    @weakify(self)
    self.tableView.contentOffset = CGPointZero;
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        self.tableView.contentOffset = point;
    }];
}

- (void)backToRootVC {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _configList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    ERepairFormCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[ERepairFormCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    NSDictionary *detail = _configList[indexPath.row];
    cell.textLabel.text = @"";
    cell.accessoryView.hidden = YES;
    cell.textField.userInteractionEnabled = NO;
    cell.textField.text = @"";
    cell.textField.hidden = YES;
    cell.dateTimeTextField.text = @"";
    cell.dateTimeTextField.hidden = YES;
    cell.indexPath = indexPath;
    cell.actionButton.hidden = YES;
    [cell.actionButton removeTarget:self action:nil forControlEvents:UIControlEventAllEvents];
    
    cell.textField.text = detail[kValue];
    cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:detail[kPlaceHolder] attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray}];
    cell.dateTimeTextField.attributedPlaceholder = cell.textField.attributedPlaceholder;
    
    NSString *type = detail[kType];
    cell.textLabel.text = detail[kTitle];
    if ([type isEqualToString:@"tf"]) {
        cell.textField.userInteractionEnabled = YES;
        cell.textField.hidden = NO;
    }
    if ([type isEqualToString:@"dp"]||[type isEqualToString:@"sel"]) {
        cell.textField.hidden = NO;
        if ([type isEqualToString:@"sel"]) {
            NSString *selectorString = detail[kSeletor];
            if (selectorString&&![selectorString isEqualToString:@""]) {
                SEL selector = NSSelectorFromString(selectorString);
                if ([self respondsToSelector:selector]) {
                    cell.actionButton.hidden = NO;
                    [cell.actionButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
                }
            }
            cell.accessoryView.hidden = NO;
        }
    }
    if ([type isEqualToString:@"dt"]) {
        cell.dateTimeTextField.hidden = NO;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
