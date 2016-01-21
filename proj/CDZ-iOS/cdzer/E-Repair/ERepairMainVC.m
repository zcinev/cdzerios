//
//  ERepairMainVC.m
//  cdzer
//
//  Created by KEns0n on 11/4/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "ERepairMainVC.h"
#import "InsetsLabel.h"
#import "ERepairFormVC.h"
@interface ERepairMainVC ()

@property (nonatomic, strong) NSMutableAttributedString *introString;

@property (nonatomic, strong) InsetsLabel *contentLabel;

@end

@implementation ERepairMainVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    self.title = getLocalizationString(@"e_repair");
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    @autoreleasepool {
        UIFont *titlesFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16.0f, YES);
        UIFont *contentsFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 13.0f, YES);
        
        self.introString = NSMutableAttributedString.new;
        [_introString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"服务对象\n"
                                              attributes:@{NSFontAttributeName:titlesFont}]];
        [_introString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"e服务仅仅面向车队长注册会员，服务提供商为车队长认证商家。\n\n"
                                              attributes:@{NSFontAttributeName:contentsFont}]];
        
        
        [_introString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"开通服务城市\n"
                                              attributes:@{NSFontAttributeName:titlesFont}]];
        [_introString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"e服务目前支持的城市为长沙，其他城市陆续开通中，敬请期待！\n\n"
                                              attributes:@{NSFontAttributeName:contentsFont}]];
        
        
        [_introString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"服务内容\n"
                                              attributes:@{NSFontAttributeName:titlesFont}]];
        [_introString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"－提供专家免费诊断，判断车辆故障原因，降低小病大修的风险；\n－提供第三方验车服务，降低维修质量风险；\n－提供上门取车，维修完后送车上门服务；\n\n"
                                              attributes:@{NSFontAttributeName:contentsFont}]];
        
        
        [_introString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"体验与优惠\n"
                                              attributes:@{NSFontAttributeName:titlesFont}]];
        [_introString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"－会员首次体验免费，第二次减半收取费用；\n－现只支持线下支付；\n－介绍其他会员、评价送积分；"
                                              attributes:@{NSFontAttributeName:contentsFont}]];
    }
    
}

- (void)initializationUI {
    UIImage *image = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches fileName:@"main_bg" type:FMImageTypeOfPNG scaleWithPhone4:YES needToUpdate:YES];
    [self.contentView setBackgroundImageByCALayerWithImage:image];
    
    CGRect contentFrame = self.contentView.bounds;
    contentFrame.size.height = [SupportingClass getAttributedStringSizeWithString:_introString widthOfView:CGSizeMake(CGRectGetWidth(contentFrame), CGFLOAT_MAX)].height;
    self.contentLabel = [[InsetsLabel alloc] initWithFrame:contentFrame andEdgeInsetsValue:DefaultEdgeInsets];
    _contentLabel.attributedText = _introString;
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    NSString *btnTitle = @"《车队长E服务协议》";
    NSDictionary *attrDict = @{NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 20.0f, NO),
                               NSForegroundColorAttributeName:CDZColorOfBlue};
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:btnTitle attributes:attrDict];
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,[btnTitle length])];
    
    UIButton *TnCButton = [UIButton buttonWithType:UIButtonTypeSystem];
    TnCButton.frame = CGRectMake(0.0f, CGRectGetMaxY(_contentLabel.frame)+vAdjustByScreenRatio(10.0f), CGRectGetWidth(self.contentView.frame), 36.0f);
    TnCButton.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 15.0f, YES);
    [TnCButton setAttributedTitle:title forState:UIControlStateNormal];
    [self.contentView addSubview:TnCButton];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmButton.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)*0.2f, CGRectGetMaxY(TnCButton.frame), CGRectGetWidth(self.contentView.frame)*0.65f, vAdjustByScreenRatio(40.0f));
    confirmButton.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16.0f, YES);
    confirmButton.backgroundColor = CDZColorOfOrangeColor;
    [confirmButton setTitle:@"同意协议" forState:UIControlStateNormal];
    [confirmButton setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
    [confirmButton setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
    [confirmButton addTarget:self action:@selector(verifyUserWasMadeAppointment) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:confirmButton];
}

- (void)setReactiveRules {
    
}

- (void)goNextViewController {
    @autoreleasepool {
        ERepairFormVC *vc = ERepairFormVC.new;
        [vc setNavBarBackButtonTitleOrImage:nil titleColor:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)verifyUserWasMadeAppointment {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUD];
    @weakify(self)
    [APIsConnection.shareConnection personalCenterAPIsGetERepairVerifyUserWasMadeAppointmentWithAccessToken:self.accessToken theSign:@"" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        
        if (errorCode==0) {
            [ProgressHUDHandler dismissHUDWithCompletion:^{
                @strongify(self)
                [self goNextViewController];
            }];
            return;
        }
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:nil message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"不明错误" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
