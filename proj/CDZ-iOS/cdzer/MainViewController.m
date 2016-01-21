//
//  ViewController.m
//  cdzer
//
//  Created by KEns0n on 2/4/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MainViewController.h"
#import "KeyCityDTO.h"
#import "UserLocationHandler.h"
#import "APIsConnection.h"
#import "CommonTabBar.h"
#import "AdvertisingScrollView.h"
#import "MPSectionContainer.h"
#import "RepairMainVC.h"
#import "RepairShopVC.h"
#import "VehicleSelectionPickerVC.h"
#import "RepairShopSearchResultVC.h"
#import "CommentListVC.h"
#import "SelfRepairVC.h"
#import "PersonalCenterMainVC.h"
#import "UserLoginVC.h"
#import "PartStoreSearchVC.h"
#import "GPSMainVC.h"
#import "GPSSettingVC.h"
#import "GPSAlertSettingVC.h"
#import "ShopAppointmentVC.h"
#import "MessageAlertVC.h"
#import "WriteCommentVC.h"
#import "RepairCasesVC.h"
#import "CitySelectionVC.h"
#import "UserRegisterVC.h"
#import "GPSAppointmentVC.h"


@interface MainViewController () <UITabBarDelegate, MPSBDelegate>

//@property (nonatomic, strong) CommonTabBar *commonTabBar;

@property (nonatomic, strong) AdvertisingScrollView *advertSrollView;

@property (nonatomic, strong) MPSectionContainer *btnsViewContainer;

@end

@implementation MainViewController
  
- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationUI];
    // Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(delayRun) withObject:self afterDelay:1];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [(BaseTabBarController *)self.tabBarController showTitleImageView];
}

#pragma -mark UI initialization

- (void)initializationUI {
    @autoreleasepool {
        [self setAdvertSrollView:[[AdvertisingScrollView alloc] initWithMinFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), 140.0f)]];
        [_advertSrollView initializationUIWithDataArray:@[@{@"user_bannerimg_str":@"01"},
                                                          @{@"user_bannerimg_str":@"02"},
                                                          @{@"user_bannerimg_str":@"03"},
                                                          @{@"user_bannerimg_str":@"04"},
                                                          @{@"user_bannerimg_str":@"05"},
                                                          @{@"user_bannerimg_str":@"06"},
                                                          @{@"user_bannerimg_str":@"07"},
                                                          @{@"user_bannerimg_str":@"08"},
                                                          @{@"user_bannerimg_str":@"09"}]];
        [self.contentView addSubview:_advertSrollView];
        
//        [self setCommonTabBar:[[CommonTabBar alloc] init]];
//        [_commonTabBar initializationUIWithID:0];
//        [_commonTabBar setCTBDelegate:self];
//        [self.contentView addSubview:_commonTabBar];
//        -CGRectGetHeight(self.tabBarController.tabBar.frame)
        CGFloat btnsViewHeight = CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(_advertSrollView.frame);
        [self setBtnsViewContainer:[[MPSectionContainer alloc] initWithFrame:CGRectMake(0.0f,
                                                                                        CGRectGetMaxY(_advertSrollView.frame),
                                                                                        CGRectGetWidth(self.view.bounds),
                                                                                        btnsViewHeight)]];
        [_btnsViewContainer initializationUI];
        [_btnsViewContainer setDelegate:self];
        [self.contentView addSubview:_btnsViewContainer];
    }
}

#pragma -mark MPSBDelegate For Push Other VC
- (void)MPSButtonResponseByType:(MPSButtonType)type {
    @autoreleasepool {
        id bvc = nil;
        NSString *backTitle = nil;
        switch (type) {
            case MPSButtonTypeOfGPS:
                if (UserBehaviorHandler.shareInstance.getUserType==CDZUserTypeOfUnknowUser) {
                    [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"请登入已绑定GPS的账户，方能使用GPS服务。" isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"login" clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                        if (btnIdx.integerValue>0) {
                            [self presentLoginViewAtViewController:self.tabBarController.navigationController backTitle:nil animated:YES completion:nil];
                        }
                    }];
                    return;
                }
                
                if(UserBehaviorHandler.shareInstance.getUserType==CDZUserTypeOfNormalUser){
                    [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"你的账号没有绑定GPS设备，请联络我们的客服咨询详情。" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                        if (btnIdx.integerValue>0) {
                        }
                    }];
                    return;
                }
                bvc = [GPSMainVC new];
//                bvc = [GPSAlertSettingVC new];
                break;
            case MPSButtonTypeOfRepair:
                bvc = [RepairMainVC new];
                break;
            case MPSButtonTypeOfParts:
                bvc = [PartStoreSearchVC new];
                break;
            case MPSButtonTypeOfUsedCars:
                
                break;
            case MPSButtonTypeOfTrafficViolation:
                
                break;
            case MPSButtonTypeOfVehicleManagement:
                break;
            case MPSButtonTypeOfGPSAppiontment:
                bvc = [GPSAppointmentVC new];
                backTitle = @"cancel";
                break;
            case MPSButtonTypeOfMessageHistory:
                bvc = [MessageAlertVC new];
                break;
            case MPSButtonTypeOfCS:
//                bvc = [WriteCommentVC new];
                break;
            default:
                break;
        }
        if (bvc) {
            [self setNavBarBackButtonTitleOrImage:backTitle titleColor:nil];
            [self.tabBarController.navigationController pushViewController:bvc animated:YES];
        }
    }
}

- (void)delayRun{
    @autoreleasepool {
        [UserLocationHandler checkSelectedKeyCity:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
