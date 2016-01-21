//
//  GPSMainVC.m
//  cdzer
//
//  Created by KEns0n on 5/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "GPSMainVC.h"
#import "RealtimeAutoInfoVC.h"
#import "MyAutoLocationMainVC.h"
#import "MyAutoLocationVC.h"
#import "AutosDrivingRecordVC.h"
#import "OBDDiagnosisVC.h"
#import "FastPreventionVC.h"
#define vButtonTag 100
@interface GPSMainVC ()

@end

@implementation GPSMainVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GPS服务";
    [self initializationUI];
    
    // Do any additional setup after loading the view.
}

- (void)initializationUI {
    NSArray *array = @[@"车辆定位",@"实时车况",@"故障诊断",@"快速设防"];
    @weakify(self)
    UIImage *bgImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                           fileName:@"gps_main_bg"
                                                                               type:FMImageTypeOfJPEG
                                                                    scaleWithPhone4:NO
                                                                       needToUpdate:NO];
    [self.contentView setBackgroundImageByCALayerWithImage:bgImage];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImage *btnImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                                fileName:[NSString stringWithFormat:@"gps_btn_0%u",idx+1 ]
                                                                                    type:FMImageTypeOfPNG
                                                                         scaleWithPhone4:NO
                                                                            needToUpdate:NO];
        
        @strongify(self)
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect btnFrame = CGRectZero;
        btnFrame.size = btnImage.size;
        btn.frame = btnFrame;
        CGFloat avgHeight = CGRectGetHeight(self.contentView.frame)/array.count;
        CGPoint center = CGPointZero;
        center.x = CGRectGetWidth(self.contentView.frame)/2;
        center.y = avgHeight/2+avgHeight*idx;
        btn.center = center;
        btn.tag = vButtonTag+idx;
        [btn setImage:btnImage forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonPresentVCAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }];
    
}

- (void)buttonPresentVCAction:(UIButton *)button {
    if(!self.accessToken) {
        [self presentLoginViewAtViewController:self backTitle:nil animated:YES completion:^{
           
        }];
        return;
    }
    @autoreleasepool {
        
        id bvc = nil;
        switch (button.tag) {
            case vButtonTag:
                bvc = [MyAutoLocationMainVC new];
                break;
            case vButtonTag+1:
                bvc = [RealtimeAutoInfoVC new];
                break;
            case vButtonTag+2:
                bvc = [OBDDiagnosisVC new];
                break;
            case vButtonTag+3:
                bvc = [FastPreventionVC new];
                break;
                
            default:
                break;
        }
        if (bvc) {
            [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
            [self.navigationController pushViewController:bvc animated:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
