//
//
//  RealtimeAutoInfoVC.m
//  cdzer
//
//  Created by KEns0n on 5/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "RealtimeAutoInfoVC.h"
#import "InsetsLabel.h"
#define vLabelTag 100
@interface RealtimeAutoInfoVC ()

@property (nonatomic, strong) UIView *imageBGView;

@property (nonatomic, strong) InsetsLabel *engineRPMLabel;
@property (nonatomic, strong) InsetsLabel *battaryVoltage;
@property (nonatomic, strong) InsetsLabel *waterTemperature;
@property (nonatomic, strong) InsetsLabel *totalMiles;
@property (nonatomic, strong) InsetsLabel *autoSpeed;
@property (nonatomic, strong) InsetsLabel *fuelConsumption;
@property (nonatomic, strong) InsetsLabel *fuelConsumptionPerKM;
@property (nonatomic, strong) InsetsLabel *journeyTime;


@end

@implementation RealtimeAutoInfoVC


- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    @autoreleasepool {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshODBData)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    [self initializationUI];
    
    // Do any additional setup after loading the view.
}

- (void)labelInitialByID:(NSInteger)identID {
    @autoreleasepool {
        UIEdgeInsets insetValue = UIEdgeInsetsZero;
        CGRect rect = CGRectZero;
        rect.size = CGSizeMake(CGRectGetWidth(_imageBGView.frame), 20.f);
        InsetsLabel *dataLabel = [InsetsLabel new];
        switch (identID) {
            case 0:
                self.engineRPMLabel = dataLabel;
                insetValue.right = 251.0f;
                rect.origin.y = 5.0f;
                break;
                
            case 1:
                self.battaryVoltage = dataLabel;
                insetValue.right = 94.0f;
                rect.origin.y = 2.0f;
                break;
                
            case 2:
                self.waterTemperature = dataLabel;
                insetValue.right = 269.0f;
                rect.origin.y = 71.0f;
                break;
                
            case 3:
                self.totalMiles = dataLabel;
                insetValue.right = 230.0f;
                rect.origin.y = 229.0f;
                break;
                
            case 4:
                self.autoSpeed = dataLabel;
                insetValue.right = 63.0f;
                rect.origin.y = 253.0f;
                break;
                
            case 5:
                self.fuelConsumption = dataLabel;
                insetValue.right = 261.0f;
                rect.origin.y = 286.0f;
                break;
                
            case 6:
                self.fuelConsumptionPerKM = dataLabel;
                insetValue.right = 198.0f;
                rect.origin.y = 318.0f;
                break;
                
            case 7:
                self.journeyTime = dataLabel;
                insetValue.right = 108.0f;
                rect.origin.y = 351.0f;
                break;
                
            default:
                break;
        }
        dataLabel.frame = rect;
        dataLabel.edgeInsets = insetValue;
        dataLabel.textAlignment = NSTextAlignmentRight;
        dataLabel.font = systemFontBoldWithoutRatio(18.0f);
        dataLabel.text = @"--";
        dataLabel.textColor = CDZColorOfDefaultColor;
        [_imageBGView addSubview:dataLabel];
    }
}

- (void)initializationUI {
    @autoreleasepool {
        UIImage *image = [ImageHandler getImageFromCacheWithByFixdeRatioFileRootPath:kSysImageCaches fileName:@"ic_car_current" type:FMImageTypeOfPNG needToUpdate:NO];
        CGRect rect = CGRectZero;
        rect.size = image.size;
        
        self.imageBGView = [[UIView alloc] initWithFrame:rect];
        _imageBGView.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0, CGRectGetHeight(self.contentView.frame)/2.0);
        [self.contentView addSubview:_imageBGView];
        [self.imageBGView setBackgroundImageByCALayerWithImage:image];
        
        
        for (int i=0; i<8; i++) {
            [self labelInitialByID:i];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserAutoOBDData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshODBData {
    NSString *status = @"0";
    if (![status isEqualToString:@"0"]) {
        CGRect frame =  CGRectMake(20, self.view.frame.size.height-150,self.view.frame.size.width-40, 45);
        NSString *msg ;
        if ([status isEqualToString:@"1"]) {
            msg = @"熄火";
        }else if([status isEqualToString:@"2"]){
            msg = @"离线";
        }else{
            msg = @"无信号";
        }
        NSString *text = [NSString stringWithFormat:@"您当前的车辆处于%@状态，此数据是历史数据，请检查设备是否安装正确！",msg];
        [SupportingClass addLabelWithFrame:frame content:text radius:5.0f fontSize:13.0f parentView:self.view isAlertShow:YES pushBlock:^{
            
        }];
        return;
    }
    [self getUserAutoOBDData];
}

#pragma mark- Data Handle Request
- (void)handleResponseData:(id)responseObject {
    if (!responseObject||![responseObject isKindOfClass:NSDictionary.class]) {
        NSLog(@"data Error");
        return;
    }
    
    if ([responseObject count]==0) {
        self.engineRPMLabel.text = @"--";
        self.battaryVoltage.text = @"--";
        self.waterTemperature.text = @"--";
        self.totalMiles.text = @"--";
        self.autoSpeed.text = @"--";
        self.fuelConsumption.text = @"--";
        self.fuelConsumptionPerKM.text = @"--";
        self.journeyTime.text = @"--";
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"没有更多ODB数据！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
         
        }];
        return;
    }
    self.engineRPMLabel.text = responseObject[@"fdjzs"];
    self.battaryVoltage.text = responseObject[@"dpdy"];
    self.waterTemperature.text = responseObject[@"sw"];
    self.totalMiles.text = responseObject[@"lc"];
    self.autoSpeed.text = responseObject[@"cs"];
    self.fuelConsumption.text = responseObject[@"yh"];
    self.fuelConsumptionPerKM.text = responseObject[@"bglyh"];
    self.journeyTime.text = responseObject[@"xssj"];
}

#pragma mark- APIs Access Request
- (void)getUserAutoOBDData {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUD];
    [[APIsConnection shareConnection] personalGPSAPIsGetAutoOBDDataWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }else if (!error&&responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
//                if ([APIsErrorHandler isTokenErrorWithResponseObject:responseObject]) {
//                    [self setAccessToken:nil];
//                    [self.navigationController popViewControllerAnimated:YES];
//                }
            }];
            return;
        }
        
        NSLog(@"%@",responseObject);
        [self handleResponseData:responseObject[CDZKeyOfResultKey]];
        
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
