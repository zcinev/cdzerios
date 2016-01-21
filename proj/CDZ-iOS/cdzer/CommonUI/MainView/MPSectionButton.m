//
//  MPSectionButton.m
//  cdzer
//
//  Created by KEns0n on 2/27/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinSpace 4.0f
#define vMinContainerWidth 320.0f
#define vMinContainerHeight 247.0

#import "MPSectionButton.h"

@interface MPSectionButton (){
    CGFloat _minBottomBtnsHeight;
}

@property (nonatomic, assign) CGSize containerSize;

@property (nonatomic, strong) NSDictionary *btnConfig;

@property (nonatomic, strong) UILabel *btnTitleLabel;

@property (nonatomic, strong) UILabel *btnSubTitleLabel;

@property (nonatomic, strong) UIImageView *btnImageView;

@property (nonatomic, assign) CGFloat ratio;

@property (nonatomic, assign) CGFloat ratioForPhone4;

@end


@implementation MPSectionButton

static NSString * const kMPSButtonColor = @"kMPSButtonColor";
static NSString * const kMPSButtonRect = @"kMPSButtonRect";
static NSString * const kMPSButtonTitile = @"kMPSButtonTitile";
static NSString * const kMPSButtonSubTitile = @"kMPSButtonSubTitile";

#pragma -mark Button Config Section
- (UIColor *)buttonColorByType:(MPSButtonType)buttonType{
    UIColor *color = nil;
    switch (buttonType) {
        case MPSButtonTypeOfGPS:
            color = [UIColor colorWithRed:0.973f green:0.353f blue:0.322f alpha:1.00f];
            break;
        case MPSButtonTypeOfRepair:
            color = [UIColor colorWithRed:0.129f green:0.694f blue:0.988f alpha:1.00f];
            break;
        case MPSButtonTypeOfParts:
            color = [UIColor colorWithRed:0.118f green:0.671f blue:0.886f alpha:1.00f];
            break;
        case MPSButtonTypeOfVehicleManagement:
            color = [UIColor colorWithRed:0.992f green:0.604f blue:0.235f alpha:1.00f];
            break;
        case MPSButtonTypeOfTrafficViolation:
            color = [UIColor colorWithRed:0.133f green:0.776f blue:0.812f alpha:1.00f];
            break;
        case MPSButtonTypeOfUsedCars:
        case MPSButtonTypeOfGPSAppiontment:
            color = [UIColor colorWithRed:0.141f green:0.851f blue:0.157f alpha:1.00f];
            break;
        case MPSButtonTypeOfMessageHistory:
        case MPSButtonTypeOfCS:
            color = [UIColor colorWithRed:0.941f green:0.765f blue:0.188f alpha:1.00f];
            break;
        default:
            color = CDZColorOfWhite;
            break;
    }
    
    return color;
}

- (NSString *)buttonImageStringByType:(MPSButtonType)buttonType{
    NSString *fileName = nil;
    switch (buttonType) {
        case MPSButtonTypeOfGPS:
            fileName = @"GPS";
            break;
        case MPSButtonTypeOfRepair:
            fileName = @"maintenance";
            break;
        case MPSButtonTypeOfParts:
            fileName = @"auto_parts";
            break;
        case MPSButtonTypeOfUsedCars:
            fileName = @"used_car";
            break;
        case MPSButtonTypeOfTrafficViolation:
            fileName = @"illegal";
            break;
        case MPSButtonTypeOfVehicleManagement:
            fileName = @"management";
            break;
        default:
            fileName = nil;
            break;
    }
    
    return fileName;
}

- (NSString *)buttonTitleByType:(MPSButtonType)buttonType{
    NSString *stringKey = nil;
    switch (buttonType) {
        case MPSButtonTypeOfGPS:
            stringKey = @"SBT-GPS";
            break;
        case MPSButtonTypeOfRepair:
            stringKey = @"SBT-Repair";
            break;
        case MPSButtonTypeOfParts:
            stringKey = @"SBT-Parts";
            break;
        case MPSButtonTypeOfUsedCars:
            stringKey = @"SBT-UsedCars";
            break;
        case MPSButtonTypeOfTrafficViolation:
            stringKey = @"SBT-Violation";
            break;
        case MPSButtonTypeOfVehicleManagement:
            stringKey = @"SBT-Management";
            break;
        case MPSButtonTypeOfGPSAppiontment:
            stringKey = @"SBT-GPSAppointment";
            break;
        case MPSButtonTypeOfMessageHistory:
            stringKey = @"SBT-Message";
            break;
        case MPSButtonTypeOfCS:
            stringKey = @"SBT-CS";
            break;
        default:
            stringKey = nil;
            break;
    }
    
    return getLocalizationString(stringKey);
}

- (NSString *)buttonSubTitleByType:(MPSButtonType)buttonType{
    NSString *stringKey = nil;
    switch (buttonType) {
        case MPSButtonTypeOfGPS:
            stringKey = @"SBST-GPS";
            break;
        case MPSButtonTypeOfRepair:
            stringKey = (IS_IPHONE_5_ABOVE)?@"SBST-Repair":@"SBST-RepairB4";
            break;
        case MPSButtonTypeOfVehicleManagement:
            stringKey = @"SBST-Management";
            break;
        default:
            stringKey = nil;
            break;
    }
    
    return getLocalizationString(stringKey);
}

- (CGRect)buttonRectByType:(MPSButtonType)buttonType{
    CGRect rect = CGRectZero;
    CGFloat scaleSpace = vMinSpace * _ratio;
    CGFloat averageWidth = (_containerSize.width-scaleSpace*2)/3;
    CGFloat averageHeigth = (_containerSize.height-scaleSpace*5-_minBottomBtnsHeight)/3;
    switch (buttonType) {
        case MPSButtonTypeOfGPS:
            rect = CGRectMake(0.0f,
                              scaleSpace,
                              averageWidth*2+scaleSpace,
                              averageHeigth);            
            break;
        case MPSButtonTypeOfRepair:
            rect = CGRectMake((averageWidth+scaleSpace)*2,
                              scaleSpace,
                              averageWidth,
                              averageHeigth);
            
            break;
        case MPSButtonTypeOfParts:
            rect = CGRectMake(0.0f,
                              scaleSpace*2+averageHeigth,
                              averageWidth,
                              averageHeigth*2+scaleSpace);
            
            break;
        case MPSButtonTypeOfUsedCars:
            rect = CGRectMake(averageWidth+scaleSpace,
                              scaleSpace*2+averageHeigth,
                              averageWidth,
                              averageHeigth);
            
            break;
        case MPSButtonTypeOfTrafficViolation:
            rect = CGRectMake((averageWidth+scaleSpace)*2,
                              scaleSpace*2+averageHeigth,
                              averageWidth,
                              averageHeigth);
            
            break;
        case MPSButtonTypeOfVehicleManagement:
            rect = CGRectMake(averageWidth+scaleSpace,
                              scaleSpace*3+averageHeigth*2,
                              averageWidth*2+scaleSpace,
                              averageHeigth);
            
            break;
        case MPSButtonTypeOfGPSAppiontment:
            rect = CGRectMake(0.0f,
                              _containerSize.height-_minBottomBtnsHeight-scaleSpace,
                              averageWidth,
                              _minBottomBtnsHeight);
            break;
        case MPSButtonTypeOfMessageHistory:
            rect = CGRectMake(averageWidth+scaleSpace,
                              _containerSize.height-_minBottomBtnsHeight-scaleSpace,
                              averageWidth,
                              _minBottomBtnsHeight);
            break;
        case MPSButtonTypeOfCS:
            rect = CGRectMake((averageWidth+scaleSpace)*2,
                              _containerSize.height-_minBottomBtnsHeight-scaleSpace,
                              averageWidth,
                              _minBottomBtnsHeight);
            break;
        default:
            rect = CGRectZero;
            break;
    }
    
    return rect;
}

- (CGRect)buttonTitleRectByType:(MPSButtonType)buttonType{
    CGFloat widthOfSelf = CGRectGetWidth(self.frame);
    
    CGFloat newX = 0.0f;
    CGFloat newY = 0.0f;
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    
    switch (buttonType) {
        case MPSButtonTypeOfGPS:
            newX = 14.0f*_ratio*_ratioForPhone4;
            newY = 18.0f*_ratio*_ratioForPhone4;
            newWidth = widthOfSelf-newX;
            newHeight = 34.0f*_ratio;
            break;
        case MPSButtonTypeOfRepair:
            newX = 7.0f*_ratio;
            newWidth = widthOfSelf-newX;
            newHeight = 34.0f*_ratio;
            break;
        case MPSButtonTypeOfTrafficViolation:
            newX = 7.0f*_ratio;
            newWidth = widthOfSelf-newX;
            newHeight = 34.0f*_ratio;
            newY = (CGRectGetHeight(self.frame)-newHeight-20.0f*_ratio)/2.0f;
            
            break;
        case MPSButtonTypeOfVehicleManagement:
            newX = 14.0f*_ratio;
            newWidth = widthOfSelf-newX;
            
            newHeight = 34.0f*_ratio;
            newY = CGRectGetHeight(self.frame)-newHeight-20.0f*_ratio;
            
            break;
        default:
            break;
    }
    
    return CGRectMake(newX,
                      newY,
                      newWidth,
                      newHeight);
}

- (CGRect)buttonSubTitleRectByType:(MPSButtonType)buttonType{
    CGFloat widthOfSelf = CGRectGetWidth(self.frame);
    
    CGFloat newX = 0.0f;
    CGFloat newY = 0.0f;
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    switch (buttonType) {
        case MPSButtonTypeOfGPS:
            newX = 14.0f*_ratio*_ratioForPhone4;
            newY = 36.0f*_ratio*_ratioForPhone4;
            newWidth = widthOfSelf-newX;
            newHeight = 34.0f*_ratio;
            break;
        case MPSButtonTypeOfRepair:
            newX = 7.0f*_ratio;
            newY = 16.0f*_ratio;
            newWidth = widthOfSelf-newX;
            newHeight = 40.0f*_ratio;
            break;
        case MPSButtonTypeOfVehicleManagement:
            newX = 14.0f*_ratio;
            newWidth = widthOfSelf-newX;
            
            newHeight = 40.0f*_ratio;
            newY = CGRectGetHeight(self.frame)-newHeight;
            break;
        default:
            break;
    }
    
    return CGRectMake(newX,
                      newY,
                      newWidth,
                      newHeight);
}

- (CGRect)buttonIVRectByType:(MPSButtonType)buttonType{
    
    CGFloat widthOfSelf = CGRectGetWidth(self.frame);
    CGFloat heightOfSelf = CGRectGetHeight(self.frame);
    
    CGFloat newX = 0.0f;
    CGFloat newY = 0.0f;
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    switch (buttonType) {
        case MPSButtonTypeOfGPS:
            
            newHeight = 66.0f*_ratio*_ratioForPhone4;
            newWidth = 50.0f*_ratio*_ratioForPhone4;
            newX = widthOfSelf-newWidth-(10.0f*_ratio*_ratioForPhone4);
            newY = (heightOfSelf-newHeight)/2.0f;
            break;
        case MPSButtonTypeOfRepair:
            newWidth = 44.0f*_ratio*_ratioForPhone4;
            newHeight = 49.0f*_ratio*_ratioForPhone4;
            newX = widthOfSelf-newWidth;
            newY = heightOfSelf-newHeight;
            break;
        case MPSButtonTypeOfParts:
            newWidth = 60.0f*_ratio*_ratioForPhone4;
            newHeight = 64.0f*_ratio*_ratioForPhone4;
            newX = widthOfSelf-newWidth;
            newY = heightOfSelf-newHeight;
            break;
        case MPSButtonTypeOfUsedCars:
            newWidth = 30.0f*_ratio*_ratioForPhone4;
            newHeight = 33.0f*_ratio*_ratioForPhone4;
            newX = widthOfSelf-newWidth;
            newY = heightOfSelf-newHeight;
            break;
        case MPSButtonTypeOfTrafficViolation:
            newWidth = 28.0f*_ratio*_ratioForPhone4;
            newHeight = 45.0f*_ratio*_ratioForPhone4;
            newX = widthOfSelf-newWidth;
            newY = heightOfSelf-newHeight;            
            break;
        case MPSButtonTypeOfVehicleManagement:
            newWidth = 55.0f*_ratio*_ratioForPhone4;
            newHeight = 57.0f*_ratio*_ratioForPhone4;
            newX = widthOfSelf-newWidth-(15.0f*_ratio*_ratioForPhone4);
            newY = (heightOfSelf-newHeight)/2.0f+(IS_IPHONE_5_ABOVE?(10.0f*_ratio):0.0f);
            break;
        default:
            break;
    }
    
    return  CGRectMake(newX,
                       newY,
                       newWidth,
                       newHeight);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setContainerSize:(CGSize)containerSize{
    _containerSize = containerSize;
    if (containerSize.width<vMinContainerWidth) {
        _containerSize.width = vMinContainerWidth;
    }
    if (containerSize.height<vMinContainerHeight) {
        _containerSize.height = vMinContainerHeight;
    }
}

- (instancetype)initWithButtonType:(MPSButtonType)type ContainerSize:(CGSize)size{
    _buttonType = type;
    _containerSize = size;
    if (IS_IPHONE_5_ABOVE) {
        _minBottomBtnsHeight = 48.0f;
    }else{
        _minBottomBtnsHeight = 40.0f;
    }
    _ratio = CGRectGetWidth([[UIScreen mainScreen] bounds])/vMinContainerWidth;
    _ratioForPhone4 = (IS_IPHONE_5_ABOVE)?1.0f:(480.0f/580.0f);
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
    }
    return self;
}

- (void)initializationUI {
    [self setClipsToBounds:YES];
    [self setFrame:[self buttonRectByType:_buttonType]];
    [self setBackgroundColor:[self buttonColorByType:_buttonType]];
    
    [self setButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    [_button setTag:_buttonType];
    [_button setFrame:self.bounds];
    [self addSubview:_button];

    if (_buttonType == MPSButtonTypeOfGPSAppiontment ||
        _buttonType == MPSButtonTypeOfMessageHistory ||
        _buttonType == MPSButtonTypeOfCS ||
        _buttonType == MPSButtonTypeOfParts ||
        _buttonType == MPSButtonTypeOfUsedCars) {
        
        [[_button titleLabel] setFont:[UIFont systemFontOfSize:18*_ratio]];
        if (_buttonType == MPSButtonTypeOfParts ||
            _buttonType == MPSButtonTypeOfUsedCars) {
            
            [[_button titleLabel] setFont:[UIFont boldSystemFontOfSize:18*_ratio]];
        }
        if (_buttonType == MPSButtonTypeOfGPSAppiontment) {
            
            [[_button titleLabel] setFont:[UIFont systemFontOfSize:16*_ratio]];
        }
        [_button setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
        [_button setTitle:getLocalizationString([self buttonTitleByType:_buttonType]) forState:UIControlStateNormal];
        
    }else{
        
        [self setBtnTitleLabel:[[UILabel alloc] initWithFrame:[self buttonTitleRectByType:_buttonType]]];
        [_btnTitleLabel setText:getLocalizationString([self buttonTitleByType:_buttonType])];
        [_btnTitleLabel setTextColor:CDZColorOfWhite];
        [_btnTitleLabel setFont:[UIFont boldSystemFontOfSize:18*_ratio]];
        [self addSubview:_btnTitleLabel];
        
        if (_buttonType == MPSButtonTypeOfGPS ||
            _buttonType == MPSButtonTypeOfRepair ||
            _buttonType == MPSButtonTypeOfVehicleManagement) {
            
            [self setBtnSubTitleLabel:[[UILabel alloc] initWithFrame:[self buttonSubTitleRectByType:_buttonType]]];
            [_btnSubTitleLabel setText:getLocalizationString([self buttonSubTitleByType:_buttonType])];
            [_btnSubTitleLabel setNumberOfLines:-1];
            [_btnSubTitleLabel setTextColor:CDZColorOfWhite];
            [_btnSubTitleLabel setFont:[UIFont systemFontOfSize:10*_ratio]];
            [self addSubview:_btnSubTitleLabel];
        }
    }
    
    if (_buttonType != MPSButtonTypeOfGPSAppiontment &&
        _buttonType != MPSButtonTypeOfMessageHistory &&
        _buttonType != MPSButtonTypeOfCS) {
        
        UIImage *iConImage = [ImageHandler getImageFromCacheWithByFixdeRatioFileRootPath:kSysImageCaches fileName:[self buttonImageStringByType:_buttonType] type:FMImageTypeOfPNG needToUpdate:NO];
        [self setBtnImageView:[[UIImageView alloc] initWithImage:iConImage]];
        [_btnImageView setFrame:[self buttonIVRectByType:_buttonType]];
        [self addSubview:_btnImageView];
    }
    
}

@end
