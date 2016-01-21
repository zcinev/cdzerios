//
//  BaseViewController.m
//  cdzer
//
//  Created by KEns0n on 2/6/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "BaseViewController.h"
#import "UserLoginVC.h"
#import "VehicleSelectionPickerVC.h"
#import "CitySelectionVC.h"
#import "KeyCityDTO.h"


@interface BaseViewController ()
@end

@implementation BaseViewController


- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([SupportingClass isOS7Plus]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
    @autoreleasepool {
        CGRect rect = self.view.bounds;
        if (self.navigationController) {
            rect.size.height -= vNavBarHeight;
        }
        if(self.tabBarController){
            rect.size.height -= CGRectGetHeight(self.tabBarController.tabBar.frame);
            if (self.tabBarController.navigationController&&!self.navigationController) {
                rect.size.height -= vNavBarHeight;
            }
        }
        UIView *contentView = [[UIView alloc]initWithFrame:rect];
        [contentView setBackgroundColor:CDZColorOfWhite];
        [self.view addSubview:contentView];
        [self setContentView:contentView];
        contentView = nil;
    }
    [self setAccessToken:vGetUserToken];
    
    // Do any additional setup after loading the view.
}

- (void)presentLoginViewAtViewController:(id)viewController backTitle:(NSString *)backTitle animated:(BOOL)flag completion:(void (^)(void))completion{
    
    @autoreleasepool {
        if (!viewController) {
            viewController = self;
        }
        UserLoginVC *vc = [UserLoginVC new];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [viewController setNavBarBackButtonTitleOrImage:backTitle titleColor:nil];
        [viewController presentViewController:vc animated:flag completion:completion];
    }
}

- (void)pushToAutoSelectionViewWithBackTitle:(NSString *)backTitle animated:(BOOL)flag onlyForSelection:(BOOL)onlyForSelection {
    
    @autoreleasepool {
        if (backTitle) {
            backTitle = getLocalizationString(backTitle);
        }
        VehicleSelectionPickerVC *vc = [VehicleSelectionPickerVC new];
        vc.onlyForSelection = onlyForSelection;
        [self setNavBarBackButtonTitleOrImage:backTitle titleColor:nil];
        
        if (self.tabBarController) {
            
            [self.tabBarController.navigationController pushViewController:vc animated:flag];
            return;
        }
        
        [self.navigationController pushViewController:vc animated:flag];
    }
}

- (void)pushToCitySelectionViewWithBackTitle:(NSString *)backTitle selectedCity:(KeyCityDTO *)selectedCity hiddenLocation:(BOOL)hidden onlySelection:(BOOL)onlySelection animated:(BOOL)flag {
    
    @autoreleasepool {
        if (backTitle) {
            backTitle = getLocalizationString(backTitle);
        }
        CitySelectionVC *vc = [CitySelectionVC new];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        vc.selectedCity = selectedCity;
        vc.hiddenLocationView = hidden;
        vc.selectionWithoutSave = onlySelection;
        [self setNavBarBackButtonTitleOrImage:backTitle titleColor:nil];
        
        if (self.tabBarController) {
            
            [self.tabBarController.navigationController pushViewController:vc animated:flag];
            return;
        }
        
        [self.navigationController pushViewController:vc animated:flag];
    }
}

//- (void)makeACall:(NSString *)number {
//    NSLog(@"%d",IS_SIMULATOR);
//    NSLog(@"%d",IS_IPHONE);
//    if (IS_IPHONE&&/* DISABLES CODE */ (!IS_SIMULATOR)) {
//        [SupportingClass showAlertViewWithTitle:@"alert_remind"
//                                        message:[NSString stringWithFormat:@"系统将会拨打以下号码：\n%@", number]
//                                isShowImmediate:YES cancelButtonTitle:@"cancel"
//                              otherButtonTitles:@"ok" clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
//                                  if (btnIdx.integerValue == 1) {
//                                      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:number]]];
//                                  }
//                              }];
//    }else {
//        [SupportingClass showAlertViewWithTitle:@"alert_remind"
//                                        message:[@"本机不支援拨号功能！\n请用有拨号功能的电话拨打以下号码：\n" stringByAppendingString:number]
//                                isShowImmediate:YES cancelButtonTitle:@"ok"
//                              otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
//    }
//  
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setAccessToken:vGetUserToken];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}
@end
