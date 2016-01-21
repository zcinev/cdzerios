//
//  MCSCAddressView.m
//  cdzer
//
//  Created by KEns0n on 7/17/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight 140.0f

#import "MCSCAddressView.h"
#import "InsetsLabel.h"
#import "AddressDTO.h"
#import "MyAddressesVC.h"
#import "AFViewShaker.h"
#import <UIView+Borders/UIView+Borders.h>

@interface MCSCAddressView ()

@property (nonatomic, strong) InsetsLabel *PCDLabel;

@property (nonatomic, strong) InsetsLabel *userNameLabel;

@property (nonatomic, strong) InsetsLabel *mobilePhoneLabel;

@property (nonatomic, strong) InsetsLabel *postCodeLabel;

@property (nonatomic, strong) InsetsLabel *addressLabel;

@property (nonatomic, strong) InsetsLabel *loadingView;

@property (nonatomic, strong) UIButton *reminderBtn;

@property (nonatomic, assign) BaseViewController *container;

@property (nonatomic, strong) AddressDTO *dto;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) AFViewShaker *viewShaker;

@end

@implementation MCSCAddressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    self.container = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    CGRect frame = UIScreen.mainScreen.bounds;
    frame.size.height = vMinHeight;
    self = [self initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.height<vMinHeight) {
        frame.size.height = vMinHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CDZColorOfWhite;
        self.dto = [DBHandler.shareInstance getUserDefaultAddress];
        [self initializationUI];
        [self addTopBorderWithHeight:1.0f andColor:CDZColorOfLightGray];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(getAddressSelection:) name:CDZNotiKeyOfSelectedAddress object:nil];
    }
    return self;
}

- (InsetsLabel *)insetLabelInitialWithFrame:(CGRect)frame {
    UIEdgeInsets insetValue = UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 10.0f);
    UIFont *font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
    InsetsLabel *label = [[InsetsLabel alloc] initWithFrame:frame andEdgeInsetsValue:insetValue];
    label.font = font;
    label.numberOfLines = 0;
    [self addSubview:label];
    return label;
}

- (InsetsLabel *)insetLabelInitialWithIndependentTitleLabel:(NSString *)title andFrame:(CGRect)frame  {
    UIEdgeInsets defaultInsetValue = UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 10.0f);
    UIFont *font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
    if (!title) title = @"";
    
    UIEdgeInsets insetValueL = defaultInsetValue;
    insetValueL.right = 0.0f;
    NSString *titleString = title;
    CGSize size = [SupportingClass getStringSizeWithString:titleString font:font widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGRect titleRect = CGRectZero;
    titleRect.size.width = size.width+insetValueL.left;
    titleRect.size.height = CGRectGetHeight(frame);
    
    InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:insetValueL];
    titleLabel.text = titleString;
    titleLabel.font = font;
    
    UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, CGRectGetWidth(titleRect), 0.0f, defaultInsetValue.right);
    InsetsLabel *label = [[InsetsLabel alloc] initWithFrame:frame andEdgeInsetsValue:insetsValue];
    label.text = @"";
    label.font = font;
    label.numberOfLines = 0;
    [self addSubview:label];
    [label addSubview:titleLabel];

    return label;
}

- (void)shakeView {
    if (!_addressID) {
        [_viewShaker shake];
    }
}

- (void)initializationUI {
    CGFloat height = (CGRectGetHeight(self.frame)-20.0f)/5.0f;
    
    self.PCDLabel = [self insetLabelInitialWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), height)];
    _PCDLabel.text = @"区域：";
    
    self.userNameLabel = [self insetLabelInitialWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_PCDLabel.frame), CGRectGetWidth(self.frame), height)];
    _userNameLabel.text = @"姓名：";
    
    self.mobilePhoneLabel = [self insetLabelInitialWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_userNameLabel.frame), CGRectGetWidth(self.frame), height)];
    _mobilePhoneLabel.text = @"电话：";
    
    self.postCodeLabel = [self insetLabelInitialWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_mobilePhoneLabel.frame), CGRectGetWidth(self.frame), height)];
    _postCodeLabel.text = @"邮政编号：";
    
    self.addressLabel = [self insetLabelInitialWithIndependentTitleLabel:@"地址：" andFrame:CGRectMake(0.0f, CGRectGetMaxY(_postCodeLabel.frame), CGRectGetWidth(self.frame), height+20.0f)];
    
    self.reminderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _reminderBtn.frame = self.bounds;
    _reminderBtn.backgroundColor = CDZColorOfWhite;
    _reminderBtn.titleLabel.numberOfLines = 0;
    _reminderBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_reminderBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
    [_reminderBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateHighlighted];
    [_reminderBtn addTarget:self action:@selector(pushToAddressSelelctView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reminderBtn];
    
    self.loadingView = [self insetLabelInitialWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_postCodeLabel.frame), CGRectGetWidth(self.frame), height)];
    _loadingView.textAlignment = NSTextAlignmentCenter;
    _loadingView.backgroundColor = CDZColorOfWhite;
    _loadingView.text = @"载入中.......";
    _loadingView.hidden = YES;
    
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicatorView.hidesWhenStopped = NO;
    [indicatorView startAnimating];
    [_loadingView addSubview:indicatorView];
    indicatorView.center = CGPointMake(CGRectGetWidth(_loadingView.frame)/2.0f, CGRectGetWidth(_loadingView.frame)/2.0f-10);
    
    self.viewShaker = [[AFViewShaker alloc] initWithView:self];
    
    [self getUserAddressList];
}

- (void)updateAddress {
    if (_dto&&_dataList&&_dataList.count!=0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.addressID == %@ ", _dto.addressID];
        NSArray *resultList = [_dataList filteredArrayUsingPredicate:predicate];
        if (resultList&&resultList.count!=0) {
            self.addressID = _dto.addressID;
            _PCDLabel.text = [NSString stringWithFormat:@"区域：%@ %@ %@",_dto.provinceName, _dto.cityName, _dto.regionName];
            _userNameLabel.text = [@"姓名：" stringByAppendingString:_dto.consigneeName];
            _mobilePhoneLabel.text = [@"电话：" stringByAppendingString:_dto.telNumber];
            _postCodeLabel.text = [@"邮政编号：" stringByAppendingString:_dto.consigneeName];
            _addressLabel.text = _dto.address;
            _reminderBtn.backgroundColor = CDZColorOfClearColor;
            [_reminderBtn setTitle:@"" forState:UIControlStateNormal];
            [_reminderBtn setTitle:@"" forState:UIControlStateHighlighted];
        }else {
            self.dto = nil;
            [DBHandler.shareInstance clearUserDefaultAddress];
            [self updateAddress];
            
        }
    }else {
        _PCDLabel.text = @"区域：";
        _userNameLabel.text = @"姓名：";
        _mobilePhoneLabel.text = @"电话：";
        _postCodeLabel.text = @"邮政编号：";
        _addressLabel.text = @"";
        _reminderBtn.backgroundColor = CDZColorOfWhite;
        [_reminderBtn setTitle:@"还没设置预设地址\n请点击这里选择地址！" forState:UIControlStateNormal];
        [_reminderBtn setTitle:@"还没设置预设地址\n请点击这里选择地址！" forState:UIControlStateHighlighted];
        self.addressID = nil;
    }
    
}

- (void)setAddressID:(NSString *)addressID {
    _addressID = addressID;
}

- (void)setSuperContainer:(id)container {
    self.container = container;
}

- (void)pushToAddressSelelctView {
    @autoreleasepool {
        if (_container) {
            MyAddressesVC *vc = [MyAddressesVC new];
            vc.isForSelection = YES;
            vc.selectedDTO = _dto;
            [_container setNavBarBackButtonTitleOrImage:nil titleColor:nil];
            [_container.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)getAddressSelection:(NSNotification *)notification {
    if ([notification.object isKindOfClass:AddressDTO.class]) {
        self.dto = notification.object;
        [self updateAddress];
    }
}

- (void)getUserAddressList {
    if (!vGetUserToken)return;
    
    _loadingView.hidden = NO;
    NSLog(@"%@ accessing network request",NSStringFromClass(self.class));
    [[APIsConnection shareConnection] personalCenterAPIsGetShippingAddressListWithAccessToken:vGetUserToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}
- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    
    _loadingView.hidden = YES;
    _PCDLabel.text = @"区域：";
    _userNameLabel.text = @"姓名：";
    _mobilePhoneLabel.text = @"电话：";
    _postCodeLabel.text = @"邮政编号：";
    _addressLabel.text = @"";
    _reminderBtn.backgroundColor = CDZColorOfWhite;
    [_reminderBtn setTitle:@"还没设置预设地址\n请点击这里选择地址！" forState:UIControlStateNormal];
    [_reminderBtn setTitle:@"还没设置预设地址\n请点击这里选择地址！" forState:UIControlStateHighlighted];
    if (!error&&responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode==0) {
            self.dataList = [AddressDTO handleDataListToDTOList:[responseObject objectForKey:CDZKeyOfResultKey]];
        }
    }
    [self updateAddress];
    
    
}

@end
