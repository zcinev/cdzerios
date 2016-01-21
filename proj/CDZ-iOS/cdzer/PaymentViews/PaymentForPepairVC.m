//
//  PaymentForPepairVC.m
//  cdzer
//
//  Created by KEns0n on 6/10/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vCommentFont systemFontWithoutRatio(15.0f)

#define vCommentBoldFont systemFontBoldWithoutRatio(16.0f)
#import "PaymentForPepairVC.h"
#import "InsetsLabel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "OrderForm.h"
#import "MyOrderConfig.h"
#import "MyRepairDetailTVCell.h"

@interface PaymentForPepairVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *detailList;

@property (nonatomic, strong) NSArray *titleList;

@property (nonatomic, strong) UIButton *aliPayBtn;

@property (nonatomic, strong) UIButton *unionPayBtn;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation PaymentForPepairVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"order_payment")];
    [self componentSetting];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)componentSetting {
    NSArray *priceList = @[@{@"title":@"预估管理费:",@"content":_repairDetail.estimatedManagementCost},
                           @{@"title":@"诊断费:",@"content":_repairDetail.diagnoseAmount},
                           @{@"title":@"预计材料费：",@"content":_repairDetail.estimatedMaterialCost},
                           @{@"title":@"预计优惠金额：",@"content":_repairDetail.discount},
                           @{@"title":@"工时：",@"content":_repairDetail.workingHour},
                           @{@"title":@"总工时费：",@"content":_repairDetail.totalWorkingHour},
                           @{@"title":@"工时费：",@"content":_repairDetail.workingHourPrice},
                           @{@"title":@"预计费用合计：",@"content":_repairDetail.estimatedTotalAmount},];
    self.detailList = [NSMutableArray arrayWithObject:priceList];
    [_detailList addObjectsFromArray:_repairDetail.repairmentNComponentList];
    self.titleList =@[@"价格详情",
                      getLocalizationString(@"repair_item"),
                      getLocalizationString(@"repair_material")];
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
        CGFloat buttonWidth = CGRectGetWidth(self.contentView.frame)-viewOffset*2.0f;
        CGFloat buttonHeight = 40.0f;
        
        self.unionPayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _unionPayBtn.frame = CGRectMake(viewOffset, CGRectGetHeight(self.contentView.frame)-viewOffset-buttonHeight,
                                        buttonWidth, buttonHeight);
        _unionPayBtn.backgroundColor = CDZColorOfGreen;
        [_unionPayBtn setTitle:getLocalizationString(@"payment_method_unionPay") forState:UIControlStateNormal];
        [_unionPayBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_unionPayBtn setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [self.contentView addSubview:_unionPayBtn];
        
        
        self.aliPayBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _aliPayBtn.frame = CGRectMake(viewOffset, CGRectGetMinY(_unionPayBtn.frame)-viewOffset-buttonHeight,
                                      buttonWidth, buttonHeight);
        _aliPayBtn.backgroundColor = UIColor.orangeColor;
        [_aliPayBtn setTitle:getLocalizationString(@"payment_method_aliPay") forState:UIControlStateNormal];
        [_aliPayBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_aliPayBtn addTarget:self action:@selector(getAliPayInitialData) forControlEvents:UIControlEventTouchUpInside];
        [_aliPayBtn setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
        [self.contentView addSubview:_aliPayBtn];
        
        CGRect tableViewRect = self.contentView.bounds;
        tableViewRect.size.height = CGRectGetMinY(_aliPayBtn.frame)-viewOffset*2.0f;
        self.tableView = [[UITableView alloc] initWithFrame:tableViewRect];
        _tableView.backgroundColor = CDZColorOfWhite;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.contentView addSubview:_tableView];
    }
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _detailList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_detailList[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MyRepairDetailTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyRepairDetailTVCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    // Configure the cell...
    CDZRepairDetailType type = CDZRepairDetailTypeOfPrice;
    if (indexPath.section==1) {
        type = CDZRepairDetailTypeOfWXXM;
    }
    if (indexPath.section==2) {
        type = CDZRepairDetailTypeOfWXCL;
    }
    [cell updateUIDataWithData:[_detailList[indexPath.section] objectAtIndex:indexPath.row] detailType:type isShowCheckMark:NO] ;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 44.0f;
    }
    return 70.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    @autoreleasepool {
        static NSString *headerIdentifier = @"header";
        UITableViewHeaderFooterView *myHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
        if(!myHeader) {
            myHeader = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
            InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectZero
                                                               andEdgeInsetsValue:DefaultEdgeInsets];
            titleLabel.font = vCommentBoldFont;
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.tag = 10;
            titleLabel.translatesAutoresizingMaskIntoConstraints = YES;
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            [myHeader.contentView addSubview:titleLabel];
            
            [myHeader.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
            [myHeader setBorderWithColor:nil borderWidth:(0.5f)];
            [myHeader setNeedsUpdateConstraints];
            [myHeader updateConstraintsIfNeeded];
            [myHeader setNeedsLayout];
            [myHeader layoutIfNeeded];
        }
        InsetsLabel *titleLabel = (InsetsLabel *)[myHeader viewWithTag:10];
        NSString *title = _titleList[section];
        titleLabel.text = title;
        
        return myHeader;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
    if (!self.accessToken||!_shopID) return;
    [ProgressHUDHandler showHUDWithTitle:@"支付初始中" onView:nil];
    [[APIsConnection shareConnection] personalCenterAPIsGetMaintenanceClearingPaymentInfoWithAccessToken:self.accessToken keyID:_shopID success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

@end
