//
//  UserBehaviorHandler.m
//  cdzer
//
//  Created by KEns0n on 7/3/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "BDPushConfigDTO.h"
#import "UserAutosInfoDTO.h"
#import "UserSelectedAutosInfoDTO.h"
#import "UserBehaviorHandler.h"
@interface UserBehaviorHandler()
{
    NSString *_uid;
    NSString *_userToken;
    CDZUserType _userType;
    NSString *_userTypeName;
    NSNumber *_csHotline;
}
@end

@implementation UserBehaviorHandler

static UserBehaviorHandler *_ubHandleInstance = nil;

- (NSString *)getUserToken {
    if (!_userToken) return nil;
    return [SecurityCryptor.shareInstance tokenDecryption:_userToken];
}

- (NSString *)getUserID {
    if (!_uid) return @"0";
    return _uid;
}

- (CDZUserType)getUserType {
    return _userType;
}

- (NSString *)getUserTypeName {
    if (!_userTypeName) return nil;
    return _userTypeName;
}

- (NSNumber *)getCSHotline {
    if (!_csHotline) return nil;
    return _csHotline;
}

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

+ (UserBehaviorHandler *)shareInstance {
    
    if (!_ubHandleInstance) {
        _ubHandleInstance = [UserBehaviorHandler new];
        [_ubHandleInstance updateUserIdentData];
    }
    return _ubHandleInstance;
}

- (void)updateUserIdentData {
    @autoreleasepool {
        NSDictionary *userIdentData = DBHandler.shareInstance.getUserIdentData;
        _uid = nil;
        _userToken = nil;
        _userType = CDZUserTypeOfUnknowUser;
        _userTypeName = nil;
        _csHotline = nil;
        if (userIdentData) {
            NSString *uid = userIdentData[@"uid"];
            if (uid&&![uid isEqualToString:@""]&&[[uid lowercaseString] rangeOfString:@"null"].location==NSNotFound) {
                _uid = uid;
            }
            NSString *userToken = userIdentData[@"token"];
            if (userToken&&![userToken isEqualToString:@""]&&[[userToken lowercaseString] rangeOfString:@"null"].location==NSNotFound) {
                _userToken = userToken;
            }
            NSNumber *userType = userIdentData[@"type"];
            if (userType&&userType.integerValue!=CDZUserTypeOfUnknowUser) {
                _userType = userType.integerValue;
            }
            
            NSString *userTypeName = userIdentData[@"typeName"];
            if (userTypeName&&![userTypeName isEqualToString:@""]&&[[userTypeName lowercaseString] rangeOfString:@"null"].location==NSNotFound) {
                _userTypeName = userTypeName;
            }
            
            NSNumber *csHotline = userIdentData[@"csHotline"];
            if (csHotline) {
                _csHotline = csHotline;
            }
        }
    }
}

- (void)clearUserData {
    
    NSLog(@"Clear User Ident Data success::::::%d",[DBHandler.shareInstance clearUserIdentData]);
    NSLog(@"Clear User Autos Detail Data success::::::%d",[DBHandler.shareInstance clearUserAutosDetailData]);
}

- (void)userLogoutWasPopupDialog:(BOOL)showDialog andCompletionBlock:(UBLogoutCompletionBlock)completionBlock {
    if (showDialog) {
        @weakify(self)
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"你是否确定登出账号？" isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"ok" clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            if (btnIdx.integerValue>0) {
                @strongify(self)
                [self executeLogoutWithCompletionBlock:completionBlock];
                
            }
        }];
    }else {
        [self executeLogoutWithCompletionBlock:completionBlock];
    }
}

- (void)executeLogoutWithCompletionBlock:(UBLogoutCompletionBlock)completionBlock  {
    @autoreleasepool {
        if (self.getUserToken) {
            [APIsConnection.shareConnection personalCenterAPNSSettingAlertListWithAccessToken:self.getUserToken messageON:NO channelID:@"" deviceToken:@"" apnsUserID:@"" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
                NSLog(@"%@",message);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
        }
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isOnPush"];
        
        
        [DBHandler.shareInstance clearSelectedAutoData];
        BOOL isDone = [[DBHandler shareInstance] clearUserIdentData];
        [DBHandler.shareInstance clearUserAutosDetailData];
        [DBHandler.shareInstance clearUserInfo];
        if (isDone) {
            [self updateUserIdentData];
            if (completionBlock) {
                completionBlock();
            }
        }

    }
}

- (void)validUserTokenWithSuccessBlock:(UBLoginRegisterSuccessBlock)successBlock failureBlock:(UBLoginRegisterfailureBlock)failureBlock {
    NSString *token = self.getUserToken;
    NSString *userID = _uid;
    if (!token||!userID) {
        NSError *error = [NSError errorWithDomain:@"Token Or UserID Missing" code:CDZUserDataErrorTokenOrUserIDMssing userInfo:nil];
        failureBlock(@"", error);
    };
    
    BDPushConfigDTO *dto = DBHandler.shareInstance.getBDAPNSConfigData;
    
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPostValidUserTokenWithAccessToken:token
                                                                                   userID:userID
                                                                                channelID:dto.channelID
                                                                              deviceToken:dto.deviceToken
                                                                               apnsUserID:dto.bdpUserID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self)
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode!=0) {
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            NSLog(@"Fail Valid Token");
            [self clearUserData];
            failureBlock(message, nil);
            return;
        }
        BOOL isDone = [self handleUserLoginOrTokenValidResponseData:responseObject];
        if (isDone) {
            successBlock();
        }else {
            NSLog(@"Fail Valid Token");
            [self clearUserData];
            NSError *error = [NSError errorWithDomain:@"Data Corruption" code:CDZUserDataErrorDataCorruption userInfo:nil];
            failureBlock(@"验证失败！", error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        NSError *theError = [NSError errorWithDomain:@"UpdateAccessNetworkError" code:CDZUserDataNetworkUpdateAccessError userInfo:nil];
        failureBlock(@"登入失败，请稍后再试！", theError);
    }];

}

- (void)userLoginWithUserPhone:(NSString *)userPhone password:(NSString *)password success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock  {
    @weakify(self)
    
    BDPushConfigDTO *pushDTO = DBHandler.shareInstance.getBDAPNSConfigData;
    NSString *channelID = pushDTO.channelID;
    NSString *deviceToken = pushDTO.deviceToken;
    NSString *apnsUserID = pushDTO.bdpUserID;
    
    [[APIsConnection shareConnection] personalCenterAPIsPostUserLoginWithUserPhone:userPhone
                                                                          password:password
                                                                         channelID:channelID
                                                                       deviceToken:deviceToken
                                                                        apnsUserID:apnsUserID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode!=0) {
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            failureBlock(message, nil);
            return;
        }
        @strongify(self)
        BOOL isDone = [self handleUserLoginOrTokenValidResponseData:responseObject];
        if (isDone) {
            successBlock();
            if (![channelID isEqualToString:@""]&&![deviceToken isEqualToString:@""]&&![apnsUserID isEqualToString:@""]) {
                [APIsConnection.shareConnection personalCenterAPNSSettingAlertListWithAccessToken:self.getUserToken messageON:YES channelID:channelID deviceToken:deviceToken apnsUserID:apnsUserID success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
                    NSLog(@"%@",message);
                    NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
                    if (errorCode==0) {
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isOnPush"];
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {}];
            }
        }else {
            NSLog(@"Login Fail");
            [self clearUserData];
            NSError *error = [NSError errorWithDomain:@"Data Corruption" code:CDZUserDataErrorDataCorruption userInfo:nil];
            failureBlock(@"验证失败！", error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {;
        NSLog(@"%@",error);
        NSError *theError = [NSError errorWithDomain:@"UpdateAccessNetworkError" code:CDZUserDataNetworkUpdateAccessError userInfo:nil];
        failureBlock(@"登入失败，请稍后再试！", theError);
    }];
}

- (void)userRegisterWithUserPhone:(NSString *)userPhone validCode:(NSString *)validCode password:(NSString *)password repassword:(NSString *)repassword success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock  {
    [[APIsConnection shareConnection] personalCenterAPIsPostUserRegisterWithUserPhone:userPhone validCode:validCode password:password repassword:repassword success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode!=0) {
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            failureBlock(message, nil);
            return;
        }
        successBlock();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {;
        NSLog(@"%@",error);
        NSError *theError = [NSError errorWithDomain:@"UpdateAccessNetworkError" code:CDZUserDataNetworkUpdateAccessError userInfo:nil];
        failureBlock(@"注册失败，请稍后再试！", theError);
    }];
}

- (void)userRequestRegisterValidCodeWithUserPhone:(NSString *)userPhone success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock  {
    [[APIsConnection shareConnection] personalCenterAPIsPostUserRegisterValidCodeWithUserPhone:userPhone success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode!=0) {
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            failureBlock(message, nil);
            return;
        }
        
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:[responseObject[CDZKeyOfResultKey] objectForKey:@"verify"] isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
        successBlock();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {;
        NSLog(@"%@",error);
        NSError *theError = [NSError errorWithDomain:@"UpdateAccessNetworkError" code:CDZUserDataNetworkUpdateAccessError userInfo:nil];
        failureBlock(@"请求验证码失败，请稍后再试！", theError);
    }];
}

- (void)userForgotPasswordWithUserPhone:(NSString *)userPhone validCode:(NSString *)validCode password:(NSString *)password repassword:(NSString *)repassword success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock  {
    [[APIsConnection shareConnection] personalCenterAPIsPostUserForgetPasswordWithUserPhone:userPhone validCode:validCode password:password repassword:repassword success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode!=0) {
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            failureBlock(message, nil);
            return;
        }
        successBlock();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {;
        NSLog(@"%@",error);
        NSError *theError = [NSError errorWithDomain:@"UpdateAccessNetworkError" code:CDZUserDataNetworkUpdateAccessError userInfo:nil];
        failureBlock(@"密码更改失败，请稍后再试！", theError);
    }];
}

- (void)userRequestForgotPasswordValidCodeWithUserPhone:(NSString *)userPhone success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock  {
    [[APIsConnection shareConnection] personalCenterAPIsPostUserForgetPWValidCodeWithUserPhone:userPhone success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode!=0) {
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            failureBlock(message, nil);
            return;
        }
         [SupportingClass showAlertViewWithTitle:@"alert_remind" message:[responseObject[CDZKeyOfResultKey] objectForKey:@"verify"] isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
        successBlock();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {;
        NSLog(@"%@",error);
        NSError *theError = [NSError errorWithDomain:@"UpdateAccessNetworkError" code:CDZUserDataNetworkUpdateAccessError userInfo:nil];
        failureBlock(@"请求验证码失败，请稍后再试！", theError);
    }];
}

- (BOOL)handleUserLoginOrTokenValidResponseData:(id)responseObject {
    NSDictionary *data = responseObject[CDZKeyOfResultKey];
    NSString *token = data[@"token"];
    NSString *uid = data[@"user_id"];
    NSNumber *typeID = @([data[@"type_id"] integerValue]);
    NSString *typeName = data[@"type_name"];
    NSNumber *csHotline = @([data[@"customer"] longLongValue]);
    
    UserAutosInfoDTO *dto = [UserAutosInfoDTO new];
    [dto processDataToObject:data[@"carInfo"] optionWithUID:uid];
    
    if([DBHandler.shareInstance updateUserToken:token userID:uid userType:typeID typeName:typeName csHotline:csHotline]) {
        [self updateUserIdentData];
        NSLog(@"success update token & uid");
        NSLog(@"success update user autos detail data::::::%d", [DBHandler.shareInstance updateUserAutosDetailData:[dto processObjectToDBData]]);
        
        if (dto.brandID.integerValue!=0&&dto.dealershipID.integerValue!=0&&
            dto.seriesID.integerValue!=0&&dto.modelID.integerValue!=0) {
            UserSelectedAutosInfoDTO *selectedAutoDto = [UserSelectedAutosInfoDTO new];
            [selectedAutoDto processDataToObjectWithDto:dto];
            NSLog(@"success update selected autos detail data::::::%d", [DBHandler.shareInstance updateSelectedAutoData:selectedAutoDto]);
        }
        
    }

    NSString *enToken = self.getUserToken;
    BOOL isDone = [enToken isEqual:token];
    NSLog(@"isTokenSaveSuccess:::%d",isDone);
    return isDone;
}

- (void)userRequestCreditValidCodeWithSuccessBlock:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock {
    if (!self.getUserToken) {
        [SupportingClass showAlertViewWithTitle:@"error" message:@"凭证失效！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
        return;
    }
    [[APIsConnection shareConnection] personalCenterAPIsPostUserCreditValidCodeWithToken:self.getUserToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        if (errorCode!=0) {
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            failureBlock(message, nil);
            return;
        }
        
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:[responseObject[CDZKeyOfResultKey] objectForKey:@"verify"] isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
        successBlock();
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {;
        NSLog(@"%@",error);
        NSError *theError = [NSError errorWithDomain:@"UpdateAccessNetworkError" code:CDZUserDataNetworkUpdateAccessError userInfo:nil];
        failureBlock(@"请求验证码失败，请稍后再试！", theError);
    }];
}
@end
