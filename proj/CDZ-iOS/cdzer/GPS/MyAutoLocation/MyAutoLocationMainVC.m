//
//  MyAutoLocationMainVC.m
//  cdzer
//
//  Created by KEns0n on 5/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MyAutoLocationMainVC.h"
#import "MyAutoLocationVC.h"
#import "AutosDrivingRecordVC.h"
#import "DrivingNavigationVC.h"
@interface MyAutoLocationMainVC ()<UITabBarControllerDelegate>

@end

@implementation MyAutoLocationMainVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self initializationUI];
    [self setDelegate:(id)self];
    [self setUpTabBariCons];
}

- (void)setUpTabBariCons {
    @autoreleasepool {
        
        UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:getLocalizationString(@"my_favorite_auto")
                                                                  image:[UIImage imageNamed:@"c_tab_mycar"]
                                                          selectedImage:[UIImage imageNamed:@"c_tab_mycar_p"]];
        tabBarItem1.tag = 0;
        UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:getLocalizationString(@"my_auto_driving_record")
                                                                  image:[UIImage imageNamed:@"c_tab_historicalroute"]
                                                          selectedImage:[UIImage imageNamed:@"c_tab_historicalroute_p"]];
        tabBarItem2.tag = 1;
        UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:getLocalizationString(@"my_auto_navigation")
                                                                  image:[UIImage imageNamed:@"c_tab_gps"]
                                                          selectedImage:[UIImage imageNamed:@"c_tab_gps_p"]];
        tabBarItem3.tag = 2;
        
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

- (void)initializationUI {
    @autoreleasepool {
        MyAutoLocationVC *VC1 = [[MyAutoLocationVC alloc] init];
        
        AutosDrivingRecordVC *VC2 = [[AutosDrivingRecordVC alloc] init];
        
        DrivingNavigationVC *VC3 = [[DrivingNavigationVC alloc] init];
        
        NSArray* controllers = [NSArray arrayWithObjects:VC1, VC2, VC3, nil];
        self.viewControllers = controllers;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

@end
