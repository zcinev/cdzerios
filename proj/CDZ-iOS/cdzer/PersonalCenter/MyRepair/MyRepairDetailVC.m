//
//  MyRepairDetailVC.m
//  cdzer
//
//  Created by KEns0n on 3/27/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vCommentFont systemFontWithoutRatio(15.0f)

#define vCommentBoldFont systemFontBoldWithoutRatio(16.0f)

#define vStartSpace 15.0f

#import "MyRepairDetailVC.h"
#import "InsetsLabel.h"
#import "MyRepairDetailTVCell.h"
#import "PaymentForPepairVC.h"
#import "MyRepairDetailCell4Selection.h"
@interface MyRepairDetailVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) UIEdgeInsets insetsValue;

@property (nonatomic, strong) UIView *repairShopDetailView;

@property (nonatomic, strong) UIView *userDetailView;

@property (nonatomic, strong) UIView *userDetailSubView;

@property (nonatomic, strong) UIView *pirceDetailView;

@property (nonatomic, strong) UIView *pirceDetailSubView;

@property (nonatomic, strong) UITableView *repairItemNPartsDetailTable;

@property (nonatomic, strong) NSMutableArray *tvFoldViewList;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSMutableArray *selectionItemList;

@property (nonatomic, strong) UIButton *confirmButton;

@end
@implementation MyRepairDetailVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.insetsValue = UIEdgeInsetsMake(0.0f, vStartSpace, 0.0f, 0.0f);
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"repair_detail")];
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    self.tvFoldViewList = [NSMutableArray array];
    @weakify(self)
    [_repairDetail.repairmentNComponentList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @strongify(self)
        [self.tvFoldViewList addObject:@(NO)];
    }];
    self.selectionItemList = [@[] mutableCopy];
    if(_repairDetail.statusType==CDZMaintenanceStatusTypeOfDiagnosis&&[_statusName rangeOfString:@"诊断完成"].location!=NSNotFound){
        [_repairDetail.repairmentNComponentList[0] enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
            @strongify(self)
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.selectionItemList addObject:indexPath];
        }];
    }
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, userDetailSubView.hidden) subscribeNext:^(NSNumber *isHidden) {
        @strongify(self)
        CGRect rect = self.userDetailView.frame;
        rect.size.height = (isHidden.boolValue)?CGRectGetMinY(self.userDetailSubView.frame):CGRectGetMaxY(self.userDetailSubView.frame);
        self.userDetailView.frame = rect;
    }];
    
    [RACObserve(self, userDetailView.frame) subscribeNext:^(id frame) {
        @strongify(self)
        CGRect udvRect = [frame CGRectValue];
        if (self.repairDetail.isHavePriceDetail) {
            CGRect rect = self.pirceDetailView.frame;
            rect.origin.y = CGRectGetMaxY(udvRect);
            self.pirceDetailView.frame = rect;
        }else {
            CGRect rect = self.repairItemNPartsDetailTable.frame;
            rect.origin.y = CGRectGetMaxY(udvRect);
            self.repairItemNPartsDetailTable.frame = rect;
        }
    }];
    
    if (_repairDetail.isHavePriceDetail) {
        
        [RACObserve(self, pirceDetailSubView.hidden) subscribeNext:^(NSNumber *isHidden) {
            @strongify(self)
            CGRect rect = self.pirceDetailView.frame;
            rect.size.height = (isHidden.boolValue)?CGRectGetMinY(self.pirceDetailSubView.frame):CGRectGetMaxY(self.pirceDetailSubView.frame);
            self.pirceDetailView.frame = rect;
        }];
        
        [RACObserve(self, pirceDetailView.frame) subscribeNext:^(id frame) {
            @strongify(self)
            CGRect udvRect = [frame CGRectValue];
            CGRect rect = self.repairItemNPartsDetailTable.frame;
            rect.origin.y = CGRectGetMaxY(udvRect);
            self.repairItemNPartsDetailTable.frame = rect;
        }];
    }
    
    [RACObserve(self, repairItemNPartsDetailTable.contentSize) subscribeNext:^(id size) {
        @strongify(self)
        CGSize newSize = [size CGSizeValue];
        CGRect rect = self.repairItemNPartsDetailTable.frame;
        rect.size.height = newSize.height;
        self.repairItemNPartsDetailTable.frame = rect;
    }];
    
    [RACObserve(self, repairItemNPartsDetailTable.frame) subscribeNext:^(id frame) {
        @strongify(self)
        CGRect tvFrame = [frame CGRectValue];
        CGSize contentSize = self.scrollView.contentSize;
        CGFloat additionalHeight = 0.0f;
        CGFloat gapSpace = CGRectGetHeight(self.bottomView.frame);
        if (gapSpace==0) gapSpace=30;
        if (CGRectGetMaxY(tvFrame)>CGRectGetHeight(self.scrollView.frame)-gapSpace) {
            additionalHeight = gapSpace;
        }
        contentSize.height = CGRectGetMaxY(tvFrame)+additionalHeight;
        self.scrollView.contentSize = contentSize;
    }];
}

- (void)initializationUI {
    @autoreleasepool {
        [self setScrollView:[[UIScrollView alloc] initWithFrame:self.contentView.bounds]];
        [_scrollView setBackgroundColor:sCommonBGColor];
        [_scrollView setBounces:NO];
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)*2.0f)];
        [self.contentView addSubview:_scrollView];
        
        
        self.repairShopDetailView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), 100.0f)];
        [_scrollView addSubview:_repairShopDetailView];
        [self initsRepairShopDetailViewSubview];
        
        self.userDetailView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_repairShopDetailView.frame), CGRectGetWidth(self.contentView.frame), 100.0f)];
        _userDetailView.backgroundColor = [UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f];
        [_userDetailView setBorderWithColor:nil borderWidth:(0.5f)];
        [_scrollView addSubview:_userDetailView];
        [self initsUserDetailViewSubview];
        
        if (_repairDetail.isHavePriceDetail) {
            
            self.pirceDetailView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_userDetailView.frame), CGRectGetWidth(self.contentView.frame), 100.0f)];
            _pirceDetailView.backgroundColor = [UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f];
            [_pirceDetailView setBorderWithColor:nil borderWidth:(0.5f)];
            [_scrollView addSubview:_pirceDetailView];
            [self initsPirceDetailViewSubview];
        }
        
        if (_repairDetail.repairmentNComponentList.count>0) {
            CGRect tableViewRect = self.contentView.bounds;
            tableViewRect.origin.y = (_repairDetail.isHavePriceDetail)?CGRectGetMaxY(_pirceDetailView.frame):CGRectGetMaxY(_userDetailView.frame);
            tableViewRect.size.height = 300.0f;
            self.repairItemNPartsDetailTable = [[UITableView alloc] initWithFrame:tableViewRect];
            _repairItemNPartsDetailTable.backgroundColor = CDZColorOfWhite;
            _repairItemNPartsDetailTable.showsHorizontalScrollIndicator = NO;
            _repairItemNPartsDetailTable.showsVerticalScrollIndicator = NO;
            _repairItemNPartsDetailTable.bounces = NO;
            _repairItemNPartsDetailTable.delegate = self;
            _repairItemNPartsDetailTable.allowsMultipleSelection = YES;
            _repairItemNPartsDetailTable.dataSource = self;
            [self.scrollView addSubview:_repairItemNPartsDetailTable];
        }
        
        if (_repairDetail.statusType==CDZMaintenanceStatusTypeOfHasBeenClearing&&(_paymentStatus.integerValue!=8&&_paymentStatus.integerValue!=9)) {
            return;
        }
        CGFloat bottomViewHeight = 22.0f;
        if (_repairDetail.isHavePriceDetail) {
            bottomViewHeight += 22.0f;
        }
        if ((_repairDetail.statusType==CDZMaintenanceStatusTypeOfDiagnosis&&[_statusName rangeOfString:@"诊断完成"].location!=NSNotFound)||
            (_repairDetail.statusType==CDZMaintenanceStatusTypeOfHasBeenClearing&&(_paymentStatus.integerValue==8||_paymentStatus.integerValue==9))) {
            bottomViewHeight += 56.0f;
        }
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.contentView.bounds)-bottomViewHeight,
                                                                   CGRectGetWidth(self.contentView.bounds), bottomViewHeight)];
        [_bottomView setBackgroundColor:[UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.00f]];
        [self.contentView addSubview:_bottomView];
        [self initsButtomViewSubView];
    }
}
// Top View subview setup

- (void)initsRepairShopDetailViewSubview {
    
    CGRect shopTopViewRect = CGRectZero;
    shopTopViewRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame), 50.0f);
    
    UIView *shopTopView = [[UIView alloc] initWithFrame:shopTopViewRect];
    [shopTopView setBackgroundColor:CDZColorOfWhite];
    [shopTopView setBorderWithColor:nil borderWidth:(0.5f)];
    [_repairShopDetailView addSubview:shopTopView];
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect orderNumTitleRect = shopTopView.bounds;
    orderNumTitleRect.size.height = CGRectGetHeight(shopTopViewRect)*0.4f;
    InsetsLabel *orderNumTitleLabel = [[InsetsLabel alloc] initWithFrame:orderNumTitleRect andEdgeInsetsValue:_insetsValue];
    [orderNumTitleLabel setFont:vCommentFont];
    [orderNumTitleLabel setText:getLocalizationString(@"order_number")];
    [orderNumTitleLabel setTextColor:UIColor.grayColor];
    [shopTopView addSubview:orderNumTitleLabel];
    
    CGRect orderNumRect = shopTopView.bounds;;
    orderNumRect.origin.y = CGRectGetMaxY(orderNumTitleRect);
    orderNumRect.size.height = CGRectGetHeight(shopTopViewRect)*0.6f;
    InsetsLabel *orderNumLabel = [[InsetsLabel alloc] initWithFrame:orderNumRect andEdgeInsetsValue:_insetsValue];
    [orderNumLabel setFont:vCommentBoldFont];
    [orderNumLabel setText:_repairDetail.repairNmuber];
    [orderNumLabel setTextColor:UIColor.grayColor];
    [shopTopView addSubview:orderNumLabel];
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    CGRect subMiddleViewRect = CGRectZero;
    subMiddleViewRect.origin.y = CGRectGetMaxY(shopTopViewRect);
    subMiddleViewRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame), 50.0f);
    
    UIView *subMiddleView = [[UIView alloc] initWithFrame:subMiddleViewRect];
    [subMiddleView setBackgroundColor:CDZColorOfWhite];
    [subMiddleView setBorderWithColor:nil borderWidth:(0.5f)];
    [_repairShopDetailView addSubview:subMiddleView];
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect statusTitleRect = CGRectZero;
    statusTitleRect.size.width = CGRectGetWidth(subMiddleViewRect)*0.4f;
    statusTitleRect.size.height = CGRectGetHeight(subMiddleViewRect)*0.4f;
    InsetsLabel *statusTitleLabel = [[InsetsLabel alloc] initWithFrame:statusTitleRect andEdgeInsetsValue:_insetsValue];
    [statusTitleLabel setFont:vCommentFont];
    [statusTitleLabel setText:getLocalizationString(@"repair_status")];
    [statusTitleLabel setTextColor:UIColor.grayColor];
    [subMiddleView addSubview:statusTitleLabel];
    
    CGRect statusRect = CGRectZero;
    statusRect.origin.y = CGRectGetMaxY(statusTitleRect);
    statusRect.size.width = CGRectGetWidth(statusTitleRect);
    statusRect.size.height = CGRectGetHeight(subMiddleViewRect)*0.6f;
    InsetsLabel *statusLabel = [[InsetsLabel alloc] initWithFrame:statusRect andEdgeInsetsValue:_insetsValue];
    [statusLabel setFont:vCommentBoldFont];
    [statusLabel setText:_statusName];
    [statusLabel setTextColor:[UIColor orangeColor]];
    [subMiddleView addSubview:statusLabel];
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect timeTitleRect = statusTitleRect;
    timeTitleRect.origin.x = CGRectGetMaxX(statusTitleRect);
    timeTitleRect.size.width = CGRectGetWidth(subMiddleViewRect)-CGRectGetMaxX(statusTitleRect);
    UILabel *timeTitleLabel = [[UILabel alloc] initWithFrame:timeTitleRect];
    [timeTitleLabel setFont:vCommentFont];
    [timeTitleLabel setText:getLocalizationString(@"repair_time")];
    [timeTitleLabel setTextColor:UIColor.grayColor];
    [subMiddleView addSubview:timeTitleLabel];
    
    
    CGRect timeRect = statusRect;
    timeRect.origin.x = CGRectGetMaxX(statusRect);
    timeRect.size.width = CGRectGetWidth(timeTitleRect);
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:timeRect];
    [timeLabel setFont:vCommentBoldFont];
    [timeLabel setText:_repairDetail.appointmentTime];
    [timeLabel setTextColor:CDZColorOfDefaultColor];
    [subMiddleView addSubview:timeLabel];
    
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect subBottomViewRect = CGRectZero;
    subBottomViewRect.origin.y = CGRectGetMaxY(subMiddleViewRect);
    subBottomViewRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame), 90.0f);
    
    UIView *subBottomView = [[UIView alloc] initWithFrame:subBottomViewRect];
    [subBottomView setBackgroundColor:CDZColorOfWhite];
    [subBottomView setBorderWithColor:nil borderWidth:(0.5f)];
    [_scrollView addSubview:subBottomView];
    
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
//    CGRect portraitRect = CGRectZero;
//    portraitRect.size = CGSizeMake(70.0f, 70.0f);
//    portraitRect.origin.x = CGRectGetWidth(containerViewRect)-_insetsValue.left-CGRectGetWidth(portraitRect);
//    UIImageView *portraitIV = [[UIImageView alloc] initWithFrame:portraitRect];
//    [portraitIV setCenter:CGPointMake(portraitIV.center.x, CGRectGetHeight(containerViewRect)/2.0f)];
//    [portraitIV setBackgroundColor:[UIColor blackColor]];
//    [containerView addSubview:portraitIV];

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect storeTitleRect = subBottomView.bounds;
    storeTitleRect.origin.y = CGRectGetHeight(subBottomViewRect)*0.05f;
//    storeTitleRect.size.width = CGRectGetMinX(portraitRect);
    storeTitleRect.size.height = CGRectGetHeight(subBottomViewRect)*0.2f;
    CGFloat height = [SupportingClass getStringSizeWithString:_repairDetail.shopName font:vCommentBoldFont widthOfView:CGSizeMake(CGRectGetWidth(storeTitleRect)-_insetsValue.left, CGFLOAT_MAX)].height;
    height += 6;
    if ( storeTitleRect.size.height<height) {
        storeTitleRect.size.height = height;;
    }
    InsetsLabel *typeTitleLabel = [[InsetsLabel alloc] initWithFrame:storeTitleRect andEdgeInsetsValue:_insetsValue];
    typeTitleLabel.numberOfLines = 0;
    [typeTitleLabel setFont:vCommentBoldFont];
    [typeTitleLabel setText:_repairDetail.shopName];
    [typeTitleLabel setTextColor:[UIColor blackColor]];
    [subBottomView addSubview:typeTitleLabel];
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect addressRect = storeTitleRect;
    addressRect.origin.y = CGRectGetMaxY(storeTitleRect);
    addressRect.size.height = CGRectGetHeight(subBottomViewRect)*0.4f;
    InsetsLabel *addressLabel = [[InsetsLabel alloc] initWithFrame:addressRect andEdgeInsetsValue:_insetsValue];
    [addressLabel setFont:systemFontWithoutRatio(14.0f)];
    [addressLabel setText:_repairDetail.shopAddress];
    [addressLabel setNumberOfLines:0];
    [addressLabel setTextColor:[UIColor grayColor]];
    [subBottomView addSubview:addressLabel];
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    UIButton *phoneBtnLabel = nil;
    if (_repairDetail.shopTel) {
        
        CGRect phoneBtnRect = CGRectZero;
        phoneBtnRect.origin.x = _insetsValue.left;
        phoneBtnRect.origin.y = CGRectGetMaxY(addressRect);
        phoneBtnRect.size.width = (CGRectGetWidth(addressRect)-_insetsValue.left*2.0f-10.0f)/2.0f;
        phoneBtnRect.size.height = CGRectGetHeight(subBottomViewRect)*0.3f;
        
        UIImage *image = [ImageHandler createImageWithColor:CDZColorOfDefaultColor
                                                   withRect:CGRectMake(0.0f, 0, CGRectGetHeight(phoneBtnRect), CGRectGetHeight(phoneBtnRect))];
        
        phoneBtnLabel = [UIButton buttonWithType:UIButtonTypeSystem];
        [phoneBtnLabel setFrame:phoneBtnRect];
        [phoneBtnLabel setImage:image forState:UIControlStateNormal];
        [phoneBtnLabel setTitle:@"拨打电话"  forState:UIControlStateNormal];
        [phoneBtnLabel setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
        [phoneBtnLabel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [phoneBtnLabel setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f)];
        [phoneBtnLabel addTarget:self action:@selector(callNumber) forControlEvents:UIControlEventTouchUpInside];
        [subBottomView addSubview:phoneBtnLabel];
    }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//    CGRect mapBtnRect = phoneBtnRect;
//    mapBtnRect.origin.x = CGRectGetMaxX(phoneBtnRect)+10.0f;
//    UIButton *mapBtnLabel = [UIButton buttonWithType:UIButtonTypeSystem];
//    [mapBtnLabel setFrame:mapBtnRect];
//    [mapBtnLabel setImage:image forState:UIControlStateNormal];
//    [mapBtnLabel setTitle:@"查看地图"  forState:UIControlStateNormal];
//    [mapBtnLabel setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
//    [mapBtnLabel setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [mapBtnLabel setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f];
//    [containerView addSubview:mapBtnLabel];
//
//
    CGFloat maxHeight = CGRectGetMaxY(phoneBtnLabel.frame);
    if (!phoneBtnLabel) {
        maxHeight = CGRectGetMaxY(addressLabel.frame);
    }
    subBottomViewRect.size.height = maxHeight+5.0f;
    subBottomView.frame = subBottomViewRect;
    
    
    CGRect finalRect = _repairShopDetailView.frame;
    finalRect.size.height = CGRectGetMaxY(subBottomViewRect);
    _repairShopDetailView.frame = finalRect;

}

- (NSMutableArray *)getUserDetailConfigData {
    @autoreleasepool {
        
        NSMutableArray *detailArray = [@[@{@"title":@"车主名称:",@"content":_repairDetail.autosOwnerName},
                                         @{@"title":@"联系电话:",@"content":_repairDetail.contactsNumber},
                                         @{@"title":@"汽车品牌：",@"content":_repairDetail.autosBrandName},
                                         @{@"title":@"汽车商：",@"content":_repairDetail.autosDealershipName},
                                         @{@"title":@"汽车系列：",@"content":_repairDetail.autosSeries},
                                         @{@"title":@"汽车型号：",@"content":_repairDetail.autosModel},
                                         @{@"title":@"汽车颜色：",@"content":_repairDetail.autosColor},
                                         @{@"title":@"汽车外观：",@"content":_repairDetail.autosAppearance},
                                         @{@"title":@"车架号码：",@"content":_repairDetail.autosBodyCode},
                                         @{@"title":@"发动机号码：",@"content":_repairDetail.autosEngineCode},
                                         @{@"title":@"里数：",@"content":_repairDetail.mileageCounts},
                                         @{@"title":@"保险到期：",@"content":_repairDetail.insuranceTime},] mutableCopy];
        
        
        if (_repairDetail.userName) {
            NSDictionary *data = @{@"title":@"用户名：",@"content":_repairDetail.userName};
            [detailArray addObject:data];
        }
        
        if (_repairDetail.contactName) {
            NSDictionary *data = @{@"title":@"送修人：",@"content":_repairDetail.contactName};
            [detailArray addObject:data];
        }
        
        if (_repairDetail.licensePlateNumber) {
            NSDictionary *data = @{@"title":@"车牌号码：",@"content":_repairDetail.licensePlateNumber};
            [detailArray addObject:data];
        }
        
        if (_repairDetail.handleTime) {
            NSDictionary *data = @{@"title":@"处理时间：",@"content":_repairDetail.contactName};
            [detailArray addObject:data];
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (_repairDetail.oilReadingData) {
            NSDictionary *data = @{@"title":@"油量：",@"content":_repairDetail.oilReadingData};
            [detailArray addObject:data];
        }
        
        if (_repairDetail.repairType) {
            NSDictionary *data = @{@"title":@"维修类型：",@"content":_repairDetail.repairType};
            [detailArray addObject:data];
        }
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        if (_repairDetail.handlerName) {
            NSDictionary *data = @{@"title":@"操作员：",@"content":_repairDetail.handlerName};
            [detailArray addObject:data];
        }
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        if (_repairDetail.remarkString) {
//            NSDictionary *data = @{@"title":@"备注：",@"content":_repairDetail.remarkString};
//            [detailArray addObject:data];
//        }
        return detailArray;
    }
}

- (void)showHiddenUserDetail:(UIButton *)button {
    button.selected = !button.selected;
    _userDetailSubView.hidden = !_userDetailSubView.hidden;
    [_repairItemNPartsDetailTable reloadData];
}

- (void)initsUserDetailViewSubview {

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect titleRect = _userDetailView.bounds;
    titleRect.size.height = 30.0f;
    InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:_insetsValue];
    [titleLabel setFont:vCommentBoldFont];
    [titleLabel setText:@"接待信息"];
    [titleLabel setTextColor:[UIColor blackColor]];
    [_userDetailView addSubview:titleLabel];
    
    
    CGRect buttonRect = titleRect;
    buttonRect.size.width = 60.0f;
    buttonRect.origin.x = CGRectGetWidth(titleRect)-CGRectGetWidth(buttonRect);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = buttonRect;
    button.titleLabel.font = titleLabel.font;
    [button setTitle:@"展开＋" forState:UIControlStateNormal];
    [button setTitle:@"收缩－" forState:UIControlStateSelected];
    [button setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
    [button setTitleColor:CDZColorOfOrangeColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(showHiddenUserDetail:) forControlEvents:UIControlEventTouchUpInside];
    [_userDetailView addSubview:button];
    
    
    self.userDetailSubView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(titleRect), CGRectGetWidth(_userDetailView.frame), 100)];
    [_userDetailView addSubview:_userDetailSubView];
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    NSMutableArray *detailArray = [self getUserDetailConfigData];
    
    __block CGFloat finalHeight = 0.0f;
    CGFloat width = CGRectGetWidth(_userDetailSubView.frame)/2.0f;
    CGFloat height = 60.0f;
    UIEdgeInsets leftInsetsValue = UIEdgeInsetsMake(0.0f, vStartSpace, 0.0f, 0.0f);
    UIEdgeInsets rightInsetsValue = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, vStartSpace);
    NSInteger columnsPerRow = 2.0f;
    @weakify(self)
    [detailArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @strongify(self)
        NSInteger row = idx/columnsPerRow;
        NSInteger column = idx%columnsPerRow;
        CGRect subContainerViewRect = CGRectZero;
        subContainerViewRect.origin.x = width*column;
        subContainerViewRect.origin.y = height*row;
        subContainerViewRect.size = CGSizeMake(width, height);
        UIView *subContainerView = [[UIView alloc] initWithFrame:subContainerViewRect];
        [subContainerView setBackgroundColor:[UIColor whiteColor]];
        [subContainerView setBorderWithColor:nil borderWidth:(0.5f)];
        [self.userDetailSubView addSubview:subContainerView];
        
        
        CGRect titleRect = subContainerView.bounds;
        titleRect.size.height = 20.0f;
        InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:leftInsetsValue];
        [titleLabel setFont:vCommentBoldFont];
        [titleLabel setText:obj[@"title"]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setTextColor:UIColor.lightGrayColor];
        [subContainerView addSubview:titleLabel];
        
        CGRect contentRect = subContainerView.bounds;
        contentRect.size.height = 40.0f;
        contentRect.origin.y =  CGRectGetMaxY(titleRect);
        InsetsLabel *contentLabel = [[InsetsLabel alloc] initWithFrame:contentRect andEdgeInsetsValue:rightInsetsValue];
        contentLabel.numberOfLines = 0;
        [contentLabel setFont:vCommentFont];
        [contentLabel setText:obj[@"content"]];
        [contentLabel setTextAlignment:NSTextAlignmentRight];
        [subContainerView addSubview:contentLabel];
        if ([detailArray.lastObject isEqual:obj]) {
            finalHeight = CGRectGetMaxY(subContainerViewRect);
        }
    }];
    CGRect rect = _userDetailSubView.frame;
    rect.size.height = finalHeight;
    _userDetailSubView.frame = rect;
    _userDetailSubView.hidden = YES;
    
    CGRect finalRect = _userDetailView.frame;
    finalRect.size.height = CGRectGetMinY(_userDetailSubView.frame);
    _userDetailView.frame = finalRect;

}

- (void)showHiddenPriceDetail:(UIButton *)button {
    button.selected = !button.selected;
    _pirceDetailSubView.hidden = !_pirceDetailSubView.hidden;
    
}

- (void)initsPirceDetailViewSubview {
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect titleRect = _userDetailView.bounds;
    titleRect.size.height = 30.0f;
    InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:_insetsValue];
    [titleLabel setFont:vCommentBoldFont];
    [titleLabel setText:@"价格详情"];
    [titleLabel setTextColor:[UIColor blackColor]];
    [_pirceDetailView addSubview:titleLabel];
    
    CGRect buttonRect = titleRect;
    buttonRect.size.width = 60.0f;
    buttonRect.origin.x = CGRectGetWidth(titleRect)-CGRectGetWidth(buttonRect);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = buttonRect;
    button.titleLabel.font = titleLabel.font;
    [button setTitle:@"展开＋" forState:UIControlStateNormal];
    [button setTitle:@"收缩－" forState:UIControlStateSelected];
    [button setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
    [button setTitleColor:CDZColorOfOrangeColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(showHiddenPriceDetail:) forControlEvents:UIControlEventTouchUpInside];
    [_pirceDetailView addSubview:button];
    
    self.pirceDetailSubView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(titleRect), CGRectGetWidth(_userDetailView.frame), 100)];
    [_pirceDetailView addSubview:_pirceDetailSubView];
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    NSArray *detailArray = @[@{@"title":@"预估管理费:",@"content":_repairDetail.estimatedManagementCost},
                             @{@"title":@"诊断费:",@"content":_repairDetail.diagnoseAmount},
                             @{@"title":@"预计材料费：",@"content":_repairDetail.estimatedMaterialCost},
                             @{@"title":@"预计优惠金额：",@"content":_repairDetail.discount},
                             @{@"title":@"工时：",@"content":_repairDetail.workingHour},
                             @{@"title":@"总工时费：",@"content":_repairDetail.totalWorkingHour},
                             @{@"title":@"工时费：",@"content":_repairDetail.workingHourPrice},
                             @{@"title":@"预计费用合计：",@"content":_repairDetail.estimatedTotalAmount},];
    
    __block CGFloat finalHeight = 0.0f;
    CGFloat width = CGRectGetWidth(_pirceDetailSubView.frame)/2.0f;
    CGFloat height = 40.0f;
    UIEdgeInsets leftInsetsValue = UIEdgeInsetsMake(0.0f, vStartSpace, 0.0f, 0.0f);
    UIEdgeInsets rightInsetsValue = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, vStartSpace);
    NSInteger columnsPerRow = 2.0f;
    @weakify(self)
    [detailArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @strongify(self)
        NSInteger row = idx/columnsPerRow;
        NSInteger column = idx%columnsPerRow;
        CGRect subContainerViewRect = CGRectZero;
        subContainerViewRect.origin.x = width*column;
        subContainerViewRect.origin.y = height*row;
        subContainerViewRect.size = CGSizeMake(width, height);
        UIView *subContainerView = [[UIView alloc] initWithFrame:subContainerViewRect];
        [subContainerView setBackgroundColor:[UIColor whiteColor]];
        [subContainerView setBorderWithColor:nil borderWidth:(0.5f)];
        [self.pirceDetailSubView addSubview:subContainerView];
        
        
        CGRect titleRect = subContainerView.bounds;
        titleRect.size.height = 20.0f;
        InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:leftInsetsValue];
        [titleLabel setFont:vCommentBoldFont];
        [titleLabel setText:obj[@"title"]];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setTextColor:UIColor.lightGrayColor];
        [subContainerView addSubview:titleLabel];
        
        CGRect contentRect = subContainerView.bounds;
        contentRect.size.height = 20.0f;
        contentRect.origin.y =  CGRectGetMaxY(titleRect);
        InsetsLabel *contentLabel = [[InsetsLabel alloc] initWithFrame:contentRect andEdgeInsetsValue:rightInsetsValue];
        contentLabel.numberOfLines = 0;
        [contentLabel setFont:vCommentFont];
        [contentLabel setText:[obj[@"content"] stringValue]];
        [contentLabel setTextAlignment:NSTextAlignmentRight];
        [subContainerView addSubview:contentLabel];
        if ([detailArray.lastObject isEqual:obj]) {
            finalHeight = CGRectGetMaxY(subContainerViewRect);
        }
    }];
    CGRect rect = _pirceDetailSubView.frame;
    rect.size.height = finalHeight;
    _pirceDetailSubView.frame = rect;
    _pirceDetailSubView.hidden = YES;
    
    CGRect finalRect = _pirceDetailView.frame;
    finalRect.size.height = CGRectGetMinY(_pirceDetailSubView.frame);
    _pirceDetailView.frame = finalRect;
    
}

- (void)initsButtomViewSubView {
    
    UIEdgeInsets insertsValue = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    UIFont *font = systemFontWithoutRatio(14);
    
    NSMutableAttributedString* totalItemString = [NSMutableAttributedString new];
    [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:@"项目总数："
                                             attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                          NSFontAttributeName:font
                                                          }]];
    [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:@([_repairDetail.repairmentNComponentList[0] count]).stringValue
                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfWeiboColor,
                                                          NSFontAttributeName:font
                                                          }]];
    [totalItemString appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:@"项"
                                             attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                          NSFontAttributeName:font
                                                          }]];
    
    CGRect totalItemRect = _bottomView.bounds;
    totalItemRect.size.height = 22.0f;
    
    InsetsLabel *totalItemLabel = [[InsetsLabel alloc] initWithFrame:totalItemRect andEdgeInsetsValue:insertsValue];
    [totalItemLabel setTextAlignment:NSTextAlignmentLeft];
    [totalItemLabel setFont:font];
    [totalItemLabel setAttributedText:totalItemString];
    [_bottomView addSubview:totalItemLabel];
    
    CGRect totalPriceRect = totalItemRect;
    totalPriceRect.origin.y = CGRectGetMaxY(totalItemRect);
    NSMutableAttributedString* totalPriceString = nil;
    InsetsLabel *totalPriceLabel = nil;
    if (_repairDetail.isHavePriceDetail) {
        totalPriceString = [NSMutableAttributedString new];
        [totalPriceString appendAttributedString:[[NSAttributedString alloc]
                                                  initWithString:@"维修总额："
                                                  attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                               NSFontAttributeName:font
                                                               }]];
        [totalPriceString appendAttributedString:[[NSAttributedString alloc]
                                                  initWithString:[@"¥" stringByAppendingString: _repairDetail.estimatedTotalAmount.stringValue]
                                                  attributes:@{NSForegroundColorAttributeName:CDZColorOfWeiboColor,
                                                               NSFontAttributeName:font
                                                               }]];
        if (_repairDetail.remarkString) {
            [totalPriceString appendAttributedString:[[NSAttributedString alloc]
                                                      initWithString:[NSString stringWithFormat:@"（%@）", _repairDetail.remarkString]
                                                      attributes:@{NSForegroundColorAttributeName:UIColor.lightGrayColor,
                                                                   NSFontAttributeName:font
                                                                   }]];
            
        }
        
        if (_repairDetail.isHavePriceDetail) {
            totalPriceLabel = [[InsetsLabel alloc] initWithFrame:totalPriceRect andEdgeInsetsValue:insertsValue];
            [totalPriceLabel setTextAlignment:NSTextAlignmentLeft];
            [totalPriceLabel setFont:font];
            [totalPriceLabel setAttributedText:totalPriceString];
            [_bottomView addSubview:totalPriceLabel];
        }
        
    }
    
    
    
    
    if (_repairDetail.statusType==CDZMaintenanceStatusTypeOfAppointment||
        _repairDetail.statusType==CDZMaintenanceStatusTypeOfUserAuthorized||
        (_repairDetail.statusType==CDZMaintenanceStatusTypeOfDiagnosis&&[_statusName rangeOfString:@"诊断完成"].location==NSNotFound)||
        (_repairDetail.statusType==CDZMaintenanceStatusTypeOfHasBeenClearing&&(_paymentStatus.integerValue!=8&&_paymentStatus.integerValue!=9))) {
        return;
    }
    
    CGRect cancelBtnRect = CGRectZero;
    cancelBtnRect.origin.x = insertsValue.left;
    cancelBtnRect.origin.y = CGRectGetMaxY(totalPriceRect);
    cancelBtnRect.size.height = CGRectGetHeight(_bottomView.frame)-CGRectGetMaxY(totalPriceRect)-10.0f;
    cancelBtnRect.size.width = (CGRectGetWidth(_bottomView.frame)-insertsValue.left-insertsValue.right)/2.0f;
    
    
    NSString *confirmButtonTitle = (_paymentStatus.integerValue==8)?@"确认付款":@"维修评论";
    CGRect confirmBtnRect = CGRectZero;
    confirmBtnRect.origin.x = insertsValue.left;
    confirmBtnRect.origin.y = CGRectGetMaxY(totalPriceRect);
    confirmBtnRect.size.height = CGRectGetHeight(_bottomView.frame)-CGRectGetMaxY(totalPriceRect)-10.0f;
    confirmBtnRect.size.width = CGRectGetWidth(_bottomView.frame)-insertsValue.left-insertsValue.right;
    

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (_repairDetail.statusType==CDZMaintenanceStatusTypeOfDiagnosis) {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelBtn setFrame:cancelBtnRect];
        [cancelBtn setBackgroundColor:[UIColor colorWithRed:0.863f green:0.863f blue:0.863f alpha:1.00f]];
        [cancelBtn setTitleColor:CDZColorOfBlack forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消维修" forState:UIControlStateNormal];
        [cancelBtn setViewCornerWithRectCorner:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerSize:5.0f];
        [cancelBtn addTarget:self action:@selector(cancelRepairOrder) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:cancelBtn];
        
        confirmBtnRect = cancelBtnRect;
        confirmBtnRect.origin.x = CGRectGetMaxX(cancelBtnRect);
        confirmButtonTitle = @"确认维修";
    }
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [confirmBtn setFrame:confirmBtnRect];
    [confirmBtn setBackgroundColor:CDZColorOfRed];//[UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.00f]];
    [confirmBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
    [confirmBtn setTitle:confirmButtonTitle forState:UIControlStateNormal];
    if (_repairDetail.statusType==CDZMaintenanceStatusTypeOfDiagnosis) {
        [confirmBtn addTarget:self action:@selector(confirmRepairOrder) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setViewCornerWithRectCorner:UIRectCornerTopRight|UIRectCornerBottomRight cornerSize:5.0f];
        self.confirmButton = confirmBtn;
    }else if(_repairDetail.statusType==CDZMaintenanceStatusTypeOfHasBeenClearing&&_paymentStatus.integerValue==8){
        [confirmBtn addTarget:self action:@selector(confirmPayment) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
    }else if(_repairDetail.statusType==CDZMaintenanceStatusTypeOfHasBeenClearing&&_paymentStatus.integerValue==9){
        [confirmBtn addTarget:self action:@selector(showCommentView) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        
    }
    [_bottomView addSubview:confirmBtn];
    

    
    
}

- (void)showCommentView {
    
}

- (void)callNumber {
    [SupportingClass makeACall:_repairDetail.shopTel];
}

- (void)showHiddenTableViewDetail:(UIButton *)button {
    [_tvFoldViewList replaceObjectAtIndex:button.accessibilityIdentifier.integerValue withObject:@(!button.selected)];
    [_repairItemNPartsDetailTable reloadData];
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _repairDetail.repairmentNComponentList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    BOOL isFold = [_tvFoldViewList[section] boolValue];
    if (!isFold) {
        return 0;
    }
    return [_repairDetail.repairmentNComponentList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MyRepairDetailTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyRepairDetailTVCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // Configure the cell...
    CDZRepairDetailType type = CDZRepairDetailTypeOfWXXM;
    if (indexPath.section==1) {
        type = CDZRepairDetailTypeOfWXCL;
    }
    BOOL isShowCheckMark = NO;
    if(_repairDetail.statusType==CDZMaintenanceStatusTypeOfDiagnosis&&indexPath.section==0&&[_statusName rangeOfString:@"诊断完成"].location!=NSNotFound) {
        isShowCheckMark = YES;
        [_selectionItemList enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
            if ([(NSIndexPath *)obj compare:indexPath]==NSOrderedSame) {
                [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                *stop = YES;
            }
        }];
    }
    
    [cell updateUIDataWithData:[_repairDetail.repairmentNComponentList[indexPath.section] objectAtIndex:indexPath.row] detailType:type isShowCheckMark:isShowCheckMark];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    @autoreleasepool {
        static NSString *headerIdentifier = @"header";
        UITableViewHeaderFooterView *myHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
        if(!myHeader) {
            myHeader = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
            InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectZero
                                                               andEdgeInsetsValue:DefaultEdgeInsets];
            titleLabel.font = vCommentBoldFont;
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.tag = 10;
            titleLabel.translatesAutoresizingMaskIntoConstraints = YES;
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            [myHeader.contentView addSubview:titleLabel];
            
            BOOL isFold = [_tvFoldViewList[section] boolValue];
            CGRect buttonRect = myHeader.bounds;
            buttonRect.size.width = 60.0f;
            buttonRect.origin.x = CGRectGetWidth(tableView.bounds)-CGRectGetWidth(buttonRect);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = buttonRect;
            button.titleLabel.font = titleLabel.font;
            button.selected = isFold;
            button.accessibilityIdentifier = @(section).stringValue;
            button.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [button setTitle:@"展开＋" forState:UIControlStateNormal];
            [button setTitle:@"收缩－" forState:UIControlStateSelected];
            [button setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
            [button setTitleColor:CDZColorOfOrangeColor forState:UIControlStateSelected];
            [button addTarget:self action:@selector(showHiddenTableViewDetail:) forControlEvents:UIControlEventTouchUpInside];
            [myHeader.contentView addSubview:button];
            
            [myHeader.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
            [myHeader setBorderWithColor:nil borderWidth:(0.5f)];
            [myHeader setNeedsUpdateConstraints];
            [myHeader updateConstraintsIfNeeded];
            [myHeader setNeedsLayout];
            [myHeader layoutIfNeeded];
        }
        NSArray *titleList = @[getLocalizationString(@"repair_item"),
                               getLocalizationString(@"repair_item"),
                               getLocalizationString(@"repair_material")];
        InsetsLabel *titleLabel = (InsetsLabel *)[myHeader viewWithTag:10];
        NSString *title = titleList[section];
        titleLabel.text = title;
        
        return myHeader;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        [self.selectionItemList removeAllObjects];
        [self.selectionItemList addObjectsFromArray:tableView.indexPathsForSelectedRows];
        self.confirmButton.enabled = YES;
        self.confirmButton.backgroundColor = CDZColorOfRed;
    }else {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        [self.selectionItemList removeAllObjects];
        [self.selectionItemList addObjectsFromArray:tableView.indexPathsForSelectedRows];
        if (self.selectionItemList.count==0){
            self.confirmButton.enabled = NO;
            self.confirmButton.backgroundColor = CDZColorOfDeepGray;
        }
    }
}

- (NSString *)getRepairItemListString {
    @autoreleasepool {
        
        NSArray *repairItemList = [_repairDetail.repairmentNComponentList[0] valueForKey:@"diagph_name"];
        NSMutableArray *filterList = [@[] mutableCopy];
        [repairItemList enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.selectionItemList enumerateObjectsUsingBlock:^(NSIndexPath *  selectedIndex, NSUInteger subIdx, BOOL *  subStop) {
                if ([selectedIndex compare:indexPath]==NSOrderedSame) {
                    [filterList addObject:obj];
                    *subStop = YES;
                }
            }];
        }];
        return [filterList componentsJoinedByString:@"-"];
    }
}

- (void)confirmRepairOrder {
    NSString *repairItemsString = [self getRepairItemListString];
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] personalCenterAPIsPostConfirmMaintenanceAuthorizationWithAccessToken:self.accessToken keyID:_repairDetail.repairNmuber repairItemsString:repairItemsString success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)cancelRepairOrder {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] personalCenterAPIsPostCancelMaintenanceWithAccessToken:self.accessToken keyID:_repairDetail.repairNmuber success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)confirmPayment {
    PaymentForPepairVC *vc = [PaymentForPepairVC new];
    vc.shopID = _repairID;
    vc.repairDetail = _repairDetail;
    [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"操作逾时，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
    }else if (!error&&responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return;
        }
        NSLog(@"%@",responseObject);
        [ProgressHUDHandler showSuccessWithStatus:message onView:nil completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    
}


@end
