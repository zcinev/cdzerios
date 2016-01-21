//
//  BaseNavigationController.m
//  cdzer
//
//  Created by KEns0n on 2/6/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "BaseNavigationController.h"
#import <unistd.h>


@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *barBKC = CDZColorOfDefaultColor;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:CDZColorOfWhite};
    self.navigationBar.barTintColor = barBKC;
    self.navigationBar.backgroundColor = barBKC;
    self.navigationBar.tintColor = CDZColorOfWhite;
    self.navigationBar.layer.borderWidth = 1;
    self.navigationBar.layer.borderColor = [barBKC CGColor];
    // Do any additional setup after loading the view.

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showWithGradient:(NSNotification *)notifi {
    NSString *message = @"加载中";
    if ([notifi object] && [[notifi object] isKindOfClass:[NSString class]]) {
       message = [[notifi object] stringValue];
    }
}

- (void)hideHUD:(NSNotification *)notifi {
    
}

/*
#pragma mark- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}
@end
