//
//  SelfRepairVC.m
//  cdzer
//
//  Created by KEns0n on 3/18/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vDateStartFrom @"1990-01-01"
#define vLblTitleColor [UIColor colorWithRed:0.290f green:0.286f blue:0.271f alpha:1.00f]
#define vLblFont [UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)]

#import "SelfRepairVC.h"
#import "AutosSelectedView.h"
#import "SelfRepairResultVC.h"

@interface SelfRepairVC ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) AutosSelectedView *ASView;

@property (nonatomic, strong) UILabel *mileageLabel;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIPickerView *mileagePicker;

@property (nonatomic, strong) UIView *pickerContainerView;

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSString *lastSelectDate;

@property (nonatomic, strong) NSString *lastSelectMile;

@end

@implementation SelfRepairVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"self_repair")];
    [self initializationUI];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_ASView reloadUIData];
}
// private functions
- (void)nextStepToResultViewWithMaintanceData:(NSDictionary *)maintanceData {
    @autoreleasepool {
        if (!maintanceData) {
            NSLog(@"maintanceData is Missing");
            return;
        }
        [self hidePickerContainerView];
        SelfRepairResultVC *resultVC = [[SelfRepairResultVC alloc] init];
        [resultVC setMaintanceData:maintanceData];
        [self.navigationController pushViewController:resultVC animated:YES];
    }
}

- (void)pushAutoSelectionView {
    [self pushToAutoSelectionViewWithBackTitle:nil animated:YES onlyForSelection:NO];
}

// label value change
- (void)setMileageLblText {
//    if (_mileagePicker.hidden) {
//        for (int i = 0; i<6; i++) {
//            NSInteger row = [[_lastSelectMile substringWithRange:NSMakeRange(i, 1)] integerValue];
//            [_mileagePicker selectRow:row inComponent:i animated:NO];
//        }
//        return;
//    }
    @autoreleasepool {
        NSArray * array = @[@"0",@"1",@"2",
                            @"3",@"4",@"5",
                            @"6",@"7",@"8",
                            @"9",];
        NSString *mileageTxt = @"";
        NSString *tmpLastMile = @"";
        for (int i = 0; i<6; i++) {
            if ([_mileagePicker selectedRowInComponent:i] != 0 ) {
                NSInteger row = [_mileagePicker selectedRowInComponent:i];
                mileageTxt = [mileageTxt stringByAppendingString:array[row]];
            }else {
                if (![mileageTxt isEqualToString:@""]) {
                    NSInteger row = [_mileagePicker selectedRowInComponent:i];
                    mileageTxt = [mileageTxt stringByAppendingString:array[row]];
                }
            }
            
            tmpLastMile = [tmpLastMile stringByAppendingString:array[[_mileagePicker selectedRowInComponent:i]]];
        }
        if ([mileageTxt isEqualToString:@""]) {
            mileageTxt = @"0";
        }
        [self setLastSelectMile:tmpLastMile];
        [self mileageLabelVauleChange:mileageTxt];
    }
}

- (void)mileageLabelVauleChange:(NSString *)string {
    @autoreleasepool {
        NSMutableAttributedString *abString = [NSMutableAttributedString new];
        
        [abString appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:getLocalizationString(@"mileage_txt_prefix")
                                          attributes:@{NSForegroundColorAttributeName:vLblTitleColor,
                                                       NSFontAttributeName:vLblFont
                                                       }]];
        [abString appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:string
                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                       NSFontAttributeName:vLblFont
                                                       }]];
        [_mileageLabel setAttributedText:abString];
    }
}

- (void)datePickerVauleChangeResponseAction:(UIDatePicker *)datePicker {
//    if (datePicker.hidden) {
//        [datePicker setDate:[_dateFormatter dateFromString:_lastSelectDate]];
//        return;
//    }
    @autoreleasepool {
        NSMutableAttributedString *abString = [NSMutableAttributedString new];
        
        [abString appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:getLocalizationString(@"date_txt_prefix")
                                         attributes:@{NSForegroundColorAttributeName:vLblTitleColor,
                                                      NSFontAttributeName:vLblFont
                                                      }]];
        [abString appendAttributedString:[[NSAttributedString alloc]
                                         initWithString:[_dateFormatter stringFromDate:[datePicker date]]
                                         attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack,
                                                      NSFontAttributeName:vLblFont
                                                      }]];
        [_dateLabel setAttributedText:abString];
        [self setLastSelectDate:[_dateFormatter stringFromDate:[datePicker date]]];
    }
}

// picker code section
- (void)showPickerContainerViewShiftOffset:(CGFloat)offset {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect pickerConRect = self.pickerContainerView.frame;
        CGRect contentRect = self.contentView.frame;
        pickerConRect.origin.y = CGRectGetHeight(self.view.frame)-CGRectGetHeight(pickerConRect);
        contentRect.origin.y = -offset;
        [self.pickerContainerView setFrame:pickerConRect];
        [self.contentView setFrame:contentRect];
    }];
}

- (void)hidePickerContainerView {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect pickerConRect = self.pickerContainerView.frame;
        CGRect contentRect = self.contentView.frame;
        pickerConRect.origin.y = CGRectGetHeight(self.view.frame);
        contentRect.origin.y = 0.0f;
        [self.pickerContainerView setFrame:pickerConRect];
        [self.contentView setFrame:contentRect];
    } completion:^(BOOL finished) {
        [self.mileagePicker setHidden:YES];
        [self.datePicker setHidden:YES];
    }];
}

- (void)pickersActiveAction:(UIButton *)button {
    [_mileagePicker setHidden:YES];
    [_datePicker setHidden:YES];
    CGFloat offset = 0;
    switch (button.tag) {
        case 10:
            [_mileagePicker setHidden:NO];
            offset = vAdjustByScreenRatio(10.0f);
            break;
            
        case 11:
            [_datePicker setHidden:NO];
            offset = vAdjustByScreenRatio(20.0f);
            break;
            
        default:
            break;
    }
    [self showPickerContainerViewShiftOffset:offset];
}

// UIPickerViewDelegate & DataSourcDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 6;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return 3;
            break;
            
        default:
            return 10;
            break;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    @autoreleasepool {
        NSArray * array = @[@"0",@"1",@"2",
                            @"3",@"4",@"5",
                            @"6",@"7",@"8",
                            @"9",];
        return array[row];
    }
}

- (void)pickerTurnToZeroOutLimit:(UIPickerView *)pickerView {
    for (int i=1; i<6; i++) {
        [pickerView selectRow:0 inComponent:i animated:YES];
    }
    [self setMileageLblText];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    BOOL isSelectedC0R2 = (component==0 && row==2);
    BOOL currentSelectedIsC0R2 = ([pickerView selectedRowInComponent:0]==2);
    if (isSelectedC0R2||currentSelectedIsC0R2) {
        [self pickerTurnToZeroOutLimit:pickerView];
        return;
    }
    [self setMileageLblText];
}

// view init section
- (CGFloat)mileageAndDateViewInitWithLastYPostion {
    CGRect  mileageConRect = CGRectZero;
    mileageConRect.size = CGSizeMake(vAdjustByScreenRatio(188.0f), vAdjustByScreenRatio(30.0f));
    mileageConRect.origin.y = CGRectGetMaxY(_ASView.frame)+vAdjustByScreenRatio(vO2OSpaceSpace);
    mileageConRect.origin.x = vAdjustByScreenRatio(9.0f);
    UIView *mileageContainerView = [[UIView alloc] initWithFrame:mileageConRect];
    [mileageContainerView setBackgroundColor:CDZColorOfWhite];
    [mileageContainerView setBorderWithColor:[UIColor colorWithRed:0.886f green:0.878f blue:0.882f alpha:1.00f] borderWidth:1.0f];
    [self.contentView addSubview:mileageContainerView];
    
    
    
    CGRect mileageLabelRect = CGRectZero;
    mileageLabelRect.origin.x = vAdjustByScreenRatio(5.0f);
    mileageLabelRect.size.height = CGRectGetHeight(mileageConRect);
    mileageLabelRect.size.width = CGRectGetWidth(mileageConRect)-CGRectGetMinX(mileageLabelRect);
    self.mileageLabel = [[UILabel alloc] initWithFrame:mileageLabelRect];
    [_mileageLabel setBackgroundColor:CDZColorOfWhite];
    [_mileageLabel setTextAlignment:NSTextAlignmentLeft];
    [mileageContainerView addSubview:_mileageLabel];
    [self setLastSelectMile:@"000000"];
    [self mileageLabelVauleChange:@"0"];
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UILabel *kmLLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(mileageConRect)-CGRectGetHeight(mileageConRect),
                                                                  0.0f,
                                                                  CGRectGetHeight(mileageConRect),
                                                                  CGRectGetHeight(mileageConRect))];
    [kmLLabel setBackgroundColor:[UIColor colorWithRed:0.886f green:0.878f blue:0.882f alpha:1.00f]];
    [kmLLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(12.0f)]];
    [kmLLabel setTextAlignment:NSTextAlignmentCenter];
    [kmLLabel setTextColor:[UIColor colorWithRed:0.286f green:0.282f blue:0.267f alpha:1.00f]];
    [kmLLabel setText:@"KM"];
    [mileageContainerView addSubview:kmLLabel];
    
    UIButton *mileageActiveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [mileageActiveBtn setBackgroundColor:[UIColor clearColor]];
    [mileageActiveBtn setFrame:mileageContainerView.bounds];
    [mileageActiveBtn setTag:10];
    [mileageActiveBtn addTarget:self action:@selector(pickersActiveAction:) forControlEvents:UIControlEventTouchUpInside];
    [mileageContainerView addSubview:mileageActiveBtn];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    CGRect hintsLabelRect = mileageConRect;
    hintsLabelRect.origin.x = CGRectGetMaxX(mileageConRect)+vAdjustByScreenRatio(10.0f);
    hintsLabelRect.size.width = vAdjustByScreenRatio(100.0f);
    UILabel *hintsLabel = [[UILabel alloc] initWithFrame:hintsLabelRect];
    [hintsLabel setNumberOfLines:2];
    [hintsLabel setBackgroundColor:[UIColor clearColor]];
    [hintsLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(12.0f)]];
    [hintsLabel setTextAlignment:NSTextAlignmentLeft];
    [hintsLabel setTextColor:[UIColor colorWithRed:0.984f green:0.420f blue:0.133f alpha:1.00f]];
    [hintsLabel setText:getLocalizationString(@"km_label_hints")];
    [self.contentView addSubview:hintsLabel];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    CGRect  dateConRect = mileageConRect;
    dateConRect.origin.y = CGRectGetMaxY(mileageConRect)+vAdjustByScreenRatio(4.0f);
    UIView *dateContainerView = [[UIView alloc] initWithFrame:dateConRect];
    [dateContainerView setBackgroundColor:CDZColorOfWhite];
    [dateContainerView setBorderWithColor:[UIColor colorWithRed:0.886f green:0.878f blue:0.882f alpha:1.00f] borderWidth:1.0f];
    [self.contentView addSubview:dateContainerView];
    
    
    CGRect dateLabelRect = mileageLabelRect;
    self.dateLabel = [[UILabel alloc] initWithFrame:dateLabelRect];
    [_dateLabel setBackgroundColor:CDZColorOfWhite];
    [_dateLabel setTextAlignment:NSTextAlignmentLeft];
    [dateContainerView addSubview:_dateLabel];
    
    
    
    UIButton *dtActiveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [dtActiveBtn setBackgroundColor:[UIColor clearColor]];
    [dtActiveBtn setFrame:dateContainerView.bounds];
    [dtActiveBtn setTag:11];
    [dtActiveBtn addTarget:self action:@selector(pickersActiveAction:) forControlEvents:UIControlEventTouchUpInside];
    [dateContainerView addSubview:dtActiveBtn];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIButton *nextStepBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextStepBtn setBackgroundColor:CDZColorOfDefaultColor];
    [nextStepBtn setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
    [nextStepBtn setFrame:CGRectMake(CGRectGetMaxX(dateConRect)+vAdjustByScreenRatio(10.0f),
                                     CGRectGetMinY(dateConRect),
                                     vAdjustByScreenRatio(100.0f),
                                     CGRectGetHeight(dateConRect))];
    [nextStepBtn addTarget:self action:@selector(getSelfMaintenanceGetInfo) forControlEvents:UIControlEventTouchUpInside];
    [nextStepBtn setTitle:getLocalizationString(@"next_step") forState:UIControlStateNormal];
    [self.contentView addSubview:nextStepBtn];
    
    return CGRectGetMaxY(nextStepBtn.frame);
}

- (void)pickersViewInit {
    CGRect  pickerConRect = CGRectZero;
    pickerConRect.origin.y = CGRectGetHeight(self.view.frame);
    pickerConRect.size = CGSizeMake(CGRectGetWidth(self.contentView.frame), 260.0f);
    self.pickerContainerView = [[UIView alloc] initWithFrame:pickerConRect];
    [_pickerContainerView setBackgroundColor:CDZColorOfWhite];
    [self.view addSubview:_pickerContainerView];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    //    UIBarButtonItem *canecelItem = [[UIBarButtonItem alloc] initWithTitle:getLocalizationString(@"cancel"] style:UIBarButtonItemStylePlain target:self action:nil];
    //    canecelItem.tintColor = [UIColor grayColor];
    UIBarButtonItem *spacerItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc] initWithTitle:getLocalizationString(@"finish") style:UIBarButtonItemStylePlain target:self action:@selector(hidePickerContainerView)];
    finishItem.tintColor = CDZColorOfDefaultColor;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(pickerConRect), 40.0f)];
    [toolBar setBarTintColor:[UIColor colorWithRed:0.945f green:0.945f blue:0.937f alpha:1.00f]];
    [toolBar setItems:@[spacerItem,finishItem] animated:NO];
    [_pickerContainerView addSubview:toolBar];
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(toolBar.frame), 0.0f, 0.0f)];
    [_datePicker setBackgroundColor:CDZColorOfWhite];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_datePicker setDate:[_dateFormatter dateFromString:@"2000-01-01"]];
    [_datePicker setMaximumDate:[NSDate date]];
    [_datePicker setMinimumDate:[_dateFormatter dateFromString:vDateStartFrom]];
    [_datePicker setLocale:locale];
    [_datePicker addTarget:self action:@selector(datePickerVauleChangeResponseAction:) forControlEvents:UIControlEventValueChanged];
    [_pickerContainerView addSubview:_datePicker];
    [self setLastSelectDate:@"2000-01-01"];
    [self datePickerVauleChangeResponseAction:_datePicker];
    
    self.mileagePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(toolBar.frame), 0.0f, 0.0f)];
    [_mileagePicker setDataSource:self];
    [_mileagePicker setDelegate:self];
    [_pickerContainerView addSubview:_mileagePicker];
    
    
    [_datePicker setHidden:YES];
    [_mileagePicker setHidden:YES];
}

- (void)initializationUI {
    @autoreleasepool {
        
        CGFloat startPointY = vAdjustByScreenRatio(8.0f);
        CGRect alertIconRect = CGRectZero;
        alertIconRect.origin.y = startPointY;
        alertIconRect.origin.x = vAdjustByScreenRatio(15.0f);
        UIImage *alertIconImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches fileName:@"alert_icon" type:FMImageTypeOfPNG scaleWithPhone4:NO needToUpdate:NO];
        alertIconRect.size = alertIconImage.size;
        UIImageView *alertIconView = [[UIImageView alloc] initWithFrame:alertIconRect];
        [alertIconView setImage:alertIconImage];
        [self.contentView addSubview:alertIconView];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(alertIconRect)+vAdjustByScreenRatio(4.0f), startPointY, vAdjustByScreenRatio(266.0f), vAdjustByScreenRatio(30.0f))];
        [alertLabel setText:getLocalizationString(@"alert_description")];
        [alertLabel setNumberOfLines:2];
        [alertLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(12.0f)]];
        [self.contentView addSubview:alertLabel];
        
        
        self.ASView = [[AutosSelectedView alloc] initWithOrigin:CGPointMake(0.0f, CGRectGetMaxY(alertLabel.frame)+vAdjustByScreenRatio(vO2OSpaceSpace)) showMoreDeatil:NO onlyForSelection:NO];
        [self.contentView addSubview:_ASView];
        [_ASView addTarget:self action:@selector(pushAutoSelectionView) forControlEvents:UIControlEventTouchUpInside];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGFloat lastPostion = [self mileageAndDateViewInitWithLastYPostion];
        [self pickersViewInit];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//        CGFloat spaceWidth = (IS_IPHONE_4_OR_LESS?5.0f:vAdjustByScreenRatio(15.0f));
//        UIView *serviceConView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
//                                                                          lastPostion+spaceWidth,
//                                                                          CGRectGetWidth(self.contentView.frame),
//                                                                          CGRectGetHeight(self.contentView.frame)-(lastPostion+spaceWidth))];
//        [serviceConView setBackgroundColor:CDZColorOfWhite];
//        [serviceConView setBorderWithColor:[UIColor colorWithRed:0.886f green:0.878f blue:0.882f alpha:1.00f] borderWidth:1.0f];
//        [self.contentView addSubview:serviceConView];
//
//        CGFloat serDesX = vAdjustByScreenRatio(10.0f);
//        UILabel *serDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(serDesX,
//                                                                                 0.0f,
//                                                                                 CGRectGetWidth(self.contentView.frame)-serDesX*2.0f,
//                                                                                 vAdjustByScreenRatio(30.0f))];
//        [serDescriptionLabel setText:getLocalizationString(@"service_description")];
//        [serDescriptionLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)]];
//        [serviceConView addSubview:serDescriptionLabel];
//        
//        [self directServiceViewInitWithContainerView:serviceConView positionStartY:CGRectGetMaxY(serDescriptionLabel.frame)];
    }
}

- (void)directServiceViewInitWithContainerView:(UIView *)serviceConView positionStartY:(CGFloat)positionY {
    @autoreleasepool {
        
        CGFloat ncvPostionX = vAdjustByScreenRatio(10.0f);
        CGFloat spaceWidth = IS_IPHONE_4_OR_LESS?8.0f:vAdjustByScreenRatio(10.0f);
        CGFloat averageHeight = (CGRectGetHeight(serviceConView.frame)-positionY-spaceWidth*3.0f)/2;
        
        UIView *normalCheckView = [[UIView alloc] initWithFrame:CGRectMake(ncvPostionX,
                                                                           positionY+spaceWidth,
                                                                           CGRectGetWidth(serviceConView.frame)-ncvPostionX*2,
                                                                           averageHeight)];
        [normalCheckView setBackgroundColor:[UIColor colorWithRed:0.945f green:0.937f blue:0.941f alpha:1.00f]];
        [normalCheckView setBorderWithColor:[UIColor colorWithRed:0.886f green:0.878f blue:0.882f alpha:1.00f] borderWidth:1.0f];
        [normalCheckView.layer setCornerRadius:vAdjustByScreenRatio(5.0f)];
        [normalCheckView.layer setMasksToBounds:YES];
        [serviceConView addSubview:normalCheckView];
        
        
        UIView *depthCheckView = [[UIView alloc] initWithFrame:CGRectMake(ncvPostionX,
                                                                          CGRectGetMaxY(normalCheckView.frame)+spaceWidth,
                                                                          CGRectGetWidth(normalCheckView.frame),
                                                                          averageHeight)];
        [depthCheckView setBackgroundColor:[UIColor colorWithRed:0.945f green:0.937f blue:0.941f alpha:1.00f]];
        [depthCheckView setBorderWithColor:[UIColor colorWithRed:0.886f green:0.878f blue:0.882f alpha:1.00f] borderWidth:1.0f];
        [depthCheckView.layer setCornerRadius:vAdjustByScreenRatio(5.0f)];
        [depthCheckView.layer setMasksToBounds:YES];
        [serviceConView addSubview:depthCheckView];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        CGFloat btnsAverageWidth = CGRectGetWidth(normalCheckView.frame)/3;
        CGFloat btnsAverageHeight = averageHeight/3;
        
        NSArray *btnsSizeAndTitleList = @[@[@{@"width":@1,@"height":@2,
                                              @"row":@0,@"column":@0,
                                              @"title":@"normal_check"},
                                            
                                            @{@"width":@1,@"height":@1,
                                              @"row":@0,@"column":@1,
                                              @"title":@"minor_repair"},
                                            
                                            @{@"width":@1,@"height":@1,
                                              @"row":@0,@"column":@2,
                                              @"title":@"major_repair"},
                                            ////////////////////////////////////////////////////////////////////////////////////////////////
                                            @{@"width":@2,@"height":@1,
                                              @"row":@1,@"column":@1,
                                              @"title":@"replace_filter"},
                                            ////////////////////////////////////////////////////////////////////////////////////////////////
                                            @{@"width":@1,@"height":@1,
                                              @"row":@2,@"column":@0,@"title_size":@13,
                                              @"title":@"replace_refrigerant"},
                                            
                                            @{@"width":@2,@"height":@1,
                                              @"row":@2,@"column":@1,
                                              @"title":@"replace_wiper"}],
                                          
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                          
                                          @[@{@"width":@1,@"height":@2,
                                              @"row":@0,@"column":@0,
                                              @"title":@"d_check"},
                                            
                                            @{@"width":@1,@"height":@1,
                                              @"row":@0,@"column":@1,
                                              @"title":@"fuel_sys_check"},
                                            
                                            @{@"width":@1,@"height":@1,
                                              @"row":@0,@"column":@2,@"title_size":@13,
                                              @"title":@"engine_int_check"},
                                            ////////////////////////////////////////////////////////////////////////////////////////////////
                                            @{@"width":@2,@"height":@1,
                                              @"row":@1,@"column":@1,
                                              @"title":@"aircon_sys_check"},
                                            ////////////////////////////////////////////////////////////////////////////////////////////////
                                            @{@"width":@1,@"height":@1,
                                              @"row":@2,@"column":@0,@"title_size":@13,
                                              @"title":@"gear_sys_check"},
                                            
                                            @{@"width":@2,@"height":@1,
                                              @"row":@2,@"column":@1,
                                              @"title":@"coldwn_sys_check"}]];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        for (int i = 0; i<2; i++) {

            UIView *tmpView = normalCheckView;
            if (i==1) tmpView = depthCheckView;
            
            NSArray *tmpArray = btnsSizeAndTitleList[i];
            [tmpArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

                CGFloat btnsWidth = btnsAverageWidth*[[obj objectForKey:@"width"] floatValue];
                CGFloat btnsHeight = btnsAverageHeight*[[obj objectForKey:@"height"] floatValue];
                CGFloat currentRow = [[obj objectForKey:@"row"] floatValue];
                CGFloat currentColumn = [[obj objectForKey:@"column"] floatValue];
                CGFloat titleSize = 14.0f;
                if ([obj objectForKey:@"title_size"]) {
                    titleSize = [[obj objectForKey:@"title_size"] floatValue];
                }
                NSString *title = [getLocalizationString([obj objectForKey:@"title"])
                                   stringByReplacingOccurrencesOfString:@"\n"
                                   withString:@""];
                
                CGRect rect = CGRectZero;
                rect.size = CGSizeMake(btnsWidth, btnsHeight);
                rect.origin.x = btnsAverageWidth*currentColumn;
                rect.origin.y = btnsAverageHeight*currentRow;
                
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
                [btn setFrame:rect];
                [btn setTitle:title forState:UIControlStateNormal];
                [btn setTitleColor:CDZColorOfBlack forState:UIControlStateNormal];
                [btn setBorderWithColor:[UIColor colorWithRed:0.886f green:0.878f blue:0.882f alpha:1.00f] borderWidth:0.5f];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:vAdjustByScreenRatio(titleSize)]];
                [tmpView addSubview:btn];
            }];

        }
        
   
    }
    
}

#pragma mark- APIs Access Request
- (void)getSelfMaintenanceGetInfo {
    if (_lastSelectMile.integerValue<1) {
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:getLocalizationString(@"mile_alert_message") isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
        }];
        return;
    }
    [ProgressHUDHandler showHUD];
    NSString *autoModelID = _ASView.autoData.modelID.stringValue;
    [[APIsConnection shareConnection] theSelfMaintenanceAPIsGetMaintenanceInfoWithAutoModelID:autoModelID autoTotalMileage:_lastSelectMile purchaseDate:_lastSelectDate success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
        
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    
    if (error&&!responseObject) {
        NSLog(@"%@",error);
        [ProgressHUDHandler dismissHUD];
    }else if (!error&&responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        [ProgressHUDHandler dismissHUD];
        if (errorCode!=0) {
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                [ProgressHUDHandler dismissHUD];
            }];
            return;
        }
        NSMutableDictionary *maintanceData = [NSMutableDictionary dictionaryWithDictionary:responseObject];
        [maintanceData setObject:_lastSelectMile forKey:@"miles"];
        [self nextStepToResultViewWithMaintanceData:maintanceData];
    }
    
}

@end
