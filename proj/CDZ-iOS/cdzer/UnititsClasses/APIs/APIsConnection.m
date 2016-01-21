//
//  APIsConnection.m
//  cdzer
//
//  Created by KEns0n on 4/9/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

typedef void (^APIsConnectionFormData)(id <AFMultipartFormData> formData);

#import "APIsConnection.h"

#define kParameterOfToken @"token"
#define kParameterOfID @"id"
@interface APIsConnection ()
@property (nonatomic, strong) AFJSONResponseSerializer *jsonRequestSerializer;
@property (nonatomic, strong) NSMutableSet *normalResponseFilterSet;
@end

@implementation APIsConnection

static APIsConnection *connectionInstance = nil;
static NSString * const FirstRelativePath = @"b2bweb-portal/";
static AFHTTPRequestOperationManager *operationManager = nil;


+ (APIsConnection *)shareConnection {
    
    if (!connectionInstance) {
        connectionInstance = [APIsConnection new];
        connectionInstance.normalResponseFilterSet = [NSMutableSet set];
        
        operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        [operationManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        operationManager.requestSerializer.timeoutInterval = 6.0f;
        [operationManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        [operationManager.operationQueue setMaxConcurrentOperationCount:2];
        //AFHTTPRequestOperationManager responseSerializer configs
        connectionInstance.jsonRequestSerializer = [AFJSONResponseSerializer serializer];
        NSLog(@"%@",[connectionInstance.jsonRequestSerializer.acceptableContentTypes setByAddingObject:@"text/plain"]);
        connectionInstance.jsonRequestSerializer.acceptableContentTypes = [connectionInstance.jsonRequestSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        operationManager.responseSerializer = connectionInstance.jsonRequestSerializer;
    }
    
    return connectionInstance;
}

- (AFHTTPRequestOperation *)createRequestWithHTTPMethod:(CDZAPIsHTTPMethod)methodType
                                  withFirstRelativePath:(BOOL)withFirstRelativePath
                                           relativePath:(NSString *)pathString
                                             parameters:(id)parameters
                          constructingPOSTBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))POSTBodyBlock
                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    //    void (^blockSEL)(AFHTTPRequestOperation *operation, id responseObject);
    //
    //    blockSEL = ^(AFHTTPRequestOperation *operation, id responseObject){
    //
    //    };
    AFHTTPRequestOperation *operation = nil;
    if (!pathString) {
        return operation;
    }
    
    operationManager.responseSerializer = self.jsonRequestSerializer;
    if ([self.normalResponseFilterSet containsObject:pathString]) {
        operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    if (withFirstRelativePath) {
        pathString = [FirstRelativePath stringByAppendingPathComponent:pathString];
    }
    
    
    @autoreleasepool {
        switch (methodType) {
            case CDZAPIsHTTPMethodTypeOfGET:{
                operation = [operationManager GET:pathString parameters:parameters success:success failure:failure];
            }
                
                break;
            case CDZAPIsHTTPMethodTypeOfPOST:{
                if (!POSTBodyBlock) {
                    operation = [operationManager POST:pathString parameters:parameters success:success failure:failure];
                }else {
                    operation = [operationManager POST:pathString parameters:parameters constructingBodyWithBlock:POSTBodyBlock success:success failure:failure];
                }
            }
                
                break;
            case CDZAPIsHTTPMethodTypeOfPUT:{
                operation = [operationManager PUT:pathString parameters:parameters success:success failure:failure];
            }
                
                break;
            case CDZAPIsHTTPMethodTypeOfPATCH:{
                operation = [operationManager PATCH:pathString parameters:parameters success:success failure:failure];
            }
                
                break;
            case CDZAPIsHTTPMethodTypeOfDELETE:{
                operation = [operationManager DELETE:pathString parameters:parameters success:success failure:failure];
            }
                
                break;
                
            default:
                NSLog(@"request a error method!!");
                break;
        }
        
        return operation;
    }
}


- (AFHTTPRequestOperation *)createImageRequestWithRelativePath:(NSString *)pathString
                                                  parameters:(id)parameters
                               constructingPOSTBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))POSTBodyBlock
                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!POSTBodyBlock) {
        return nil;
    }
    @autoreleasepool {
        
        AFHTTPRequestOperationManager *tmpOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://192.168.1.143:8080/"]];
        //AFHTTPRequestOperationManager responseSerializer configs
        AFJSONResponseSerializer *jsonResponseSerialize = [AFJSONResponseSerializer serializer];
        NSMutableSet *contentTypesSet = [NSMutableSet setWithSet:jsonResponseSerialize.acceptableContentTypes];
        [contentTypesSet addObject:@"text/plain"];
        jsonResponseSerialize.acceptableContentTypes = contentTypesSet;
        tmpOperationManager.responseSerializer = jsonResponseSerialize;
        
        return [tmpOperationManager POST:pathString parameters:parameters constructingBodyWithBlock:POSTBodyBlock success:success failure:failure];

    }
}

#pragma mark- /////////////////////////////////////////////////////Personal Center APIs（个人中心接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////用户/////##########/////
/* 个人基本资料 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetPersonalInformationWithAccessToken:(NSString *)token
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalInfoDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户注册 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserRegisterWithUserPhone:(NSString *)userPhone
                                                                  validCode:(NSString *)validCode
                                                                   password:(NSString *)password
                                                                 repassword:(NSString *)repassword
                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"telephone":userPhone, @"code":validCode, @"pass_word":password, @"password_again":repassword};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalRegister
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户注册验证码 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserRegisterValidCodeWithUserPhone:(NSString *)userPhone
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"telephone":userPhone};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalRegisterValidCode
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户忘记密码 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserForgetPasswordWithUserPhone:(NSString *)userPhone
                                                                        validCode:(NSString *)validCode
                                                                         password:(NSString *)password
                                                                       repassword:(NSString *)repassword
                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"telephone":userPhone, @"code":validCode, @"pass_word":password, @"password_again":repassword};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalForgotPassword
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}
/* 用户忘记密码验证码 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserForgetPWValidCodeWithUserPhone:(NSString *)userPhone
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"telephone":userPhone};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalForgotPasswordValidCode
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 用户登录 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserLoginWithUserPhone:(NSString *)userPhone
                                                                password:(NSString *)password
                                                               channelID:(NSString *)channelID
                                                             deviceToken:(NSString *)deviceToken
                                                              apnsUserID:(NSString *)apnsUserID
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!channelID) {
            channelID = @"";
        }
        if (!deviceToken) {
            deviceToken = @"";
        }
        if (!apnsUserID) {
            apnsUserID = @"";
        }
        NSDictionary *parameters = @{@"user_name":userPhone,
                                     @"pass_word":password,
                                     @"channelId":channelID,
                                     @"deviceToken":deviceToken,
                                     @"userId":apnsUserID,
                                     @"deviceCode":@""};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalLogin
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 验证Token期限 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostValidUserTokenWithAccessToken:(NSString *)token
                                                                         userID:(NSString *)userID
                                                                      channelID:(NSString *)channelID
                                                                    deviceToken:(NSString *)deviceToken
                                                                     apnsUserID:(NSString *)apnsUserID
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        if (!channelID) {
            channelID = @"";
        }
        if (!deviceToken) {
            deviceToken = @"";
        }
        if (!apnsUserID) {
            apnsUserID = @"";
        }
        
        NSDictionary *parameters = @{@"token":token,
                                     @"userId":userID,
                                     @"channelId":channelID,
                                     @"deviceToken":deviceToken,
                                     @"userId":apnsUserID,
                                     @"deviceCode":@""};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalTokenValid
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户修改密码 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserChangePasswordWithAccessToken:(NSString *)token
                                                                        oldPassword:(NSString *)oldPW
                                                                        newPassword:(NSString *)newPW
                                                                   newPasswordAgain:(NSString *)newPWAgain
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"old_pass_word":oldPW,
                                     @"new_pass_word":newPW,
                                     @"again_pass_word":newPWAgain};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalChangePW
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户基本资料修改 */
- (AFHTTPRequestOperation *)personalCenterAPIsPatchUserPersonalInformationWithAccessToken:(NSString *)token
                                                                           byPortraitPath:(NSString *)portraitPath
                                                                                 autoInfo:(NSString *)autoInfo
                                                                             mobileNumber:(NSNumber *)mobileNumber
                                                                                 nickName:(NSString *)nickName
                                                                                   sexual:(NSNumber *)sexual
                                                                                      bod:(NSString *)bod
                                                                                 qqNumber:(NSNumber *)qqNumber
                                                                                    email:(NSString *)email
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObject:token forKey:kParameterOfToken];
        if (!nickName&&
            !sexual&&
            !bod&&
            !qqNumber&&
            !email&&
            !portraitPath) {
            [ProgressHUDHandler dismissHUDWithCompletion:^{
                
            }];
            return nil;
        }
        if (portraitPath) {
            [parameters setObject:portraitPath forKey:@"faceImg"];
        }else if (nickName) {
            [parameters setObject:nickName forKey:@"nichen"];
        }else if (sexual) {
            [parameters setObject:sexual forKey:@"sex"];
        }else if (bod) {
            [parameters setObject:bod forKey:@"birthday"];
        }else if (qqNumber) {
            [parameters setObject:qqNumber forKey:@"qq"];
        }else if (email) {
            [parameters setObject:email forKey:@"email"];
        }
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalInfoUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户个人头像修改 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUseryPortraitImage:(UIImage *)portraitImage
                                                           imageName:(NSString *)imageName
                                                           imageType:(ConnectionImageType)imageType
                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSString *imageTypeString = @"image/jpeg";
        NSString *imageExt = @"jpg";
        NSData *data = UIImageJPEGRepresentation(portraitImage, 1.0);
        if (ConnectionImageTypeOfPNG==imageType) {
            imageTypeString = @"image/png";
            imageExt = @"png";
            data = UIImagePNGRepresentation(portraitImage);
        }
        if (!imageName){
           imageName = @"userPortraitImage";
        }
        
        APIsConnectionFormData formData = ^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:data name:@"file" fileName:[imageName stringByAppendingPathExtension:imageExt] mimeType:imageTypeString];
        };
        NSDictionary *parameters = @{@"root":@"demo/basic/faceImg"};
        AFHTTPRequestOperation *operation = nil;
//        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
//                                withFirstRelativePath:NO
//                                         relativePath:kCDZPersonalImageUpload
//                                           parameters:parameters
//                        constructingPOSTBodyWithBlock:formData
//                                              success:success
//                                              failure:failure];
        
        operation = [self createImageRequestWithRelativePath:kCDZPersonalImageUpload
                                                  parameters:parameters
                               constructingPOSTBodyWithBlock:formData
                                                     success:success
                                                     failure:failure];
        return operation;
    }
}



/* 用户积分验证码 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserCreditValidCodeWithToken:(NSString *)token
                                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalCreditValidCode
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////车辆管理/////##########/////
/* 车辆列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMyAutoListWithAccessToken:(NSString *)token
                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZMyAutoList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 车辆修改 */
- (AFHTTPRequestOperation *)personalCenterAPIsPatchMyAutoWithAccessToken:(NSString *)token
                                                                myAutoID:(NSString *)myAutoID

                                                            myAutoNumber:(NSString *)myAutoNumber
                                                         myAutoBodyColor:(NSString *)myAutoBodyColor
                                                           myAutoMileage:(NSString *)myAutoMileage
                                                          myAutoFrameNum:(NSString *)myAutoFrameNum

                                                         myAutoEngineNum:(NSString *)myAutoEngineNum
                                                           insuranceDate:(NSString *)insuranceDate
                                                         annualCheckDate:(NSString *)annualCheckDate
                                                         maintenanceDate:(NSString *)maintenanceDate

                                                             registrDate:(NSString *)registrDate
                                                                 brandID:(NSString *)brandID
                                                       brandDealershipID:(NSString *)brandDealershipID
                                                                seriesID:(NSString *)seriesID
                                                                 modelID:(NSString *)modelID
                                                            insuranceNum:(NSString *)insuranceNum
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSMutableDictionary *parameters = [@{kParameterOfToken:token} mutableCopy];
        if (!brandID && !brandDealershipID && !seriesID&&!modelID &&! registrDate&&
            !myAutoNumber && !myAutoBodyColor && !myAutoMileage &&! myAutoFrameNum&&
            !myAutoEngineNum && !insuranceDate && !annualCheckDate && !maintenanceDate &&!insuranceNum) {
            [ProgressHUDHandler dismissHUDWithCompletion:^{
                
            }];
            return nil;
        }
        
        if (brandID&&brandDealershipID&&seriesID&&modelID) {
            [parameters addEntriesFromDictionary: @{@"brand_id":brandID,
                                                    @"factory_id":brandDealershipID,
                                                    @"fct_id":seriesID,
                                                    @"spec_id":modelID}];
        }
        if (myAutoNumber){
            [parameters addEntriesFromDictionary: @{@"car_number":myAutoNumber}];
        }
        if (registrDate){
            [parameters addEntriesFromDictionary: @{@"registr_time":registrDate}];
        }
        if (myAutoBodyColor){
            [parameters addEntriesFromDictionary: @{@"color":myAutoBodyColor}];
        }
        if (myAutoMileage){
            [parameters addEntriesFromDictionary: @{@"mileage":myAutoMileage}];
        }
        if (myAutoFrameNum){
            [parameters addEntriesFromDictionary: @{@"frame_no":myAutoFrameNum}];
        }
        if (myAutoEngineNum){
            [parameters addEntriesFromDictionary: @{@"engine_code":myAutoEngineNum}];
        }
        if (insuranceDate){
            [parameters addEntriesFromDictionary: @{@"insure_time":insuranceDate}];
        }
        if (annualCheckDate){
            [parameters addEntriesFromDictionary: @{@"annual_time":annualCheckDate}];
        }
        if (maintenanceDate){
            [parameters addEntriesFromDictionary: @{@"maintain_time":maintenanceDate}];
        }
        if (insuranceNum){
            [parameters addEntriesFromDictionary: @{@"insuranceNum":insuranceNum}];
        }
    
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMyAutoUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


#pragma mark /////##########/////收藏/////##########/////
/* 收藏的商品列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetProductsCollectionListWithAccessToken:(NSString *)token
                                                                              pageNums:(NSString *)pageNums
                                                                              pageSize:(NSString *)pageSize
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        if (!pageNums) pageNums = @"1";
        if (!pageSize) pageSize = @"10";
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"page_size":pageSize,
                                     @"page_no":pageNums};
        
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZProductsCollectionList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 收藏的店铺列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetShopsCollectionListWithAccessToken:(NSString *)token
                                                                           pageNums:(NSString *)pageNums
                                                                           pageSize:(NSString *)pageSize
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        if (pageSize&&pageNums) {
            parameters = nil;
            parameters = @{kParameterOfToken:token,
                           @"page_size":pageSize,
                           @"page_no":pageNums};
        }
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZShopsCollectionList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}
/* 添加收藏的商品 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostInsertProductCollectionWithAccessToken:(NSString *)token
                                                                           productIDList:(NSArray *)productIDList
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSString *productIDListStr = [productIDList componentsJoinedByString:@","];
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:productIDListStr};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZProductsCollectionAdd
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 添加收藏的店铺 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostInsertShopCollectionWithAccessToken:(NSString *)token
                                                                           shopIDList:(NSArray *)shopIDList
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSString *shopIDListStr = [shopIDList componentsJoinedByString:@","];
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:shopIDListStr};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZShopsCollectionAdd
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 删除收藏的商品 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeleteProductsCollectionWithAccessToken:(NSString *)token
                                                                         collectionIDList:(NSArray *)collectionIDList
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSString *collectionIDListStr = [collectionIDList componentsJoinedByString:@","];
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:collectionIDListStr};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZProductsCollectionDelete
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 删除收藏的店铺 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeleteShopCollectionWithAccessToken:(NSString *)token
                                                                     collectionIDList:(NSArray *)collectionIDList
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSString *collectionIDListStr = [collectionIDList componentsJoinedByString:@","];
        NSDictionary *parameters = @{kParameterOfToken:token,kParameterOfID:collectionIDListStr};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZShopsCollectionDelete
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}
/* 检测商品是否已收藏 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetProductiWasCollectedWithAccessToken:(NSString *)token
                                                                        collectionID:(NSString *)collectionID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSDictionary *parameters = @{kParameterOfToken:token,kParameterOfID:collectionID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZProductWasCollected
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}
/* 检测店铺是否已收藏 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetShopWasCollectedWithAccessToken:(NSString *)token
                                                                          shopID:(NSString *)shopID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSDictionary *parameters = @{kParameterOfToken:token,kParameterOfID:shopID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZShopsWasCollected
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////订单/////##########/////
/* 订单列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetPurchaseOrderListWithAccessToken:(NSString *)token
                                                                         pageNums:(NSString *)pageNums
                                                                         pageSize:(NSString *)pageSize
                                                                        stateName:(NSString *)stateName
                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!pageNums) pageNums = @"1";
        if (!pageSize) pageSize = @"10";
        
        if (!stateName||[stateName isEqualToString:getLocalizationString(@"all_order_list")]) {
            stateName = @"";
        }
            
        NSDictionary *parameters = @{@"page_size":pageSize,
                                     @"page_no":pageNums,
                                     @"state_name":stateName,
                                     kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 订单详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetPurchaseOrderDetailWithAccessToken:(NSString *)token
                                                                        orderMainID:(NSString *)orderMainID
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:orderMainID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 提交订单 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostOrderSubmitWithAccessToken:(NSString *)token
                                                               productIDList:(NSArray *)productIDList
                                                            productCountList:(NSArray *)productCountList
                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSString *productIDListStr = [productIDList componentsJoinedByString:@","];
        NSString *productCountListStr = [productCountList componentsJoinedByString:@","];
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:productIDListStr,
                                     @"add_count":productCountListStr};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchasesOrderDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 订单确认 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostConfirmOrderAndPaymentWithAccessToken:(NSString *)token
                                                                          isRedeemPoint:(BOOL)isRedeemPoint
                                                                            redeemPoint:(NSString *)redeemPoint
                                                                            userRemarks:(NSString *)userRemarks
                                                                          productIDList:(NSString *)productIDList
                                                                       productCountList:(NSString *)productCountList
                                                                        frameNumberList:(NSString *)frameNumberList
                                                                           logisticsFee:(NSString *)logisticsFee
                                                                              addressID:(NSString *)addressID
                                                                             totalPrice:(NSString *)totalPrice
                                                                             verifyCode:(NSString *)verifyCode
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSMutableDictionary *parameters = [@{kParameterOfToken:token,
                                             @"isSelect":@(isRedeemPoint),
                                             @"remarks":userRemarks,
                                             @"number":productIDList,
                                             @"add_count":productCountList,
                                             @"frameNo":frameNumberList,
                                             @"mailFee":logisticsFee,
                                             @"goodsSumPrice":totalPrice,
                                             @"addr":addressID,} mutableCopy];
        if (isRedeemPoint) {
            [parameters setObject:redeemPoint forKey:@"credits"];
            [parameters setObject:verifyCode forKey:@"verify"];
        }
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchasesOrderConfirm
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 订单付款方法－货到付款/状态更变 */
- (AFHTTPRequestOperation *)personalCenterAPIsPaymentMethodByPayAfterDeliveryWithAccessToken:(NSString *)token
                                                                          isPayAfterDelivery:(BOOL)isPayAfterDelivery
                                                                                 orderMainID:(NSString *)orderMainID
                                                                                    costType:(NSString *)costType
                                                                                costTypeName:(NSString *)costTypeName
                                                                                     payType:(NSString *)payType
                                                                                 payTypeName:(NSString *)payTypeName
                                                                                       state:(NSString *)state
                                                                                   stateName:(NSString *)stateName
                                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!costType) {
            costType = @"";
        }
        if (!costTypeName) {
            costTypeName = @"";
        }
        if (!state) {
            state = @"";
        }
        if (!stateName) {
            stateName = @"";
        }
        if (!payType) {
            payType = @"";
        }
        if (!payTypeName) {
            payTypeName = @"";
        }
        
        NSMutableDictionary *parameters = [@{kParameterOfToken:token,
                                             @"finished":@(!isPayAfterDelivery),
                                             @"main_id":orderMainID} mutableCopy];
        
        if (!isPayAfterDelivery) {
            [parameters addEntriesFromDictionary:@{@"cost_type":costType,
                                                   @"cost_type_name":costTypeName,
                                                   @"paytype":payType,
                                                   @"paytype_name":payTypeName,
                                                   @"state":state,
                                                   @"state_name":stateName,}];
        }
        
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPaymentMethodByCashOnDelivery
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 订单付款方法－银联 */
- (AFHTTPRequestOperation *)personalCenterAPIsPaymentMethodByUnionPayWithAccessToken:(NSString *)token
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalLogin
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 订单付款方法－支付宝 */
- (AFHTTPRequestOperation *)personalCenterAPIsPaymentMethodByAlipayWithAccessToken:(NSString *)token
                                                                       orderMainID:(NSString *)orderMainID
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"mainOrderId":orderMainID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPaymentMethodByAlipay
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 更新支付状态 */
- (AFHTTPRequestOperation *)personalCenterAPIsPaymentStatusUpdateWithAccessToken:(NSString *)token
                                                                     orderMainID:(NSString *)orderMainID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"mainId":orderMainID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPaymentStatusUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
    
}

/* 订单完成发表评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostCommentForPurchaseOrderStateOfOrderFinsihWithAccessToken:(NSString *)token
                                                                                               orderMainID:(NSString *)orderMainID
                                                                                                itemNumber:(NSString *)itemNumber
                                                                                                   content:(NSString *)content
                                                                                                    rating:(NSString *)rating
                                                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"mainId":orderMainID,
                                     @"number":itemNumber,
                                     @"content":content,
                                     @"rate":rating};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderComment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 订单完成查看评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetCommentForPurchaseOrderStateOfOrderFinsihWithAccessToken:(NSString *)token
                                                                                              orderMainID:(NSString *)orderMainID
                                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"mainId":orderMainID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderCommentView
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 取消订单 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostCancelPurchaseOrderWithAccessToken:(NSString *)token
                                                                         orderMainID:(NSString *)orderMainID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"mainId":orderMainID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderCancel
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 订单删除 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeletePurchaseOrderWithAccessToken:(NSString *)token
                                                                         orderMainID:(NSString *)orderMainID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"mainId":orderMainID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderDelete
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 确定收货 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostConfirmPurchaseOrderStateOfHasBeenArrivedWithAccessToken:(NSString *)token
                                                                                               orderMainID:(NSString *)orderMainID
                                                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"mainId":orderMainID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderGoodsArrivedConfirm
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户申请退货 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserApplyReturnedPurchaseWithAccessToken:(NSString *)token
                                                                               orderMainID:(NSString *)orderMainID
                                                                                    reason:(NSString *)reason
                                                                                   content:(NSString *)content
                                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"mainId":orderMainID,
                                     @"reason":reason,
                                     @"content":content};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderReturnOfGoods
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 确定退货完成 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostConfirmGoodsHasBeenReturnAccessToken:(NSString *)token
                                                                           orderMainID:(NSString *)orderMainID
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"mainId":orderMainID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderGoodsReturnConfirm
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


#pragma mark /////##########/////保险/////##########/////
/* 检测用户保险信息 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceInfoCheckWithtAccessToken:(NSString *)token
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZUserInsuranceInfoCheck
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户已预约&购买保险列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceAppointmentAndPurchasedListWasPurchasedList:(BOOL)isPurchasedList
                                                                                              accessToken:(NSString *)token
                                                                                                 pageNums:(NSNumber *)pageNums
                                                                                                 pageSize:(NSNumber *)pageSize
                                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"page_no":pageNums,
                                     @"page_size":pageSize,
                                     @"state_name":isPurchasedList?@"已购买":@"已预约"};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:isPurchasedList?kCDZUserInsurancePurchasedList:kCDZUserInsuranceAppointmentList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户已登记的保险车辆 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceAutosListWithAccessToken:(NSString *)token
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
    
        NSDictionary *parameters = @{kParameterOfToken:token};
    
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZUserInsuranceAutosList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户已登记的保险车辆保费详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceAutosInsurancePremiumDetailWithAccessToken:(NSString *)token
                                                                                         autosLicenseNum:(NSString *)autosLicenseNum
                                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"car_number":autosLicenseNum};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZUserInsuranceAutosPremiumDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 用户保险详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceAutosInsuranceDetailWithAccessToken:(NSString *)token
                                                                                        premiumID:(NSString *)premiumID
                                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"premiumId":premiumID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZUserInsuranceDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 添加保险车辆信息 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserAutosInsuranceInfoWithtAccessToken:(NSString *)token
                                                                                 brandID:(NSString *)brandID
                                                                               brandName:(NSString *)brandName
                                                                       brandDealershipID:(NSString *)brandDealershipID
                                                                     brandDealershipName:(NSString *)brandDealershipName
                                                                                seriesID:(NSString *)seriesID
                                                                              seriesName:(NSString *)seriesIName
                                                                                 modelID:(NSString *)modelID
                                                                               modelName:(NSString *)modelName

                                                                                userName:(NSString *)userName
                                                                             phoneNumber:(NSString *)phoneNumber

                                                                                  cityID:(NSString *)cityID
                                                                             autosNumber:(NSString *)autosNumber
                                                                           autosFrameNum:(NSString *)autosFrameNum
                                                                          autosEngineNum:(NSString *)autosEngineNum
                                                                              autosPrice:(NSString *)autosPrice
                                                                       autosRegisterDate:(NSString *)autosRegisterDate

                                                                          autosUsageType:(NSString *)autosUsageType
                                                                         autosNumOfSeats:(NSNumber *)autosNumOfSeats
                                                                           autosWasSHand:(NSNumber *)autosWasSHand
                                                                     autosAssignmentDate:(NSString *)autosAssignmentDate
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"brand":brandID, //(车品牌id)
                                     @"brandName":brandName, //(车品牌)
                                     @"factory":brandDealershipID, //(车厂商id)
                                     @"factoryName":brandDealershipName, //(车厂商)
                                     @"fct":seriesID, //(车系名id)
                                     @"fctName":seriesIName, //(车系名)
                                     @"speci":modelID, //(车型名id)
                                     @"speciName":modelName, //(车型名)
                                     
                                     @"carUserName":userName, //(车主名称),
                                     @"phoneNo":phoneNumber, //(联系方式)
                                     
                                     @"c_city":cityID, //(投保城市)
                                     @"carNumber":autosNumber, //(车牌号)
                                     @"frameNo":autosFrameNum, //(车架号)
                                     @"engineCode":autosEngineNum, //(发动机号)
                                     @"carPrice":autosPrice, //(汽车价格)
                                     @"registTime":autosRegisterDate, //(注册时间)
                                     
                                     @"useType":autosUsageType, //(使用性质)
                                     @"seatNumber":autosNumOfSeats, //(座位号)
                                     @"isAssigned":autosWasSHand?@"是":@"否", //(汽车是否过户)
                                     @"assignedTime":autosAssignmentDate, //(过户时间)
                                     };
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZUserAutosInsuranceInfo
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 提交保险信息 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserAutosInsuranceAppointmentWithtAccessToken:(NSString *)token
                                                                                          carId:(NSString *)carId
                                                                               insuranceCompany:(NSString *)insuranceCompany
                                                                       VTALCInsuranceActiveDate:(NSString *)autosTALCInsuranceActiveDate
                                                                            vehicleAndVesselTax:(NSNumber *)vehicleAndVesselTax
                                                                             autosTALCInsurance:(NSNumber *)autosTALCInsurance

                                                                    commerceInsuranceActiveDate:(NSString *)commerceInsuranceActiveDate
                                                                           autosDamageInsurance:(NSNumber *)autosDamageInsurance
                                                           thirdPartyLiabilityInsuranceCoverage:(NSString *)thirdPartyLiabilityInsuranceCoverage
                                                                   thirdPartyLiabilityInsurance:(NSNumber *)thirdPartyLiabilityInsurance
                                                                       robberyAndTheftInsurance:(NSNumber *)robberyAndTheftInsurance


                                                               driverLiabilityInsuranceCoverage:(NSString *)driverLiabilityInsuranceCoverage
                                                                       driverLiabilityInsurance:(NSNumber *)driverLiabilityInsurance
                                                            passengerLiabilityInsuranceCoverage:(NSString *)passengerLiabilityInsuranceCoverage
                                                                    passengerLiabilityInsurance:(NSNumber *)passengerLiabilityInsurance

                                                                  windshieldDamageInsuranceType:(NSString *)windshieldDamageInsuranceType
                                                                      windshieldDamageInsurance:(NSNumber *)windshieldDamageInsurance
                                                                                  fireInsurance:(NSNumber *)fireInsurance
                                                                 scratchDamageInsuranceCoverage:(NSString *)scratchDamageInsuranceCoverage
                                                                         scratchDamageInsurance:(NSNumber *)scratchDamageInsurance
                                                                 specifyServiceFactoryInsurance:(NSNumber *)specifyServiceFactoryInsurance
                                                      sideMirrorAndHeadlightDamageInsuranceType:(NSString *)sideMirrorAndHeadlightDamageInsuranceType
                                                          sideMirrorAndHeadlightDamageInsurance:(NSNumber *)sideMirrorAndHeadlightDamageInsurance
                                                                         wadingDrivingInsurance:(NSNumber *)wadingDrivingInsurance

                                                                               extraADInsurance:(NSNumber *)extraADInsurance
                                                                              extraRATInsurance:(NSNumber *)extraRATInsurance
                                                                              extraTPLInsurance:(NSNumber *)extraTPLInsurance
                                                                            extraDLNPLInsurance:(NSNumber *)extraDLNPLInsurance
                                                                             extraPlusInsurance:(NSNumber *)extraPlusInsurance
                                                                 businessTotalPriceWithDiscount:(NSNumber *)businessTotalPriceWithDiscount
                                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"carId":carId, 
                                     @"company":insuranceCompany,  //保险公司
                                     @"saliTime":autosTALCInsuranceActiveDate,  //交钱险生效时间
                                     @"taxPrice":vehicleAndVesselTax,  //车船税
                                     @"saliPrice":autosTALCInsurance,  //交强险
                                     @"saliAllPrice":@(autosTALCInsurance.doubleValue+vehicleAndVesselTax.doubleValue),  //交强险 总价
                                     
                                     @"businessTime":commerceInsuranceActiveDate,  //商业险生效日期
                                     @"lossPrice":autosDamageInsurance,  //车辆损失险保费
                                     @"thirdType":thirdPartyLiabilityInsuranceCoverage,  //第三方责任险保额
                                     @"thirdPrice":thirdPartyLiabilityInsurance,  //第三方责任险保费
                                     @"theftPrice":robberyAndTheftInsurance,  //全车盗抢险保费
                                     
                                     @"driverType":driverLiabilityInsuranceCoverage,  //司机座位责任险保额
                                     @"driverPrice":driverLiabilityInsurance,  //司机座位责任险保费
                                     @"passengerType":passengerLiabilityInsuranceCoverage,  //乘客座位责任险保额
                                     @"passengerPrice":passengerLiabilityInsurance,  //乘客座位责任险保费
                                     
                                     @"glassType":windshieldDamageInsuranceType,  //玻璃单独损失险（玻璃进口还是国产）
                                     @"glassPrice":windshieldDamageInsurance,  //玻璃单独损失险保费
                                     @"fire":fireInsurance,  //自燃损失险
                                     @"bodyPrice":scratchDamageInsuranceCoverage,  //车身划痕保额
                                     @"body":scratchDamageInsurance,  //车身划痕保费
                                     @"repair":specifyServiceFactoryInsurance,  //指定专修厂特约险
                                     @"light_type":sideMirrorAndHeadlightDamageInsuranceType,  //倒车镜与车灯 国产还是进口
                                     @"light":sideMirrorAndHeadlightDamageInsurance,  //倒车镜与车灯单独损坏险
                                     @"water":wadingDrivingInsurance,  //涉水行驶损失险
                                     
                                     @"lsPrice":extraADInsurance,  //不计免赔特约险-车损
                                     @"thsPrice":extraRATInsurance,  //不计免赔特约险-盗抢
                                     @"tsPrice":extraTPLInsurance,  //不计免赔特约险-三者
                                     @"msPrice":extraDLNPLInsurance,  //不计免赔特约险-司机乘客
                                     @"anPrice":extraPlusInsurance,  //不计免赔特约险-附加险
                                     @"businessPrice":businessTotalPriceWithDiscount//商业险 折后总价
                                     };
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZUserAutosInsuranceAppointment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////GPS购买/////##########/////
/* GPS购买 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostGPSPurchasesAppointmentWithUserID:(NSString *)userID
                                                                           userName:(NSString *)userName
                                                                            gpsType:(NSUInteger)gpsType
                                                                       dataCardType:(NSUInteger)dataCardType
                                                                   recognizanceType:(NSUInteger)recognizanceType
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSString *gpsTypeName = @"gps1";
        if (gpsType==1) gpsTypeName = @"gps2";
        if (gpsType==2) gpsTypeName = @"gps3";
        
        NSString *recognizanceTypeName = @"pay1";
        if (dataCardType==1) recognizanceTypeName = @"pay2";
        
        NSDictionary *parameters = @{@"userName":userName,
                                     @"userId":userID,
                                     @"gpsType":gpsTypeName,
                                     @"payType":recognizanceTypeName,};
        NSString *path = kCDZGPSPurchasesAppointment;
        if (![_normalResponseFilterSet containsObject:path]) {
            [_normalResponseFilterSet addObject:path];
        }
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:path
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        
        
        return operation;
    }
}

#pragma mark /////##########/////优惠劵/////##########/////
/* 维修商优惠券列表 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopCouponAvailableListWithAccessToken:(NSString *)token
                                                                                   maintenanceShopID:(NSString *)maintenanceShopID
                                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"wxsId":maintenanceShopID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZRepairShopCouponAvailableList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 个人领取维修商优惠券 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsPostUserCollectMaintenanceShopCouponWithAccessToken:(NSString *)token
                                                                                           couponID:(NSString *)couponID
                                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"preferId":couponID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZRepairShopUserCollectCoupon
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 个人中心我的优惠券列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMyCouponCollectedListWithAccessToken:(NSString *)token
                                                                             pageNums:(NSNumber *)pageNums
                                                                             pageSize:(NSNumber *)pageSize
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"page_no":pageNums,
                                     @"page_size":pageSize};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMyCouponUserCollectedCouponList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 使用优惠券选择列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserApplyCouponWithAccessToken:(NSString *)token
                                                                        repairID:(NSString *)repairID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"rid":repairID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMyCouponAppleySelection
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////E-代修/////##########/////
/* E代修检测用户是否预约 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairVerifyUserWasMadeAppointmentWithAccessToken:(NSString *)token
                                                                                            theSign:(NSString *)theSign
                                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSMutableDictionary *parameters = [@{kParameterOfToken:token} mutableCopy];
        if (theSign) {
            [parameters setObject:theSign forKey:@"sign"];
        }
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZERepairVerifyUserWasMadeAppointment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 提交预约E代修服务 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostERepairMakeAppointmentWithAccessToken:(NSString *)token
                                                                           repairShopID:(NSString *)repairShopID
                                                                         repairShopName:(NSString *)repairShopName
                                                                             registrant:(NSString *)registrant
                                                                        registrantPhone:(NSString *)registrantPhone
                                                                                address:(NSString *)address
                                                                         autosModelName:(NSString *)autosModelName
                                                                            repairItems:(NSString *)repairItems
                                                                        appointmentTime:(NSString *)appointmentTime
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"wxsId":repairShopID,
                                     @"wxsName":repairShopName,
                                     @"name":registrant,
                                     @"phone":registrantPhone,
                                     @"address":address,
                                     @"carModel":autosModelName,
                                     @"addTime":appointmentTime,
                                     @"project":repairItems};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZERepairMakeAppointment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* E代修列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairListByStateWithAccessToken:(NSString *)token
                                                                          pageNums:(NSNumber *)pageNums
                                                                          pageSize:(NSNumber *)pageSize
                                                                          listType:(ERepairListType)listType
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        NSString *stateName = @"";
        switch (listType) {
            case ERepairListTypeOfWasAppointment:
                stateName = @"已预约";
                break;
            case ERepairListTypeOfWait4Pickup:
                stateName = @"等待接车";
                break;
            case ERepairListTypeOfAutosRepairing:
                stateName = @"维修中";
                break;
            case ERepairListTypeOfRepairCompleted:
                stateName = @"代修完成";
                break;
                
            default:
                break;
        }
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"page_no":pageNums,
                                     @"page_size":pageSize,
                                     @"state_name":stateName,};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZERepairList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* E代修详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairDetailWithAccessToken:(NSString *)token
                                                                    eRepairID:(NSString *)eRepairID
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"id_str":eRepairID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZERepairDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 取消E-代修服务 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostERepairCancelServiceWithAccessToken:(NSString *)token
                                                                            eRepairID:(NSString *)eRepairID
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:eRepairID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZERepairServiceCancel
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* E-代修确认还车 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostERepairConfirmVehicleWasReturnWithAccessToken:(NSString *)token
                                                                                      eRepairID:(NSString *)eRepairID
                                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"id_str":eRepairID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZERepairConfirmVehicleReturn
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* E-代修专员详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairAssistantDetailWithAccessToken:(NSString *)token
                                                                             eRepairID:(NSString *)eRepairID
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:eRepairID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZERepairAssistantDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* E-代修提交评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostERepairServiceCommentWithAccessToken:(NSString *)token
                                                                             eRepairID:(NSString *)eRepairID
                                                                            rateNumber:(NSNumber *)rateNumber
                                                                               comment:(NSString *)comment
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        rateNumber = @(round( rateNumber.doubleValue * 100.0 ) / 100.0);

        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"id_str":eRepairID,
                                     @"rate":rateNumber,
                                     @"comment":comment};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZERepairSubmitComment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* E-代修查看评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairServiceCommentWithAccessToken:(NSString *)token
                                                                            eRepairID:(NSString *)eRepairID
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"id_str":eRepairID,};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZERepairReviewComment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////地址/////##########/////
/* 地址列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetShippingAddressListWithAccessToken:(NSString *)token
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZShippingAddressList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 添加地址 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostInsertShippingAddressWithAccessToken:(NSString *)token
                                                                         consigneeName:(NSString *)onsigneeName
                                                                          mobileNumber:(NSString *)mobileNumber
                                                                              postCode:(NSString *)postCode
                                                                            provinceID:(NSString *)provinceID
                                                                                cityID:(NSString *)cityID
                                                                            districtID:(NSString *)districtID
                                                                         detailAddress:(NSString *)detailAddress
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{kParameterOfToken:token,
                                                                                          @"name":onsigneeName,
                                                                                          @"tel":mobileNumber,
                                                                                          @"provinceId":provinceID,
                                                                                          @"cityId":cityID,
                                                                                          @"address":detailAddress}];
        if (districtID) {
            [parameters setObject:districtID forKey:@"regionId"];
        }
        if (postCode) {
            [parameters setObject:postCode forKey:@"postCode"];
        }
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZShippingAddressAdd
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 删除地址 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeleteShippingAddressWithAccessToken:(NSString *)token
                                                                         addressIDList:(NSArray *)addressIDList
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSString *addressIDListStr = [addressIDList componentsJoinedByString:@","];
        NSDictionary *parameters = @{kParameterOfToken:token,@"address_id":addressIDListStr};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZShippingAddressDelete
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}
/* 更新地址 */
- (AFHTTPRequestOperation *)personalCenterAPIsPatchShippingAddressWithAccessToken:(NSString *)token
                                                                        addressID:(NSString *)addressID
                                                                    consigneeName:(NSString *)onsigneeName
                                                                     mobileNumber:(NSString *)mobileNumber
                                                                         postCode:(NSString *)postCode
                                                                       provinceID:(NSString *)provinceID
                                                                           cityID:(NSString *)cityID
                                                                       districtID:(NSString *)districtID
                                                                    detailAddress:(NSString *)detailAddress
                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{kParameterOfToken:token,
                                                                                          @"addressId":addressID,
                                                                                          @"name":onsigneeName,
                                                                                          @"tel":mobileNumber,
                                                                                          @"provinceId":provinceID,
                                                                                          @"countryId":cityID,
                                                                                          @"address":detailAddress}];
        if (districtID) {
            [parameters setObject:districtID forKey:@"regionId"];
        }
        if (postCode) {
            [parameters setObject:postCode forKey:@"postCode"];
        }
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZShippingAddressUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////购物车/////##########/////
/* 购物车列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetCartListWithAccessToken:(NSString *)token
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZCartOfCartList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 添加商品到购物车 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostInsertProductToTheCartWithAccessToken:(NSString *)token
                                                                              productID:(NSString *)productID
                                                                                brandID:(NSString *)brandID
                                                                      brandDealershipID:(NSString *)brandDealershipID
                                                                               seriesID:(NSString *)seriesID
                                                                                modelID:(NSString *)modelID
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:productID,
                                     @"brand":brandID,
                                     @"factory":brandDealershipID,
                                     @"speci":seriesID,
                                     @"fct":modelID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZCartOfAddCart
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 删除购物车的商品 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeleteProductFormTheCartWithAccessToken:(NSString *)token
                                                                            productIDList:(NSArray *)productIDList
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSString *productIDListStr = [productIDList componentsJoinedByString:@","];
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:productIDListStr};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZCartOfDeleteCart
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////车辆维修/////##########/////
/* 查询维修列表由维修类型 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMaintenanceStatusListByStatusType:(CDZMaintenanceStatusType)statusType
                                                                       accessToken:(NSString *)token
                                                                          pageNums:(NSNumber *)pageNums
                                                                          pageSize:(NSNumber *)pageSize
                                                                   shopNameOrKeyID:(NSString *)shopNameOrKeyID
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSString *relativePath = nil;
        switch (statusType) {
            case CDZMaintenanceStatusTypeOfAppointment:
                relativePath = kCDZAutosRepairStatusOfAppointment;
                break;
            case CDZMaintenanceStatusTypeOfDiagnosis:
                relativePath = kCDZAutosRepairStatusOfDiagnosis;
                break;
            case CDZMaintenanceStatusTypeOfUserAuthorized:
                relativePath = kCDZAutosRepairStatusOfUserAuthorized;
                break;
            case CDZMaintenanceStatusTypeOfHasBeenClearing:
                relativePath = kCDZAutosRepairStatusOfHasBeenClearing;
                break;
                
            default:
                break;
        }
        if (!relativePath) return nil;
        if (!shopNameOrKeyID) shopNameOrKeyID = @"";
        
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"makenumber_wxsname":shopNameOrKeyID,
                                     @"page_no":pageNums,
                                     @"page_size":pageSize};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:relativePath
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 查询维修详情由维修类型 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMaintenanceStatusDetailByStatusType:(CDZMaintenanceStatusType)statusType
                                                                         accessToken:(NSString *)token
                                                                               keyID:(NSString *)keyID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSString *relativePath = nil;
        switch (statusType) {
            case CDZMaintenanceStatusTypeOfAppointment:
                relativePath = kCDZAutosRepairStatusOfAppointmentDetial;
                break;
            case CDZMaintenanceStatusTypeOfDiagnosis:
                relativePath = kCDZAutosRepairStatusOfDiagnosisDetial;
                break;
            case CDZMaintenanceStatusTypeOfUserAuthorized:
                relativePath = kCDZAutosRepairStatusOfUserAuthorizedDetial;
                break;
            case CDZMaintenanceStatusTypeOfHasBeenClearing:
                relativePath = kCDZAutosRepairStatusOfHasBeenClearingDetial;
                break;
                
            default:
                break;
        }
        if (!relativePath) return nil;
        NSDictionary *parameters = @{kParameterOfToken:token,kParameterOfID:keyID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:relativePath
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 确认委托维修授权 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostConfirmMaintenanceAuthorizationWithAccessToken:(NSString *)token
                                                                                           keyID:(NSString *)keyID
                                                                               repairItemsString:(NSString *)repairItemsString
                                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:keyID,
                                     @"repairName":repairItemsString};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosRepairConfirm
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 结算信息准备 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMaintenanceClearingPaymentInfoWithAccessToken:(NSString *)token
                                                                                         keyID:(NSString *)keyID
                                                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:keyID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosRepairClearingReady
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 取消维修 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostCancelMaintenanceWithAccessToken:(NSString *)token
                                                                             keyID:(NSString *)keyID
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     kParameterOfID:keyID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosRepairCancelMaintenance
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////其他/////##########/////
/* 询价列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetSelfEnquireProductsPriceWithAccessToken:(NSString *)token
                                                                                pageNums:(NSString *)pageNums
                                                                                pageSize:(NSString *)pageSize
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!pageNums) pageNums = @"1";
        if (!pageSize) pageSize = @"10";
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"page_size":pageSize,
                                     @"page_no":pageNums};
        
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZSelfEnquireProductsPrice
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 询价 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostSelfEnquireProductsPriceWithAccessToken:(NSString *)token
                                                                                  brandID:(NSString *)brandID
                                                                        brandDealershipID:(NSString *)brandDealershipID
                                                                                 seriesID:(NSString *)seriesID
                                                                                  modelID:(NSString *)modelID
                                                                                 centerID:(NSString *)centerID
                                                                             mobileNumber:(NSString *)mobileNumber
                                                                                 userName:(NSString *)userName
                                                                             productionID:(NSString *)productionID
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"brand":brandID,
                                     @"factory":brandDealershipID,
                                     @"fct":seriesID,
                                     @"spec":modelID,
                                     @"centerId":centerID,
                                     @"telphone":mobileNumber,
                                     @"real_name":userName,
                                     @"product_id":productionID,};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosPartsEnquirePrice
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}



/* 积分列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetCreditPointsHistoryWithAccessToken:(NSString *)token
                                                                           pageNums:(NSNumber *)pageNums
                                                                           pageSize:(NSNumber *)pageSize
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"page_size":pageSize,
                                     @"page_no":pageNums};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZCreditPointsHistory
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 采购中心列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetPurchaseCenterListWithCityID:(NSString *)cityID
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
    
        NSDictionary *parameters = @{@"cityId":cityID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseCenterList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


#pragma mark- /////////////////////////////////////////////////////Autos Parts APIs（配件接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////汽车配件选择和配件详情/////##########/////
/* 配件第一级分类 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsFirstLevelListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosPartsSearchStepOne
                                           parameters:nil
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 配件第二级分类 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsSecondLevelListWithFirstLevelID:(NSString *)firstLevelID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfID:firstLevelID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosPartsSearchStepTwo
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 配件第三级分类 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsThirdLevelListWithSecondLevelID:(NSString *)secondLevelID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfID:secondLevelID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosPartsSearchStepThree
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 配件第四级分类 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsLastLevelListWithThirdLevelID:(NSString *)thirdLevelID
                                                                    autoModelID:(NSString *)autoModelID
                                                                     priceOrder:(NSString *)priceOrder
                                                               salesVolumeOrder:(NSString *)salesVolumeOrder
                                                                       pageNums:(NSString *)pageNums
                                                                       pageSize:(NSString *)pageSize
                                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!pageNums) pageNums = @"1";
        if (!pageSize) pageSize = @"10";
        
        switch (salesVolumeOrder.integerValue) {
            case 1:
                salesVolumeOrder = @"0";
                break;
            case 2:
                salesVolumeOrder = @"1";
                break;
                
            default:
                salesVolumeOrder = @"";
                break;
        }
        switch (priceOrder.integerValue) {
            case 1:
                priceOrder = @"0";
                break;
            case 2:
                priceOrder = @"1";
                break;
                
            default:
                priceOrder = @"";
                break;
        }
        
        NSDictionary *parameters = @{kParameterOfID:thirdLevelID,
                                     @"page_no":pageNums,
                                     @"page_size":pageSize,
                                     @"price_high_low":priceOrder,
                                     @"sales_high_low":salesVolumeOrder,
                                     @"speci":autoModelID,};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosPartsSearchStepFour
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 配件详情 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsDetailWithLastLevelID:(NSString *)lastLevelID
                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfID:lastLevelID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosPartsDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 配件评论列表 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetAutosPartsCommnetListWithProductID:(NSString *)ProductID
                                                                       pageNums:(NSNumber *)pageNums
                                                                       pageSize:(NSNumber *)pageSize
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        NSDictionary *parameters = @{@"productId":ProductID,@"page_no":pageNums,@"page_size":pageSize};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosPartsComment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 配件推荐列表 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetRecommendProductWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosPartsRecommendProduct
                                           parameters:nil
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 搜索配件 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetAutosPartsSearchListWithKeyword:(NSString *)keyword
                                                                 autoModelID:(NSString *)autoModelID
                                                                  priceOrder:(NSString *)priceOrder
                                                            salesVolumeOrder:(NSString *)salesVolumeOrder
                                                                    pageNums:(NSNumber *)pageNums
                                                                    pageSize:(NSNumber *)pageSize
                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        
        switch (salesVolumeOrder.integerValue) {
            case 1:
                salesVolumeOrder = @"0";
                break;
            case 2:
                salesVolumeOrder = @"1";
                break;
                
            default:
                salesVolumeOrder = @"";
                break;
        }
        switch (priceOrder.integerValue) {
            case 1:
                priceOrder = @"0";
                break;
            case 2:
                priceOrder = @"1";
                break;
                
            default:
                priceOrder = @"";
                break;
        }
        
        NSDictionary *parameters = @{@"name":keyword,
                                     @"speci":autoModelID,
                                     @"price_high_low":priceOrder,
                                     @"sales_high_low":salesVolumeOrder,
                                     @"page_no":pageNums,
                                     @"page_size":pageSize};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosPartsKeywordSearch
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
    
}
#pragma mark- /////////////////////////////////////////////////////Maintenance Shops APIs（维修商接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////查询维修商、维修商详情和附属接口/////##########/////
/* 查询维修商 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsListWithPageNums:(NSString *)pageNums
                                                                           pageSize:(NSString *)pageSize
                                                                            ranking:(NSString *)rankValue
                                                                          serviceID:(NSString *)serviceID
                                                                           shopType:(NSString *)shopType
                                                                           shopName:(NSString *)shopName
                                                                             cityID:(NSString *)cityID
                                                                            address:(NSString *)address
                                                                          autoBrand:(NSString *)autoBrand
                                                                          longitude:(NSString *)longitude
                                                                           latitude:(NSString *)latitude
                                                                        isCertified:(BOOL)isCertified
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!pageNums) pageNums = @"1";
        if (!pageSize) pageSize = @"10";
        if (!rankValue) rankValue = @"";
        if (!serviceID) serviceID = @"";
        
        if (!shopType) shopType = @"";
        if (!shopName) shopName = @"";
        
        if (!cityID) cityID = @"";
        if (!address) address = @"";
        if (!autoBrand) autoBrand = @"";
        
        if (!longitude||!latitude) {
            longitude = @"112.979353";
            latitude = @"28.213478";
        }
        
        
        
        NSDictionary *parameters = @{@"page_size":pageSize,
                                     @"page_no":pageNums,
                                     @"rank":rankValue,
                                     @"service_item":serviceID,
                                     
                                     @"user_kind_id":shopType,
                                     @"shop_name":shopName,
                                     
                                     @"city":cityID,
                                     @"address":address,
                                     @"brand":autoBrand,
                                     
                                     @"longitude":longitude,
                                     @"latitude":latitude,
                                     @"isTrue":[@(isCertified) stringValue]};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopSearch
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 维修商详情 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsDetailWithShopID:(NSString *)shopID
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"wxsId":shopID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopDetails
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 维修商属下维修技师 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsTechnicianListWithShopID:(NSString *)shopID
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"wxsId":shopID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopTechnicianList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 维修商属下维修技师详情 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsTechnicianDetailWithTechnicianID:(NSString *)technicianID
                                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfID:technicianID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopTechnicianDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 维修商种类 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsTypeListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalLogin
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 维修商评论列表 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsCommnetListWithShopID:(NSString *)shopID
                                                                                pageNums:(NSString *)pageNums
                                                                                pageSize:(NSString *)pageSize
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!pageNums) pageNums = @"1";
        if (!pageSize) pageSize = @"10";
        
        NSDictionary *parameters = @{kParameterOfID:shopID,@"page_no":pageNums,@"page_size":pageSize};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopComment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}
/* 维修商公用设施 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsInfrastructureWithShopID:(NSString *)shopID
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"equipment":shopID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopEquipment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 预约维修商保养或者维修选择 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsPostAppointmentFromMaintenanceShopsWithShopID:(NSString *)shopID
                                                                                 workingPrice:(NSString *)workingPrice
                                                                                  serviceItem:(NSString *)serviceItem
                                                                              isRepairService:(BOOL)isRepairService
                                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalLogin
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 确认和提交预约信息 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsPostConfirmAppointmentMaintenanceServieWithAccessToken:(NSString *)token
                                                                                                shopID:(NSString *)shopID
                                                                                           serviceItem:(NSString *)serviceItem
                                                                                           serviceType:(NSNumber *)serviceType
                                                                                           contactName:(NSString *)contactName
                                                                                         contactNumber:(NSString *)contactNumber
                                                                                        purchaseByShop:(BOOL)isPurchaseByShop
                                                                                              dateTime:(NSString *)dateTime
                                                                                          technicianID:(NSString *)technicianID
                                                                                              isChange:(NSNumber *)isChange
                                                                                               brandID:(NSString *)brandID
                                                                                     brandDealershipID:(NSString *)brandDealershipID
                                                                                              seriesID:(NSString *)seriesID
                                                                                               modelID:(NSString *)modelID
                                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSString *serviceTypeString = @"维修";
        if (serviceType.integerValue==1&&serviceType.integerValue<=2) {
            serviceTypeString = @"保养";
        }
        if (serviceType.integerValue==2&&serviceType.integerValue<=2) {
            serviceTypeString = @"保养-维修";
        }
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"wxsId":shopID,
                                     @"project":serviceTypeString,
                                     @"item":serviceItem,
                                     @"contactNumber":contactNumber,
                                     @"contacts":contactName,
                                     @"remark":@(isPurchaseByShop+1),
                                     @"addtime":dateTime,
                                     @"technician":technicianID,
                                     @"brand":brandID,
                                     @"factory":brandDealershipID,
                                     @"fct":seriesID,
                                     @"speci":modelID,
                                     @"isChange":isChange};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopConfirmAppointment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 维修完成评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostCommentForShopRepairFinishWithAccessToken:(NSString *)token
                                                                                 makeNumber:(NSString *)makeNumber
                                                                                    content:(NSString *)content
                                                                                     rating:(NSString *)rating
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"makeNumber":makeNumber,
                                     @"content":content,
                                     @"rate":rating};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopRepairFinishComment
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 获取预约维修资讯  */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetAppointmentPrepareRepairInfoWithShopID:(NSString *)shopID
                                                              repairServiceItemListString:(NSString *)repairServiceItemListString
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"wxsId":shopID,
                                     @"phenomenon":repairServiceItemListString};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopAppointmentRepairInfoPrepare
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 获取预约保养资讯  */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetAppointmentPrepareMaintenanceInfoWithShopID:(NSString *)shopID
                                                                maintenanceServiceIDListString:(NSString *)maintenanceServiceIDListString
                                                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"wxsId":shopID,
                                     kParameterOfID:maintenanceServiceIDListString};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZMaintenanceShopAppointmentMaintenanceInfoPrepare
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


#pragma mark- /////////////////////////////////////////////////////Self-Diagnosis APIs（自助诊断接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////自助诊断结果/////##########/////
/* 故障解决方案 */
- (AFHTTPRequestOperation *)theSelfDiagnosisAPIsGetSolutionPlanWithDiagnosisResultID:(NSString *)diagnosisResultID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"yyfxId":diagnosisResultID};
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZSelfDiagnosisSolutionPlan
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 配件更换建议 */
- (AFHTTPRequestOperation *)theSelfDiagnosisAPIsGetProposedReplacementPartsWithSolutionPlanID:(NSString *)solutionPlanID
                                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"jjfaId":solutionPlanID};
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZSelfDiagnosisReplacementParts
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 获取维修商 */
- (AFHTTPRequestOperation *)theSelfDiagnosisAPIsGetMaintenanceShopsSuggestListWithReplacementPartsName:(NSString *)replacementPartsName
                                                                                            seriesID:(NSString *)seriesID
                                                                                         autoModelID:(NSString *)autoModelID
                                                                                             address:(NSString *)address
                                                                                        isDescenting:(NSNumber *)isDescenting
                                                                                           longitude:(NSString *)longitude
                                                                                            latitude:(NSString *)latitude
                                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"serviceModel":replacementPartsName,
                                                                                          @"fctid":seriesID,
                                                                                          @"specid":autoModelID,
                                                                                          @"flag":isDescenting.stringValue}];
        if (address) {
            [parameters setObject:address forKey:@"address"];
        }
        if (longitude&&latitude) {
            [parameters setObject:longitude forKey:@"longitude"];
            [parameters setObject:latitude forKey:@"latitude"];
        }
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZSelfDiagnosisResult
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


#pragma mark- /////////////////////////////////////////////////////Get History Cases of Success APIs（获取案例接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////获取案例步骤/////##########/////

/* 获取案例第一级分类 */
- (AFHTTPRequestOperation *)casesHistoryAPIsGetHistoryCasesOfStepOneListWithAutosModelID:(NSNumber *)autosModelID
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"speci":autosModelID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZCasesHistoryListStepOne
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 获取案例第二级分类 */
- (AFHTTPRequestOperation *)casesHistoryAPIsGetHistoryCasesOfStepTwoListWithStepOneID:(NSString *)stepOneID
                                                                    selectedTextTitle:(NSString *)selectedTextTitle
                                                                       isDescSymptoms:(BOOL)isDescSymptoms
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfID:stepOneID,
                                     @"flag":@(isDescSymptoms+1),
                                     @"selectText":selectedTextTitle};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZCasesHistoryListStepTwo
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 获取案例结果 */
- (AFHTTPRequestOperation *)casesHistoryAPIsGetHistoryCasesResultListWithTwoStepIDsList:(NSArray *)twoStepIDsList
                                                                        twoStepTextList:(NSArray *)twoStepTesxtList
                                                                                address:(NSString *)address
                                                                              priceSort:(NSString *)priceSort
                                                                                brandID:(NSString *)brandID
                                                                      brandDealershipID:(NSString *)brandDealershipID
                                                                               seriesID:(NSString *)seriesID
                                                                                modelID:(NSString *)modelID
                                                                               pageNums:(NSNumber *)pageNums
                                                                               pageSize:(NSNumber *)pageSize
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSString *theIDsListString = [twoStepIDsList componentsJoinedByString:@","];
        NSString *theTitleListString = [twoStepTesxtList componentsJoinedByString:@"|"];
        if (!address) {
            address = @"";
        }
        if (!priceSort) {
            priceSort = @"";
        }
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        
        NSDictionary *parameters = @{@"tid":theIDsListString,
                                     @"selectText":theTitleListString,
                                     @"address":address,
                                     @"fee_sort":priceSort,
                                     @"brand":brandID,
                                     @"factory":brandDealershipID,
                                     @"speci":seriesID,
                                     @"fct":modelID,
                                     @"page_size":pageSize,
                                     @"page_no":pageNums};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZCasesHistoryResultList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
    
}



/* 获取案例 */
- (AFHTTPRequestOperation *)casesHistoryAPIsGetHistoryCasesOfSuccessMaintenanceShopsListWithPageNums:(NSString *)pageNums
                                                                                            pageSize:(NSString *)pageSize
                                                                                   diagnosisResultID:(NSString *)diagnosisResultID
                                                                                            shopType:(NSString *)shopType
                                                                                   isPriceDescenting:(BOOL)isPriceDescenting
                                                                                isDistanceDescenting:(BOOL)isDistanceDescenting
                                                                                           longitude:(NSString *)longitude
                                                                                            latitude:(NSString *)latitude
                                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZPersonalLogin
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 案例详情 */
- (AFHTTPRequestOperation *)casesHistoryAPIsGetHistoryCasesOfCaseDetailWithSubscribeID:(NSString *)subscribeID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfID:subscribeID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZCasesHistoryOfCaseDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


#pragma mark- /////////////////////////////////////////////////////Self-Maintenance APIs（自助保养接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////自助维修步骤和结果/////##########/////
/* 获取保养信息 */
- (AFHTTPRequestOperation *)theSelfMaintenanceAPIsGetMaintenanceInfoWithAutoModelID:(NSString *)autoModelID
                                                                   autoTotalMileage:(NSString *)autoTotalMileage
                                                                       purchaseDate:(NSString *)purchaseDate
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"speci":autoModelID,@"mileage":autoTotalMileage,@"buyDate":purchaseDate};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZSelfMaintenanceGetInfo
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 选择保养服务 */
- (AFHTTPRequestOperation *)theSelfMaintenanceAPIsGetMaintenanceServiceListWithPartsIDList:(NSArray *)partsIDList
                                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"isChecked":[partsIDList componentsJoinedByString:@","]};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZSelfMaintenanceServiceList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 配件详情 */
- (AFHTTPRequestOperation *)theSelfMaintenanceAPIsGetItemDetailWithProductID:(NSString *)productID
                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"productId":productID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZSelfMaintenancePartsDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}



#pragma mark- /////////////////////////////////////////////////////Common APIs（公用接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////新自助诊断步骤/////##########/////
/* 新自助诊断1～5步 */

- (AFHTTPRequestOperation *)commonAPIsGetAutoSelfDiagnosisStepListWithStep:(SelfDiagnosisSelectionStep)theStep
                                                            previousStepID:(NSString *)previousStepID
                                                                  seriesID:(NSNumber *)seriesID
                                                                   modelID:(NSNumber *)modelID
                                                                    typeID:(NSNumber *)typeID
                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSString *relativePath = @"";
        NSDictionary *parameters = nil;
        if (theStep==SelfDiagnosisStepOne) {
            if (!seriesID||!modelID||seriesID.integerValue==0||modelID.integerValue==0) {
                relativePath = @"";
            }else {
                parameters = @{@"fct":seriesID,@"speci":modelID};
                relativePath = kCDZSelfDiagnoseFirstStepList;
            }
        }else if (theStep==SelfDiagnosisStepTwo) {
            if (!seriesID||!modelID||seriesID.integerValue==0||modelID.integerValue==0) {
                relativePath = @"";
            }else {
                parameters = @{@"fct":seriesID,@"speci":modelID,
                               kParameterOfID:previousStepID,
                               @"type":typeID};
                relativePath = kCDZSelfDiagnoseSecondStepList;
            }
        }else {
            if (theStep==SelfDiagnosisStepThree) {
                relativePath = kCDZSelfDiagnoseThirdStepList;
            }
            if (theStep==SelfDiagnosisStepFour) {
                relativePath = kCDZSelfDiagnoseFourthStepList;
            }
            if (theStep==SelfDiagnosisStepFive) {
                relativePath = kCDZSelfDiagnoseFifthStepList;
            }
            if (!previousStepID||[previousStepID isEqualToString:@""]) {
                relativePath = @"";
            }else {
                parameters = @{kParameterOfID:previousStepID,
                               @"type":typeID};
            }
        }
        
        if ([relativePath isEqualToString:@""]) {
            return nil;
        }
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:relativePath
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 新自助诊断结果 */
- (AFHTTPRequestOperation *)selfDiagnoseAPIsGetDiagnoseResultListWithReasonName:(NSString *)reasonName
                                                                        brandId:(NSNumber *)brandId
                                                                       pageNums:(NSNumber *)pageNums
                                                                       pageSize:(NSNumber *)pageSize
                                                                      longitude:(NSNumber *)longitude
                                                                       latitude:(NSNumber *)latitude
                                                                         cityID:(NSNumber *)cityID
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        NSDictionary *parameters = @{@"reasonName":reasonName,
                                     @"city":cityID,
                                     @"lat":latitude,
                                     @"lng":longitude,
                                     @"brandId":brandId,
                                     @"page_size":pageSize,
                                     @"page_no":pageNums};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZSelfDiagnoseFinalResultList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////获取案例和自助诊断公用步骤/////##########////

/* 故障种类 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoFailureTypeListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosFailureType
                                           parameters:nil
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 故障现象 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoFaultSymptomListWithAutoFailureTypeID:(NSString *)failureTypeID
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"gzzlId":failureTypeID};
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosFaultSymptom
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 故障架构 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoFaultStructureListWithAutoFaultSymptomID:(NSString *)faultSymptomID
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"gzxxId":faultSymptomID};
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosFaultStructure
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 故障原因分析 */
- (AFHTTPRequestOperation *)commonAPIsGetDiagnosisResultListWithAutoFaultStructureID:(NSString *)faultStructureID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"gzjgId":faultStructureID};
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosFaultDiagnosis
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////汽车型号选择/////##########/////
/* 车辆品牌 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoBrandListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutoBrandList
                                           parameters:nil
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 车辆经销商 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoBrandDealershipListWithBrandID:(NSString *)brandID
                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"brandId":brandID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosFactoryName
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 车辆系列 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoSeriesListWithBrandDealershipID:(NSString *)brandDealershipID
                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"factoryId":brandDealershipID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutosFctList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 车辆型号 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoModelListWithAutoSeriesID:(NSString *)seriesID
                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"fctId":seriesID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAutoSpecList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark /////##########/////其他/////##########/////

/* 省份列表 */
- (AFHTTPRequestOperation *)commonAPIsGetProvinceListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZProvinceList
                                           parameters:nil
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 城市列表 */
- (AFHTTPRequestOperation *)commonAPIsGetCityListWithProvinceID:(NSString *)provinceID
                                                      isKeyCity:(BOOL)isKeyCity
                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!provinceID) {
            provinceID = @"";
        }
        NSDictionary *parameters = @{@"provinceId":provinceID,@"isKeyCity":@(isKeyCity)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZCityListWithProvince
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 区列表 */
- (AFHTTPRequestOperation *)commonAPIsGetDistrictListWithCityID:(NSString *)cityID
                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{@"cityId":cityID};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZDistrictListWithCity
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 维修商类型列表 */
- (AFHTTPRequestOperation *)commonAPIsGetRepairShopTypeListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZRepairShopType
                                           parameters:nil
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 维修商保养服务类型列表 */
- (AFHTTPRequestOperation *)commonAPIsGetRepairShopServiceTypeListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZRepairShopServiceType
                                           parameters:nil
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}
/* 维修商保养服务列表 */
- (AFHTTPRequestOperation *)commonAPIsGetRepairShopServiceListWithShopID:(NSString *)shopID
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        NSDictionary *parameters  = nil;
        if (shopID&&![shopID isEqualToString:@""]) {
            parameters = @{@"wxs_id":shopID};
        }
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZRepairShopServiceList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 订单状态列表 */
- (AFHTTPRequestOperation *)commonAPIsGetPurchaseOrderStatusListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZPurchaseOrderStatusList
                                           parameters:nil
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

#pragma mark- /////##########/////GPS/////##########/////
#pragma mark /////##########/////GPS配置/////##########/////
/* 车辆实时位置信息 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoGPSRealtimeInfoWithAccessToken:(NSString *)token
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoRealtimeInfo
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 查询GPS上传设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetUploadSettingStatusWithAccessToken:(NSString *)token
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSUploadSettingStauts
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改GPS上传设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostUpdateGPSUploadSettingWithAccessToken:(NSString *)token
                                                                     localinfoStatus:(NSNumber *)localinfoStatus
                                                                        remindStatus:(NSNumber *)remindStatus
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"locainfoStatus":localinfoStatus,
                                     @"remindStatus":remindStatus};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSUpdateUploadSetting
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


#pragma mark /////##########/////OBD&&车辆配置/////##########/////
/* 服务密码验证 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAuthorizeServerSecurityPWWithAccessToken:(NSString *)token
                                                                                 serPwd:(NSString *)serPwd
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"password":serPwd};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAuthorizeServerSecurityPW
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 快速设防详情 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetFastPreventionDetailWithAccessToken:(NSString *)token
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSFastPreventionDetail
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 开启快速设防 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostFastPreventionOfnWithAccessToken:(NSString *)token
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token };
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSFastPreventionOn
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 关闭快速设防 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostFastPreventionOffWithAccessToken:(NSString *)token
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSFastPreventionOff
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 省电设置详情 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoPowerSaveStatusWithAccessToken:(NSString *)token
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoPowerSaveStatus
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改省电设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoPowerSaveChangeStatusWithAccessToken:(NSString *)token
                                                                                 status:(BOOL)status
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoPowerSaveChangeStatus
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 设备安装校正 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoDeviceCalibrationWithAccessToken:(NSString *)token
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoDeviceCalibrate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 点火熄火校准 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoIgnitionSystemCalibrationWithAccessToken:(NSString *)token
                                                                                     status:(BOOL)status
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoIgnitionSystemCalibrate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}




/* 获取安全设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoAllAlertStatusListWithAccessToken:(NSString *)token
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoAllAlertStatusList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改侧翻设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoRoleAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                 status:(BOOL)status
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoRoleAlertStatusUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改碰撞设置*/
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoImpactAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                   status:(BOOL)status
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoImpactAlertStatusUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改电瓶低电压设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoBatteryLowAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                       status:(BOOL)status
                                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoBatteryLowAlertStatusUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改拖车设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoTrailingAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                     status:(BOOL)status
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoTrailingAlertStatusUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改设备移除（断电）设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoODBRemoveAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                      status:(BOOL)status
                                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoODBRemoveAlertStatusUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改防盗喇叭设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoSecurityAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                     status:(BOOL)status
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoSecurityAlertStatusUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改疲劳驾驶设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoFatigueDrivingAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                           status:(BOOL)status
                                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoFatigueDrivingAlertStatusUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}



/* 获取超速设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoOverSpeedSettingWithAccessToken:(NSString *)token
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoOverSpeedSetting
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 修改超速设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoOverSpeedSettingUpdateWithAccessToken:(NSString *)token
                                                                                    speedStatus:(BOOL)speedStatus
                                                                                          speed:(NSNumber *)speed
                                                                                    voiceStatus:(BOOL)voiceStatus
                                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"ratedStatus":@(speedStatus),
                                     @"ratedSpeed":speed,
                                     @"voiceStatus":@(voiceStatus)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoOverSpeedSettingUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 获取断油断电设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoPowerAndOilControlStatusWithAccessToken:(NSString *)token
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoPowerAndOilControlStatus
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 修改断油断电设置*/
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoPowerAndOilControlStatusUpdateWithAccessToken:(NSString *)token
                                                                                          status:(BOOL)status
                                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,@"status":@(status)};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoPowerAndOilControlStatusUpdate
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


/* 查询个人电子围栏 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoElectricFencingDetialWithAccessToken:(NSString *)token
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoElectricFencingDetial
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 增加电子围栏 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoAddElectricFencingWithAccessToken:(NSString *)token
                                                                                type:(NSString *)type
                                                                              radius:(NSString *)radius
                                                                           longitude:(NSString *)longitude
                                                                            latitude:(NSString *)latitude
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"type":type,
                                     @"radius":radius,
                                     @"longitude":longitude,
                                     @"latitude":latitude};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoAddElectricFencing
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 删除电子围栏 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoRemoveElectricFencingWithAccessToken:(NSString *)token
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoRemoveElectricFencing
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}





/* OBD主动查询 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoOBDDataWithAccessToken:(NSString *)token
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoOBDData
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* OBD故障检测 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoOBDDiagnosisWithAccessToken:(NSString *)token
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoOBDDiagnosis
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


#pragma mark /////##########/////GPS、汽车记录和数据/////##########/////
/* 行车轨迹 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetDrivingHistoryListWithAccessToken:(NSString *)token
                                                                  startDateTime:(NSString *)startDateTime
                                                                    endDateTime:(NSString *)endDateTime
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"startTime":startDateTime,
                                     @"endTime":endDateTime};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSAutoDrivingHistoryList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

/* 清除行车历史轨迹 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostEraseDrivingHistoryWithAccessToken:(NSString *)token
                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        NSDictionary *parameters = @{kParameterOfToken:token};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfPOST
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSEraseDrivingHistory
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}


#pragma mark /////##########/////其他/////##########/////
/* 消息列表 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetMessageAlertListWithAccessToken:(NSString *)token
                                                                     pageNums:(NSNumber *)pageNums
                                                                     pageSize:(NSNumber *)pageSize
                                                                    plateName:(NSString *)plateName
                                                                     typeName:(NSString *)typeName
                                                              isMessWasReaded:(BOOL)isMessWasReaded
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        
        
        if (!pageNums) pageNums = @(1);
        if (!pageSize) pageSize = @(10);
        if (!plateName) plateName = @"";
        if (!typeName) typeName = @"";
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"page_size":pageSize,
                                     @"page_no":pageNums,
                                     @"plate_name":plateName,
                                     @"type_nam":typeName,
                                     @"state_name":@(isMessWasReaded)};

        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZGPSMessageAlertList
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        
        return operation;
    }
}

/* 推送消息设置 */
- (AFHTTPRequestOperation *)personalCenterAPNSSettingAlertListWithAccessToken:(NSString *)token
                                                                    messageON:(BOOL)messageON
                                                                    channelID:(NSString *)channelID
                                                                  deviceToken:(NSString *)deviceToken
                                                                   apnsUserID:(NSString *)apnsUserID
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    @autoreleasepool {
        if (!channelID) {
            channelID = @"";
        }
        if (!deviceToken) {
            deviceToken = @"";
        }
        if (!apnsUserID) {
            apnsUserID = @"";
        }
        if ([deviceToken isEqualToString:@""]||[channelID isEqualToString:@""]||[apnsUserID isEqualToString:@""]) {
            messageON = NO;
        }
        NSDictionary *parameters = @{kParameterOfToken:token,
                                     @"message":@(!messageON),
                                     @"channelId":channelID,
                                     @"deviceToken":deviceToken,
                                     @"userId":apnsUserID,
                                     @"deviceCode":@""};
        
        AFHTTPRequestOperation *operation = nil;
        operation = [self createRequestWithHTTPMethod:CDZAPIsHTTPMethodTypeOfGET
                                withFirstRelativePath:YES
                                         relativePath:kCDZAPNSPushSetting
                                           parameters:parameters
                        constructingPOSTBodyWithBlock:nil
                                              success:success
                                              failure:failure];
        return operation;
    }
}

@end
