//
//  MyOrderConfirmVC.m
//  cdzer
//
//  Created by KEns0n on 4/9/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MyOrderConfirmVC.h"
#import "RBBorderLineView.h"
#import "InsetsLabel.h"
#import "MyOrderConfig.h"

@interface MyOrderConfirmVC ()

@property (nonatomic, strong) NSDictionary *orderDetail;

@end

@implementation MyOrderConfirmVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"my_order_confirm")];
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
        CGRect addressViewRect = CGRectZero;
        addressViewRect.origin = CGPointMake(vAdjustByScreenRatio(10.0f), vAdjustByScreenRatio(10.0f));
        addressViewRect.size.width = CGRectGetWidth(self.contentView.frame) - CGRectGetMinX(addressViewRect)*2.0f;
        addressViewRect.size.height = vAdjustByScreenRatio(120.0f);
        RBBorderLineView *addressContainerView = [[RBBorderLineView alloc] initWithFrame:addressViewRect];
        [addressContainerView setBackgroundColor:CDZColorOfWhite];
        [self.contentView addSubview:addressContainerView];
        
        
        UIEdgeInsets insetValue = UIEdgeInsetsMake(0.0f, vAdjustByScreenRatio(20.0f), 0.0f, 0.0f);
        CGRect addressTitleRect = addressContainerView.bounds;
        addressTitleRect.size.height = vAdjustByScreenRatio(30.0f);
        InsetsLabel *addressTitleLabel = [[InsetsLabel alloc] initWithFrame:addressTitleRect andEdgeInsetsValue:insetValue];
        [addressTitleLabel setText:getLocalizationString(@"delivery_info")];
        [addressTitleLabel setFont:systemFont(16.0f)];
        [addressContainerView addSubview:addressTitleLabel];
        
        NSDictionary *address_details = _orderDetail[kAddressDetailKey];
        //        NSDictionary *order_details = _orderDetail[kOrderDetailKey];
        //        NSDictionary *center_details = _orderDetail[kCenterDetailKey];
#warning 提醒加上数据
        NSArray *titleWithContent = @[[NSString stringWithFormat:@"%@ %@ %@",address_details[@"province_id_name"],address_details[@"city_id_name"],address_details[@"region_id_name"]],
                                      [NSString stringWithFormat:@"%@ %@",address_details[@"name"],address_details[@"tel"]],
                                      @"邮编：410000（假的后台没设定次数据）",
                                      address_details[@"address"]];
        
        UIFont *font = systemFont(14.0f);
        CGFloat averageHeight = (CGRectGetHeight(addressViewRect)-CGRectGetHeight(addressTitleRect))/5.0f;
        [titleWithContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            CGRect addressLabelRect = addressContainerView.bounds;
            addressLabelRect.size.height = averageHeight;
            addressLabelRect.origin.y = CGRectGetMaxY(addressTitleRect)+idx*averageHeight;
            InsetsLabel *addressLabel = [[InsetsLabel alloc] initWithFrame:addressLabelRect andEdgeInsetsValue:insetValue];
            [addressLabel setText:obj];
            [addressLabel setFont:font];
            [addressContainerView addSubview:addressLabel];
        }];
    }
    
}

- (void)setupOrderDetail:(NSDictionary *)detail {
    self.orderDetail = detail;
}

/*
#pragma mark- Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
