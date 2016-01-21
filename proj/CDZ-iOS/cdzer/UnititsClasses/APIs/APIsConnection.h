//
//  APIsConnection.h
//  cdzer
//
//  Created by KEns0n on 4/9/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIsDefine.h"
#import "APIsErrorHandler.h"


typedef NS_ENUM(NSInteger, CDZAPIsHTTPMethod) {
    CDZAPIsHTTPMethodTypeOfGET,
    CDZAPIsHTTPMethodTypeOfPOST,
    CDZAPIsHTTPMethodTypeOfPUT,
    CDZAPIsHTTPMethodTypeOfPATCH,
    CDZAPIsHTTPMethodTypeOfDELETE,
};

typedef NS_ENUM(NSInteger, ConnectionImageType) {
    ConnectionImageTypeOfPNG = 1,
    ConnectionImageTypeOfJPEG = 2,
};

typedef NS_ENUM(NSInteger, SelfDiagnosisSelectionStep) {
    SelfDiagnosisStepOne = 0,
    SelfDiagnosisStepTwo = 1,
    SelfDiagnosisStepThree = 2,
    SelfDiagnosisStepFour = 3,
    SelfDiagnosisStepFive = 4,
};

typedef NS_ENUM(NSInteger, ERepairListType) {
    ERepairListTypeOfWasAppointment = 0,
    ERepairListTypeOfWait4Pickup = 1,
    ERepairListTypeOfAutosRepairing = 2,
    ERepairListTypeOfRepairCompleted = 3,
};

@class AFHTTPRequestOperation;
@interface APIsConnection : NSObject

+ (APIsConnection *)shareConnection;


- (AFHTTPRequestOperation *)createRequestWithHTTPMethod:(CDZAPIsHTTPMethod)methodType
                                  withFirstRelativePath:(BOOL)withFirstRelativePath
                                           relativePath:(NSString *)pathString
                                             parameters:(id)parameters
                          constructingPOSTBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))POSTBodyBlock
                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark - /////////////////////////////////////////////////////Personal Center APIs（个人中心接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////用户/////##########/////
/* 个人基本资料 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetPersonalInformationWithAccessToken:(NSString *)token
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户注册 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserRegisterWithUserPhone:(NSString *)userPhone
                                                                  validCode:(NSString *)validCode
                                                                   password:(NSString *)password
                                                                 repassword:(NSString *)repassword
                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户注册验证码 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserRegisterValidCodeWithUserPhone:(NSString *)userPhone
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户忘记密码 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserForgetPasswordWithUserPhone:(NSString *)userPhone
                                                                        validCode:(NSString *)validCode
                                                                         password:(NSString *)password
                                                                       repassword:(NSString *)repassword
                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 用户忘记密码验证码 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserForgetPWValidCodeWithUserPhone:(NSString *)userPhone
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户登录 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserLoginWithUserPhone:(NSString *)userPhone
                                                                password:(NSString *)password
                                                               channelID:(NSString *)channelID
                                                             deviceToken:(NSString *)deviceToken
                                                              apnsUserID:(NSString *)apnsUserID
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 验证Token期限 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostValidUserTokenWithAccessToken:(NSString *)token
                                                                         userID:(NSString *)userID
                                                                      channelID:(NSString *)channelID
                                                                    deviceToken:(NSString *)deviceToken
                                                                     apnsUserID:(NSString *)apnsUserID
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户修改密码 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserChangePasswordWithAccessToken:(NSString *)token
                                                                        oldPassword:(NSString *)oldPW
                                                                        newPassword:(NSString *)newPW
                                                                   newPasswordAgain:(NSString *)newPWAgain
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户个人头像修改 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUseryPortraitImage:(UIImage *)portraitImage
                                                           imageName:(NSString *)imageName
                                                           imageType:(ConnectionImageType)imageType
                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)personalCenterAPIsPostUserCreditValidCodeWithToken:(NSString *)token
                                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////车辆管理/////##########/////
/* 车辆列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMyAutoListWithAccessToken:(NSString *)token
                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


#pragma mark /////##########/////收藏/////##########/////
/* 收藏的商品列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetProductsCollectionListWithAccessToken:(NSString *)token
                                                                              pageNums:(NSString *)pageNums
                                                                              pageSize:(NSString *)pageSize
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 收藏的店铺列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetShopsCollectionListWithAccessToken:(NSString *)token
                                                                           pageNums:(NSString *)pageNums
                                                                           pageSize:(NSString *)pageSize
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 添加收藏的商品 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostInsertProductCollectionWithAccessToken:(NSString *)token
                                                                           productIDList:(NSArray *)productIDList
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 添加收藏的店铺 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostInsertShopCollectionWithAccessToken:(NSString *)token
                                                                           shopIDList:(NSArray *)shopIDList
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 删除收藏的商品 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeleteProductsCollectionWithAccessToken:(NSString *)token
                                                                         collectionIDList:(NSArray *)collectionIDList
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 删除收藏的店铺 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeleteShopCollectionWithAccessToken:(NSString *)token
                                                                     collectionIDList:(NSArray *)collectionIDList
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 检测商品是否已收藏 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetProductiWasCollectedWithAccessToken:(NSString *)token
                                                                        collectionID:(NSString *)collectionID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 检测店铺是否已收藏 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetShopWasCollectedWithAccessToken:(NSString *)token
                                                                          shopID:(NSString *)shopID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////订单/////##########/////
/* 订单列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetPurchaseOrderListWithAccessToken:(NSString *)token
                                                                         pageNums:(NSString *)pageNums
                                                                         pageSize:(NSString *)pageSize
                                                                        stateName:(NSString *)stateName
                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 订单详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetPurchaseOrderDetailWithAccessToken:(NSString *)token
                                                                        orderMainID:(NSString *)orderMainID
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 提交订单 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostOrderSubmitWithAccessToken:(NSString *)token
                                                               productIDList:(NSArray *)productIDList
                                                            productCountList:(NSArray *)productCountList
                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 订单付款方法－银联 */
- (AFHTTPRequestOperation *)personalCenterAPIsPaymentMethodByUnionPayWithAccessToken:(NSString *)token
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 订单付款方法－支付宝 */
- (AFHTTPRequestOperation *)personalCenterAPIsPaymentMethodByAlipayWithAccessToken:(NSString *)token
                                                                       orderMainID:(NSString *)orderMainID
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 更新支付状态 */
- (AFHTTPRequestOperation *)personalCenterAPIsPaymentStatusUpdateWithAccessToken:(NSString *)token
                                                                     orderMainID:(NSString *)orderMainID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 订单完成发表评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostCommentForPurchaseOrderStateOfOrderFinsihWithAccessToken:(NSString *)token
                                                                                               orderMainID:(NSString *)orderMainID
                                                                                                itemNumber:(NSString *)itemNumber
                                                                                                   content:(NSString *)content
                                                                                                    rating:(NSString *)rating
                                                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 订单完成查看评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetCommentForPurchaseOrderStateOfOrderFinsihWithAccessToken:(NSString *)token
                                                                                              orderMainID:(NSString *)orderMainID
                                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 取消订单 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostCancelPurchaseOrderWithAccessToken:(NSString *)token
                                                                         orderMainID:(NSString *)orderMainID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 订单删除 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeletePurchaseOrderWithAccessToken:(NSString *)token
                                                                         orderMainID:(NSString *)orderMainID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 确定收货 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostConfirmPurchaseOrderStateOfHasBeenArrivedWithAccessToken:(NSString *)token
                                                                                               orderMainID:(NSString *)orderMainID
                                                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户申请退货 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserApplyReturnedPurchaseWithAccessToken:(NSString *)token
                                                                               orderMainID:(NSString *)orderMainID
                                                                                    reason:(NSString *)reason
                                                                                   content:(NSString *)content
                                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 确定退货完成 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostConfirmGoodsHasBeenReturnAccessToken:(NSString *)token
                                                                           orderMainID:(NSString *)orderMainID
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure ;

#pragma mark /////##########/////保险/////##########/////
/* 检测用户保险信息 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceInfoCheckWithtAccessToken:(NSString *)token
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户已预约&购买保险列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceAppointmentAndPurchasedListWasPurchasedList:(BOOL)isPurchasedList
                                                                                              accessToken:(NSString *)token
                                                                                                 pageNums:(NSNumber *)pageNums
                                                                                                 pageSize:(NSNumber *)pageSize
                                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户已登记的保险车辆 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceAutosListWithAccessToken:(NSString *)token
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户已登记的保险车辆保费详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceAutosInsurancePremiumDetailWithAccessToken:(NSString *)token
                                                                                         autosLicenseNum:(NSString *)autosLicenseNum
                                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 用户保险详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetUserInsuranceAutosInsuranceDetailWithAccessToken:(NSString *)token
                                                                                        premiumID:(NSString *)premiumID
                                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
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
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


#pragma mark /////##########/////GPS购买/////##########/////
/* GPS购买 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostGPSPurchasesAppointmentWithUserID:(NSString *)userID
                                                                           userName:(NSString *)userName
                                                                            gpsType:(NSUInteger)gpsType
                                                                       dataCardType:(NSUInteger)dataCardType
                                                                   recognizanceType:(NSUInteger)recognizanceType
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


#pragma mark /////##########/////优惠劵/////##########/////
/* 维修商优惠券列表 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopCouponAvailableListWithAccessToken:(NSString *)token
                                                                                   maintenanceShopID:(NSString *)maintenanceShopID
                                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 个人领取维修商优惠券 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsPostUserCollectMaintenanceShopCouponWithAccessToken:(NSString *)token
                                                                                           couponID:(NSString *)couponID
                                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 个人中心我的优惠券列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMyCouponCollectedListWithAccessToken:(NSString *)token
                                                                             pageNums:(NSNumber *)pageNums
                                                                             pageSize:(NSNumber *)pageSize
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 使用优惠券选择列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostUserApplyCouponWithAccessToken:(NSString *)token
                                                                        repairID:(NSString *)repairID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////E-代修/////##########/////
/* E代修检测用户是否预约 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairVerifyUserWasMadeAppointmentWithAccessToken:(NSString *)token
                                                                                            theSign:(NSString *)theSign
                                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
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
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* E代修列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairListByStateWithAccessToken:(NSString *)token
                                                                          pageNums:(NSNumber *)pageNums
                                                                          pageSize:(NSNumber *)pageSize
                                                                          listType:(ERepairListType)listType
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* E代修详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairDetailWithAccessToken:(NSString *)token
                                                                    eRepairID:(NSString *)eRepairID
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 取消E-代修服务 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostERepairCancelServiceWithAccessToken:(NSString *)token
                                                                            eRepairID:(NSString *)eRepairID
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* E-代修确认还车 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostERepairConfirmVehicleWasReturnWithAccessToken:(NSString *)token
                                                                                      eRepairID:(NSString *)eRepairID
                                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* E-代修专员详情 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairAssistantDetailWithAccessToken:(NSString *)token
                                                                             eRepairID:(NSString *)eRepairID
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* E-代修提交评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostERepairServiceCommentWithAccessToken:(NSString *)token
                                                                             eRepairID:(NSString *)eRepairID
                                                                            rateNumber:(NSNumber *)rateNumber
                                                                               comment:(NSString *)comment
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* E-代修查看评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetERepairServiceCommentWithAccessToken:(NSString *)token
                                                                            eRepairID:(NSString *)eRepairID
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////地址/////##########/////
/* 地址列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetShippingAddressListWithAccessToken:(NSString *)token
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 删除地址 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeleteShippingAddressWithAccessToken:(NSString *)token
                                                                         addressIDList:(NSArray *)addressIDList
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
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
                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////购物车/////##########/////
/* 购物车列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetCartListWithAccessToken:(NSString *)token
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 添加商品到购物车 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostInsertProductToTheCartWithAccessToken:(NSString *)token
                                                                              productID:(NSString *)productID
                                                                                brandID:(NSString *)brandID
                                                                      brandDealershipID:(NSString *)brandDealershipID
                                                                               seriesID:(NSString *)seriesID
                                                                                modelID:(NSString *)modelID
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 删除购物车的商品 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostDeleteProductFormTheCartWithAccessToken:(NSString *)token
                                                                            productIDList:(NSArray *)productIDList
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////车辆维修/////##########/////
/* 查询维修列表由维修类型 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMaintenanceStatusListByStatusType:(CDZMaintenanceStatusType)statusType
                                                                       accessToken:(NSString *)token
                                                                          pageNums:(NSNumber *)pageNums
                                                                          pageSize:(NSNumber *)pageSize
                                                                   shopNameOrKeyID:(NSString *)shopNameOrKeyID
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 查询维修详情由维修类型 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMaintenanceStatusDetailByStatusType:(CDZMaintenanceStatusType)statusType
                                                                         accessToken:(NSString *)token
                                                                               keyID:(NSString *)keyID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 确认委托维修授权 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostConfirmMaintenanceAuthorizationWithAccessToken:(NSString *)token
                                                                                           keyID:(NSString *)keyID
                                                                               repairItemsString:(NSString *)repairItemsString
                                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 结算信息准备 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetMaintenanceClearingPaymentInfoWithAccessToken:(NSString *)token
                                                                                         keyID:(NSString *)keyID
                                                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 取消维修 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostCancelMaintenanceWithAccessToken:(NSString *)token
                                                                             keyID:(NSString *)keyID
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////其他/////##########/////
/* 询价列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetSelfEnquireProductsPriceWithAccessToken:(NSString *)token
                                                                                pageNums:(NSString *)pageNums
                                                                                pageSize:(NSString *)pageSize
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 积分列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetCreditPointsHistoryWithAccessToken:(NSString *)token
                                                                           pageNums:(NSNumber *)pageNums
                                                                           pageSize:(NSNumber *)pageSize
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 采购中心列表 */
- (AFHTTPRequestOperation *)personalCenterAPIsGetPurchaseCenterListWithCityID:(NSString *)cityID
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark - /////////////////////////////////////////////////////Autos Parts APIs（配件接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////汽车配件选择和配件详情/////##########/////
/* 配件第一级分类 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsFirstLevelListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 配件第二级分类 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsSecondLevelListWithFirstLevelID:(NSString *)firstLevelID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 配件第三级分类 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsThirdLevelListWithSecondLevelID:(NSString *)secondLevelID
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 配件第四级分类 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsLastLevelListWithThirdLevelID:(NSString *)thirdLevelID
                                                                    autoModelID:(NSString *)autoModelID
                                                                    priceOrder:(NSString *)priceOrder
                                                               salesVolumeOrder:(NSString *)salesVolumeOrder
                                                                       pageNums:(NSString *)pageNums
                                                                       pageSize:(NSString *)pageSize
                                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 配件详情 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetPartsDetailWithLastLevelID:(NSString *)lastLevelID
                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 配件评论列表 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetAutosPartsCommnetListWithProductID:(NSString *)shopID
                                                                       pageNums:(NSNumber *)pageNums
                                                                       pageSize:(NSNumber *)pageSize
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 配件推荐列表 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetRecommendProductWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 搜索配件 */
- (AFHTTPRequestOperation *)autosPartsAPIsGetAutosPartsSearchListWithKeyword:(NSString *)keyword
                                                                 autoModelID:(NSString *)autoModelID
                                                                  priceOrder:(NSString *)priceOrder
                                                            salesVolumeOrder:(NSString *)salesVolumeOrder
                                                                    pageNums:(NSNumber *)pageNums
                                                                    pageSize:(NSNumber *)pageSize
                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark - /////////////////////////////////////////////////////Maintenance Shops APIs（维修商接口）/////////////////////////////////////////////////////
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
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 维修商详情 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsDetailWithShopID:(NSString *)shopID
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 维修商属下维修技师 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsTechnicianListWithShopID:(NSString *)shopID
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 维修商属下维修技师详情 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsTechnicianDetailWithTechnicianID:(NSString *)technicianID
                                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 维修商种类 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsTypeListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 维修商评论列表 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsCommnetListWithShopID:(NSString *)shopID
                                                                                pageNums:(NSString *)pageNums
                                                                                pageSize:(NSString *)pageSize
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 维修商公用设施 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetMaintenanceShopsInfrastructureWithShopID:(NSString *)shopID
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 预约维修商保养或者维修选择 */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsPostAppointmentFromMaintenanceShopsWithShopID:(NSString *)shopID
                                                                                 workingPrice:(NSString *)workingPrice
                                                                                  serviceItem:(NSString *)serviceItem
                                                                              isRepairService:(BOOL)isRepairService
                                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
                                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 维修完成评论 */
- (AFHTTPRequestOperation *)personalCenterAPIsPostCommentForShopRepairFinishWithAccessToken:(NSString *)token
                                                                                 makeNumber:(NSString *)makeNumber
                                                                                    content:(NSString *)content
                                                                                     rating:(NSString *)rating
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 获取预约维修资讯  */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetAppointmentPrepareRepairInfoWithShopID:(NSString *)shopID
                                                              repairServiceItemListString:(NSString *)repairServiceItemListString
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 获取预约保养资讯  */
- (AFHTTPRequestOperation *)maintenanceShopsAPIsGetAppointmentPrepareMaintenanceInfoWithShopID:(NSString *)shopID
                                                                maintenanceServiceIDListString:(NSString *)maintenanceServiceIDListString
                                                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark - /////////////////////////////////////////////////////Self-Diagnosis APIs（自助诊断接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////自助诊断结果/////##########/////
/* 故障解决方案 */
- (AFHTTPRequestOperation *)theSelfDiagnosisAPIsGetSolutionPlanWithDiagnosisResultID:(NSString *)diagnosisResultID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 配件更换建议 */
- (AFHTTPRequestOperation *)theSelfDiagnosisAPIsGetProposedReplacementPartsWithSolutionPlanID:(NSString *)solutionPlanID
                                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 获取维修商 */
- (AFHTTPRequestOperation *)theSelfDiagnosisAPIsGetMaintenanceShopsSuggestListWithReplacementPartsName:(NSString *)replacementPartsName
                                                                                              seriesID:(NSString *)seriesID
                                                                                           autoModelID:(NSString *)autoModelID
                                                                                               address:(NSString *)address
                                                                                          isDescenting:(NSNumber *)isDescenting
                                                                                             longitude:(NSString *)longitude
                                                                                              latitude:(NSString *)latitude
                                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


#pragma mark - /////////////////////////////////////////////////////Get History Cases of Success APIs（获取案例接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////获取案例步骤/////##########/////

/* 获取案例第一级分类 */
- (AFHTTPRequestOperation *)casesHistoryAPIsGetHistoryCasesOfStepOneListWithAutosModelID:(NSNumber *)autosModelID
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 获取案例第二级分类 */
- (AFHTTPRequestOperation *)casesHistoryAPIsGetHistoryCasesOfStepTwoListWithStepOneID:(NSString *)stepOneID
                                                                    selectedTextTitle:(NSString *)selectedTextTitle
                                                                       isDescSymptoms:(BOOL)isDescSymptoms
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 获取案例结果 */
- (AFHTTPRequestOperation *)casesHistoryAPIsGetHistoryCasesResultListWithTwoStepIDsList:(NSArray *)twoStepIDsList
                                                                        twoStepTextList:(NSArray *)twoStepTextList
                                                                                address:(NSString *)address
                                                                              priceSort:(NSString *)priceSort
                                                                                brandID:(NSString *)brandID
                                                                      brandDealershipID:(NSString *)brandDealershipID
                                                                               seriesID:(NSString *)seriesID
                                                                                modelID:(NSString *)modelID
                                                                               pageNums:(NSNumber *)pageNums
                                                                               pageSize:(NSNumber *)pageSize
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


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
                                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 案例详情 */
- (AFHTTPRequestOperation *)casesHistoryAPIsGetHistoryCasesOfCaseDetailWithSubscribeID:(NSString *)subscribeID
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


#pragma mark - /////////////////////////////////////////////////////Self-Maintenance APIs（自助保养接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////新自助诊断步骤/////##########/////
/* 新自助诊断1～5步 */

- (AFHTTPRequestOperation *)commonAPIsGetAutoSelfDiagnosisStepListWithStep:(SelfDiagnosisSelectionStep)theStep
                                                            previousStepID:(NSString *)previousStepID
                                                                  seriesID:(NSNumber *)seriesID
                                                                   modelID:(NSNumber *)modelID
                                                                    typeID:(NSNumber *)typeID
                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 新自助诊断结果 */
- (AFHTTPRequestOperation *)selfDiagnoseAPIsGetDiagnoseResultListWithReasonName:(NSString *)reasonName
                                                                        brandId:(NSNumber *)brandId
                                                                       pageNums:(NSNumber *)pageNums
                                                                       pageSize:(NSNumber *)pageSize
                                                                      longitude:(NSNumber *)longitude
                                                                       latitude:(NSNumber *)latitude
                                                                         cityID:(NSNumber *)cityID
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;



#pragma mark /////##########/////自助维修步骤和结果/////##########/////
/* 获取保养信息 */
- (AFHTTPRequestOperation *)theSelfMaintenanceAPIsGetMaintenanceInfoWithAutoModelID:(NSString *)autoModelID
                                                                   autoTotalMileage:(NSString *)autoTotalMileage
                                                                       purchaseDate:(NSString *)purchaseDate
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 选择保养服务 */
- (AFHTTPRequestOperation *)theSelfMaintenanceAPIsGetMaintenanceServiceListWithPartsIDList:(NSArray *)partsIDList
                                                                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 配件详情 */
- (AFHTTPRequestOperation *)theSelfMaintenanceAPIsGetItemDetailWithProductID:(NSString *)productID
                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


#pragma mark - /////////////////////////////////////////////////////Common APIs（公用接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////获取案例和自助诊断公用步骤/////##########/////
/* 故障种类 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoFailureTypeListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 故障现象 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoFaultSymptomListWithAutoFailureTypeID:(NSString *)failureTypeID
                                                                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 故障架构 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoFaultStructureListWithAutoFaultSymptomID:(NSString *)faultSymptomID
                                                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 故障原因分析 */
- (AFHTTPRequestOperation *)commonAPIsGetDiagnosisResultListWithAutoFaultStructureID:(NSString *)faultStructureID
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////汽车型号选择/////##########/////
/* 车辆品牌 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoBrandListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 车辆经销商 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoBrandDealershipListWithBrandID:(NSString *)brandID
                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 车辆系列 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoSeriesListWithBrandDealershipID:(NSString *)brandDealershipID
                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 车辆型号 */
- (AFHTTPRequestOperation *)commonAPIsGetAutoModelListWithAutoSeriesID:(NSString *)seriesID
                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////其他/////##########/////

/* 省份列表 */
- (AFHTTPRequestOperation *)commonAPIsGetProvinceListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 城市列表 */
- (AFHTTPRequestOperation *)commonAPIsGetCityListWithProvinceID:(NSString *)provinceID
                                                      isKeyCity:(BOOL)isKeyCity
                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 区列表 */
- (AFHTTPRequestOperation *)commonAPIsGetDistrictListWithCityID:(NSString *)cityID
                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 维修商类型列表 */
- (AFHTTPRequestOperation *)commonAPIsGetRepairShopTypeListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 维修商保养服务类型列表 */
- (AFHTTPRequestOperation *)commonAPIsGetRepairShopServiceTypeListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 维修商保养服务列表 */
- (AFHTTPRequestOperation *)commonAPIsGetRepairShopServiceListWithShopID:(NSString *)shopID
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 订单状态列表 */
- (AFHTTPRequestOperation *)commonAPIsGetPurchaseOrderStatusListWithSuccessBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
#pragma mark- /////##########/////GPS接口/////##########/////
#pragma mark /////##########/////GPS配置/////##########/////
/* 车辆实时位置信息 */

- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoGPSRealtimeInfoWithAccessToken:(NSString *)token
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 查询GPS上传设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetUploadSettingStatusWithAccessToken:(NSString *)token
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改GPS上传设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostUpdateGPSUploadSettingWithAccessToken:(NSString *)token
                                                                     localinfoStatus:(NSNumber *)localinfoStatus
                                                                        remindStatus:(NSNumber *)remindStatus
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;



#pragma mark /////##########/////OBD&&车辆配置/////##########/////
/* 服务密码验证 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAuthorizeServerSecurityPWWithAccessToken:(NSString *)token
                                                                                 serPwd:(NSString *)serPwd
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 快速设防详情 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetFastPreventionDetailWithAccessToken:(NSString *)token
                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 开启快速设防 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostFastPreventionOfnWithAccessToken:(NSString *)token
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 关闭快速设防 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostFastPreventionOffWithAccessToken:(NSString *)token
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 省电设置详情 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoPowerSaveStatusWithAccessToken:(NSString *)token
                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改省电设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoPowerSaveChangeStatusWithAccessToken:(NSString *)token
                                                                                 status:(BOOL)status
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 设备安装校正 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoDeviceCalibrationWithAccessToken:(NSString *)token
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 点火熄火校准 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoIgnitionSystemCalibrationWithAccessToken:(NSString *)token
                                                                                     status:(BOOL)status
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/* 获取安全设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoAllAlertStatusListWithAccessToken:(NSString *)token
                                                                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改侧翻设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoRoleAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                 status:(BOOL)status
                                                                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改碰撞设置*/
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoImpactAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                   status:(BOOL)status
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改电瓶低电压设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoBatteryLowAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                       status:(BOOL)status
                                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/* 修改拖车设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoTrailingAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                     status:(BOOL)status
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改设备移除（断电）设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoODBRemoveAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                      status:(BOOL)status
                                                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改防盗喇叭设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoSecurityAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                     status:(BOOL)status
                                                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改疲劳驾驶设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoFatigueDrivingAlertStatusUpdateWithAccessToken:(NSString *)token
                                                                                           status:(BOOL)status
                                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/* 获取超速设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoOverSpeedSettingWithAccessToken:(NSString *)token
                                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改超速设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoOverSpeedSettingUpdateWithAccessToken:(NSString *)token
                                                                                    speedStatus:(BOOL)speedStatus
                                                                                          speed:(NSNumber *)speed
                                                                                    voiceStatus:(BOOL)voiceStatus
                                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 获取断油断电设置 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoPowerAndOilControlStatusWithAccessToken:(NSString *)token
                                                                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 修改断油断电设置*/
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoPowerAndOilControlStatusUpdateWithAccessToken:(NSString *)token
                                                                                          status:(BOOL)status
                                                                                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;





/* 查询个人电子围栏 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoElectricFencingDetialWithAccessToken:(NSString *)token
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 增加电子围栏 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoAddElectricFencingWithAccessToken:(NSString *)token
                                                                                type:(NSString *)type
                                                                              radius:(NSString *)radius
                                                                           longitude:(NSString *)longitude
                                                                            latitude:(NSString *)latitude
                                                                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 删除电子围栏 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostAutoRemoveElectricFencingWithAccessToken:(NSString *)token
                                                                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/* OBD主动查询 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoOBDDataWithAccessToken:(NSString *)token
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* OBD故障检测 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetAutoOBDDiagnosisWithAccessToken:(NSString *)token
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;





#pragma mark /////##########/////GPS、汽车记录和数据/////##########/////
/* 行车轨迹 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetDrivingHistoryListWithAccessToken:(NSString *)token
                                                                  startDateTime:(NSString *)startDateTime
                                                                    endDateTime:(NSString *)endDateTime
                                                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 清除行车历史轨迹 */
- (AFHTTPRequestOperation *)personalGPSAPIsPostEraseDrivingHistoryWithAccessToken:(NSString *)token
                                                                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark /////##########/////其他/////##########/////
/* 消息列表 */
- (AFHTTPRequestOperation *)personalGPSAPIsGetMessageAlertListWithAccessToken:(NSString *)token
                                                                     pageNums:(NSNumber *)pageNums
                                                                     pageSize:(NSNumber *)pageSize
                                                                    plateName:(NSString *)plateName
                                                                     typeName:(NSString *)typeName
                                                              isMessWasReaded:(BOOL)isMessWasReaded
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/* 推送消息设置 */
- (AFHTTPRequestOperation *)personalCenterAPNSSettingAlertListWithAccessToken:(NSString *)token
                                                                    messageON:(BOOL)messageON
                                                                    channelID:(NSString *)channelID
                                                                  deviceToken:(NSString *)deviceToken
                                                                   apnsUserID:(NSString *)apnsUserID
                                                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
