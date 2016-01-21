//
//  FastPreventionVC.m
//  cdzer
//
//  Created by KEns0n on 6/2/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "FastPreventionVC.h"
#import "MBSliderView.h"

@interface FastPreventionVC () <MBSliderViewDelegate>

@property (nonatomic, strong) UILabel *tagLa;

@property (nonatomic, strong) UIButton *circleBtn;

@property (nonatomic, strong) UIButton *lockBtn;

@end

@implementation FastPreventionVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.contentView setBackgroundImageByCALayerWithImage:[UIImage imageNamed:@"f_bg@2x.png"]];
    self.title = @"快速设防";
    [self setReactiveRules];
    [self componentSetting];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getFastPreventionDetail];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setReactiveRules {
    
}

- (void)componentSetting {
}

- (void)initializationUI {
    
    UIImageView *sliderImg = [[UIImageView alloc] init];
    sliderImg.frame = CGRectMake(0.0f, 350, 280, 52);
    sliderImg.image = [UIImage imageNamed:@"f_slider_bg"];
    sliderImg.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0f, sliderImg.center.y);
    
    self.tagLa =[[UILabel alloc] init];
    self.tagLa.frame = sliderImg.frame;
    self.tagLa.textColor = [UIColor whiteColor];
    self.tagLa.textAlignment = NSTextAlignmentCenter;
    self.tagLa.text = @"开启设防";
    
    
    MBSliderView *silderView = [[MBSliderView alloc] init];
    silderView.delegate = self ;
    silderView.frame = CGRectMake(0.0f, 361, 274, 31);
    [silderView setThumbColor:[UIColor whiteColor]];
    [silderView setLabelColor:[UIColor clearColor]];
    silderView.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0f, silderView.center.y);
    
    [self.view addSubview:self.tagLa];
    [self.view addSubview:sliderImg];
    [self.view addSubview:silderView];
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    self.circleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _circleBtn.frame = CGRectMake(63, 62, 207, 291);
    _circleBtn.userInteractionEnabled = NO;
    _circleBtn.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0f, _circleBtn.center.y);
    [_circleBtn setImage:[UIImage imageNamed:@"f_circle"] forState:UIControlStateNormal];
    [self.contentView addSubview:_circleBtn];
    
    self.lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lockBtn.frame = CGRectMake(131, 126, 78, 65);
    _lockBtn.userInteractionEnabled = NO;
    _lockBtn.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0f, _lockBtn.center.y);
    [_lockBtn setImage:[UIImage imageNamed:@"f_open_lock"] forState:UIControlStateNormal];
    [_lockBtn setImage:[UIImage imageNamed:@"f_close_lock"] forState:UIControlStateSelected];
    [self.contentView addSubview:_lockBtn];
    
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    

}

bool isOpen ;
#pragma mark 滑动条的监听方法
-(void)sliderDidSlide:(MBSliderView *)slideView{
    isOpen = !isOpen ;
    if(isOpen){
        [self shutdownFastPreventionProtect];
    }else{
        [self turnOnFastPreventionProtect];
    }
}


#pragma mark- APIs Access Request

- (void)getFastPreventionDetail {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUDWithTitle:getLocalizationString(@"loading") onView:nil];
    NSDictionary *userInfo = @{@"ident":@0};
    [[APIsConnection shareConnection] personalGPSAPIsGetFastPreventionDetailWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)turnOnFastPreventionProtect {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUDWithTitle:@"正在开启设防...." onView:nil];
    NSDictionary *userInfo = @{@"ident":@1};
    [[APIsConnection shareConnection] personalGPSAPIsPostFastPreventionOfnWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)shutdownFastPreventionProtect {
    if (!self.accessToken) return;
    [ProgressHUDHandler updateProgressStatusWithTitle:@"正在关闭设防...."];
    NSDictionary *userInfo = @{@"ident":@2};
    
    [[APIsConnection shareConnection] personalGPSAPIsPostFastPreventionOffWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = userInfo;
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    NSNumber *ident = operation.userInfo[@"ident"];
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        [ProgressHUDHandler showError];
    }else if (!error&&responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);        switch (errorCode) {
            case 0:
                NSLog(@"%@",responseObject);
                switch (ident.integerValue) {
                    case 0:{
                        BOOL isON = [responseObject[CDZKeyOfResultKey] boolValue];
                        isOpen = isON ;
                        self.circleBtn.selected = isON;
                        self.tagLa.text = isON?@"关闭设防":@"开启设防";
                        [ProgressHUDHandler dismissHUD];
                    }
                        break;
                        
                    case 1:
                        self.tagLa.text = @"关闭设防";
                        self.lockBtn.selected = NO ;
                        self.circleBtn.selected = !self.circleBtn.selected ;
                        [ProgressHUDHandler showSuccessWithStatus:@"开启成功" onView:nil completion:^{
                            
                        }];
                        break;
                        
                    case 2:
                        self.tagLa.text = @"开启设防";
                        self.lockBtn.selected = YES ;
                        self.circleBtn.selected = !self.circleBtn.selected ;
                        [ProgressHUDHandler showSuccessWithStatus:@"关闭成功" onView:nil completion:^{
                            
                        }];
                        break;
                        
                    default:
                        break;
                }
                break;
            case 1:
            case 2:{
                [ProgressHUDHandler dismissHUD];
                NSString *title = getLocalizationString(@"error");
                if (ident.integerValue == 1) {
                    title = getLocalizationString(@"alert_remind");
                }
                
                @weakify(self)
                [SupportingClass showAlertViewWithTitle:title message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                    if ([APIsErrorHandler isTokenErrorWithResponseObject:responseObject]) {
                        @strongify(self)
                        [self setAccessToken:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                        return;
                    }
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
    
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
