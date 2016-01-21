//
//  MyAutosInfoVC.m
//  cdzer
//
//  Created by KEns0n on 3/24/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define kNotSetIt getLocalizationString(@"not_define")
#define vStartSpace 15.0f
#import "MyAutosInfoVC.h"
#import "InsetsLabel.h"
#import "MyAutosInfoInputView.h"
#import "UserAutosInfoDTO.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIView+Borders/UIView+Borders.h>

@interface MyAutosInfoVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *autoDetailTV;

@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) UIImageView *autoPortraitImageView;

@property (nonatomic, strong) InsetsLabel *plateNumberLabel;

@property (nonatomic, strong) InsetsLabel *autoBrandLabel;

@property (nonatomic, strong) InsetsLabel *autoSeriesModelLabel;

@property (nonatomic, strong) NSMutableArray *myAutoViewStructureData, *myAutoHeaderViewStructureData;

@property (nonatomic, strong) NSMutableDictionary *autoData;

@property (nonatomic, strong) UIButton *selectAutosBtn;

@property (nonatomic, strong) MyAutosInfoInputView *maiiv;

@end

@implementation MyAutosInfoVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"my_autos")];
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_autoData.count==0) {
        [self getMyAutoData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setReactiveRules {
    RACSignal *autosDetailSignal = [RACObserve(self, myAutoHeaderViewStructureData) map:^id(NSArray *array) {
        BOOL dataIsReady = YES;
        NSString *string = [(NSArray *)[array valueForKey:@"value"] componentsJoinedByString:@","];
        if ([string rangeOfString:kNotSetIt].location!=NSNotFound) {
            dataIsReady = NO;
        }
        return @(dataIsReady);
    }];
    
    RACSignal *autosOtherDetailSignal = [RACObserve(self, myAutoViewStructureData) map:^id(NSArray *array) {
        BOOL dataIsReady = YES;
        NSString *string = [(NSArray *)[array valueForKey:@"value"] componentsJoinedByString:@","];
        if ([string rangeOfString:kNotSetIt].location!=NSNotFound) {
            dataIsReady = NO;
        }
        return @(dataIsReady);
    }];
    @weakify(self)
    [[RACSignal combineLatest:@[autosDetailSignal, autosOtherDetailSignal] reduce:^id(NSNumber *isReady1, NSNumber *isReady2){
        return @(isReady1.boolValue&&isReady2.boolValue);
    }] subscribeNext:^(NSNumber *isReady) {
        @strongify(self)
        self.navigationItem.rightBarButtonItem.enabled = isReady.boolValue;
    }];
}

- (void)componentSetting {
    @autoreleasepool {
//        "id": "15033110001028703339",
//        "car_number": "湘AUX927",
//        "brand_name": "奥迪",
//        "brand_img": "http://x.autoimg.cn/app/image/brand/33_3.png",
//        "factory_name": "一汽-大众奥迪",
//        "fct_name": "奥迪A4L",
//        "spec_name": "2015款 30 TFSI 手动舒适型",
//        "brandId": "33",
//        "factoryId": "36",
//        "fctId": "692",
//        "specId": "19485",
//        "imei": "21231004869",
//        "color": "红色",
//        "mileage": "666666",
//        "insure_time": "2015-07-23",
//        "annual_time": "2016-03-10",
//        "maintain_time": "",
//        "registr_time": "2015-03-16",
//        "frame_no": "",
//        "engine_code": "KML20323"
    

        self.autoData = [@{} mutableCopy];
        
        self.myAutoHeaderViewStructureData = [@[@{@"title":@"myautos_brand", @"value":kNotSetIt, @"valueKey":CDZAutosKeyOfBrandName,
                                                  @"valueID":@(-1), @"valueIDKey":@"brandId", @"valueIcon":@"", @"valueIconKey":@"brand_img",
                                                  @"inputType":@(MAIInputTypeOfAutosSelection), @"resultUpdateKey":MAIInputKeyFirstValue},
                                                @{@"title":@"myautos_dealership", @"value":kNotSetIt, @"valueKey":@"factory_name", @"valueID":@(-1), @"valueIDKey":@"factoryId",
                                                  @"inputType":@(MAIInputTypeOfAutosSelection), @"resultUpdateKey":MAIInputKeySecondValue},
                                                @{@"title":@"myautos_series", @"value":kNotSetIt, @"valueKey":@"fct_name", @"valueID":@(-1), @"valueIDKey":@"fctId",
                                                  @"inputType":@(MAIInputTypeOfAutosSelection), @"resultUpdateKey":MAIInputKeyThirdValue},
                                                @{@"title":@"myautos_model", @"value":kNotSetIt, @"valueKey":@"spec_name", @"valueID":@(-1), @"valueIDKey":@"specId",
                                                  @"inputType":@(MAIInputTypeOfAutosSelection), @"resultUpdateKey":MAIInputKeyFourthValue},
                                                ] mutableCopy];
        
        self.myAutoViewStructureData = [@[@{@"title":@"space",@"height":@(20.0f)},
                                          
                                          @{@"title":@"myautos_number", @"value":kNotSetIt, @"valueKey":@"car_number", @"canBeEdit":@(YES),
                                            @"inputType":@(MAIInputTypeOfLicensePlate)},
                                          
//                                          @{@"title":@"space",@"height":@(20.0f)},
//                                          
//                                          @{@"title":@"myautos_brand", @"value":kNotSetIt, @"valueKey":CDZAutosKeyOfBrandName, @"canBeEdit":@(YES)
//                                            ,@"inputType":@(MAIInputTypeOfAutosSelection)},
//                                          @{@"title":@"myautos_dealership", @"value":kNotSetIt, @"valueKey":@"factory_name", @"canBeEdit":@(YES),
//                                            @"inputType":@(MAIInputTypeOfAutosSelection)},
//                                          @{@"title":@"myautos_series", @"value":kNotSetIt, @"valueKey":@"fct_name", @"canBeEdit":@(YES),
//                                            @"inputType":@(MAIInputTypeOfAutosSelection)},
//                                          @{@"title":@"myautos_model", @"value":kNotSetIt, @"valueKey":@"spec_name", @"canBeEdit":@(YES),
//                                            @"inputType":@(MAIInputTypeOfAutosSelection)},
                                          @{@"title":@"myautos_color", @"value":kNotSetIt, @"valueKey":@"color", @"canBeEdit":@(YES),
                                            @"inputType":@(MAIInputTypeOfAutosBodyColor)},
                                          @{@"title":@"myautos_frame_no", @"value":kNotSetIt, @"valueKey":@"frame_no", @"canBeEdit":@(YES),
                                            @"inputType":@(MAIInputTypeOfAutosFrameNumber)},
                                          @{@"title":@"myautos_engine_code", @"value":kNotSetIt, @"valueKey":@"engine_code", @"canBeEdit":@(YES),
                                            @"inputType":@(MAIInputTypeOfAutosEngineNumber)},
                                          
                                          @{@"title":@"space",@"height":@(20.0f)},
                                          
                                          @{@"title":@"myautos_start_mile", @"value":kNotSetIt, @"valueKey":@"mileage", @"canBeEdit":@(YES),
                                           @"inputType":@(MAIInputTypeOfInitialMileage)},
//                                          @{@"title":@"myautos_insurance_num", @"value":kNotSetIt, @"valueKey":@"insure_number", @"canBeEdit":@(YES),
//                                         @"inputType":@(MAIInputTypeOfAutosInsuranceNumber)},
                                          @{@"title":@"myautos_insure_date", @"value":kNotSetIt, @"valueKey":@"insure_time", @"canBeEdit":@(YES),
                                           @"inputType":@(MAIInputTypeOfAutosInsuranceDate)},
                                          @{@"title":@"myautos_annual_date", @"value":kNotSetIt, @"valueKey":@"annual_time", @"canBeEdit":@(YES),
                                           @"inputType":@(MAIInputTypeOfAutosAnniversaryCheckDate)},
                                          @{@"title":@"myautos_maintenance_date", @"value":kNotSetIt, @"valueKey":@"maintain_time", @"canBeEdit":@(YES),
                                           @"inputType":@(MAIInputTypeOfAutosMaintenanceDate)},
                                          @{@"title":@"myautos_register_date", @"value":kNotSetIt, @"valueKey":@"registr_time", @"canBeEdit":@(YES),
                                            @"inputType":@(MAIInputTypeOfAutosRegisterDate)},
                                          ] mutableCopy];
        
        if (vGetUserType==CDZUserTypeOfGPSWithODBUser||vGetUserType==CDZUserTypeOfGPSUser) {
            [_myAutoViewStructureData insertObject:@{@"title":@"myautos_GPS", @"value":@"A007310100000010", @"valueKey":@"imei", @"canBeEdit":@(YES)} atIndex:2];
        }else {
            [self setRightNavButtonWithTitleOrImage:(@"ok") style:UIBarButtonItemStyleDone target:self action:@selector(updateAutosInfomation) titleColor:nil isNeedToSet:YES];
        }
        
        
        
    }
}

- (void)initializationUI {
    @autoreleasepool {
        
        self.autoDetailTV = [[UITableView alloc] initWithFrame:self.contentView.bounds];
        _autoDetailTV.backgroundColor = [UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f];
        _autoDetailTV.delegate = self;
        _autoDetailTV.dataSource = self;
        _autoDetailTV.bounces = NO;
        _autoDetailTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.contentView addSubview:_autoDetailTV];
        

        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(_autoDetailTV.frame), 40.0f)];
        [footerView addTopBorderWithHeight:1.0f andColor:[UIColor colorWithRed:0.847f green:0.843f blue:0.835f alpha:1.00f]];
        _autoDetailTV.tableFooterView = footerView;

        
        self.maiiv = [[MyAutosInfoInputView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_maiiv];
        
        @weakify(self)
        [_maiiv setMAICompletionBlock:^(MAIInputType type, NSDictionary *result) {
            if (type==MAIInputTypeOfNone) return;
            @strongify(self)
            if (type==MAIInputTypeOfAutosSelection) {
                NSMutableArray *headerArray = [self mutableArrayValueForKey:@"myAutoHeaderViewStructureData"];
                [self.myAutoHeaderViewStructureData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    NSMutableDictionary *data = [obj mutableCopy];
                    NSString *resultUpdateKey = obj[@"resultUpdateKey"];
                    
                    NSDictionary *resultData = result[resultUpdateKey];
                    NSString *title = resultData[@"title"];
                    NSString *theIDkey = resultData[@"keyID"];
                    [data setObject:title forKey:@"value"];
                    [data setObject:@(theIDkey.integerValue) forKey:@"valueID"];
                    if (resultData[@"icon"]&&obj[@"valueIcon"]) {
                        [data setObject:resultData[@"icon"] forKey:@"valueIcon"];
                        [self.autoData setObject:resultData[@"icon"] forKey:data[@"valueIconKey"]];
                    }
                    [headerArray replaceObjectAtIndex:idx withObject:data];
                    [self.autoData setObject:data[@"value"] forKey:data[@"valueKey"]];
                    [self.autoData setObject:data[@"valueID"] forKey:data[@"valueIDKey"]];
                }];
            }else {
                NSMutableArray *array = [self mutableArrayValueForKey:@"myAutoViewStructureData"];
                NSString *title = result[MAIInputKeyFirstValue];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.inputType == %d",type];
                NSMutableDictionary *detail = [[[array filteredArrayUsingPredicate:predicate] lastObject] mutableCopy];
                NSInteger idx = [self.myAutoViewStructureData indexOfObject:detail];
                [detail setObject:title forKey:@"value"];
                [array replaceObjectAtIndex:idx withObject:detail];
                [self.autoData setObject:detail[@"value"] forKey:detail[@"valueKey"]];
            }
            [self.autoDetailTV reloadData];
        }];
        
    }
}

#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
   
    return _myAutoViewStructureData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), 40.0f);
        cell.textLabel.text = @"";
        cell.textLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
        cell.detailTextLabel.text = @"";
        cell.detailTextLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor = CDZColorOfDefaultColor;
        [cell addTopBorderWithHeight:1.0 andColor:[UIColor colorWithRed:0.847f green:0.843f blue:0.835f alpha:1.00f]];
    }
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    NSDictionary *data = _myAutoViewStructureData[indexPath.row];
    NSString *title = data[@"title"];
    if ([title isEqualToString:@"space"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.contentView.backgroundColor = tableView.backgroundColor;
    }else {
        cell.textLabel.text = getLocalizationString(title);
        cell.detailTextLabel.text = data[@"value"];
        cell.accessoryType = (vGetUserType==CDZUserTypeOfGPSWithODBUser||vGetUserType==CDZUserTypeOfGPSUser)?UITableViewCellAccessoryNone:UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = CDZColorOfWhite;
    }
    
    // Configure the cell...

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = _myAutoViewStructureData[indexPath.row];
    NSString *string = data[@"title"];
    if ([string isEqualToString:@"space"]) {
        return [data[@"height"] floatValue];
    }
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 90.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *headerIdentifier = @"header";
    UITableViewCell *myHeader = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
    if(!myHeader) {
        myHeader = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headerIdentifier];
        
        if (!_headerView) {
            CGRect headerViewRect = _autoDetailTV.bounds;
            headerViewRect.size.height = 90.0f;
            self.headerView = [[UIView alloc] initWithFrame:headerViewRect];
            _headerView.backgroundColor = CDZColorOfWhite;
            [_headerView addTopBorderWithHeight:1.0f andColor:[UIColor colorWithRed:0.847f green:0.843f blue:0.835f alpha:1.00f]];
            [_headerView addBottomBorderWithHeight:0.5f andColor:[UIColor colorWithRed:0.847f green:0.843f blue:0.835f alpha:1.00f]];
            [myHeader.contentView addSubview:_headerView];
           
            
            UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vStartSpace, 0.0f, vStartSpace);
            CGFloat innerHeight = 80.0f;
            
            CGRect autoPortraitIVRect = _autoPortraitImageView.frame;
            autoPortraitIVRect.size = CGSizeMake(60.0f, 60.0f);
            autoPortraitIVRect.origin.x = insetsValue.left;
            autoPortraitIVRect.origin.y = (CGRectGetHeight(headerViewRect)-CGRectGetHeight(autoPortraitIVRect))/2.0f;
            
            self.autoPortraitImageView = [[UIImageView alloc] initWithFrame:autoPortraitIVRect];
            _autoPortraitImageView.image = [ImageHandler getDefaultWhiteLogo];
            [_headerView addSubview:_autoPortraitImageView];
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            CGRect autoBrandRect = CGRectZero;
            autoBrandRect.size = CGSizeMake(CGRectGetWidth(headerViewRect)-CGRectGetMaxX(autoPortraitIVRect), innerHeight*0.4);
            autoBrandRect.origin.x = CGRectGetMaxX(autoPortraitIVRect);
            autoBrandRect.origin.y = 5.0f;
            
            
            self.autoBrandLabel = [[InsetsLabel alloc] initWithFrame:autoBrandRect andEdgeInsetsValue:insetsValue];
            [_autoBrandLabel setText:kNotSetIt];
            [_autoBrandLabel setFont:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 18, NO)];
            [_headerView addSubview:_autoBrandLabel];
            
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            CGRect autoNumberRect = autoBrandRect;
            autoNumberRect.size.height = innerHeight*0.3;
            autoNumberRect.origin.y = CGRectGetMaxY(autoBrandRect);
            
            NSMutableAttributedString *autoSeriesString = [NSMutableAttributedString new];
            [autoSeriesString appendAttributedString:[[NSAttributedString alloc]
                                                           initWithString:@"车系："
                                                           attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.420f green:0.420f blue:0.420f alpha:1.00f]
                                                                        }]];
            [autoSeriesString appendAttributedString:[[NSAttributedString alloc]
                                                           initWithString:kNotSetIt
                                                           attributes:@{NSForegroundColorAttributeName:CDZColorOfDefaultColor
                                                                        }]];
            
            self.plateNumberLabel = [[InsetsLabel alloc] initWithFrame:autoNumberRect andEdgeInsetsValue:insetsValue];
            [_plateNumberLabel setAttributedText:autoSeriesString];
            [_plateNumberLabel setFont:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 13, NO)];
            [_headerView addSubview:_plateNumberLabel];
            
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            CGRect autoSeriesModelRect = autoNumberRect;
            autoSeriesModelRect.origin.y = CGRectGetMaxY(autoNumberRect);
            
            NSMutableAttributedString *autoModelString = [NSMutableAttributedString new];
            [autoModelString appendAttributedString:[[NSAttributedString alloc]
                                                           initWithString:@"车型："
                                                           attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.420f green:0.420f blue:0.420f alpha:1.00f]
                                                                        }]];
            [autoModelString appendAttributedString:[[NSAttributedString alloc]
                                                           initWithString:kNotSetIt
                                                           attributes:@{NSForegroundColorAttributeName:CDZColorOfDefaultColor
                                                                        }]];
            
            self.autoSeriesModelLabel = [[InsetsLabel alloc] initWithFrame:autoSeriesModelRect andEdgeInsetsValue:insetsValue];
            [_autoSeriesModelLabel setAttributedText:autoModelString];
            [_autoSeriesModelLabel setFont:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 13, NO)];
            [_headerView addSubview:_autoSeriesModelLabel];
            if (UserBehaviorHandler.shareInstance.getUserType==CDZUserTypeOfNormalUser) {
                self.selectAutosBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                _selectAutosBtn.frame = _headerView.bounds;
                [_selectAutosBtn addTarget:self action:@selector(actionForAutosEdit) forControlEvents:UIControlEventTouchUpInside];
                [_headerView addSubview:_selectAutosBtn];
            }
        }else {
            [myHeader addSubview:_headerView];
        }
    }
    myHeader.accessoryType = UITableViewCellAccessoryNone;
    if (UserBehaviorHandler.shareInstance.getUserType==CDZUserTypeOfNormalUser) {
        myHeader.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (_autoData) {
        NSString *brandString = [_myAutoHeaderViewStructureData[0] objectForKey:@"value"];
        if ([brandString isEqualToString:@""]) {
            brandString = kNotSetIt;
        }
        NSString *dealershipString = [_myAutoHeaderViewStructureData[1] objectForKey:@"value"];
        if ([dealershipString isEqualToString:@""]) {
            dealershipString = kNotSetIt;
        }
        
        NSString *autosSeriesString = [_myAutoHeaderViewStructureData[2] objectForKey:@"value"];
        if ([autosSeriesString isEqualToString:@""]) {
            autosSeriesString = kNotSetIt;
        }
        
        NSString *autosModelString = [_myAutoHeaderViewStructureData[3] objectForKey:@"value"];
        if ([autosModelString isEqualToString:@""]) {
            autosModelString = kNotSetIt;
        }
        
        _autoBrandLabel.text = [NSString stringWithFormat:@"%@ - %@", brandString, dealershipString];
        if ([brandString isEqualToString:kNotSetIt] || [dealershipString isEqualToString:kNotSetIt]) {
            _autoBrandLabel.text = kNotSetIt;
        }
        
        NSMutableAttributedString *autosSeriesAttributedString = [NSMutableAttributedString new];
        [autosSeriesAttributedString appendAttributedString:[[NSAttributedString alloc]
                                                           initWithString:@"车系："
                                                           attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.420f green:0.420f blue:0.420f alpha:1.00f]
                                                                        }]];
        [autosSeriesAttributedString appendAttributedString:[[NSAttributedString alloc]
                                                           initWithString:autosSeriesString
                                                           attributes:@{NSForegroundColorAttributeName:CDZColorOfDefaultColor
                                                                        }]];
        _plateNumberLabel.attributedText = autosSeriesAttributedString;
        
        
        
        NSMutableAttributedString *autoModelAttributedString = [NSMutableAttributedString new];
        [autoModelAttributedString appendAttributedString:[[NSAttributedString alloc]
                                                       initWithString:@"车型："
                                                       attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.420f green:0.420f blue:0.420f alpha:1.00f]
                                                                    }]];
        [autoModelAttributedString appendAttributedString:[[NSAttributedString alloc]
                                                       initWithString:autosModelString
                                                       attributes:@{NSForegroundColorAttributeName:CDZColorOfDefaultColor
                                                                    }]];
        _autoSeriesModelLabel.attributedText = autoModelAttributedString;
        
        NSString *imgURL = [_myAutoHeaderViewStructureData[0] objectForKey:@"valueIcon"];
        if (imgURL&&![imgURL isEqualToString:@""]&&[imgURL rangeOfString:@"http"].location!=NSNotFound) {
            [_autoPortraitImageView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[ImageHandler getDefaultWhiteLogo]];
        }
    }
    
    return myHeader;

}

- (void)actionForAutosEdit {
    @autoreleasepool {
        MAIInputType inputType = MAIInputTypeOfAutosSelection;
        NSArray *valueList = [_myAutoHeaderViewStructureData valueForKey:@"valueID"];
        NSString *originalValue = [valueList componentsJoinedByString:@","];
        _maiiv.userAutosID = _autoData[@"id"];
        [_maiiv setInputType:inputType withOriginalValue:originalValue];
        [_maiiv showView];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath:::%@",indexPath);
    NSLog(@"%d",vGetUserType);
    if (vGetUserType==CDZUserTypeOfNormalUser&&[_myAutoViewStructureData[indexPath.row] objectForKey:@"inputType"]) {
        [self actionForActiveEditInfo:indexPath];
    }
}

- (void)actionForActiveEditInfo:(NSIndexPath *)indexPath {
    @autoreleasepool {
        NSDictionary *settingDetail = _myAutoViewStructureData[indexPath.row];
        MAIInputType inputType = [settingDetail[@"inputType"] integerValue];
        NSString *originalValue = settingDetail[@"value"];
        if ([originalValue isEqualToString:kNotSetIt]) {
            originalValue = @"";
        }
        _maiiv.userAutosID = _autoData[@"id"];
        [_maiiv setInputType:inputType withOriginalValue:originalValue];
        [_maiiv showView];
    }
}
/*
 #pragma mark- Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark- Data Receive Handle
- (void)updateViewData {
    @autoreleasepool {
        
        NSMutableArray *array = [self mutableArrayValueForKey:@"myAutoViewStructureData"];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSString *title = obj[@"title"];
            if (![title isEqualToString:@"space"]) {
                NSMutableDictionary *data = [obj mutableCopy];
                NSString *key = obj[@"valueKey"];
                id object = self.autoData[key];
                if (object) {
                    NSString *string = @"";
                    if ([object isKindOfClass:[NSNumber class]]) {
                        string  = [(NSNumber *)object stringValue];
                    }
                    if ([object isKindOfClass:[NSString class]]) {
                        string  = object;
                    }
                    if ([string isEqualToString:@""]) {
                        [data setObject:kNotSetIt forKey:@"value"];
                    }else {
                        [data setObject:string forKey:@"value"];
                    }
                }else{
                    [data setObject:kNotSetIt forKey:@"value"];
                }
                [array replaceObjectAtIndex:idx withObject:data];
            }
        }];
        
        NSMutableArray *headerArray = [self mutableArrayValueForKey:@"myAutoHeaderViewStructureData"];
        [headerArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSMutableDictionary *data = [obj mutableCopy];
            NSString *key = obj[@"valueKey"];
            id object = self.autoData[key];
            if (object) {
                NSString *string = @"";
                if ([object isKindOfClass:[NSNumber class]]) {
                    string  = [(NSNumber *)object stringValue];
                }
                if ([object isKindOfClass:[NSString class]]) {
                    string  = object;
                }
                if ([string isEqualToString:@""]) {
                    [data setObject:kNotSetIt forKey:@"value"];
                }else {
                    [data setObject:string forKey:@"value"];
                }
            }else{
                [data setObject:kNotSetIt forKey:@"value"];
            }
            
            
            NSString *theIDKey = obj[@"valueIDKey"];
            NSString *numString = self.autoData[theIDKey];
            if (numString) {
                if ([numString isEqualToString:@""]) {
                    [data setObject:@(-1) forKey:@"valueID"];
                }else {
                    [data setObject:@(numString.integerValue) forKey:@"valueID"];
                }
            }else{
                [data setObject:@(-1) forKey:@"valueID"];
            }
            
            if ([obj objectForKey:@"valueIconKey"]) {
                NSString *iconKey = obj[@"valueIconKey"];
                NSString *iconURL = self.autoData[iconKey];
                [data setObject:iconURL forKey:@"valueIcon"];
            }
            
            
            
            [headerArray replaceObjectAtIndex:idx withObject:data];
            
        }];
        [_autoDetailTV reloadData];
        NSString *theIDs = [(NSArray *)[_myAutoHeaderViewStructureData valueForKey:@"valueID"] componentsJoinedByString:@","];
        if ([theIDs rangeOfString:@"-1"].location==NSNotFound) {
            [_maiiv initAutoDataAndSelect:theIDs];
        }
        [ProgressHUDHandler dismissHUD];
    }
}

#pragma mark- API Access Code Section
- (void)getMyAutoData {
    if (!self.accessToken) {
        return;
    }
    @weakify(self)
    [ProgressHUDHandler showHUDWithTitle:getLocalizationString(@"loading") onView:nil];
    [[APIsConnection shareConnection] personalCenterAPIsGetMyAutoListWithAccessToken:self.accessToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return;
        }
        @strongify(self)
        [self.autoData removeAllObjects];
        [self.autoData addEntriesFromDictionary:responseObject[CDZKeyOfResultKey]];
        [self updateViewData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }];
    
}

- (void)updateAutosInfomation {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUDWithTitle:@"更新资料中...." onView:nil];
    __block NSString *userAutosID = _autoData[@"id"];
    __block NSString *licensePlate = @"";
    __block NSString *bodyColor = @"";
    __block NSString *frameNumber = @"";
    __block NSString *engineNumber = @"";
    __block NSString *initialMileage = @"";
    __block NSString *insuranceNumber = nil;
    __block NSString *insuranceDate = @"";
    __block NSString *anniversaryCheckDate = @"";
    __block NSString *maintenanceDate = @"";
    __block NSString *registerDate = @"";
    [_myAutoViewStructureData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj[@"inputType"]) {
            MAIInputType inputType = [obj[@"inputType"] integerValue];
            NSString *value = obj[@"value"];
            switch (inputType) {
                case MAIInputTypeOfLicensePlate:
                    licensePlate = value;
                    break;
                case MAIInputTypeOfAutosBodyColor:
                    bodyColor = value;
                    break;
                case MAIInputTypeOfAutosFrameNumber:
                    frameNumber = value;
                    break;
                case MAIInputTypeOfAutosEngineNumber:
                    engineNumber = value;
                    break;
                case MAIInputTypeOfInitialMileage:
                    initialMileage = value;
                    break;
                case MAIInputTypeOfAutosInsuranceDate:
                    insuranceDate = value;
                    break;
                case MAIInputTypeOfAutosAnniversaryCheckDate:
                    anniversaryCheckDate = value;
                    break;
                case MAIInputTypeOfAutosMaintenanceDate:
                    maintenanceDate = value;
                    break;
                case MAIInputTypeOfAutosRegisterDate:
                    registerDate = value;
                    break;
                    
                default:
                    break;
            }
            
        }
    }];
    
    NSString *brandID = @"";
    NSString *dealershipID = @"";
    NSString *seriesID = @"";
    NSString *modelID = @"";
    NSString *checkSelectedIdx = [[_myAutoHeaderViewStructureData valueForKey:@"valueID"] componentsJoinedByString:@","];
    if ([checkSelectedIdx rangeOfString:@"-1"].location==NSNotFound) {
        brandID = [_myAutoHeaderViewStructureData[0] objectForKey:@"valueID"];
        dealershipID = [_myAutoHeaderViewStructureData[1] objectForKey:@"valueID"];
        seriesID = [_myAutoHeaderViewStructureData[2] objectForKey:@"valueID"];
        modelID = [_myAutoHeaderViewStructureData[3] objectForKey:@"valueID"];
    }
    
    //    @weakify(self)
    [[APIsConnection shareConnection] personalCenterAPIsPatchMyAutoWithAccessToken:self.accessToken myAutoID:userAutosID myAutoNumber:licensePlate myAutoBodyColor:bodyColor myAutoMileage:initialMileage myAutoFrameNum:frameNumber myAutoEngineNum:engineNumber insuranceDate:insuranceDate annualCheckDate:anniversaryCheckDate maintenanceDate:maintenanceDate registrDate:registerDate brandID:brandID brandDealershipID:dealershipID seriesID:seriesID modelID:modelID insuranceNum:insuranceNumber success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return;
        }
        
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
            UserAutosInfoDTO *dto = [UserAutosInfoDTO new];
            [dto processDataToObject:self.autoData optionWithUID:UserBehaviorHandler.shareInstance.getUserID];
            NSLog(@"%@", dto);
            NSLog(@"success update user autos detail data::::::%d", [DBHandler.shareInstance updateUserAutosDetailData:dto.processObjectToDBData]);
            if (self.wasBackRootView) {
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        NSLog(@"%@",error.domain);
        [SupportingClass showAlertViewWithTitle:@"error" message:@"不明错误" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
    }];
    
}

@end
