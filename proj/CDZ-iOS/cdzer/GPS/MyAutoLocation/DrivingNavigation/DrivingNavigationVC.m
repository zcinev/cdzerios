//
//  DrivingNavigationVC.m
//  cdzer
//
//  Created by KEns0n on 5/30/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "DrivingNavigationVC.h"
#import "InsetsTextField.h"
#import <BaiduMapAPI/BMapKit.h>
@interface DrivingNavigationVC ()<BMKLocationServiceDelegate, BMKPoiSearchDelegate, UITableViewDataSource,
                                         UITableViewDelegate, UIScrollViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) BMKPoiSearch *bmkSearch;

@property (nonatomic, strong) BMKPoiInfo *startPointInfo;

@property (nonatomic, strong) BMKPoiInfo *endPointInfo;

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) UITableView *searchAddressTableView;

@property (nonatomic, strong) NSArray *tmpAddressArray;

@property (nonatomic, strong) InsetsTextField *startNavTextField;

@property (nonatomic, strong) InsetsTextField *endNavTextField;

@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation DrivingNavigationVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = getLocalizationString(@"my_auto_navigation");
    [self setReactiveRules];
    [self componentSetting];
    [self initializationUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.title = self.title;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    [super viewWillAppear:animated];
    _bmkSearch.delegate = self;
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    [notiCenter addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [notiCenter addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    [notiCenter addObserver:self selector:@selector(keyboardDidAppear:) name:UIKeyboardDidShowNotification object:nil];
    [notiCenter addObserver:self selector:@selector(textFieldEditing:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_locService stopUserLocationService];
    _locService.delegate = nil;
    _bmkSearch.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setReactiveRules {
    
    @weakify(self)
    [[RACSignal combineLatest:@[RACObserve(self, startPointInfo), RACObserve(self, endPointInfo)] reduce:^id(BMKPoiInfo *value1, BMKPoiInfo *value2){
        return @(value1&&value2);
    }] subscribeNext:^(NSNumber *isOn) {
        @strongify(self)
        self.searchButton.enabled = isOn.boolValue;
    }];

}

- (void)componentSetting {
    self.tmpAddressArray = @[];
    
    self.startPointInfo = nil;
    self.endPointInfo = nil;;
    
    self.locationManager = [CLLocationManager new];
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    if (!_locService) {
        self.locService = [[BMKLocationService alloc] init];
    }
    
    if ([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusDenied&&[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusRestricted) {
        _locService.delegate = self;
        [_locService startUserLocationService];
    }
    
    self.bmkSearch = [[BMKPoiSearch alloc] init];
}

- (void)initializationUI {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    _scrollView.backgroundColor = sCommonBGColor;
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = _scrollView.bounds.size;
    [self.contentView addSubview:_scrollView];
    
    UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vAdjustByScreenRatio(8.0f), 0.0f, 0.0f);
    self.startNavTextField = [[InsetsTextField alloc] initWithFrame:CGRectMake(0.0f, vAdjustByScreenRatio(20.0f),
                                                                               CGRectGetWidth(self.contentView.frame)*0.8f,
                                                                               vAdjustByScreenRatio(30.0f))
                                                         andEdgeInsetsValue:insetsValue];
    _startNavTextField.delegate = self;
    _startNavTextField.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0f, _startNavTextField.center.y);
    _startNavTextField.font = systemFontWithoutRatio(15.0f);
    _startNavTextField.returnKeyType = UIReturnKeyDone;
    _startNavTextField.borderStyle = UITextBorderStyleRoundedRect;
    _startNavTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _startNavTextField.placeholder = getLocalizationString(@"input_start_point");
    [_scrollView addSubview:_startNavTextField];
    
    CGRect endNavTFRect = _startNavTextField.frame;
    endNavTFRect.origin.y = CGRectGetMaxY(_startNavTextField.frame)+vAdjustByScreenRatio(13.0f);
    self.endNavTextField = [[InsetsTextField alloc] initWithFrame:endNavTFRect andEdgeInsetsValue:insetsValue];
    _endNavTextField.delegate = self;
    _endNavTextField.font = systemFontWithoutRatio(15.0f);
    _endNavTextField.returnKeyType = UIReturnKeyDone;
    _endNavTextField.borderStyle = UITextBorderStyleRoundedRect;
    _endNavTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _endNavTextField.placeholder = getLocalizationString(@"input_end_point");
    [_scrollView addSubview:_endNavTextField];
    
    CGRect searchBtnRect = _endNavTextField.frame;
    searchBtnRect.origin.y = CGRectGetMaxY(_endNavTextField.frame)+vAdjustByScreenRatio(13.0f);
    self.searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _searchButton.frame = searchBtnRect;
    _searchButton.layer.cornerRadius = 5.0f;
    _searchButton.layer.masksToBounds = YES;
    _searchButton.enabled = NO;
    [_searchButton setBorderWithColor:CDZColorOfBrown borderWidth:1.0f];
    [_searchButton setTitle:getLocalizationString(@"search") forState:UIControlStateNormal];
    [_searchButton setTitle:getLocalizationString(@"search") forState:UIControlStateDisabled];
    [_searchButton setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
    [_searchButton setTitleColor:CDZColorOfWhite forState:UIControlStateDisabled];
    [_searchButton setBackgroundImage:[ImageHandler createImageWithColor:[UIColor colorWithRed:0.992f green:0.620f blue:0.216f alpha:1.00f]
                                                                withRect:_searchButton.bounds] forState:UIControlStateNormal];
    [_searchButton setBackgroundImage:[ImageHandler createImageWithColor:CDZColorOfDeepGray
                                                                withRect:_searchButton.bounds] forState:UIControlStateDisabled];
    [_searchButton addTarget:self action:@selector(startDrivingNavigation) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_searchButton];
    
    
    self.searchAddressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,CGRectGetMaxY(_startNavTextField.frame),
                                                                                CGRectGetWidth(_scrollView.frame), 400.0f)];
    _searchAddressTableView.delegate = self;
    _searchAddressTableView.dataSource = self;
    _searchAddressTableView.scrollsToTop = YES;
    _searchAddressTableView.bounces = NO;
    _searchAddressTableView.alpha = 0.0f;
    [self.contentView addSubview:_searchAddressTableView];
    
}

- (void)startDrivingNavigation {
    NSURL *url = [NSURL URLWithString:@"baidumapsdk:"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        
        BMKNaviPara* para = [[BMKNaviPara alloc]init];
        //指定导航类型
        para.naviType = BMK_NAVI_TYPE_NATIVE;
        
        //初始化起点和终点节点
        BMKPlanNode* start = [[BMKPlanNode alloc]init];
        BMKPlanNode* end = [[BMKPlanNode alloc]init];
        
        //指定起点和终点经纬度
        start.pt = _startPointInfo.pt;
        end.pt = _endPointInfo.pt;
        //指定起点和终点名称
        start.name = _startPointInfo.name;
        end.name = _endPointInfo.name;
        //指定起点和终点
        para.startPoint = start;
        para.endPoint = end;
        
        //指定返回自定义scheme，具体定义方法请参考常见问题
        para.appScheme = @"baidumapsdk://mapsdk.baidu.com";
        //调启百度地图客户端导航
        [BMKNavigation openBaiduMapNavigation:para];

    }else {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您未安装百度地图，是否立即前往APPStore安装！" delegate:self cancelButtonTitle:@"稍后安装" otherButtonTitles:@"立即安装", nil];
        [alert.rac_buttonClickedSignal subscribeNext:^(NSNumber *buttonIndex) {
            if (buttonIndex.integerValue==1) {
                NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app/id%d",452186370];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
        }];
        [alert show];
    }
    
}

- (void)textFieldEditing:(id)sender {
    InsetsTextField *textField = nil;
    if (!sender) return;
    if ([sender isKindOfClass:[NSNotification class]]) textField = [(NSNotification *)sender object];
    if ([sender isKindOfClass:[InsetsTextField class]]) textField = sender;
    
    if (!textField.text||[textField.text isEqualToString:@""]){
        self.tmpAddressArray = @[];
        [_searchAddressTableView reloadData];
        if ([_startNavTextField isFirstResponder]) self.startPointInfo = nil;
        if ([_endNavTextField isFirstResponder]) self.endPointInfo = nil;
        return;
    }
    
    BMKCitySearchOption *searchOption = [[BMKCitySearchOption alloc] init];
    searchOption.keyword = textField.text;
    searchOption.city = @"长沙市";
    
    [_bmkSearch poiSearchInCity:searchOption];
}

#pragma mark- Keyboard Response Action
- (void)keyboardWillDisappear:(NSNotification *)notiObject {
    CGRect tableViewRect = _searchAddressTableView.frame;
    tableViewRect.size.height = CGRectGetHeight(_scrollView.frame)-CGRectGetMinY(tableViewRect);
    _searchAddressTableView.frame = tableViewRect;
}

- (void)keyboardWillAppear:(NSNotification *)notiObject {
    CGRect tableViewRect = _searchAddressTableView.frame;
    tableViewRect.size.height = CGRectGetHeight(_scrollView.frame)-CGRectGetMinY(tableViewRect);
    _searchAddressTableView.frame = tableViewRect;
}

- (void)keyboardDidAppear:(NSNotification *)notiObject {
    @autoreleasepool {
        CGFloat textFieldOffsetY = CGRectGetMaxY(_startNavTextField.frame);
        CGRect keyboardRect = [notiObject.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        CGRect tableViewRect = _searchAddressTableView.frame;
        CGFloat tableViewHeight = CGRectGetHeight(_scrollView.frame)-CGRectGetHeight(keyboardRect)-textFieldOffsetY;
        tableViewRect.size.height = tableViewHeight;
        _searchAddressTableView.frame = tableViewRect;
    }
}

- (void)showAccessoryTableView:(UITextField *)textField{
    CGFloat offSetY = CGRectGetMinY(textField.frame)-vAdjustByScreenRatio(13.0f);
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.searchAddressTableView.alpha = 1.0f;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, offSetY);
    }];
}

- (void)hideAccessoryTableView:(UITextField *)textField{
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.searchAddressTableView.alpha = 0.0f;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, 0.0f);
    }];
}

#pragma mark- BMKLocationServiceDelegate
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

#pragma mark- BMKPoiSearchDelegate
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    switch (errorCode) {
        case BMK_SEARCH_NO_ERROR:{
            if (poiResult.poiInfoList&&poiResult.poiInfoList.count!=0) {
                self.tmpAddressArray = poiResult.poiInfoList;
            }
            [_searchAddressTableView reloadData];
            
            NSIndexPath *indexPath = nil;
            if ([_startNavTextField isFirstResponder]&&_startPointInfo) {
                NSInteger row = [[NSSet setWithArray:_tmpAddressArray] containsObject:_startPointInfo];
                indexPath = [NSIndexPath indexPathForRow:row inSection:0];
                [_searchAddressTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
            }
            if ([_endNavTextField isFirstResponder]&&_endPointInfo) {
                NSInteger row = [[NSSet setWithArray:_tmpAddressArray] containsObject:_endPointInfo];
                indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            }
            if (indexPath) {
                [_searchAddressTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
            }
    }
            break;
            
        default:
            self.tmpAddressArray = @[];
            [_searchAddressTableView reloadData];
            break;
    }
}


#pragma mark- UIScrollViewDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self showAccessoryTableView:textField];
    [self textFieldEditing:textField];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [textField sendActionsForControlEvents:UIControlEventEditingChanged];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self hideAccessoryTableView:textField];
    [textField resignFirstResponder];
    return YES;
}


#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _tmpAddressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setBackgroundColor:CDZColorOfWhite];
        
        
        UILabel *label_txt = [UILabel new];
        label_txt.tag = 101;
        [cell addSubview:label_txt];
        
        UILabel *label_detail = [UILabel new];
        label_detail.tag = 102;
        [cell addSubview:label_detail];
        
        UIImageView* imgView = [UIImageView new];
        imgView.tag = 103;
        [cell addSubview:imgView];
    }
    
    BMKPoiInfo *poiInfo = _tmpAddressArray[indexPath.row];
    NSString* name = poiInfo.name;
    NSString* address = poiInfo.address;
    
    CGFloat width = self.view.frame.size.width;
    UILabel *label_txt = (UILabel *)[cell viewWithTag:101];
    label_txt.backgroundColor=[UIColor clearColor];
    label_txt.text = name ;
    label_txt.textColor=[UIColor blackColor];
    label_txt.frame = CGRectMake(42, 5, width-54, 20);
    
    UILabel *label_detail = (UILabel *)[cell viewWithTag:102];
    label_detail.font=[UIFont systemFontOfSize:11.5];
    label_detail.text = address ;
    label_detail.textColor=[UIColor lightGrayColor];
    label_detail.backgroundColor=[UIColor clearColor];
    CGSize size1 = [SupportingClass getStringSizeWithString: label_detail.text font:[UIFont systemFontOfSize:11.5] widthOfView:CGSizeMake(MAXFLOAT, 12)];
    if (size1.width > (width-54)) {
        label_detail.frame = CGRectMake(42, 26, width-54, 29);
        label_detail.font=[UIFont systemFontOfSize:11.5];
        label_detail.numberOfLines = 0;
        label_detail.lineBreakMode = NSLineBreakByWordWrapping;
    }else{
        label_detail.frame = CGRectMake(42, 28, width-54, 12);
    }
    
    UIImageView* imgView = (UIImageView *)[cell viewWithTag:103];
    imgView.frame = CGRectMake(8, 8, 28, 28);
    imgView.image=[UIImage imageNamed:@"ic_search.png"];
    [cell.contentView addSubview:imgView];
    [cell.contentView addSubview:label_txt];
    [cell.contentView addSubview:label_detail];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat rowHeight=44;
    if (_tmpAddressArray && _tmpAddressArray.count>0) {
        
        BMKPoiInfo* poi = [_tmpAddressArray objectAtIndex:indexPath.row];
        UIFont *font = [UIFont systemFontOfSize:11.5];
        CGSize size1 = [SupportingClass getStringSizeWithString:poi.address font:font widthOfView:CGSizeMake(MAXFLOAT, 22)];
        CGFloat width = self.view.frame.size.width-54;
        if (size1.width > width) {
            rowHeight = 60;
        }
    }
    return rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.0f;
}

- (CGFloat)tableiew:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_startNavTextField isFirstResponder]) {
        self.startPointInfo = _tmpAddressArray[indexPath.row];
        _startNavTextField.text = _startPointInfo.name;
    }
    if ([_endNavTextField isFirstResponder]) {
        self.endPointInfo = _tmpAddressArray[indexPath.row];
        _endNavTextField.text = _endPointInfo.name;
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
