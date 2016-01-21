//
//  PaymentASV.m
//  cdzer
//
//  Created by KEns0n on 9/19/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "PaymentASV.h"
#import "OrderForm.h"
#import <AlipaySDK/AlipaySDK.h>
@implementation PaymentASV

+ (void)showPaymentViewWithPayAfterDelivery:(BOOL)isShowOption paymentData:(NSDictionary *)paymentData withResultBlock:(PaymentASVResultBlock)resultBlock {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择支付方式"
                                                             delegate:nil
                                                    cancelButtonTitle:getLocalizationString(@"cancel")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    [actionSheet addButtonWithTitle:@"支付宝"];
    if (isShowOption) {
        [actionSheet addButtonWithTitle:@"货到付款"];
    }
    @weakify(self)
    [actionSheet.rac_buttonClickedSignal subscribeNext:^(NSNumber *btnIdx) {
        @strongify(self)
        if (btnIdx.integerValue<(isShowOption?2:1)) {
        }
        NSString *orderID = [paymentData[@"order"] objectForKey:@"main_id"];
        if (!orderID) {
            orderID = [paymentData[@"order_details"] objectForKey:@"main_order_id"];
        }
        if (btnIdx.integerValue==2) {
            [self getPayAfterDeliveryAndOrderID:orderID withResultBlock:resultBlock];
        }
        if (btnIdx.integerValue==1) {
            [self getAliPayInitialDataAndOrderID:orderID withResultBlock:resultBlock];
        }
        if (btnIdx.integerValue==0) {
            resultBlock(@"取消支付", 3);
        }
    }];
    [actionSheet showInView:UIApplication.sharedApplication.keyWindow];
}

+ (void)getPayAfterDeliveryAndOrderID:(NSString *)orderID withResultBlock:(PaymentASVResultBlock)resultBlock {
    if (!UserBehaviorHandler.shareInstance.getUserToken||!orderID||[orderID isEqualToString:@""]) {
        resultBlock(@"提交失败，请稍后再试！", 3);
        return;
    }
    [ProgressHUDHandler showHUDWithTitle:@"提交中" onView:nil];
    [[APIsConnection shareConnection] personalCenterAPIsPaymentMethodByPayAfterDeliveryWithAccessToken:UserBehaviorHandler.shareInstance.getUserToken isPayAfterDelivery:YES orderMainID:orderID costType:nil costTypeName:nil payType:nil payTypeName:nil state:nil stateName:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            if (resultBlock) {
                resultBlock(message, errorCode);
            }
            return ;
        }
        
        [ProgressHUDHandler dismissHUD];
        if (resultBlock) {
            resultBlock(message, errorCode);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"提交失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
            if (resultBlock) {
                resultBlock(@"提交失败，请稍后再试！", error.code);
            }
        }];
        
    }];
}

+ (void)handlePaymentData:(NSDictionary *)dataDetail withResultBlock:(PaymentASVResultBlock)resultBlock{
    
    if (!dataDetail||dataDetail.count==0) {
        [ProgressHUDHandler showErrorWithStatus:@"遗失交易信息！" onView:nil completion:nil];
        resultBlock(@"遗失交易信息！", 3);
        return;
    }
    
    //    "service": "mobile.securitypay.pay",
    //    "partner": "2088611477689575",
    //    "_input_charset": "UTF-8",
    //    "notify_url": "www.cdzer.com",
    //    "out_trade_no": "DT150415113913357563",
    //    "subject": "超级发动机",
    //    "payment_type": "1",
    //    "body": "真的是一个非常不错的发动机",
    //    "seller_id": "2088611477689575",
    //    "it_b_pay": "1m",
    //    "total_fee": "665.0",
    //    "sign": "",
    //    "sign_type": "RSA"
    
    OrderForm *order = [[OrderForm alloc] init];
    order.partner = [SupportingClass verifyAndConvertDataToString:dataDetail[@"partner"]];
    order.seller = [SupportingClass verifyAndConvertDataToString:dataDetail[@"seller_email"]];
    order.tradeNO = [SupportingClass verifyAndConvertDataToString:dataDetail[@"out_trade_no"]]; //订单ID（由商家自行制定）
    order.productName = [SupportingClass verifyAndConvertDataToString:dataDetail[@"subject"]]; //商品标题
    order.productDescription = [SupportingClass verifyAndConvertDataToString:dataDetail[@"body"]]; //商品描述
    NSString *amount = [SupportingClass verifyAndConvertDataToString:dataDetail[@"total_fee"]];
    order.amount = [NSString stringWithFormat:@"%.2f",amount.floatValue]; //商品价格
    order.notifyURL = [SupportingClass verifyAndConvertDataToString:dataDetail[@"notify_url"]]; //回调URL
    
    order.service = [SupportingClass verifyAndConvertDataToString:dataDetail[@"service"]];
    order.paymentType = [SupportingClass verifyAndConvertDataToString:dataDetail[@"payment_type"]];
    order.inputCharset = [SupportingClass verifyAndConvertDataToString:dataDetail[@"_input_charset"]];
    order.itBPay = [SupportingClass verifyAndConvertDataToString:dataDetail[@"it_b_pay"]];;
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在Info.plist定义URL types
    NSString *appScheme = @"cdzerpersonal";
    
    NSString *orderBodyString = order.description;
    NSString *sign_type = [SupportingClass verifyAndConvertDataToString:dataDetail[@"sign_type"]];
    NSString *signedString = [SupportingClass verifyAndConvertDataToString:dataDetail[@"sign"]];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString) {
        [ProgressHUDHandler dismissHUD];
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderBodyString, signedString, sign_type];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@",resultDic);
            [SupportingClass showAlertViewWithTitle:@"error"
                                            message:[resultDic[@"memo"] stringByAppendingFormat:@"\n错误代码:%d",[resultDic[@"resultStatus"] integerValue]]
                                    isShowImmediate:YES
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil
                      clickedButtonAtIndexWithBlock:nil];
        }];
    }else {
        [ProgressHUDHandler showErrorWithStatus:@"遗失交易信息！" onView:nil completion:nil];
        resultBlock(@"遗失交易信息！", 3);
    }
}

+ (void)getAliPayInitialDataAndOrderID:(NSString *)orderID withResultBlock:(PaymentASVResultBlock)resultBlock {
    if (!UserBehaviorHandler.shareInstance.getUserToken||!orderID||[orderID isEqualToString:@""]) return;
    [ProgressHUDHandler showHUDWithTitle:@"支付初始中" onView:nil];
    [[APIsConnection shareConnection] personalCenterAPIsPaymentMethodByAlipayWithAccessToken:UserBehaviorHandler.shareInstance.getUserToken orderMainID:orderID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                resultBlock(message, errorCode);
            }];
            return ;
        }
        
        [self handlePaymentData:responseObject[CDZKeyOfResultKey] withResultBlock:resultBlock];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"支付初始化失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            resultBlock(@"支付初始化失败", 3);
        }];
        
    }];
}

+ (void)updatePaymentStatusAndPaymentData:(NSDictionary *)paymentData withResultBlock:(PaymentASVResultBlock)resultBlock {
    NSString *orderID = paymentData[@"main_id"];
    NSString *costType = paymentData[@"cost_type"];
    NSString *costTypeName = paymentData[@"cost_type_name"];
    NSString *payType = paymentData[@"paytype"];
    NSString *payTypeName = paymentData[@"paytype_name"];
    NSString *state = paymentData[@"state"];
    NSString *stateName = paymentData[@"state_name"];
    [self updatePaymentStatusWithPayAfterDelivery:NO orderMainID:orderID costType:costType costTypeName:costTypeName payType:payType payTypeName:payTypeName state:state stateName:stateName withResultBlock:resultBlock];
}

+ (void)updatePaymentStatusWithPayAfterDelivery:(BOOL)isPayAfterDelivery orderMainID:(NSString *)orderMainID costType:(NSString *)costType costTypeName:(NSString *)costTypeName
                                        payType:(NSString *)payType payTypeName:(NSString *)payTypeName state:(NSString *)state stateName:(NSString *)stateName withResultBlock:(PaymentASVResultBlock)resultBlock {
    
    [ProgressHUDHandler showHUDWithTitle:@"提交中" onView:nil];
    [[APIsConnection shareConnection] personalCenterAPIsPaymentMethodByPayAfterDeliveryWithAccessToken:UserBehaviorHandler.shareInstance.getUserToken isPayAfterDelivery:isPayAfterDelivery orderMainID:orderMainID costType:costType costTypeName:costTypeName payType:payType payTypeName:payTypeName state:state stateName:stateName success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
//        if (errorCode!=0) {
//            [ProgressHUDHandler dismissHUD];
//            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
//                if (resultBlock) {
//                    resultBlock(message, errorCode);
//                }
//            }];
//            return ;
//        }
        
        [ProgressHUDHandler dismissHUD];
        
        if (resultBlock) {
            resultBlock(message, errorCode);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"提交失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            if (resultBlock) {
                resultBlock(@"提交失败，请稍后再试！", error.code);
            }
        }];
        
    }];
    
}

@end
