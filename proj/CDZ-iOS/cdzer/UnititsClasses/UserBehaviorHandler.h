//
//  UserBehaviorHandler.h
//  cdzer
//
//  Created by KEns0n on 7/3/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

typedef NS_ENUM(NSInteger, CDZUserType) {
    CDZUserTypeOfUnknowUser=0,
    CDZUserTypeOfNormalUser=1,
    CDZUserTypeOfGPSUser=6,
    CDZUserTypeOfGPSWithODBUser=7,
};

typedef NS_ENUM(NSInteger, CDZUserDataError) {
    CDZUserDataErrorTokenOrUserIDMssing=-100,
    CDZUserDataErrorDataCorruption=-101,
    CDZUserDataNetworkUpdateAccessError=-102,
};


typedef void (^UBLogoutCompletionBlock)(void);
typedef void (^UBLoginRegisterSuccessBlock)(void);
typedef void (^UBLoginRegisterfailureBlock)(NSString *errorMessage, NSError *error);
#import <Foundation/Foundation.h>

@interface UserBehaviorHandler : NSObject

@property (nonatomic, readonly) NSString* getUserToken;

@property (nonatomic, readonly) NSString* getUserID;

@property (nonatomic, assign, readonly) CDZUserType getUserType;

@property (nonatomic, readonly) NSString* getUserTypeName;

@property (nonatomic, readonly) NSNumber *getCSHotline;

+ (UserBehaviorHandler *)shareInstance;

- (void)updateUserIdentData;

- (void)userLogoutWasPopupDialog:(BOOL)showDialog andCompletionBlock:(UBLogoutCompletionBlock)completionBlock;

- (void)validUserTokenWithSuccessBlock:(UBLoginRegisterSuccessBlock)successBlock failureBlock:(UBLoginRegisterfailureBlock)failureBlock;

- (void)userLoginWithUserPhone:(NSString *)userPhone password:(NSString *)password success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock;

- (void)userRegisterWithUserPhone:(NSString *)userPhone validCode:(NSString *)validCode password:(NSString *)password repassword:(NSString *)repassword success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock;

- (void)userRequestRegisterValidCodeWithUserPhone:(NSString *)userPhone success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock;

- (void)userForgotPasswordWithUserPhone:(NSString *)userPhone validCode:(NSString *)validCode password:(NSString *)password repassword:(NSString *)repassword success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock;

- (void)userRequestForgotPasswordValidCodeWithUserPhone:(NSString *)userPhone success:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock;

- (void)userRequestCreditValidCodeWithSuccessBlock:(UBLoginRegisterSuccessBlock)successBlock failure:(UBLoginRegisterfailureBlock)failureBlock;
@end
