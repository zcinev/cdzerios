//
//  APIsDefine.h
//  cdzer
//
//  Created by KEns0n on 2/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, CDZMaintenanceStatusType) {
    CDZMaintenanceStatusTypeOfAppointment = 0,
    CDZMaintenanceStatusTypeOfDiagnosis = 1,
    CDZMaintenanceStatusTypeOfUserAuthorized = 2,
    CDZMaintenanceStatusTypeOfHasBeenClearing = 3,
};


static NSString *const CDZKeyOfErrorCodeKey = @"msg_code";
static NSString *const CDZKeyOfMessageKey = @"reason";
static NSString *const CDZKeyOfResultKey = @"result";
static NSString *const CDZKeyOfPageNumKey = @"page_no";
static NSString *const CDZKeyOfPageSizeKey = @"page_size";
static NSString *const CDZKeyOfTotalPageSizeKey = @"total_size";











#pragma mark- /////////////////////////////////////////////////////APIs Base Define（接口配置）/////////////////////////////////////////////////////
#define kCDZSubPathTypeOfConnect @"connect"
#define kCDZSubPathTypeOfIntercept @"intercept"
#define kCDZSubPathTypeOfPeiConnect @"peiConnect"
#define kCDZSubPathTypeOfPersonalConnect @"personalConnect"
#define kCDZSubPathTypeOfGPS @"gps"
#define kCDZSubPathTypeOfImageUpload @"imgUpload"
#define kCDZSubPathAppendingPathComponent(basePath,appendingPath) [basePath stringByAppendingPathComponent:appendingPath]


#pragma mark- /////////////////////////////////////////////////////Personal Center APIs（个人中心接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////用户/////##########/////
/* 个人基本资料 */
#define kCDZPersonalInfoDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"basicInformation")                         //个人基本资料
/* 用户注册 */
#define kCDZPersonalRegister kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"appRegister")                                        //用户注册
/* 用户注册验证码 */
#define kCDZPersonalRegisterValidCode kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"appRegisterUser")                           //用户注册
/* 用户忘记密码 */
#define kCDZPersonalForgotPassword kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"appPassword")                                  //用户注册
/* 用户忘记密码验证码 */
#define kCDZPersonalForgotPasswordValidCode kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"appPasswordUser")                           //用户注册

/* 用户登录 */
#define kCDZPersonalLogin kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"login")                                                 //用户登录
/* 验证Token期限 */
#define kCDZPersonalTokenValid kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"appUserTokencheck")                                //验证Token期限
/* 用户修改密码 */
#define kCDZPersonalChangePW kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"updatePassWord")                           //用户修改密码
/* 用户基本资料修改 */
#define kCDZPersonalInfoUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"updateBasicInformation")                 //用户更新个人资料
/* 用户个人头像修改 */
#define kCDZPersonalImageUpload kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfImageUpload, @"imgUpload")                                 //用户个人头像修改

/* 用户积分验证码 */
#define kCDZPersonalCreditValidCode kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"appcheckCredtis")                             //用户积分验证码

#pragma mark /////##########/////车辆管理/////##########/////
/* 车辆列表 */
#define kCDZMyAutoList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfIntercept, @"carList")                                              //车辆列表
/* 车辆修改 */
#define kCDZMyAutoUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfIntercept, @"confrimUpdateCardet")                                //车辆修改


#pragma mark /////##########/////收藏/////##########/////
/* 收藏的商品列表 */
#define kCDZProductsCollectionList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"myColGoods")                               //收藏的商品列表
/* 收藏的店铺列表 */
#define kCDZShopsCollectionList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"myColStore")                                  //收藏的店铺列表
/* 添加收藏的商品 */
#define kCDZProductsCollectionAdd kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appColGoods")                               //添加收藏的商品
/* 添加收藏的店铺 */
#define kCDZShopsCollectionAdd kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"colStore")                                     //添加收藏的店铺
/* 删除收藏的商品 */
#define kCDZProductsCollectionDelete kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"delMyColGoods")                          //删除收藏的商品
/* 删除收藏的店铺 */
#define kCDZShopsCollectionDelete kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"delShop")                                   //删除收藏的店铺
/* 检测商品是否已收藏 */
#define kCDZProductWasCollected kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPeiConnect, @"peiShopCollect")                                  //检测商品是否已收藏
/* 检测店铺是否已收藏 */
#define kCDZShopsWasCollected kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"colStoreCollect")                               //检测店铺是否已收藏


#pragma mark /////##########/////订单/////##########/////
/* 订单列表 */
#define kCDZPurchaseOrderList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appTradeListNo")                                //订单列表
/* 订单详情 */
#define kCDZPurchaseOrderDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"orderDetail")                                 //订单详情
/* 提交订单 */
#define kCDZPurchasesOrderDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"consignee")                                  //提交订单
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* 订单确认 */
#define kCDZPurchasesOrderConfirm kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"confirmOrder")                              //订单确认和付款
/* 订单付款方法－货到付款/状态更变 */
#define kCDZPaymentMethodByCashOnDelivery kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"finished")                          //订单付款方法－货到付款/状态更变
/* 订单付款方法－银联 */
#define kCDZPaymentMethodByUnionPay kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"wayofPay")                                //订单确认和付款
/* 订单付款方法－支付宝 */
#define kCDZPaymentMethodByAlipay kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"appAlipay?")                                //订单确认和付款
/* 更新支付状态 */
#define kCDZPaymentStatusUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appAccountRepair")
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/* 订单完成发表评论 */
#define kCDZPurchaseOrderComment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"subComment")                                 //订单完成发表评论
/* 订单完成查看评论 */
#define kCDZPurchaseOrderCommentView kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appQueryComment")                    //订单完成查看评论
/* 取消订单 */
#define kCDZPurchaseOrderCancel kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appDelOrder")                          //取消订单
/* 订单删除 */
#define kCDZPurchaseOrderDelete kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appDeleteOrder")                        //订单删除
/* 确定收货 */
#define kCDZPurchaseOrderGoodsArrivedConfirm kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"confirmReceipt")                  //确定收货
/* 用户申请退货 */
#define kCDZPurchaseOrderReturnOfGoods kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"orderRetFm")                           //用户申请退货
/* 确定退货完成 */
#define kCDZPurchaseOrderGoodsReturnConfirm kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appConfirmReturn")                  //确定退货完成

#pragma mark /////##########/////保险/////##########/////
/* 检测用户保险信息 */
#define kCDZUserInsuranceInfoCheck kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"myInurancelist")                   //检测用户保险信息
/* 用户已预约保险列表 */
#define kCDZUserInsuranceAppointmentList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"AppShowInsuranceApp")        //用户已预约保险列表
/* 用户已购买保险列表 */
#define kCDZUserInsurancePurchasedList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appShowInsuranceInfo")         //用户已购买保险列表
/* 用户已登记的保险车辆 */
#define kCDZUserInsuranceAutosList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appUpdateCar")                     //用户已登记的保险车辆
/* 用户已登记的保险车辆保费详情 */
#define kCDZUserInsuranceAutosPremiumDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appPremiumDetail")        //用户已登记的保险车辆保费详情
/* 用户保险详情 */
#define kCDZUserInsuranceDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appInsuranceAppBuyList")              //用户保险详情
/* 添加保险车辆信息 */
#define kCDZUserAutosInsuranceInfo kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appPremiumAddCar")                 //添加保险车辆信息
/* 提交保险信息 */
#define kCDZUserAutosInsuranceAppointment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appAddPremiumList")         //提交保险信息

#pragma mark /////##########/////GPS购买/////##########/////
/* GPS购买 */
#define kCDZGPSPurchasesAppointment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"carnumber")                               //GPS购买

#pragma mark /////##########/////优惠劵/////##########/////
/* 维修商优惠券列表 */
#define kCDZRepairShopCouponAvailableList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"shopPreferList")                    //维修商优惠券列表
/* 个人领取维修商优惠券 */
#define kCDZRepairShopUserCollectCoupon kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"getShopPreference")                   //个人领取维修商优惠券
/* 个人中心我的优惠券列表 */
#define kCDZMyCouponUserCollectedCouponList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"preferList")                    //个人中心我的优惠券列表
/* 使用优惠券选择列表 */
#define kCDZMyCouponAppleySelection kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"userPreference")                    //使用优惠券选择列表

#pragma mark /////##########/////E-代修/////##########/////
/* E代修检测用户是否预约 */
#define kCDZERepairVerifyUserWasMadeAppointment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"showErepairYesNo")        //E代修检测用户是否预约
/* 提交预约E代修服务 */
#define kCDZERepairMakeAppointment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appAddERepair")                        //提交预约E代修服务
/* E代修列表 */
#define kCDZERepairList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"ShowErepairListone")                              //E代修列表
/* E代修详情 */
#define kCDZERepairDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"erepairAppoint")                                //E代修详情
/* 取消E-代修服务 */
#define kCDZERepairServiceCancel kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appCancelERepair")                       //取消E-代修服务
/* E-代修确认还车 */
#define kCDZERepairConfirmVehicleReturn kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"ensureGetCar")                    //E-代修确认还车
/* E-代修专员详情 */
#define kCDZERepairAssistantDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"commissionerBasic")                    //E-代修专员详情
/* E-代修提交评论 */
#define kCDZERepairSubmitComment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"subErepairComment")                      //E-代修提交评论
/* E-代修查看评论 */
#define kCDZERepairReviewComment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"showErepairComment")                     //E-代修查看评论



#pragma mark /////##########/////地址/////##########/////
/* 地址列表 */
#define kCDZShippingAddressList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfIntercept, @"addressList")                                 //地址列表
/* 添加地址 */
#define kCDZShippingAddressAdd kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfIntercept, @"addConsigneeList")                             //添加地址
/* 删除地址 */
#define kCDZShippingAddressDelete kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfIntercept, @"delConsigneeAll")                           //删除地址
/* 更新地址 */
#define kCDZShippingAddressUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfIntercept, @"updateConsigneeTest")                       //更新地址


#pragma mark /////##########/////购物车/////##########/////
/* 购物车列表 */
#define kCDZCartOfCartList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"showCart")                                         //购物车列表
/* 添加商品到购物车 */
#define kCDZCartOfAddCart kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"addCart")                                           //加入购物车
/* 删除购物车的商品 */
#define kCDZCartOfDeleteCart kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"delCart")                                        //删除购物车


#pragma mark /////##########/////车辆维修/////##########/////
////////////////////* 查询维修列表由维修类型 *////////////////////
#define kCDZAutosRepairStatusOfAppointment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appointList")                       //已预约
#define kCDZAutosRepairStatusOfDiagnosis kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appRepairList")                       //已诊断
#define kCDZAutosRepairStatusOfUserAuthorized kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appRepairEntrust")               //已授权
#define kCDZAutosRepairStatusOfHasBeenClearing kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appRepairAccounts")             //以结算

#define kCDZAutosRepairStatusOfAppointmentDetial kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appAuditAppointment")         //已预约详情
#define kCDZAutosRepairStatusOfDiagnosisDetial kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appDiagnoseDetailOne")          //已诊断详情
#define kCDZAutosRepairStatusOfUserAuthorizedDetial kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"showEntrustSheetTwo")               //已授权详情
#define kCDZAutosRepairStatusOfHasBeenClearingDetial kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"showBalanceSheet1Three")             //以结算详情

////////////////////* 查询维修详情由维修类型 *////////////////////
/* 确认委托维修授权 */
#define kCDZAutosRepairConfirm kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appAgreeRepair")                                //确认委托维修授权
/* 结算信息准备 */
#define kCDZAutosRepairClearingReady kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appPayRepair")                          //结算信息准备
/* 取消维修 */
#define kCDZAutosRepairCancelMaintenance kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appCancleRepair")                     //取消维修


#pragma mark /////##########/////其他/////##########/////
/* 询价 */
#define kCDZSelfEnquireProductsPrice kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"appAskPrice")                            //询价
/* 积分列表 */
#define kCDZCreditPointsHistory kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"creditsList")                                 //积分列表
/* 采购中心列表 */
#define kCDZPurchaseCenterList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"centerNameList")                               //采购中心列表



#pragma mark- /////////////////////////////////////////////////////Autos Parts APIs（配件接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////汽车配件选择和配件详情/////##########/////
/* 配件第一级分类 */
#define kCDZAutosPartsSearchStepOne kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPeiConnect, @"autopartType")                              //配件第一级分类
/* 配件第二级分类 */
#define kCDZAutosPartsSearchStepTwo kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPeiConnect, @"autopartList")                              //配件第二级分类
/* 配件第三级分类 */
#define kCDZAutosPartsSearchStepThree kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPeiConnect, @"autopartInfo")                            //配件第三级分类
/* 配件第四级分类 */
#define kCDZAutosPartsSearchStepFour kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPeiConnect, @"userProduct")                              //配件第四级分类
/* 配件详情 */
#define kCDZAutosPartsDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPeiConnect, @"peiDetail")                                        //配件详情
/* 配件询价 */
#define kCDZAutosPartsEnquirePrice kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"askPrice")                                   //配件询价
/* 配件推荐列表 */
#define kCDZAutosPartsRecommendProduct kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPeiConnect, @"recommendProduct")
/* 配件评论列表 */
#define kCDZAutosPartsComment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"detailcomment")                                      //配件用户评论
/* 搜索配件 */
#define kCDZAutosPartsKeywordSearch kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPeiConnect, @"appSearchProduct")                                //搜索配件

#pragma mark- /////////////////////////////////////////////////////Maintenance Shops APIs（维修商接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////查询维修商、维修商详情和附属接口/////##########/////
/* 查询维修商 */
#define kCDZMaintenanceShopSearch kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"searchStore")                               //查找维修商
/* 维修商详情 */
#define kCDZMaintenanceShopDetails kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"shopDetails")                              //维修商详情
/* 维修商属下维修技师 */
#define kCDZMaintenanceShopTechnicianList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"technicianList")                    //技师中心
/* 维修商属下维修技师详情 */
#define kCDZMaintenanceShopTechnicianDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"technicianDetails")               //技师详情
/* 维修商种类 */
#define kCDZMaintenanceShopType kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"wxsType")                                     //维修商类型
/* 维修商评论列表 */
#define kCDZMaintenanceShopComment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"userComment")                              //维修商用户评论
/* 维修商公用设施 */
#define kCDZMaintenanceShopEquipment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"shopEquipment")                          //维修商公用设备
/* 预约维修商保养或者维修选择 */
#define kCDZMaintenanceShopAppointmentDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"appointment")                    //预约保养或者维修
/* 确认和提交预约信息 */
#define kCDZMaintenanceShopConfirmAppointment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"confirmAppoint")                //确认和提交预约信息
/* 维修完成评论 */
#define kCDZMaintenanceShopRepairFinishComment kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"subCommentShop")                    //维修完成评论
/* 获取预约维修资讯 */
#define kCDZMaintenanceShopAppointmentRepairInfoPrepare kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"repairInfo")                    //获取预约维修资讯 
/* 获取预约保养资讯  */
#define kCDZMaintenanceShopAppointmentMaintenanceInfoPrepare kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"maintainStoreMessageUpkeep")                    //获取预约保养资讯



#pragma mark- /////////////////////////////////////////////////////Self-Diagnosis APIs（自助诊断接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////自助诊断结果/////##########/////
/* 故障解决方案 */
#define kCDZSelfDiagnosisSolutionPlan kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"faultScheme")                           //解决方案
/* 配件更换建议 */
#define kCDZSelfDiagnosisReplacementParts kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"faultParts")                        //更换配件
/* 获取维修商 */
#define kCDZSelfDiagnosisResult kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"faultResult")                                 //诊断结果


#pragma mark- /////////////////////////////////////////////////////Self-Maintenance APIs（自助保养接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////自助维修步骤和结果/////##########/////
/* 获取保养信息 */
#define kCDZSelfMaintenanceGetInfo kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"getMaintain")                              //保养信息
/* 选择保养服务 */
#define kCDZSelfMaintenanceServiceList  kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"chooseMaintain")                      //保养服务
/* 配件详情 */
#define kCDZSelfMaintenancePartsDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"detail")                               //配件详情



#pragma mark- /////////////////////////////////////////////////////Get History Cases of Success APIs（获取案例接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////获取案例步骤/////##########/////
/* 获取案例第一级分类 */
#define kCDZCasesHistoryListStepOne kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"caseSecond")                                 //获取案例第一级分类
/* 获取案例第二级分类 */
#define kCDZCasesHistoryListStepTwo kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"caseThird")                                 //获取案例第二级分类
/* 获取案例结果 */
#define kCDZCasesHistoryResultList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"caseSixth")                                 //获取案例结果

/* 获取案例 */
#define kCDZCasesHistoryOfCaseList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"gainCase")                                 //获取案例
/* 案例详情 */
#define kCDZCasesHistoryOfCaseDetail  kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"displayCase")                        //案例详情



#pragma mark- /////////////////////////////////////////////////////Common APIs（公用接口）/////////////////////////////////////////////////////
#pragma mark /////##########/////新自助诊断步骤/////##########/////
/* 新自助诊断第一步 */
#define kCDZSelfDiagnoseFirstStepList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"diagnoseSecond")                                       //新自助诊断第一步
/* 新自助诊断第二步 */
#define kCDZSelfDiagnoseSecondStepList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"diagnoseThird")                                       //新自助诊断第二步
/* 新自助诊断第三步 */
#define kCDZSelfDiagnoseThirdStepList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"diagnoseFourth")                                       //新自助诊断第三步
/* 新自助诊断第四步 */
#define kCDZSelfDiagnoseFourthStepList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"diagnoseFifth")                                       //新自助诊断第四步
/* 新自助诊断第五步 */
#define kCDZSelfDiagnoseFifthStepList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"diagnoseSixth")                                       //新自助诊断第五步
/* 新自助诊断结果 */
#define kCDZSelfDiagnoseFinalResultList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"searchQuote")                                       //新自助诊断结果



#pragma mark /////##########/////获取案例和自助诊断公用步骤/////##########/////
/* 故障种类 */
#define kCDZAutosFailureType kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"faultKind")                                       //故障种类
/* 故障现象 */
#define kCDZAutosFaultSymptom kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"faultPhenomenon")                                //故障现象
/* 故障架构 */
#define kCDZAutosFaultStructure kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"faultConstruction")                            //故障结构
/* 故障原因分析 */
#define kCDZAutosFaultDiagnosis kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"faultReason")                                  //故障原因


#pragma mark /////##########/////汽车型号选择/////##########/////
/* 车辆品牌 */
#define kCDZAutoBrandList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"brandList")                                         //车辆品牌
/* 车辆经销商 */
#define kCDZAutosFactoryName kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"factoryName")                                     //汽车厂商
/* 车辆系列 */
#define kCDZAutosFctList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"fctList")                                             //车辆系列
/* 车辆品牌 */
#define kCDZAutoSpecList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"specList")                                           //车型


#pragma mark /////##########/////其他/////##########/////
/* 省份列表 */
#define kCDZProvinceList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"provinceList")                                       //获取所有省份
/* 城市列表 */
#define kCDZCityListWithProvince kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"cityList")                                   //获取所有重点城市／部分城市由省份筛选
/* 区列表 */
#define kCDZDistrictListWithCity kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"areaList")                                   //获取地区由城市筛选
/* 维修商类型列表 */
#define kCDZRepairShopType kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"wxsType")                                          //获取维修商类型列表
/* 维修商保养服务类型列表 */
#define kCDZRepairShopServiceType kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"serviceItemName")                           //获取维修商保养服务类型列表
/* 维修商保养服务列表 */
#define kCDZRepairShopServiceList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"maintainItemList")                           //获取维修商保养服务列表
/* 订单状态列表 */
#define kCDZPurchaseOrderStatusList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfConnect, @"orderStateName")                           //订单状态列表 


#pragma mark- /////##########/////GPS/////##########/////
#pragma mark /////##########/////GPS配置/////##########/////
/* 车辆实时位置信息 */
#define kCDZGPSAutoRealtimeInfo kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"refreshCar")                                        //车辆实时位置信息

/* 查询GPS上传设置 */
#define kCDZGPSUploadSettingStauts kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"getPersonalSetting")                             //查询个人设置
/* 修改GPS上传设置 */
#define kCDZGPSUpdateUploadSetting kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"updateCustLocainfo")                             //修改个人设置


#pragma mark /////##########/////OBD&&车辆配置/////##########/////
/* 服务密码验证 */
#define kCDZGPSAuthorizeServerSecurityPW kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"verSerPwd")                                //服务密码验证

/* 快速设防详情 */
#define kCDZGPSFastPreventionDetail kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"defenceDetail")                                 //快速设防详情
/* 开启快速设防 */
#define kCDZGPSFastPreventionOn kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"defenceAdd")                                        //开启快速设防
/* 关闭快速设防 */
#define kCDZGPSFastPreventionOff kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"defencedelete")                                    //关闭快速设防

/* 省电设置详情 */
#define kCDZGPSAutoPowerSaveStatus kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"getCarLocationState")                            //省电设置详情
/* 修改省电设置 */
#define kCDZGPSAutoPowerSaveChangeStatus kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"setCarLocationState")                      //修改省电设置

/* 设备安装校正 */
#define kCDZGPSAutoDeviceCalibrate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"setDeviceInstall")                               //设备安装校正
/* 点火熄火校准 */
#define kCDZGPSAutoIgnitionSystemCalibrate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"setCarAcc")                              //点火熄火校准

/* 获取安全设置 */
#define kCDZGPSAutoAllAlertStatusList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"getSafetySet")                                //获取安全设置
/* 修改侧翻设置 */
#define kCDZGPSAutoRoleAlertStatusUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"cfSet")                                    //修改侧翻设置
/* 修改碰撞设置*/
#define kCDZGPSAutoImpactAlertStatusUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"pzSet")                                  //修改碰撞设置
/* 修改电瓶低电压设置 */
#define kCDZGPSAutoBatteryLowAlertStatusUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"dpddySet")                           //修改电瓶低电压设置
/* 修改拖车设置 */
#define kCDZGPSAutoTrailingAlertStatusUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"tcSet")                                //修改拖车设置
/* 修改设备移除（断电）设置 */
#define kCDZGPSAutoODBRemoveAlertStatusUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"ddSet")                               //修改设备移除(断电)设置
/* 修改防盗喇叭设置 */
#define kCDZGPSAutoSecurityAlertStatusUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"fdlbSet")                              //修改防盗喇叭设置
/* 修改疲劳驾驶设置 */
#define kCDZGPSAutoFatigueDrivingAlertStatusUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"pljsSet")                        //修改疲劳驾驶设置

/* 获取超速设置 */
#define kCDZGPSAutoOverSpeedSetting kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"getOverSpeedSet")                               //获取超速设置
/* 修改超速设置 */
#define kCDZGPSAutoOverSpeedSettingUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"subOverSpeedSet")                         //修改超速设置

/* 获取断油断电设置 */
#define kCDZGPSAutoPowerAndOilControlStatus kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"getDydd")                               //获取断油断电设置
/* 修改断油断电设置*/
#define kCDZGPSAutoPowerAndOilControlStatusUpdate kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"setDydd")                         //设置断油断电


/* 查询个人电子围栏 */
#define kCDZGPSAutoElectricFencingDetial kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"getGeofenceSet")                           //查询个人电子围栏
/* 增加电子围栏 */
#define kCDZGPSAutoAddElectricFencing kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"setGeofence")                                 //增加电子围栏
/* 删除电子围栏 */
#define kCDZGPSAutoRemoveElectricFencing kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"delGeofence")                               //删除电子围栏


/* OBD主动查询 */
#define kCDZGPSAutoOBDData kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"obdCheck")                                               //OBD主动查询
/* OBD故障检测 */
#define kCDZGPSAutoOBDDiagnosis kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"checkFault")                                        //OBD故障检测


#pragma mark /////##########/////GPS、汽车记录和数据/////##########/////
/* 行车轨迹 */
#define kCDZGPSAutoDrivingHistoryList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"appQueryPoint")                               //行车轨迹
/* 清除行车历史轨迹 */
#define kCDZGPSEraseDrivingHistory kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"delCustHistory")                                 //清除行车历史轨迹


#pragma mark /////##########/////其他/////##########/////
/* 消息列表 */
#define kCDZGPSMessageAlertList kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfGPS, @"appUserCarMessageList")                                  //消息列表
/* 推送消息设置 */
#define kCDZAPNSPushSetting kCDZSubPathAppendingPathComponent(kCDZSubPathTypeOfPersonalConnect, @"yesOrNointernalMessages")









