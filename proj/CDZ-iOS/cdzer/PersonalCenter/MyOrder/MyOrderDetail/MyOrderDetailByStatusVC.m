//
//  MyOrderDetailByStatusVC.m
//  cdzer
//
//  Created by KEns0n on 3/30/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vCommentFont [UIFont systemFontOfSize:vAdjustByScreenRatio(15.0f)]
#define vCommentBoldFont [UIFont boldSystemFontOfSize:vAdjustByScreenRatio(16.0f)]
#define vStartSpace vAdjustByScreenRatio(16.0f)
#define vSpace vAdjustByScreenRatio(10.0f)
#import "MyOrderDetailByStatusVC.h"

#import "InsetsLabel.h"
#import "DetailInfoView.h"
#import "ProductDetailView.h"
#import "OrderInfoDescriptionView.h"
#import "LogisticsFlowStatusView.h"
#import "ActionOfStatusButtonView.h"
#import "PaymentForPartsVC.h"
#import "ReturnGoodsApplyFormView.h"
#import "WriteCommentVC.h"
#import "OrderStatusDTO.h"
#import "PaymentASV.h"

@interface MyOrderDetailByStatusVC ()

@property (nonatomic, strong) OrderStatusDTO *orderStatus;

@property (nonatomic, strong) NSDictionary *orderDetail;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) UIEdgeInsets insetsValue;

@property (nonatomic, strong) LogisticsFlowStatusView *statusFlowView;

@property (nonatomic, strong) OrderInfoDescriptionView *infoView;

@property (nonatomic, strong) ActionOfStatusButtonView *asbView;

@property (nonatomic, strong) DetailInfoView *detailInfoView;

@property (nonatomic, strong) ProductDetailView *productInfoView;

@property (nonatomic, strong) ActionOfStatusButtonView *traceButtonView;

@property (nonatomic, strong) ReturnGoodsApplyFormView *returnGoodApplyView;

@property (nonatomic, strong) NSString *mainOrderID;

@property (nonatomic, assign) BOOL isCanPayOnDelivery;

@property (nonatomic, assign) BOOL isReloadData;


@end
@implementation MyOrderDetailByStatusVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"order_detail")];
    self.insetsValue = UIEdgeInsetsMake(0.0f, vStartSpace, 0.0f, 0.0f);
    [self componentSetting];
    [self initializationUI];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(isNeedReload) name:@"MODBSReloadData" object:nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_isReloadData) {
        [self getPurchaseOrderDetail];
        self.isReloadData = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    NSDictionary *orderDetail = _orderDetail[kOrderDetailKey];
    self.mainOrderID = orderDetail[@"main_order_id"];
    NSString *payType = orderDetail[@"paytype_name"];
    if ([payType rangeOfString:@"积分支付"].location==NSNotFound||[payType rangeOfString:@"积分"].location==NSNotFound){
        self.isCanPayOnDelivery = YES;
    }
    if ([payType rangeOfString:@"积分支付"].location==NSNotFound||[payType rangeOfString:@"积分"].location==NSNotFound){
        self.isCanPayOnDelivery = YES;
    }
}

- (void)initializationUI {
    @autoreleasepool {
        [self setScrollView:[[UIScrollView alloc] initWithFrame:self.contentView.bounds]];
        [_scrollView setBackgroundColor:sCommonBGColor];
        [_scrollView setBounces:NO];
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)*2.0f)];
        [self.contentView addSubview:_scrollView];
        
        CGFloat totalContentSize = 0;
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect infoRect = _scrollView.bounds;
        if (!CGRectEqualToRect(_statusFlowView.frame , CGRectZero)){
            infoRect.origin.y += CGRectGetMaxY(_statusFlowView.frame);
        }
        infoRect.size.height = vAdjustByScreenRatio(90.0f);
        self.infoView = [[OrderInfoDescriptionView alloc] initWithFrame:infoRect];
        [_infoView initializationUIByOrderStatus:_orderStatus.orderStatusType withOrderInfo:_orderDetail];
        [_scrollView addSubview:_infoView];

        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        if (_orderStatus.orderStatusType != MyOrderStatusOfOrderApplingReturnPurchase&& _orderStatus.orderStatusType != MyOrderStatusOfOrderUnknowState) {
            NSArray *actionList = @[];
            NSString *firstSelector = @"";
            NSString *secondSelector = @"";
            
            
            
            if (_orderStatus.orderStatusType==MyOrderStatusOfOrderWait4Payment) {
                firstSelector = NSStringFromSelector(@selector(confirmOrderAndPayment));
                secondSelector = NSStringFromSelector(@selector(confirmOrderCancel));
                actionList = @[firstSelector,secondSelector];
            }
            
            if (_orderStatus.orderStatusType==MyOrderStatusOfOrderWasPaidNWait4Delivery||_orderStatus.orderStatusType==MyOrderStatusOfOrderPayOnDeliveryNWait4Delivery) {
                firstSelector = NSStringFromSelector(@selector(confirmOrderCancel));
                actionList = @[firstSelector];
            }

            if (_orderStatus.orderStatusType==MyOrderStatusOfOrderDelivering) {
                firstSelector = NSStringFromSelector(@selector(confirmGoodsHaveBeenArrived));
                secondSelector = NSStringFromSelector(@selector(showGoodsReturnApplyFormView));
                actionList = @[firstSelector,secondSelector];
            }
            
            if (_orderStatus.orderStatusType==MyOrderStatusOfOrderReturnPurchaseRejected) {
                firstSelector = NSStringFromSelector(@selector(confirmGoodsHaveBeenArrived));
                actionList = @[firstSelector];
            }
            
            if (_orderStatus.orderStatusType==MyOrderStatusOfOrderCancel) {
                firstSelector = NSStringFromSelector(@selector(deleteOrder));
                actionList = @[firstSelector];
            }
            
            if (_orderStatus.orderStatusType==MyOrderStatusOfOrderFinish) {
                firstSelector = NSStringFromSelector(@selector(deleteOrder));
                secondSelector = NSStringFromSelector(@selector(showCommnetView));
                actionList = @[firstSelector,secondSelector];
            }

            if (_orderStatus.orderStatusType==MyOrderStatusOfOrderAcceptApplingReturnPurchase) {
                firstSelector = NSStringFromSelector(@selector(confirmGoodsHasBeenReturn));
                actionList = @[firstSelector];
            }
            

            
            CGRect asbRect = _scrollView.bounds;
            asbRect.origin.y = CGRectGetMaxY(_infoView.frame)+vSpace;
            asbRect.size.height = vAdjustByScreenRatio(30.0f);
            [self setAsbView:[[ActionOfStatusButtonView alloc] initWithFrame:asbRect]];
            [_asbView initializationUIWithOrderStatus:_orderStatus.orderStatusType target:self Actions:actionList isOnlyShowTrackBtn:NO];
            [_scrollView addSubview:_asbView];
        }
        
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        CGRect detailInfoRect = _scrollView.bounds;
        detailInfoRect.origin.y = CGRectGetMaxY(_infoView.frame)+vSpace;
        if (!CGRectEqualToRect(_asbView.frame , CGRectZero)) {
            detailInfoRect.origin.y = CGRectGetMaxY(_asbView.frame)+vSpace;
        }
        detailInfoRect.size.height = vAdjustByScreenRatio(90.0f);
        self.detailInfoView = [[DetailInfoView alloc] initWithFrame:detailInfoRect];
        [_detailInfoView initializationUIWithDetailInfo:_orderDetail];
        [_scrollView addSubview:_detailInfoView];

        CGRect productionInfoRect = _scrollView.bounds;
        productionInfoRect.origin.y = CGRectGetMaxY(_detailInfoView.frame)+vSpace;
        productionInfoRect.size.height = 150.0f;
        self.productInfoView = [[ProductDetailView alloc] initWithFrame:productionInfoRect];
        [_productInfoView setPopCommentVCActionTarget:self action:@selector(showCommnetViewByCellButton:)];
        [_productInfoView initializationUIWithDetailInfo:_orderDetail[kOrderDetailKey] andOrderStatus:_orderStatus.orderStatusType isAutoResize:YES];
        [_scrollView addSubview:_productInfoView];
        totalContentSize = CGRectGetMaxY(productionInfoRect);

        @weakify(self)
        [RACObserve(self, productInfoView.frame) subscribeNext:^(id theRect) {
            @strongify(self)
            CGRect rect = [theRect CGRectValue];
            [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetMaxY(rect)+vAdjustByScreenRatio(40.0f))];
        }];
        
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        
    }
}

- (void)isNeedReload {
    self.isReloadData = YES;
}

- (void)setupOrderDetail:(NSDictionary *)detail withOrderStatus:(OrderStatusDTO *)orderStatus {
    self.orderDetail = detail;
    self.orderStatus = orderStatus;
}

- (void)popBackPerviousPage {
    [NSNotificationCenter.defaultCenter postNotificationName:CDZNotiKeyOfReloadOrderList object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)confirmOrderAndPayment {
    @autoreleasepool {
//        PaymentForPartsVC *vc = [PaymentForPartsVC new];
//        [vc setupOrderDetail:_orderDetail];
//        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
//        [self.navigationController pushViewController:vc animated:YES];
        
        [PaymentASV showPaymentViewWithPayAfterDelivery:self.isCanPayOnDelivery paymentData:_orderDetail withResultBlock:^(NSString *resultMessage, NSInteger errorCode) {
            
            NSLog(@"message::%@  code::%d", resultMessage, errorCode);
            if (errorCode==0) {
                [SupportingClass showAlertViewWithTitle:@"alert_remind" message:resultMessage isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
                [self popBackPerviousPage];
            }
            
        }];
    }
}

- (void)showCommnetViewByCellButton:(UIButton *)button {
    
    NSArray *productList = [_orderDetail[kOrderDetailKey] objectForKey:@"product_list"];
    NSString *productID = [productList[button.accessibilityIdentifier.integerValue] objectForKey:@"good_id"];
    WriteCommentVC *vc = [WriteCommentVC new];
    vc.popToSecondVC = NO;
    [vc setCommentType:CommentTypeOfOrderCommment andID:_mainOrderID productID:productID];
    [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showCommnetView {
    
    NSArray *productList = [_orderDetail[kOrderDetailKey] objectForKey:@"product_list"];
    NSNumber *wasCommentedCount = [[productList valueForKey:@"reg_tag"] valueForKeyPath:@"@sum.self"];
    BOOL allOfUncomment = (productList.count>1&&wasCommentedCount.unsignedIntegerValue<=(productList.count-2));
    if (allOfUncomment) {
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
            [self.scrollView setContentOffset:bottomOffset animated:NO];
        }];

        return;
    }
    __block NSString *productID = @"";
    [productList enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
        if ([[SupportingClass verifyAndConvertDataToString:obj[@"reg_tag"]] isEqualToString:@"0"]) {
            productID = obj[@"good_id"];
        }
    }];
    @autoreleasepool {
        WriteCommentVC *vc = [WriteCommentVC new];
        vc.popToSecondVC = YES;
        [vc setCommentType:CommentTypeOfOrderCommment andID:_mainOrderID productID:productID];
        [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)confirmOrderCancel {
    @autoreleasepool {
        @weakify(self)
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"确认是否取消订单？" isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"ok"  clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            if (btnIdx.integerValue==1) {
                @strongify(self)
                [self cancelOrder];
            }
        }];
    }
}

- (void)cancelOrder {
    if (!self.accessToken||!_mainOrderID) return;
    [ProgressHUDHandler showHUD];
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPostCancelPurchaseOrderWithAccessToken:self.accessToken orderMainID:_mainOrderID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"订单已取消成功！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            @strongify(self)
            [self popBackPerviousPage];
        }];
        [ProgressHUDHandler dismissHUD];
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"取消失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
        
    }];
}

- (void)showGoodsReturnApplyFormView {
    if (!_returnGoodApplyView) {
        self.returnGoodApplyView = [ReturnGoodsApplyFormView new];
        @weakify(self)
        [_returnGoodApplyView setupCompletionBlock:^(NSError *error) {
            if (!error) {
            @strongify(self)
              [self popBackPerviousPage];
            }
        }];
    }
    _returnGoodApplyView.mainOrderID = _mainOrderID;
    [_returnGoodApplyView showView];
}

- (void)confirmGoodsHaveBeenArrived {
    if (!self.accessToken||!_mainOrderID) return;
    [ProgressHUDHandler showHUD];
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPostConfirmPurchaseOrderStateOfHasBeenArrivedWithAccessToken:self.accessToken orderMainID:_mainOrderID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"成功确认收货！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            @strongify(self)
            [self popBackPerviousPage];
        }];
        [ProgressHUDHandler dismissHUD];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"确认失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
        
    }];
}

- (void)confirmGoodsHasBeenReturn {
    if (!self.accessToken||!_mainOrderID) return;
    [ProgressHUDHandler showHUD];
        @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPostConfirmGoodsHasBeenReturnAccessToken:self.accessToken orderMainID:_mainOrderID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"确认成功！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            @strongify(self)
            [self popBackPerviousPage];
        }];
        [ProgressHUDHandler dismissHUD];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"确认失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
        
    }];
}

- (void)deleteOrder {
    if (!self.accessToken||!_mainOrderID) return;
    [ProgressHUDHandler showHUD];
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPostDeletePurchaseOrderWithAccessToken:self.accessToken orderMainID:_mainOrderID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if (errorCode!=0) {
            [ProgressHUDHandler dismissHUD];
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"成功删除订单！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            @strongify(self)
            [self popBackPerviousPage];
        }];
        [ProgressHUDHandler dismissHUD];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"删除失败，请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
        
    }];
}

- (void)getPurchaseOrderDetail {
    if (!self.accessToken||!_mainOrderID) return;
    [ProgressHUDHandler showHUD];
    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsGetPurchaseOrderDetailWithAccessToken:self.accessToken orderMainID:_mainOrderID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @strongify(self)
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return ;
        }
        self.orderDetail = responseObject[CDZKeyOfResultKey];
        [self.productInfoView initializationUIWithDetailInfo:self.orderDetail[kOrderDetailKey] andOrderStatus:self.orderStatus.orderStatusType isAutoResize:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"连接逾时！请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
        
    }];
}


@end
