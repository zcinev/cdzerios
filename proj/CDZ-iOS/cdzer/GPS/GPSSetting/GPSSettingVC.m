//
//  GPSSettingVC.m
//  cdzer
//
//  Created by KEns0n on 6/2/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIView+Borders/UIView+Borders.h>
#import "GPSSettingVC.h"
#import "GPSAlertSettingVC.h"
@interface GPSSettingVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *settingArray;

@property (nonatomic, strong) UISwitch *savePowerSwitch;

@end

@implementation GPSSettingVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GPS设置";
    [self setReactiveRules];
    [self componentSetting];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getPowerSaveStatus];
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
    self.settingArray = @[@[@{@"title":@"点火校正",@"icon":@"s_item0",@"topBorder":@(YES),@"bottomBorder":@(NO)},
                            @{@"title":@"设备安装设置",@"icon":@"s_item1",@"topBorder":@(NO),@"bottomBorder":@(YES)}],
                        @[@{@"title":@"报警设置",@"icon":@"u_item_03",@"topBorder":@(YES),@"bottomBorder":@(YES)}],
                        @[@{@"title":@"省电设置",@"icon":@"s_item2",@"topBorder":@(YES),@"bottomBorder":@(YES)}]];
}

- (void)initializationUI {
    self.savePowerSwitch = [[UISwitch alloc] init];
    _savePowerSwitch.on = NO;
    [_savePowerSwitch addTarget:self action:@selector(changePowerSaveStatus:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    _tableView.backgroundColor = [UIColor colorWithRed:0.937f green:0.937f blue:0.957f alpha:1.00f];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollsToTop = YES;
    _tableView.bounces = NO;
    [self.contentView addSubview:_tableView];

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
}

- (void)changePowerSaveStatus:(UISwitch *)powerSwitch {
    [self updatePowerSaveStatus:powerSwitch.on];
}

#pragma mark -  setFlame 点火熄火校正
- (void)startIgnitionSystemCalibration {
    
    [SupportingClass showAlertViewWithTitle:@"熄火低电压校正（一）" message:@"校正前请确保车辆处于熄火状态！" isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"next_step"
              clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                  if (btnIdx.integerValue == 1) {
                      [self ignitionSystemCalibration:NO];
                  }
    }];
    
}

#pragma mark -  setupDevice 设备配置安装
- (void)startSetupDevice {
    NSNumber *accStatus = [[[DBHandler shareInstance] getAutoRealtimeDataWithDataID:0] objectForKey:@"acc"];
    if (![SupportingClass analyseCarStatus:accStatus.stringValue withParentView:self.view]) return;
    
    [SupportingClass showAlertViewWithTitle:@"设备安装角度校正" message:@"请固定好你的设备，然后进行校正！" isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"next_step"
              clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                  if (btnIdx.integerValue == 1) {
                      [self autoDeviceCalibration];
                  }
              }];
}

#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _settingArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_settingArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setBackgroundColor:CDZColorOfWhite];
        
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    if (indexPath.section == 2) {
        cell.accessoryView = self.savePowerSwitch;
    }else {
        cell.accessoryView = nil;
    }
    
    NSDictionary *config = [_settingArray[indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = config[@"title"];
    cell.imageView.image = [UIImage imageNamed:config[@"icon"]];
    
    if ([config[@"topBorder"] boolValue]) {
        [cell addTopBorderWithHeight:0.5 andColor:[UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f]];
    }
    if ([config[@"bottomBorder"] boolValue]) {
        [cell addBottomBorderWithHeight:0.5 andColor:[UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f]];
    }
    
    return cell;
}

CGFloat rowHeight = 44;
CGFloat topSectionHeight = 36.0f;
CGFloat normalSectionHeight = 26.0f;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return (section ==0)?topSectionHeight:normalSectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    CGFloat lastHeight = CGRectGetHeight(tableView.frame)-topSectionHeight-(normalSectionHeight*2)-(rowHeight*4);
    return (section ==2)?lastHeight:0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [self startIgnitionSystemCalibration];
        }
        if (indexPath.row==1) {
            [self startSetupDevice];
        }
    }
    if (indexPath.section==1) {
        
    }
}

#pragma mark- APIs Access Request

- (void)getPowerSaveStatus {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUDWithTitle:getLocalizationString(@"loading") onView:nil];
    @weakify(self)
    [[APIsConnection shareConnection] personalGPSAPIsGetAutoPowerSaveStatusWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self)
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode==0) {
            BOOL status = [[responseObject[CDZKeyOfResultKey] objectForKey:@"status"] boolValue];
            self.savePowerSwitch.on = status;
        }
        [ProgressHUDHandler dismissHUD];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
    }];
}

- (void)updatePowerSaveStatus:(BOOL)status {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUDWithTitle:@"更新设置中...." onView:nil];
    @weakify(self)
    [[APIsConnection shareConnection] personalGPSAPIsPostAutoPowerSaveChangeStatusWithAccessToken:self.accessToken status:status success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        if (errorCode!=0) {
            [ProgressHUDHandler showErrorWithStatus:message onView:nil completion:nil];
            return;
        }
        [ProgressHUDHandler showSuccessWithStatus:@"更新成功！" onView:nil completion:nil];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        @strongify(self)
        self.savePowerSwitch.on = !self.savePowerSwitch.on;
        [ProgressHUDHandler showErrorWithStatus:@"更新失败！发生不明问题！" onView:nil completion:nil];
    }];
}

- (void)ignitionSystemCalibration:(BOOL)status {
    if (!self.accessToken) return;
    [[APIsConnection shareConnection] personalGPSAPIsPostAutoIgnitionSystemCalibrationWithAccessToken:self.accessToken status:status success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [SupportingClass addLabelWithFrame:alertFrame content:@"校正失败！" radius:5.0f fontSize:14.0f parentView:self.view isAlertShow:NO pushBlock:^{
            }];
            return;
        }
        if (status) {
            [SupportingClass addLabelWithFrame:alertFrame content:@"校正成功！"  radius:5.0f fontSize:14.0f parentView:self.view isAlertShow:NO pushBlock:^{
            }];
        }else {
            [SupportingClass showAlertViewWithTitle:@"熄火低电压校正（二）" message:@"校正前请确保车辆处于熄火状态！" isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"next_step"
                      clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                          if (btnIdx.integerValue == 1) {
                              [self ignitionSystemCalibration:YES];
                          }
                      }];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SupportingClass addLabelWithFrame:alertFrame content:@"校正失败！发生不明问题！" radius:5.0f fontSize:14.0f parentView:self.view isAlertShow:NO pushBlock:^{
        }];
    }];
}

- (void)autoDeviceCalibration {
    if (!self.accessToken) return;
    
    [ProgressHUDHandler showHUDWithTitle:@"正在安装中..." onView:nil];
    [[APIsConnection shareConnection] personalGPSAPIsPostAutoDeviceCalibrationWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUDHandler showHUDWithTitle:@"安装成功！" onView:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [ProgressHUDHandler showErrorWithStatus:@"安装失败！" onView:nil completion:nil];
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
