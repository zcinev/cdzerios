    //
//  PersonalCenterMainVC.m
//  cdzer
//
//  Created by KEns0n on 3/23/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vStartSpace vAdjustByScreenRatio(16.0f)
#define vListBtnBaseTag 100

#import "PersonalCenterMainVC.h"
#import "UserInfosDTO.h"
#import "BadgeButtonView.h"
#import "InsetsLabel.h"
#import "UserLoginVC.h"
#import "NetProgressImageView.h"
#import "PersonalDataVC.h"
#import "MyAutosInfoVC.h"

#import "MyRepairVC.h"
#import "MyEnquiryVC.h"
#import "MyRepairDetailVC.h"
#import "MyOrderVC.h"
#import "MyOrderTraceDetailVC.h"
#import "MyCollectionVC.h"
#import "MyCartVC.h"
#import "MyAddressesVC.h"
#import "MyOrderConfirmVC.h"
#import "MyCreditVC.h"
#import "AppSettingVC.h"
#import "MyAutoInsuranceVC.h"
#import "MyCouponVC.h"
#import "ERepairMainVC.h"



@interface PersonalCenterMainVC ()

@property (nonatomic, strong) NetProgressImageView *userIcon;

@property (nonatomic, strong) InsetsLabel *userNameLabel;

@property (nonatomic, strong) InsetsLabel *selectedCarLabel;

@property (nonatomic, strong) UILabel *userHintLabel;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UserInfosDTO *userInfo;

@property (nonatomic, strong) NSArray *settingList;

@property (nonatomic, strong) UIButton *delayButton;

@property (nonatomic, assign) BOOL isShowLogin;

@property (nonatomic, assign) BOOL isShowUserDetail;

@property (nonatomic, strong) UIButton *logoutButton;

@property (nonatomic, assign) CGRect unLoginLastRect;

@property (nonatomic, strong) UIBarButtonItem *item;

@end


@implementation PersonalCenterMainVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"personal_center")];
    [self setSettingList:@[@{@"title":@"my_autos",@"o2o_space":@YES},
                           @{@"title":@"my_cart"},
                           @{@"title":@"my_collection"},
                           @{@"title":@"my_pirce_check"},
                           @{@"title":@"my_repair_management"},
                           @{@"title":@"my_insurance"},
                           @{@"title":@"my_coupon"},
                           @{@"title":@"my_erepair"},
                           @{@"title":@"my_integration",@"o2o_space":@YES},
                           @{@"title":@"shipping_address"}]];
    UIImage *image = [ImageHandler getImageFromCacheWithByFixdeRatioFileRootPath:kSysImageCaches fileName:@"setting" type:FMImageTypeOfPNG needToUpdate:YES];
    self.item = [self setRightNavButtonWithTitleOrImage:image style:UIBarButtonItemStylePlain target:self action:@selector(pushToSettingVC) titleColor:nil isNeedToSet:YES];
    [self initializationUI];
    [self setReactiveRules];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    if (_isShowLogin) {
        _isShowLogin = NO;
    }else {
        self.delayButton = nil;
        self.isShowUserDetail = NO;
    }
    [super viewWillDisappear:animated];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(BaseTabBarController *)self.tabBarController showTitleLabelWithTitle:self.title];
    NSLog(@"%@",self.accessToken);
    
    self.tabBarController.navigationItem.rightBarButtonItem = _item;;
    
    if (self.accessToken&&_delayButton) {
        [self pushToDifferentVC:_delayButton];
        return;
    }
    if (self.accessToken) {
        self.userInfo = DBHandler.shareInstance.getUserInfo;
        if (!_userInfo) {
            [self getUserDetail];
            return;
        }
        [self reLoadAllView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Private Action Section
- (void)pushToSettingVC {
    @autoreleasepool {
        AppSettingVC *vc = [AppSettingVC new];
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
    }
}

- (void)setReactiveRules {
    
}

- (void)showLoginView {
    @autoreleasepool {
        UserLoginVC *vc = [UserLoginVC new];
        vc.modalPresentationStyle = UIModalPresentationPageSheet;
        vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self.tabBarController presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

- (void)pushToUserDetail {
    @autoreleasepool {
        if (!self.accessToken || !_userInfo) {
            self.isShowUserDetail = YES;
            _isShowLogin = YES;
            [self showLoginView];
            return;
        }
        
        PersonalDataVC *vc = [PersonalDataVC new];
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.tabBarController.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)pushToDifferentVC:(UIButton*)button {
    @autoreleasepool {
        if (!self.accessToken ) {
            _isShowLogin = YES;
            if (!_delayButton||button!=_delayButton) {
                self.delayButton = button;
            }
            [self showLoginView];
            return;
        }
        id vc = nil;
        
        NSInteger theID = button.tag-vListBtnBaseTag;
        switch (theID) {
            case 0:
                vc = [MyAutosInfoVC new];
                break;
            case 1:
                vc = [MyCartVC new];
                break;
            case 2:
                vc = [MyCollectionVC new];
                break;
            case 3:
                vc = [MyEnquiryVC new];
                break;
            case 4:
                vc = [MyRepairVC new];
                break;
            case 5:
                vc = [MyAutoInsuranceVC new];
                break;
            case 6:
                vc = [MyCouponVC new];
                break;
            case 7:
                vc = [ERepairMainVC new];
                break;
            case 8:
                vc = [MyCreditVC new];
                break;
            case 9:
                vc = [MyAddressesVC new];
                break;
                
            default:
                break;
        }
        if (vc) {
            self.delayButton = nil;
            [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
            [self.tabBarController.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}

- (void)userLogout {
    @weakify(self)
    [[UserBehaviorHandler shareInstance] userLogoutWasPopupDialog:YES andCompletionBlock:^{
        @strongify(self)
        self.scrollView.contentOffset = CGPointZero;
        self.userInfo = nil;
        [self setAccessToken:vGetUserToken];
        [self reLoadAllView];
    }];
}

- (void)pushToOrderView:(UIButton *)badgeButton {
    @autoreleasepool {
        MyOrderVC *vc = [MyOrderVC new];
        NSString *text = badgeButton.titleLabel.text;
        if ([text isEqualToString:@"所有订单"]||
            [text isEqualToString:@"未付款"]||
            [text isEqualToString:@"派送中"]||
            [text isEqualToString:@"申请退货中"]) {
            vc.currentStatusName = text;
            if ([text isEqualToString:@"所有订单"]) {
                vc.currentStatusName = @"";
            }
            [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
            [self.tabBarController.navigationController pushViewController:vc animated:YES];
        }
    }
}

#pragma mark- UI Init Section
- (void)reLoadAllView {
    @autoreleasepool {
        
        CGRect userNameLabelRect = _userNameLabel.frame;
        if (_userInfo) {
            if ([_userInfo.portrait rangeOfString:@"http"].location==NSNotFound) {
                [_userIcon setImageURL:_userInfo.portrait];
            }
            
            
            NSString *userName = [[_userInfo.nichen stringByAppendingString:@"\n"] stringByAppendingString:_userInfo.telphone];
            userNameLabelRect.size.height = CGRectGetHeight(_userIcon.frame)*0.7f;
            _userNameLabel.frame = userNameLabelRect;
            _userNameLabel.text = userName;
            _userHintLabel.hidden = NO;
            
            
            if (_userInfo.modelName) {
                UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vStartSpace, 0.0f, vStartSpace/2.0f);
                NSString *selectedCarText = _userInfo.modelName;
                UIFont *selectedCarFont = [UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)];
                CGSize textSize = [SupportingClass getStringSizeWithString:selectedCarText
                                                                      font:selectedCarFont
                                                               widthOfView:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(_selectedCarLabel.frame))];
                CGFloat maxX = CGRectGetMaxX(_selectedCarLabel.frame);
                CGFloat width = textSize.width+insetsValue.left+insetsValue.right;
                CGRect selectedCarRect = _selectedCarLabel.frame;
                selectedCarRect.size.width = width;
                selectedCarRect.origin.x = maxX - width;
                [_selectedCarLabel setEdgeInsets:insetsValue];
                [_selectedCarLabel setFrame:selectedCarRect];
                [_selectedCarLabel setText:selectedCarText];
                
            }
            
        }else {
            [_userIcon clearImage];
            
            userNameLabelRect.size.height = CGRectGetHeight(_userIcon.frame);
            _userNameLabel.frame = userNameLabelRect;
            _userNameLabel.text = getLocalizationString(@"login_first");
            _userHintLabel.hidden = YES;
            
            [_selectedCarLabel setText:@""];
            
            
        }
        
        CGFloat lastMaxY = CGRectGetMaxY(_unLoginLastRect)+30.0f;
        _logoutButton.hidden = YES;
        
        if (self.accessToken) {
            _logoutButton.hidden = NO;
            lastMaxY = CGRectGetMaxY(_logoutButton.frame)+30.0f;;
        }
        
        [_scrollView setContentSize:CGSizeMake(_scrollView.contentSize.width, lastMaxY)];
    }
}

- (CGFloat)topPersonViewInit {
    
    @autoreleasepool {
        
        UIImage *arrowImage = ImageHandler.getRightArrow;
        
        CGFloat imageSize = (IS_IPHONE_6P?100.0f:(IS_IPHONE_6?91.0f:77.5f));
        CGRect detailViewRect = _scrollView.bounds;
        detailViewRect.size.height = imageSize+vAdjustByScreenRatio(vO2OSpaceSpace)*2.0f;
        UIControl *userDetailView = [[UIControl alloc] initWithFrame:detailViewRect];
        [userDetailView setBackgroundColor:CDZColorOfClearColor];
        [userDetailView addTarget:self action:@selector(pushToUserDetail) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:userDetailView];
        
        self.userIcon = [[NetProgressImageView alloc] initWithFrame:CGRectMake(vAdjustByScreenRatio(14.0f), 0.0f, imageSize, imageSize)];
        [_userIcon.layer setMasksToBounds:YES];
        [_userIcon.layer setCornerRadius:imageSize/2.0f];
        [_userIcon setCenter:CGPointMake(_userIcon.center.x, CGRectGetHeight(detailViewRect)/2.0f)];
        [userDetailView addSubview:_userIcon];
        self.userNameLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userIcon.frame)+vAdjustByScreenRatio(vO2OSpaceSpace),
                                                                       CGRectGetMinY(_userIcon.frame),
                                                                       CGRectGetWidth(_scrollView.frame)-CGRectGetMaxX(_userIcon.frame)-vAdjustByScreenRatio(vO2OSpaceSpace),
                                                                       CGRectGetHeight(_userIcon.frame)*0.7f)
                                                      andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, arrowImage.size.width+vStartSpace*2.0f)];
        [_userNameLabel setText:getLocalizationString(@"login_first")];
        [_userNameLabel setNumberOfLines:0];
        [userDetailView addSubview:_userNameLabel];
        
        CGRect usrHintRect = _userNameLabel.frame;
        usrHintRect.origin.y = CGRectGetMaxY(_userIcon.frame)*0.7f;
        usrHintRect.size.height = CGRectGetHeight(_userIcon.frame)*0.3f;
        self.userHintLabel = [[UILabel alloc] initWithFrame:usrHintRect];
        [_userHintLabel setText:getLocalizationString(@"user_detail_hint")];
        [_userHintLabel setFont:systemFont(12.0f)];
        [_userHintLabel setTextColor:[UIColor colorWithRed:0.404f green:0.404f blue:0.404f alpha:1.00f]];
        [_userHintLabel setHidden:YES];
        [userDetailView addSubview:_userHintLabel];
        
        UIImageView *arrowIV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame)-arrowImage.size.height-vStartSpace,
                                                                             (CGRectGetHeight(detailViewRect)-arrowImage.size.height)/2.0f,
                                                                             arrowImage.size.width,
                                                                             arrowImage.size.height)];
        [arrowIV setImage:arrowImage];
        [userDetailView addSubview:arrowIV];
        
        return CGRectGetMaxY(userDetailView.frame);
    }
}

- (void)initializationUI {
    @autoreleasepool {
        
        [self setScrollView:[[UIScrollView alloc] initWithFrame:self.contentView.bounds]];
        [_scrollView setBackgroundColor:sCommonBGColor];
        [_scrollView setBounces:NO];
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)*2.0f)];
        [self.contentView addSubview:_scrollView];
        
        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGFloat lastMaxY = [self topPersonViewInit];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        CGRect logisticsViewRect = CGRectZero;
        logisticsViewRect.origin.y = lastMaxY ;
        logisticsViewRect.size = CGSizeMake(CGRectGetWidth(_scrollView.frame), vAdjustByScreenRatio(56.0f));
        UIView *logisticsConView = [[UIView alloc] initWithFrame:logisticsViewRect];
        [logisticsConView setBackgroundColor:[UIColor whiteColor]];
        [logisticsConView setBorderWithColor:nil borderWidth:(0.5)];
        [_scrollView addSubview:logisticsConView];
        
        NSArray *array = @[@{@"title":@"所有订单",@"image":@"all_order"},
                           @{@"title":@"未付款",@"image":@"pay_order"},
                           @{@"title":@"派送中",@"image":@"delivery_order"},
                           @{@"title":@"申请退货中",@"image":@"return_order"}];
        CGFloat btnHeight= vAdjustByScreenRatio(50.0f);
        CGFloat btnWidth = vAdjustByScreenRatio(60.0f);
        @weakify(self)
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @strongify(self)
            CGFloat offSetY = (CGRectGetHeight(logisticsViewRect)-btnHeight)/2.0f;
            CGFloat offSetX = (CGRectGetWidth(self.scrollView.frame)-btnWidth*4.0f)/5.0f;
            CGRect bbvRect = CGRectZero;
            bbvRect.size = CGSizeMake(btnWidth, btnHeight);
            bbvRect.origin.y = offSetY;
            bbvRect.origin.x = offSetX+(offSetX+CGRectGetWidth(bbvRect))*idx;
            
            BadgeButtonView *bbv = [[BadgeButtonView alloc] initWithFrame:bbvRect];
            UIImage *image = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches fileName:obj[@"image"] type:FMImageTypeOfPNG scaleWithPhone4:NO needToUpdate:NO];
            [bbv setImage:image andTitle:obj[@"title"]];
            [bbv setBadgeCount:0];
            [bbv addTarget:self action:@selector(pushToOrderView:) forControlEvents:UIControlEventTouchUpInside];
            [logisticsConView addSubview:bbv];
        }];

        
        
        UIImage *arrowImage = ImageHandler.getRightArrow;
        
        NSValue *nsValue = [NSValue valueWithPointer:@selector(pushToDifferentVC:)];
        __block CGRect lastRowRect = logisticsViewRect;
        lastRowRect.origin.y = CGRectGetMaxY(logisticsViewRect)+vAdjustByScreenRatio(16.0f);
        lastRowRect.size.height = vAdjustByScreenRatio(40.0f);
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vStartSpace, 0.0f, vStartSpace);
        
        [self.settingList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *containerView = [[UIView alloc] initWithFrame:lastRowRect];
            [containerView setBackgroundColor:CDZColorOfWhite];
            [containerView setBorderWithColor:nil borderWidth:(0.5f)];
            [self.scrollView addSubview:containerView];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setFrame:containerView.bounds];
            [button setBackgroundColor:[UIColor clearColor]];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:vAdjustByScreenRatio(15.0f)]];
            
            [button setTitleEdgeInsets:insetsValue];
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [button setTitle:getLocalizationString(obj[@"title"]) forState:UIControlStateHighlighted];
            [button setTitle:getLocalizationString(obj[@"title"]) forState:UIControlStateNormal];
            [button setTitleColor:CDZColorOfBlack forState:UIControlStateHighlighted];
            [button setTitleColor:CDZColorOfBlack forState:UIControlStateNormal];
            [button setTintColor:CDZColorOfDefaultColor];
            [button setTag:vListBtnBaseTag+idx];
            [button addTarget:self action:[nsValue pointerValue] forControlEvents:UIControlEventTouchUpInside];
            [containerView addSubview:button];
            
            
            UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(lastRowRect)-arrowImage.size.height-insetsValue.right,
                                                                                        (CGRectGetHeight(lastRowRect)-arrowImage.size.height)/2.0f,
                                                                                        arrowImage.size.width,
                                                                                        arrowImage.size.height)];
            [arrowImageView setImage:arrowImage];
            [containerView addSubview:arrowImageView];
            
            if ([obj[@"title"] isEqualToString:@"my_autos"]) {
                NSString *selectedCarText = @"";
                UIFont *selectedCarFont = [UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)];
                CGSize textSize = [SupportingClass getStringSizeWithString:selectedCarText
                                                                       font:selectedCarFont
                                                                widthOfView:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(lastRowRect))];
                CGRect selectedCarRect = containerView.bounds;
                selectedCarRect.size.width = textSize.width+vStartSpace*2.0f;
                selectedCarRect.origin.x = CGRectGetMinX(arrowImageView.frame)-CGRectGetWidth(selectedCarRect);
                
                self.selectedCarLabel = [[InsetsLabel alloc] initWithFrame:selectedCarRect andEdgeInsetsValue:insetsValue];
                [self.selectedCarLabel setText:selectedCarText];
                [self.selectedCarLabel setTextColor:[UIColor redColor]];
                [self.selectedCarLabel setFont:selectedCarFont];
                [self.selectedCarLabel setTextAlignment:NSTextAlignmentRight];
                [containerView addSubview:self.selectedCarLabel];

            }
            
            
            if (![[self.settingList lastObject] isEqual:obj]) {
                CGFloat o2oSpace = ([obj[@"o2o_space"] boolValue]?vAdjustByScreenRatio(16.0f):0.0f);
                CGFloat lastRowMaxY = CGRectGetMaxY(lastRowRect);
                lastRowRect.origin.y = lastRowMaxY+o2oSpace;
                
            }
            self.unLoginLastRect = lastRowRect;
        }];
        
        self.logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _logoutButton.frame = CGRectMake(CGRectGetWidth(_scrollView.frame)*0.08, CGRectGetMaxY(lastRowRect)+30.0f, CGRectGetWidth(_scrollView.frame)*0.84, 36);
        _logoutButton.backgroundColor = CDZColorOfRed;
        _logoutButton.hidden = YES;
        [_logoutButton setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_logoutButton setTitle:getLocalizationString(@"logout") forState:UIControlStateNormal];
        [_logoutButton setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [_logoutButton addTarget:self action:@selector(userLogout) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_logoutButton];
        
        [self reLoadAllView];
        
    }
    
}

#pragma mark- Access User Info Section
- (void)getUserDetail {
    if (!self.accessToken) {
        if(_userInfo){
            self.userInfo = nil;
        }
        [self reLoadAllView];
        return;
    }
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] personalCenterAPIsGetPersonalInformationWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    
    if (error&&!responseObject) {
        [ProgressHUDHandler dismissHUD];
    }else if (!error&&responseObject) {
        
        [ProgressHUDHandler dismissHUD];
        if ([APIsErrorHandler isTokenErrorWithResponseObject:responseObject]) {
            @weakify(self)
            [UserBehaviorHandler.shareInstance userLogoutWasPopupDialog:YES andCompletionBlock:^{
                @strongify(self)
                self.userInfo = nil;
                [self reLoadAllView];
            }];
            return;
        }
        
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            return;
        }
        self.userInfo = [UserInfosDTO new];
        [_userInfo processDataToObjectWithData:[responseObject objectForKey:CDZKeyOfResultKey] isFromDB:NO];
        [self reLoadAllView];
        if (self.isShowUserDetail) {
            [self pushToUserDetail];
        }
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
@end