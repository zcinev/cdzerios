//
//  AppSettingVC.m
//  cdzer
//
//  Created by KEns0n on 7/11/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "AppSettingVC.h"
#import "GPSSettingVC.h"
#import <UIView+Borders/UIView+Borders.h>
#import "ATAppUpdater.h"
#import "BDPushConfigDTO.h"

@interface AppSettingVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *configList;

@property (nonatomic, strong) UISwitch *pushSwitch;

@property (nonatomic, strong) UIView *spaceView;

@property (nonatomic, strong) BDPushConfigDTO *pushDTO;

@end

@implementation AppSettingVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setReactiveRules {

    @weakify(self)
    [RACObserve(self, tableView.contentSize) subscribeNext:^(id contentSize) {
        @strongify(self)
        CGSize size = [contentSize CGSizeValue];
        CGRect frame = self.spaceView.frame;
        frame.size.height = CGRectGetHeight(self.tableView.frame)-size.height;
        self.spaceView.frame = frame;
    }];
    
}

- (void)componentSetting {
    self.pushDTO = DBHandler.shareInstance.getBDAPNSConfigData;
    self.configList = [@[] mutableCopy];
    if (self.accessToken) {
        [_configList addObject:@{@"title":@"接收通知", @"subTitle":@"开启此设置，请检查系统是否已开启接收推送。", @"icon":@"push", @"type":@"switch"}];
    }
    if (UserBehaviorHandler.shareInstance.getUserType>=CDZUserTypeOfGPSUser) {
        [_configList addObject:@{@"title":@"GPS设置", @"icon":@"gps_icon", @"type":@"gps"}];
    }
    [_configList addObjectsFromArray:@[@{@"title":@"版本检测", @"icon":@"version", @"type":@"checkVersion"},
                                       @{@"title":@"关于我们", @"icon":@"aboutus", @"type":@"arrow"},
                                       @{@"title":@"意见反馈", @"icon":@"advice", @"type":@"arrow"},
                                       @{@"title":@"0731－88865777", @"icon":@"contact", @"type":@"call"}]];
}

- (void)initializationUI {
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"isOnPush"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isOnPush"];
    }
    BOOL isOnPush = [[NSUserDefaults.standardUserDefaults objectForKey:@"isOnPush"] boolValue];
    self.pushSwitch = [UISwitch new];
    _pushSwitch.on = isOnPush;
    [_pushSwitch addTarget:self action:@selector(updatePushOn:) forControlEvents:UIControlEventValueChanged];
    NSString *channelID = _pushDTO.channelID;
    NSString *deviceToken = _pushDTO.deviceToken;
    NSString *apnsUserID = _pushDTO.bdpUserID;
    if ([channelID isEqualToString:@""]||[deviceToken isEqualToString:@""]||[apnsUserID isEqualToString:@""]) {
        _pushSwitch.enabled  = NO;
        _pushSwitch.on = NO;
        [self updatePushSwitchStatusWithMessageON:NO channelID:@"" deviceToken:@"" apnsUserID:@"" showHud:NO];
    }

    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_tableView];

    self.spaceView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_tableView.frame), 100.0f)];
    [_spaceView addTopBorderWithHeight:0.5f andColor:[UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f]];
    _tableView.tableFooterView = _spaceView;
    
}

- (void)updatePushOn:(UISwitch *)switchs {
    NSString *channelID = _pushDTO.channelID;
    NSString *deviceToken = _pushDTO.deviceToken;
    NSString *apnsUserID = _pushDTO.bdpUserID;
    if ([channelID isEqualToString:@""]||[deviceToken isEqualToString:@""]||[apnsUserID isEqualToString:@""]) {
        if (switchs.on) {
            [SupportingClass showAlertViewWithTitle:@"" message:@"" isShowImmediate:YES cancelButtonTitle:@"" otherButtonTitles:@"" clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
        }
        channelID = @"";
        deviceToken = _pushDTO.deviceToken;
        apnsUserID = _pushDTO.bdpUserID;
        [_pushSwitch setOn:NO animated:YES];
        [[NSUserDefaults standardUserDefaults] setBool:_pushSwitch.on forKey:@"isOnPush"];
    }
    [[NSUserDefaults standardUserDefaults] setBool:switchs.on forKey:@"isOnPush"];
    [self updatePushSwitchStatusWithMessageON:switchs.on channelID:channelID deviceToken:deviceToken apnsUserID:apnsUserID showHud:YES];
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _configList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 13.0f, NO);
        cell.detailTextLabel.textColor = CDZColorOfDeepGray;
        cell.detailTextLabel.numberOfLines = 0;
        [cell addTopBorderWithHeight:0.5f andColor:[UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f]];
    }
    // Configure the cell...
    cell.detailTextLabel.text = @"";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = nil;
    NSDictionary *config = _configList[indexPath.row];
    
    UIImage *image = [ImageHandler getImageFromCacheWithByFixdeRatioFileRootPath:kSysImageCaches
                                                                         fileName:config[@"icon"]
                                                                             type:FMImageTypeOfPNG
                                                                     needToUpdate:NO];
    cell.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.imageView.tintColor = CDZColorOfDeepGray;
    cell.textLabel.text = config[@"title"];
    if (indexPath.row==0&&[config[@"type"] isEqualToString:@"switch"]) {
        cell.detailTextLabel.text = config[@"subTitle"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = _pushSwitch;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) return 56;
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *type = [_configList[indexPath.row] objectForKey:@"type"];
    if ([type isEqualToString:@"arrow"]) {
    }
    
    if ([type isEqualToString:@"gps"]) {
        @autoreleasepool {
            GPSSettingVC *vc = [GPSSettingVC new];
            [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    if ([type isEqualToString:@"call"]) {
        NSString *phone = [_configList[indexPath.row] objectForKey:@"title"];
        [SupportingClass makeACall:phone];
    }
    
    if ([type isEqualToString:@"checkVersion"]) {
        [[ATAppUpdater sharedUpdater] forceOpenNewAppVersion:NO];
    }
}

- (void)updatePushSwitchStatusWithMessageON:(BOOL)messageON channelID:(NSString *)channelID deviceToken:(NSString *)deviceToken apnsUserID:(NSString *)apnsUserID showHud:(BOOL)showHud{
    if (!self.accessToken||[self.accessToken isEqualToString:@""]) {
        return;
    }
    if (showHud) {
        [ProgressHUDHandler showHUD];
    }
    [APIsConnection.shareConnection personalCenterAPNSSettingAlertListWithAccessToken:self.accessToken messageON:messageON channelID:channelID deviceToken:deviceToken apnsUserID:apnsUserID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if (showHud) {
            [ProgressHUDHandler dismissHUD];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (showHud) {
            [ProgressHUDHandler dismissHUD];
        }
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
