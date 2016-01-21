//
//  GPSAppointmentVC.m
//  cdzer
//
//  Created by KEns0n on 10/23/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "GPSAppointmentVC.h"
#import "GPSAppointmentContentVC.h"
#import "InsetsLabel.h"
#import "MyAutosInfoVC.h"
#import "MyCartVC.h"

@interface GPSAppointmentVC ()

@property (nonatomic, strong) GPSAppointmentNavVC *navVC;

@property (nonatomic, assign) BOOL resendAppointment;

@end

@implementation GPSAppointmentVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    if (_resendAppointment) {
        [_navVC retryAppointmentRequest];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
   
    
}

- (void)pushToUserAutosEditView {
    @autoreleasepool {
        MyAutosInfoVC *vc = [MyAutosInfoVC new];
        vc.wasBackRootView = YES;
        self.resendAppointment = YES;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)pushToMyCart {
    @autoreleasepool {
        MyCartVC *vc = [MyCartVC new];
        vc.popBackRootVC = YES;
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)initializationUI {
    @autoreleasepool {
        
        
        GPSAppointmentResultBlock resultBlock = ^(GPSAppointmentResultType result, NSString *errorString){
            switch (result) {
                case GPSAppointmentResultTypeOfMissingAutosData:
                    [self pushToUserAutosEditView];
                    break;
                    
                case GPSAppointmentResultTypeOfWasAppointmented:
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    break;
                    
                case GPSAppointmentResultTypeOfSuccess:
                    [self pushToMyCart];
                    break;
                    
                default:
                    break;
            }
        };
        
        GPSAppointmentContentVC *rootView = [[GPSAppointmentContentVC alloc] initWithStepID:0];
        self.navVC = [[GPSAppointmentNavVC alloc] initWithRootViewController:rootView];
        _navVC.navigationBarHidden = YES;
        _navVC.view.frame = self.contentView.bounds;
        [self.contentView addSubview:_navVC.view];
        _navVC.resultBlock = resultBlock;
        
        
        
    }
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, navVC.title) subscribeNext:^(NSString *title) {
        @strongify(self)
        self.title = title;
    }];
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
