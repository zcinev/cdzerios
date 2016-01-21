//
//  GPSElectricFencingVC.m
//  cdzer
//
//  Created by KEns0n on 6/3/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "GPSElectricFencingVC.h"
#import "ElectronicDialog.h"
#import "PositionDto.h"
#import <BaiduMapAPI/BMapKit.h>

@interface GPSElectricFencingVC ()<BMKMapViewDelegate>
{
    BMKMapView *_mapView;
}

@property (nonatomic, strong) UIImage *carImg;

@property (nonatomic, strong) UIButton *mapZoomInButton;

@property (nonatomic, strong) UIButton *mapZoomOutButton;

@property (nonatomic, strong) UIButton *locatePositionButton;

@property (nonatomic, strong) BMKCircle *circle ;
@property (nonatomic, strong) BMKPointAnnotation *tagAnnotation ;
@property (nonatomic, assign) float zoomLevel ;
@property (nonatomic, strong) ElectronicDialog *eleDialog ;
@property (nonatomic, assign) float distance ;
@property (nonatomic, strong) PositionDto *poDto ;
@property (nonatomic, assign) BOOL isMoveSet ;
@property (nonatomic, assign) BOOL isOpen ;
@property (nonatomic, assign) CLLocationCoordinate2D clickCoordinate ;
@property (nonatomic, strong) UIButton *setOpenBtn ;

@end

@implementation GPSElectricFencingVC


- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    [_mapView removeFromSuperview];
    _mapView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"GPS设置";
    [self setReactiveRules];
    [self componentSetting];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    [self updateGeoLocationByCoordinates];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserAutoLocation:) name:CDZNotiKeyOfUpdateAutoGPSInfo object:nil];
    [[NSUserDefaults standardUserDefaults] setValue:@(YES) forKey:kRunUpdateAutoRTData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    [_mapView removeAnnotations:_mapView.annotations];
    _mapView.delegate = nil;
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:kRunUpdateAutoRTData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CDZNotiKeyOfUpdateAutoGPSInfo object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setReactiveRules {
    
}

- (void)componentSetting {
    self.carAnnotation = [[BMKPointAnnotation alloc] init];
    
    self.carImg = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"loc_car@2x" ofType:@"png"]];
}

- (void)initializationUI {
    
    //百度地图初始化
    _mapView = [[BMKMapView alloc] initWithFrame:self.contentView.bounds];
    _mapView.compassPosition = CGPointMake(100.0f, 100.0f);
    _mapView.zoomLevel=16;
    [self.contentView addSubview:_mapView];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    self.locatePositionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _locatePositionButton.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)*0.82,
                                             CGRectGetHeight(self.contentView.frame)*0.6304347826087,
                                             30.0f, 30.0f);
    [_locatePositionButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nav_btn_loc_center_normal@2x" ofType:@"png"]]
                           forState:UIControlStateNormal];
    [_locatePositionButton addTarget:self action:@selector(locateAutosPosition) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_locatePositionButton];
    
    
    
    self.mapZoomInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mapZoomInButton.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)*0.8,
                                        CGRectGetHeight(self.contentView.frame)*0.73,
                                        28.0f, 30.0f);
    _mapZoomInButton.center = CGPointMake(_locatePositionButton.center.x, _mapZoomInButton.center.y);
    [_mapZoomInButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zoomin_normal@2x" ofType:@"png"]]
                      forState:UIControlStateNormal];
    [_mapZoomInButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zoomin_disable@2x" ofType:@"png"]]
                      forState:UIControlStateDisabled];
    [_mapZoomInButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zoomin_press@2x" ofType:@"png"]]
                      forState:UIControlStateHighlighted];
    [_mapZoomInButton addTarget:self action:@selector(mapZoomInOut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_mapZoomInButton];
    
    
    
    self.mapZoomOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mapZoomOutButton.frame = CGRectMake(CGRectGetMinX(self.mapZoomInButton.frame),
                                         CGRectGetMaxY(self.mapZoomInButton.frame),
                                         28.0f, 30.0f);
    [_mapZoomOutButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zoomout_normal@2x" ofType:@"png"]]
                       forState:UIControlStateNormal];
    [_mapZoomOutButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zoomout_disable@2x" ofType:@"png"]]
                       forState:UIControlStateDisabled];
    [_mapZoomOutButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"zoomout_press@2x" ofType:@"png"]]
                       forState:UIControlStateHighlighted];
    [_mapZoomOutButton addTarget:self action:@selector(mapZoomInOut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_mapZoomOutButton];


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
}

#pragma mark- private function
- (void)updateGeoLocationByCoordinates {
    @autoreleasepool {
        NSDictionary * autoGPSDetail = [[DBHandler shareInstance] getAutoRealtimeDataWithDataID:1];
        if (!autoGPSDetail) return;
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [autoGPSDetail[@"lat"] doubleValue];
        coordinate.longitude = [autoGPSDetail[@"lon"] doubleValue];
        _carAnnotation.coordinate = coordinate;
        [self addPointAnnotation];
    }
}

#pragma mark- Map Control Action
- (void)mapZoomInOut:(UIButton *)button {
    float level = _mapView.zoomLevel;
    NSLog(@"%f",level);
    if ([button isEqual:_mapZoomInButton]) {
        if (level==19) return;
        _mapView.zoomLevel += 1;
    }
    
    if ([button isEqual:_mapZoomOutButton]) {
        if (level==3) return;
        _mapView.zoomLevel -= 1;
    }
}

- (void)locateAutosPosition {
//    if (_carAnnotation) {
//        [_mapView setCenterCoordinate:_carAnnotation.coordinate];
//    }
    
}
#pragma mark 拿到当前电子围栏信息的方法
//-(void)getElentroincInfo{
//    EnectronicElement *element = [[ApiManager getInstance] getElectronicInfo:self.appDelegate.carInfo.imei];
//    if(element != nil){
//        CLLocationCoordinate2D coordinate ;
//        coordinate.latitude = [element.latitude floatValue];
//        coordinate.longitude = [element.longitude floatValue];
//        [self addOverlayView:coordinate AndDistance:1];
//    }
//}


#pragma mark 添加报警信息的右设置按钮视图
-(void)addNavigationBarRightItem{
    self.setOpenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.setOpenBtn.frame = CGRectMake(0, 0, 40, 40);
    [self.setOpenBtn setImage:[UIImage imageNamed:@"w_warn_set_p"] forState:UIControlStateNormal];
    [self.setOpenBtn setImage:[UIImage imageNamed:@"w_warn_set"] forState:UIControlStateSelected];
    [self.setOpenBtn addTarget:self action:@selector(setElectronicScope) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.setOpenBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark -设置电子围栏信息
-(void)setElectronicScope{
    
    self.isOpen = self.setOpenBtn.selected ;
    if(self.setOpenBtn.selected){
        NSString *lan = [NSString stringWithFormat:@"%f",self.poDto.latitude] ;
        NSString *lon = [NSString stringWithFormat:@"%f",self.poDto.longitude] ;
        [self showSetViewDialog:lan AndLon:lon];
        self.setOpenBtn.enabled = NO ;
    }else{
        BOOL isSuccess = NO;// [[ApiManager getInstance] deleteElectronicInfo:self.appDelegate.carInfo.imei];
        if(isSuccess){
            [SupportingClass showToast:@"电子围栏功能已关闭"];
            self.setOpenBtn.selected = YES ;
            [self clearCircleTagAnnotation];
            //发起广播消息的通知更改设置页面的状态
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WarnStatue" object:nil];
        }else{
            [SupportingClass showToast:@"系统繁忙,请稍后尝试！"];
        }
    }
}

#pragma mark -地图定位，放大，缩小的按钮事件方法
-(IBAction)mapViewClickMenu:(id)sender{
    /*
     * 100 地图的当前位置信息方法
     * 101 地图的放大
     * 102 地图的缩小
     */
    UIButton *btn = (UIButton *)sender ;
    NSInteger tagValue = btn.tag ;
    switch (tagValue) {
        case 100:{
            self.zoomLevel = 16 ;
        }
            break;
        case 101:{
            self.zoomLevel = self.zoomLevel + 0.3 ;
        }
            break;
        case 102:{
            self.zoomLevel = self.zoomLevel - 0.3 ;
        }
            break;
    }
    _mapView.zoomLevel = self.zoomLevel ;
}

#pragma mark -添加圆形覆盖物
-(void)addOverlayView:(CLLocationCoordinate2D) coordinate AndDistance:(float) distance {
    if(self.circle == nil && self.tagAnnotation == nil){
        self.circle = [BMKCircle circleWithCenterCoordinate:coordinate radius:distance * 1000];
        [_mapView addOverlay:self.circle];
        [self addCurrentAnnotation:coordinate];
    }else{
        [self clearCircleTagAnnotation];
        self.circle = nil ;
        self.tagAnnotation = nil ;
        [self addOverlayView:coordinate AndDistance:distance];
    }
    [_mapView setCenterCoordinate:coordinate];
    
}

-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay{
    BMKCircleView* circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
    circleView.fillColor = [UIColor colorWithRed:0.024 green:0.675 blue:0.937 alpha:0.5];
    circleView.strokeColor = [UIColor colorWithRed:0.024 green:0.675 blue:0.937 alpha:0.2];
    return circleView;
}

#pragma mark -添加当前车辆位置的标识图标
-(void)addCarAnnotation:(CLLocationCoordinate2D) coordinate{
    CarPointAnnotation *carAnnotation = [[CarPointAnnotation alloc] init];
    carAnnotation.tag = 10 ;
    carAnnotation.coordinate = coordinate ;
    [_mapView addAnnotation:carAnnotation];
}

#pragma mark -添加当前选择位置的标识图标
-(void)addCurrentAnnotation:(CLLocationCoordinate2D) coordinate{
    self.tagAnnotation = [[BMKPointAnnotation alloc] init];
    self.tagAnnotation.coordinate = coordinate ;
    [_mapView addAnnotation:self.tagAnnotation];
}

-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    BMKAnnotationView *annotationView = [mapView viewForAnnotation:annotation];
    if(annotationView == nil){
        annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"sdf"];
        [annotationView.paopaoView removeFromSuperview];
        annotationView.canShowCallout = NO ;
    }
    if([annotation isKindOfClass:[CarPointAnnotation class]]){
        annotationView.image = [UIImage imageNamed:@"loc_car"];
    }else{
        annotationView.image = [UIImage imageNamed:@"w_start"];
    }
    return annotationView ;
}

#pragma mark-地图的单击方法
-(void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    if(self.isOpen){
        self.isMoveSet = YES;
        self.clickCoordinate = coordinate ;
        NSString *lan = [NSString stringWithFormat:@"%f",coordinate.latitude] ;
        NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude] ;
        [self showSetViewDialog:lan AndLon:lon];
    }
}

#pragma mark -添加电子围栏对话框事件协议方法
-(void)dialogViewSubmit:(EnectronicElement *) element{
    NSString *lan = @"";
    NSString *lon = @"";
    if(self.isMoveSet){
        lan = [NSString stringWithFormat:@"%f",self.clickCoordinate.latitude] ;
        lon = [NSString stringWithFormat:@"%f",self.clickCoordinate.longitude] ;
        self.isMoveSet = NO ;
    }else{
        lan = [NSString stringWithFormat:@"%f",self.poDto.latitude] ;
        lon = [NSString stringWithFormat:@"%f",self.poDto.longitude] ;
    }
    
    self.distance = [element.radius floatValue];
    //网络请求的代码块
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:self.appDelegate.carInfo.imei forKey:@"imei"];
    [param setObject:lan forKey:@"latitude"];
    [param setObject:lon forKey:@"longitude"];
    [param setObject:[NSString stringWithFormat:@"%f",self.distance] forKey:@"radius"];
    [param setObject:element.type forKey:@"type"];
    BOOL isSuccess = [[ApiManager getInstance] addElectronicInfo:param];
    if(isSuccess){
        //电子围栏的框选圈视图的添加
        CLLocationCoordinate2D coordinate ;
        coordinate.latitude = [lan floatValue];
        coordinate.longitude = [lon floatValue] ;
        
        [self addOverlayView:coordinate AndDistance:self.distance];
        [self showToast:@"设置电子围栏成功！"];
        self.setOpenBtn.selected = NO ;
    }else{
        [self showToast:@"系统繁忙,请重新尝试！"];
    }
    
    self.setOpenBtn.enabled = YES ;
    //发起广播消息的通知更改设置页面的状态
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WarnStatue" object:nil];
    
}

-(void)dialogViewCancel{
    self.isMoveSet = NO ;
    self.setOpenBtn.enabled = YES ;
}

#pragma mark -清除电子围栏视图的方法
-(void)clearCircleTagAnnotation{
    [_mapView removeAnnotation:self.tagAnnotation];
    [_mapView removeOverlay:self.circle];
}

#pragma mark -电子围栏设置对话框的显示
-(void)showSetViewDialog:(NSString *) lan AndLon:(NSString *) lon{
    self.eleDialog = [[[NSBundle mainBundle] loadNibNamed:@"ElectronicDialog" owner:self options:nil] objectAtIndex:0];
    self.eleDialog.delegate = self ;
    [self.view addSubview:self.eleDialog];
    if((lan!=nil && ![lan isEqualToString:@""]) && (lon!=nil && ![lon isEqualToString:@""])){
        [self.eleDialog setScopeData:lan AndLon:lon];
    }else{
        [self.eleDialog setScopeData:@"39.915" AndLon:@"116.404"];
    }
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
