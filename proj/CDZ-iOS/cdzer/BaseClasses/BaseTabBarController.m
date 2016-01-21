//
//  BaseTabBarController.m
//  cdzer
//
//  Created by KEns0n on 3/23/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UIView *navBarTitleView;

@property (nonatomic, strong) UIImageView *titleImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BaseTabBarController

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


#pragma mark- UI initialization
- (void)setNavBarImage {
    @autoreleasepool {
        if (!_navBarTitleView) {
            
            // Create a UIImage & Calculate The Size
            // ImageHandler has Import at cdzer-Prefix.pch
            UIImage *image = [ImageHandler imageResizeToNormalRetinaByFixedRatioWithPath:[[NSBundle mainBundle] pathForResource:@"top_logo" ofType:@"png"]];
            CGSize realImageSize = [ImageHandler getImageTureSizeFromIamge:image];
            CGRect rect = CGRectZero;
            rect.origin = CGPointMake((CGRectGetWidth(self.view.frame)-realImageSize.width)/2.0f, (vNavBarHeight-realImageSize.height)/2.0f);
            rect.size = realImageSize;
            
            // Initial View
            self.navBarTitleView = [UIView new];
            [_navBarTitleView setFrame:rect];
            
            self.titleLabel = [[UILabel alloc] initWithFrame:_navBarTitleView.bounds];
            [_titleLabel setHidden:YES];
            [_titleLabel setTextColor:[UIColor whiteColor]];
            [_titleLabel setTextAlignment:NSTextAlignmentCenter];
            [_titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
            [_navBarTitleView addSubview:_titleLabel];
            

            
            self.titleImageView = [UIImageView new];
            [_titleImageView setImage:image];
            [_titleImageView setFrame:_navBarTitleView.bounds];
            [_navBarTitleView addSubview:_titleImageView];
            
            [self.navigationItem setTitleView:_navBarTitleView];
            
            image = nil;
        }
        
        
    }
}

- (void)showTitleImageView {
    [_titleLabel setHidden:YES];
    [_titleImageView setHidden:NO];
    
}

- (void)showTitleLabelWithTitle:(NSString *)titleString {
    [_titleLabel setText:titleString];
    [_titleLabel setHidden:NO];
    [_titleImageView setHidden:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarImage];
    [self setDelegate:(id)self];
    [self setUpTabBariCons];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selectOrderViewTab)
                                                 name:CDZNotiKeyOfSelectOrderViewInTabBarVC
                                               object:nil];
}

- (void)selectOrderViewTab {
    self.selectedIndex = 1;
}

- (void)setUpTabBariCons {
    @autoreleasepool {
        
        UIImage *imageTab1 = [ImageHandler getImageFromCacheWithByFixdeRatioFileRootPath:kSysImageCaches
                                                                                fileName:@"home_off"
                                                                                    type:FMImageTypeOfPNG
                                                                            needToUpdate:NO];
        UIImage *imageTab2 = [ImageHandler getImageFromCacheWithByFixdeRatioFileRootPath:kSysImageCaches
                                                                                fileName:@"shopping_cart_off"
                                                                                    type:FMImageTypeOfPNG
                                                                            needToUpdate:NO];
        UIImage *imageTab3 = [ImageHandler getImageFromCacheWithByFixdeRatioFileRootPath:kSysImageCaches
                                                                                fileName:@"personal_center_off"
                                                                                    type:FMImageTypeOfPNG
                                                                            needToUpdate:NO];
        
        UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:getLocalizationString(@"home") image:imageTab1 tag:0];
        UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:getLocalizationString(@"shopping_cart") image:imageTab2 tag:1];
        UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:getLocalizationString(@"personal_center") image:imageTab3 tag:2];
        
        NSArray * tabBarItems = [NSArray arrayWithObjects:tabBarItem1, tabBarItem2, tabBarItem3, nil];
        [self.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[BaseViewController class]]) {
                [obj setTabBarItem:tabBarItems[idx]];
            }
        }];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end
