//
//  AppDelegate.m
//  cdzer
//
//  Created by KEns0n on 2/4/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#import "BPush.h"
#import "AppDelegate.h"
#import "UserLoginVC.h"
#import "ATAppUpdater.h"
#import "UserInfosDTO.h"
#import "BDPushConfigDTO.h"
#import <AlipaySDK/AlipaySDK.h>
#import <BaiduMapAPI/BMKMapManager.h>


//#import "BMKMapManager.h"

#define  kBMapAccessKey @"sV9ZVgp0QYf4QBuEGZ2kNfnK"
#define  vRepeatTime 45


@interface AppDelegate ()<BMKGeneralDelegate>{
    
    BMKMapManager* _mapManager;
    NSTimer *_timer;
    BOOL _wasUpdateShopType;
    BOOL _wasUpdateShopServiceType;
    BOOL _wasUpdateOrderStatusList;
    BOOL _wasUpdateRepairShopServiceList;
}

@end

@implementation AppDelegate

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:BaseURLString];
    
    // Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
    reach.reachableOnWWAN = YES;
    
    // Here we set up a NSNotification observer. The Reachability that caused the notification
    // is passed in the object parameter
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [reach startNotifier];
    
    
    // iOS8 下需要使用新的 API
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType myTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    
    
    if (launchOptions&&launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:[NSString stringWithFormat:@"Received Remote Notification :\n %@",launchOptions] isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
    }
    
#warning 测试 开发环境 时需要修改BPushMode为BPushModeDevelopment 需要修改Apikey为自己的Apikey
    
    // 在 App 启动时注册百度云推送服务，需要提供 Apikey
    [BPush registerChannel:launchOptions apiKey:@"H7WwHd2ATsD2cunjCau38LtT" pushMode:BPushModeDevelopment withFirstAction:nil withSecondAction:nil withCategory:nil isDebug:YES];
    // App 是用户点击推送消息启动
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSLog(@"从消息启动:%@",userInfo);
        [BPush handleNotification:userInfo];
    }
#if TARGET_IPHONE_SIMULATOR
    Byte dt[32] = {0xc6, 0x1e, 0x5a, 0x13, 0x2d, 0x04, 0x83, 0x82, 0x12, 0x4c, 0x26, 0xcd, 0x0c, 0x16, 0xf6, 0x7c, 0x74, 0x78, 0xb3, 0x5f, 0x6b, 0x37, 0x0a, 0x42, 0x4f, 0xe7, 0x97, 0xdc, 0x9f, 0x3a, 0x54, 0x10};
    [self application:application didRegisterForRemoteNotificationsWithDeviceToken:[NSData dataWithBytes:dt length:32]];
#endif
    //角标清0
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    
    
    //App Setting
    //init instance objects
    [UserBehaviorHandler shareInstance];
    [DBHandler shareInstance];
    [SecurityCryptor shareInstance];
    //init instance objects
    
    [[ATAppUpdater sharedUpdater] forceOpenNewAppVersion:NO];
    
    if (UserBehaviorHandler.shareInstance.getUserToken) {

    }
    
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:kRunUpdateAutoRTData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSettingDataFromTokenUpdate:) name:CDZNotiKeyOfTokenUpdate object:nil];
    
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:kBMapAccessKey  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    UINavigationController *navVC = [storyBoard instantiateInitialViewController];
    
    
    // remove the 1px bottom border from UINavigationBar
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //BaseTabBarController is UITabBarController's subclass
    BaseTabBarController *rootVC = (BaseTabBarController *)navVC.visibleViewController;
//    rootVC.delegate = self;
    
    
    rootVC.selectedIndex = 0;   //TabBarController must set it to 0
    
    self.window.rootViewController = navVC;
    
    self.window.backgroundColor = CDZColorOfWhite;
    
//    [self.window setRootViewController:[storyBoard instantiateInitialViewController]];
    [self.window makeKeyAndVisible];
    [self updateAllCommonData];
    if (vGetUserToken&&vGetUserID) {
        [ProgressHUDHandler showHUD];
        [self performSelector:@selector(validUserToken) withObject:nil afterDelay:1.5];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    if (_timer != nil) {
        if ([_timer isValid]) {
            [_timer invalidate];
        }
        _timer = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CDZNotiKeyOfManualUpdateAutoGPSInfo object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CDZNotiKeyOfTokenUpdate object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (_timer != nil) {
        if ([_timer isValid]) {
            [_timer invalidate];
        }
        _timer = nil;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserAutoGPSRealtimeData) name:CDZNotiKeyOfManualUpdateAutoGPSInfo object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSettingDataFromTokenUpdate:) name:CDZNotiKeyOfTokenUpdate object:nil];
    _timer = [NSTimer scheduledTimerWithTimeInterval:vRepeatTime target:self selector:@selector(updateUserAutoGPSRealtimeDataFromTimer) userInfo:nil repeats:YES];
    [self updateSettingDataFromTokenUpdate:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    if (_timer != nil) {
        if ([_timer isValid]) {
            [_timer invalidate];
        }
        _timer = nil;
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
        
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"result = %@",resultDic);
        }];
    }
    
    return YES;
}


//推送
- (void)applications:(UIApplication *)application didReceiveRemoteNotifications:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"background : %@", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
    
}

// 在 iOS8 系统中，还需要添加这个方法。通过新的 API 注册推送服务
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
    [application registerForRemoteNotifications];
    
    
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Register use deviceToken : %@",[deviceToken.description stringByTrimmingCharactersInSet:NSCharacterSet.nonBaseCharacterSet]);
    [BPush registerDeviceToken:deviceToken];
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        NSLog(@"Method: %@\n%@",BPushRequestMethodBind, result);
        if (!error&&result) {
            NSString *dtString = [[deviceToken.description stringByTrimmingCharactersInSet:NSCharacterSet.symbolCharacterSet] stringByReplacingOccurrencesOfString:@" " withString:@""];
            BDPushConfigDTO *dto = [BDPushConfigDTO new];
            dto.deviceToken = dtString;
            dto.bdpUserID = result[@"user_id"];
            dto.channelID = result[@"channel_id"];
            BOOL updateSuccess = [DBHandler.shareInstance updateBDAPNSConfigData:dto];
            NSLog(@"update is success %d", updateSuccess);
        }
    }];
    
    
    
}

// 当 DeviceToken 获取失败时，系统会回调此方法
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"DeviceToken 获取失败，原因：%@",error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // App 收到推送的通知
    [BPush handleNotification:userInfo];
    
    NSLog(@"Received Remote Notification :\n %@",userInfo);
    [SupportingClass showAlertViewWithTitle:@"alert_remind" message:[NSString stringWithFormat:@"Received Remote Notification :\n %@",userInfo] isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"接收本地通知啦！！！");
    [BPush showLocalNotificationAtFront:notification identifierKey:nil];
}

//网络检测
- (void)reachabilityChanged:(NSNotification *)notiObject {
    Reachability *theReach = notiObject.object;
    if ([theReach isKindOfClass:[Reachability class]]) {
        NSLog(@"%@", theReach.currentReachabilityString);
        NSLog(@"%@", theReach.currentReachabilityFlags);
        NSLog(@"%ld", (long)theReach.currentReachabilityStatus);
    }
}

//更新资料由登入成功后触发
- (void)updateSettingDataFromTokenUpdate:(NSNotification *)notiObject {
    [self updateUserData];
    if (vGetUserType==CDZUserTypeOfGPSUser||vGetUserType==CDZUserTypeOfGPSWithODBUser ) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:vRepeatTime target:self selector:@selector(updateUserAutoGPSRealtimeDataFromTimer) userInfo:nil repeats:YES];
        [self updateUserAutoGPSRealtimeData];
    }
}
//更新GPS车辆资料由 NSTimer 以定时方式触发
- (void)updateUserAutoGPSRealtimeDataFromTimer {
    NSString *token = vGetUserToken;
    NSNumber *updateAutoRTDataOn = [[NSUserDefaults standardUserDefaults] objectForKey:kRunUpdateAutoRTData];
    if (!token||!updateAutoRTDataOn.boolValue) return;
    [self updateUserAutoGPSRealtimeData];
}

#pragma mark- APIs Access Request

- (void)validUserToken {
//    [self updateSettingDataFromTokenUpdate:nil];
//    return;
    @weakify(self)
    [[UserBehaviorHandler shareInstance] validUserTokenWithSuccessBlock:^{
        [ProgressHUDHandler dismissHUDWithCompletion:^{
            @strongify(self)
            [self updateSettingDataFromTokenUpdate:nil];
        }];
    } failureBlock:^(NSString *errorMessage, NSError *error) {
        [ProgressHUDHandler dismissHUDWithCompletion:^{
            if (error.code==CDZUserDataNetworkUpdateAccessError) {
                
            }else {
                [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"你登录凭证已失效请重新登录已取得跟多功能" isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"ok" clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                    @strongify(self)
                    if (btnIdx.integerValue>=0) {
                        UserLoginVC *vc = [UserLoginVC new];
                        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                        [self.window.rootViewController setNavBarBackButtonTitleOrImage:nil titleColor:nil];
                        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
                    }
                }];
            }
        }];
    }];
}

- (void)updateUserData {
    NSString *token = vGetUserToken;
    if (!token) return;
    [[APIsConnection shareConnection] personalCenterAPIsGetPersonalInformationWithAccessToken:token success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@"PersonalInformation"};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = @{@"ident":@"PersonalInformation"};
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)updateUserAutoGPSRealtimeData {
    if (vGetUserType==CDZUserTypeOfGPSUser||vGetUserType==CDZUserTypeOfGPSWithODBUser) {
        NSString *token = vGetUserToken;
        if (!token) return;
        [[APIsConnection shareConnection] personalGPSAPIsGetAutoGPSRealtimeInfoWithAccessToken:token success:^(AFHTTPRequestOperation *operation, id responseObject) {
            operation.userInfo = @{@"ident":@"GPSRealtimeInfo"};
            [self requestResultHandle:operation responseObject:responseObject withError:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            operation.userInfo = @{@"ident":@"GPSRealtimeInfo"};
            [self requestResultHandle:operation responseObject:nil withError:error];
        }];
    }
    
}

- (void)updateAllCommonData {
    [[APIsConnection shareConnection] commonAPIsGetRepairShopTypeListWithSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@"RepairShopTypeList"};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = @{@"ident":@"RepairShopTypeList"};
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
    
    [[APIsConnection shareConnection] commonAPIsGetRepairShopServiceTypeListWithSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@"RepairShopServiceTypeList"};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = @{@"ident":@"RepairShopServiceTypeList"};
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
    
    [[APIsConnection shareConnection] commonAPIsGetPurchaseOrderStatusListWithSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@"PurchaseOrderStatusList"};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = @{@"ident":@"PurchaseOrderStatusList"};
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
    
    [[APIsConnection shareConnection] commonAPIsGetRepairShopServiceListWithShopID:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@"RepairShopServiceList"};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        operation.userInfo = @{@"ident":@"RepairShopServiceList"};
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

#pragma mark- Data Handle Request
- (void)handleResponseData:(id)responseObject withIdentString:(NSString *)identString {
    @autoreleasepool {
        if (!responseObject) {
            NSLog(@"data Error");
            return;
        }
        if ([identString isEqualToString:@"PersonalInformation"]) {
            UserInfosDTO *dto = [UserInfosDTO new];
            [dto processDataToObjectWithData:responseObject isFromDB:NO];
            BOOL isDone = [[DBHandler shareInstance] updateUserInfo:dto];
            NSLog(@"PersonalInformationUpdateOK?:::%d", isDone);
            
        }
        if ([identString isEqualToString:@"GPSRealtimeInfo"]) {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObject:@(1) forKey:@"id"];
            [data addEntriesFromDictionary:responseObject];
            BOOL isDone = [[DBHandler shareInstance] updateAutoRealtimeData:data];
            NSLog(@"GPSRealtimeInfoUpdateOK?:::%d", isDone);
            if (isDone) {
                [[NSNotificationCenter defaultCenter] postNotificationName:CDZNotiKeyOfUpdateAutoGPSInfo object:nil];
            }
        }
        
        if ([identString isEqualToString:@"RepairShopTypeList"]) {
            BOOL isDone = [[DBHandler shareInstance] updateRepairShopTypeList:responseObject];
            NSLog(@"RepairShopTypeListUpdateOK?:::%d", isDone);
            _wasUpdateShopType = isDone;
        }
        
        if ([identString isEqualToString:@"RepairShopServiceTypeList"]) {
            BOOL isDone = [[DBHandler shareInstance] updateRepairShopSerivceTypeList:responseObject];
            NSLog(@"RepairShopServiceTypeListUpdateOK?:::%d", isDone);
            _wasUpdateShopServiceType = isDone;
            
        }
        
        if ([identString isEqualToString:@"PurchaseOrderStatusList"]) {
            BOOL isDone = [[DBHandler shareInstance] updatePurchaseOrderStatusList:responseObject];
            NSLog(@"PurchaseOrderStatusListUpdateOK?:::%d", isDone);
            _wasUpdateOrderStatusList = isDone;
        }
        
        if ([identString isEqualToString:@"RepairShopServiceList"]) {
            NSMutableArray *list = [NSMutableArray new];
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                id convention_maintain = responseObject[CDZObjectKeyOfConventionMaintain];
                id deepness_maintain = responseObject[CDZObjectKeyOfDeepnessMaintain];
                if (convention_maintain&&[convention_maintain isKindOfClass:NSArray.class]) {
                    [(NSArray *)convention_maintain enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSMutableDictionary *object = [obj mutableCopy];
                        [object setObject:CDZObjectKeyOfConventionMaintain forKey:@"main_type"];
                        [list addObject:object];
                    }];
                }
                if (deepness_maintain&&[deepness_maintain isKindOfClass:NSArray.class]) {
                    [(NSArray *)deepness_maintain enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        NSMutableDictionary *object = [obj mutableCopy];
                        [object setObject:CDZObjectKeyOfDeepnessMaintain forKey:@"main_type"];
                        [list addObject:object];
                    }];
                }
            }else if ([responseObject isKindOfClass:NSArray.class]) {
                [list addObjectsFromArray:responseObject];
            }
            
            BOOL isDone = [[DBHandler shareInstance] updateRepairShopServiceList:list];
            NSLog(@"RepairShopServiceListUpdateOK?:::%d", isDone);
            _wasUpdateRepairShopServiceList = isDone;
        }
    }
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    
    NSString *identString = operation.userInfo[@"ident"];
    if (error&&!responseObject) {
        NSLog(@"%@",error);
    }else if (!error&&responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if ([APIsErrorHandler isTokenErrorWithResponseObject:responseObject]) {
            return;
        }
        if (errorCode==0) {
            NSLog(@"%@ SuccessGetData",identString);
            [self handleResponseData:responseObject[CDZKeyOfResultKey] withIdentString:identString];

        }
    }
    
}
@end
