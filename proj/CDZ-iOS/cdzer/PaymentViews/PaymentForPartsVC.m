//
//  PaymentForPartsVC.m
//  cdzer
//
//  Created by KEns0n on 6/10/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "PaymentForPartsVC.h"
#import "InsetsLabel.h"
#import "ProductDetailView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderForm.h"
#import "MyOrderConfig.h"
#import "MyOrderVC.h"

@interface PaymentForPartsVC ()

@property (nonatomic, strong) NSDictionary *orderDetail;

@property (nonatomic, strong) ProductDetailView *productInfoView;

@property (nonatomic, strong) UIButton *payAtArrivedBtn;

@property (nonatomic, strong) UIButton *aliPayBtn;

@property (nonatomic, strong) UIButton *unionPayBtn;

@property (nonatomic, strong) UIView *paySuccessView;

@end

@implementation PaymentForPartsVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"order_payment")];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializationUI {
    @autoreleasepool {
        CGFloat viewOffset = CGRectGetWidth(self.contentView.frame)*0.05f;
        [self setProductInfoView:[[ProductDetailView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), 220.0f)]];
        [_productInfoView initializationUIWithDetailInfo:_orderDetail[kOrderDetailKey] andOrderStatus:MyOrderStatusOfOrderUnknowState isAutoResize:NO];
        [self.contentView addSubview:_productInfoView];
        
        
        CGFloat buttonOffset = CGRectGetWidth(self.contentView.frame)*0.1f;
        CGFloat buttonWidth = CGRectGetWidth(self.contentView.frame)-buttonOffset*2.0f;
        CGFloat buttonHeight = 40.0f;
        
        self.payAtArrivedBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _payAtArrivedBtn.frame = CGRectMake(buttonOffset, viewOffset+CGRectGetMaxY(_productInfoView.frame),
                                            buttonWidth, buttonHeight);
        _payAtArrivedBtn.backgroundColor = CDZColorOfDefaultColor;
        [_payAtArrivedBtn setTitle:getLocalizationString(@"payment_method_payAtarrived") forState:UIControlStateNormal];
        [_payAtArrivedBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_payAtArrivedBtn setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [_payAtArrivedBtn addTarget:self action:@selector(getPayAfterArrived) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_payAtArrivedBtn];
        
        
        self.aliPayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _aliPayBtn.frame = CGRectMake(buttonOffset, viewOffset+CGRectGetMaxY(_payAtArrivedBtn.frame),
                                      buttonWidth, buttonHeight);
        _aliPayBtn.backgroundColor = UIColor.orangeColor;
        [_aliPayBtn setTitle:getLocalizationString(@"payment_method_aliPay") forState:UIControlStateNormal];
        [_aliPayBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_aliPayBtn addTarget:self action:@selector(getAliPayInitialData) forControlEvents:UIControlEventTouchUpInside];
        [_aliPayBtn setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [self.contentView addSubview:_aliPayBtn];
        
        
        self.unionPayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _unionPayBtn.frame = CGRectMake(buttonOffset, viewOffset+CGRectGetMaxY(_aliPayBtn.frame),
                                        buttonWidth, buttonHeight);
        _unionPayBtn.backgroundColor = CDZColorOfGreen;
        [_unionPayBtn setTitle:getLocalizationString(@"payment_method_unionPay") forState:UIControlStateNormal];
        [_unionPayBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_unionPayBtn setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [self.contentView addSubview:_unionPayBtn];
        
        CGRect successFrame = self.contentView.bounds;
        successFrame.origin.y = CGRectGetHeight(self.contentView.frame);
        self.paySuccessView = [[UIView alloc]initWithFrame:successFrame];
        [self.contentView addSubview:_paySuccessView];
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        confirmBtn.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(_paySuccessView.frame)*0.75f, CGRectGetWidth(_paySuccessView.frame)*0.1f);
        confirmBtn.backgroundColor = CDZColorOfDefaultColor;
        confirmBtn.center = CGPointMake(CGRectGetWidth(_paySuccessView.frame)/2.0f, CGRectGetHeight(_paySuccessView.frame)*0.75f);
        [confirmBtn setTitle:getLocalizationString(@"ok") forState:UIControlStateNormal];
        [confirmBtn setTitle:getLocalizationString(@"ok") forState:UIControlStateHighlighted];
        [confirmBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [confirmBtn setTitleColor:CDZColorOfWhite forState:UIControlStateHighlighted];
        [confirmBtn addTarget:self action:@selector(popBackOrderListView) forControlEvents:UIControlEventTouchUpInside];
        [_paySuccessView addSubview:confirmBtn];
        
    }
}

- (void)showPaymentSuccess {
    
    [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"你已支付成功！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
        [self popBackOrderListView];
    }];
    return;
    [UIView animateWithDuration:0.25 animations:^{
        self.title = nil;
        [self setLeftNavButtonWithTitleOrImage:@"" style:UIBarButtonItemStyleDone target:nil action:nil titleColor:nil isNeedToSet:YES];
        self.paySuccessView.frame = self.contentView.bounds;
    }];
}

- (void)popBackOrderListView {
    @autoreleasepool {
        [NSNotificationCenter.defaultCenter postNotificationName:CDZNotiKeyOfReloadOrderList object:nil];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.class == %@", MyOrderVC.class];
        NSArray *array = [self.navigationController.viewControllers filteredArrayUsingPredicate:predicate];
        if (array.count==0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            [self.navigationController popToViewController:array.lastObject animated:YES];
        }
    }
}

- (void)setupOrderDetail:(NSDictionary *)detail {
    self.orderDetail = detail;
}

- (void)handlePaymentData:(NSDictionary *)dataDetail {
    
    if (!dataDetail||dataDetail.count==0) {
        [ProgressHUDHandler showErrorWithStatus:@"遗失交易信息！" onView:nil completion:nil];
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
    order.partner = dataDetail[@"partner"];
    order.seller = dataDetail[@"seller_email"];
    order.tradeNO = dataDetail[@"out_trade_no"]; //订单ID（由商家自行制定）
    order.productName = dataDetail[@"subject"]; //商品标题
    order.productDescription = dataDetail[@"body"]; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",[dataDetail[@"total_fee"] floatValue]]; //商品价格
    order.notifyURL = dataDetail[@"notify_url"]; //回调URL
    
    order.service = dataDetail[@"service"];
    order.paymentType = dataDetail[@"payment_type"];
    order.inputCharset = dataDetail[@"_input_charset"];
    order.itBPay = dataDetail[@"it_b_pay"];;
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"cdzerpersonal";
    
    NSString *orderBodyString = order.description;
    NSString *sign_type = dataDetail[@"sign_type" ];
    NSString *signedString = dataDetail[@"sign"];
    
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
    }
}


- (void)getAliPayInitialData {
    if (!self.accessToken||![_orderDetail[kOrderDetailKey] objectForKey:@"main_order_id"]) return;
    [ProgressHUDHandler showHUDWithTitle:@"支付初始中" onView:nil];
    [[APIsConnection shareConnection] personalCenterAPIsPaymentMethodByAlipayWithAccessToken:self.accessToken orderMainID:[_orderDetail[kOrderDetailKey] objectForKey:@"main_order_id"] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        
        [self handlePaymentData:responseObject[CDZKeyOfResultKey]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"支付初始化失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
        
    }];
}

- (void)getPayAfterArrived {
    NSString *orderID = [_orderDetail[kOrderDetailKey] objectForKey:@"main_order_id"];
    if (!self.accessToken||!orderID) return;
    [ProgressHUDHandler showHUDWithTitle:@"提交中" onView:nil];
    [[APIsConnection shareConnection] personalCenterAPIsPaymentMethodByPayAfterDeliveryWithAccessToken:self.accessToken isPayAfterDelivery:YES orderMainID:orderID costType:nil costTypeName:nil payType:nil payTypeName:nil state:nil stateName:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        
        [ProgressHUDHandler dismissHUD];
        [self showPaymentSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"支付失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
        
    }];
}

- (void)getUpdateStatus {
    NSString *orderID = [_orderDetail[kOrderDetailKey] objectForKey:@"main_order_id"];
    if (!self.accessToken||!orderID) return;
    [ProgressHUDHandler showHUDWithTitle:@"提交中" onView:nil];
    [[APIsConnection shareConnection]  personalCenterAPIsPaymentMethodByPayAfterDeliveryWithAccessToken:self.accessToken isPayAfterDelivery:YES orderMainID:orderID costType:nil costTypeName:nil payType:nil payTypeName:nil state:nil stateName:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        
        [ProgressHUDHandler dismissHUD];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"支付失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
        
    }];
}

@end
