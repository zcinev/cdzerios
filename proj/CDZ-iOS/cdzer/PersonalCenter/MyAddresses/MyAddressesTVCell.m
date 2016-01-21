//
//  MyAddressesTVCell.m
//  cdzer
//
//  Created by KEns0n on 4/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vInsetsValue UIEdgeInsetsMake(0.0f, (15.0f), 0.0f, (35.0f))
#define vMinHeight (100.0f)
#import "MyAddressesTVCell.h"
#import "InsetsLabel.h"

@interface MyAddressesTVCell ()

@property (nonatomic, strong) InsetsLabel *addressLabel1;

@property (nonatomic, strong) InsetsLabel *addressLabel2;

@property (nonatomic, strong) InsetsLabel *nameWithPhoneLabel;

@property (nonatomic, strong) InsetsLabel *postNumberLabel;

@end

@implementation MyAddressesTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// address1 Text String Setting
- (void)setProvinceString:(NSString *)provinceString {
    _provinceString = nil;
    _provinceString = provinceString;
    [self setTextToAddressLabel1WithProvince:provinceString city:_cityString district:_districtString];
}

- (void)setCityString:(NSString *)cityString {
    _cityString = nil;
    _cityString = cityString;
    [self setTextToAddressLabel1WithProvince:_provinceString city:cityString district:_districtString];
    
}

- (void)setDistrictString:(NSString *)districtString {
    _districtString = nil;
    _districtString = districtString;
    [self setTextToAddressLabel1WithProvince:_provinceString city:_cityString district:districtString];
}

- (void)setTextToAddressLabel1WithProvince:(NSString *)provinceString city:(NSString *)cityString district:(NSString *)districtString {
    NSString *stringText = @"";
    
    if (provinceString) {
        stringText = [stringText stringByAppendingFormat:@"%@ ",provinceString];
    }
    
    if (cityString) {
        stringText = [stringText stringByAppendingFormat:@"%@ ",cityString];
    }
    
    if (districtString) {
        stringText = [stringText stringByAppendingFormat:@"%@ ",districtString];
    }
    
    [_addressLabel1 setText:stringText];
}

// address2 Text String Setting
- (void)setAddressString:(NSString *)addressString {
    _addressString = nil;
    _addressString = addressString;
    if ([_addressLabel1.text isEqualToString:@""]||!_addressLabel1.text) {
        
        [_addressLabel1 setText:addressString];
        return;
    }
    [_addressLabel2 setText:addressString];
}

// Name&Phone Text String Setting
- (void)setUserNameString:(NSString *)userPhoneString {
    _userNameString = nil;
    _userNameString = userPhoneString;
    [self setTextToNameWithPhoneLabelWithUserPhone:userPhoneString phoneNumber:_phoneNumberString];
    
}

- (void)setPhoneNumberString:(NSString *)phoneNumberString {
    _phoneNumberString = nil;
    _phoneNumberString = phoneNumberString;
    [self setTextToNameWithPhoneLabelWithUserPhone:_userNameString phoneNumber:phoneNumberString];
    
}

- (void)setTextToNameWithPhoneLabelWithUserPhone:(NSString *)userPhoneString phoneNumber:(NSString *)phoneNumberString{
    NSString *stringText = @"";
    
    if (userPhoneString) {
        stringText = [stringText stringByAppendingFormat:@"%@ ",userPhoneString];
    }
    
    if (phoneNumberString) {
        stringText = [stringText stringByAppendingFormat:@"%@ ",phoneNumberString];
    }
    
    if ([_addressLabel1.text isEqualToString:@""]||!_addressLabel1.text) {
        
        [_addressLabel1 setText:stringText];
        return;
    }
    if ([_addressLabel2.text isEqualToString:@""]||!_addressLabel2.text) {
        
        [_addressLabel2 setText:stringText];
        return;
    }
    
    [_nameWithPhoneLabel setText:stringText];
    
}

// PostNumber Text String Setting
- (void)setPostNumberString:(NSString *)postNumberString {
    NSString *postString = [getLocalizationString(@"post_title") stringByAppendingString:postNumberString];
    
    _postNumberString = nil;
    _postNumberString = postNumberString;
    
    if ([_addressLabel1.text isEqualToString:@""]||!_addressLabel1.text) {
        
        [_addressLabel1 setText:postString];
        return;
    }
    if ([_addressLabel2.text isEqualToString:@""]||!_addressLabel2.text) {
        
        [_addressLabel2 setText:postString];
        return;
    }
    if ([_nameWithPhoneLabel.text isEqualToString:@""]||!_nameWithPhoneLabel.text) {
        
        [_nameWithPhoneLabel setText:postString];
        return;
    }
    
    [_postNumberLabel setText:postString];

}

- (void)initializationUI {
    [self.contentView setBackgroundColor:sCommonBGColor];
    CGFloat fontSize = 15.0f;

    CGRect subContentRect = self.bounds;
    subContentRect.size.height = vMinHeight-(10.0f);;
    UIView *subContentView = [[UIView alloc] initWithFrame:subContentRect];
    [subContentView setBackgroundColor:CDZColorOfWhite];
    [self.contentView addSubview:subContentView];
    
    if (!_nameWithPhoneLabel) {
        CGRect rect = subContentView.frame;
        rect.origin.y = (5.0f);
        rect.size.height = (20.f);
        [self setNameWithPhoneLabel:[[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:vInsetsValue]];
        [_nameWithPhoneLabel setBackgroundColor:CDZColorOfClearColor];
        [_nameWithPhoneLabel setTextColor:CDZColorOfBlack];
        [_nameWithPhoneLabel setFont:systemFontBold(fontSize)];
        [_nameWithPhoneLabel setText:@"3"];
        [subContentView addSubview:_nameWithPhoneLabel];
        
    }
    
    if (!_addressLabel1) {
        CGRect rect = _nameWithPhoneLabel.bounds;
        rect.origin.y = CGRectGetMaxY(_nameWithPhoneLabel.frame);
        [self setAddressLabel1:[[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:vInsetsValue]];
        [_addressLabel1 setBackgroundColor:CDZColorOfClearColor];
        [_addressLabel1 setTextColor:CDZColorOfBlack];
        [_addressLabel1 setFont:systemFontBold(fontSize)];
        [_addressLabel1 setText:@"1"];
        [subContentView addSubview:_addressLabel1];
        
    }
    
    if (!_addressLabel2) {
        CGRect rect = _addressLabel1.frame;
        rect.origin.y = CGRectGetMaxY(_addressLabel1.frame);
        rect.size.height = 40.0f;
        [self setAddressLabel2:[[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:vInsetsValue]];
        [_addressLabel2 setBackgroundColor:CDZColorOfClearColor];
        [_addressLabel2 setTextColor:CDZColorOfBlack];
        [_addressLabel2 setFont:systemFontBold(fontSize)];
        [_addressLabel2 setText:@"2"];
        _addressLabel2.numberOfLines = 0;
        [subContentView addSubview:_addressLabel2];
        
    }
    
    if (_postNumberLabel) {
        CGRect rect = _addressLabel1.frame;
        rect.origin.y = CGRectGetMaxY(_addressLabel2.frame);
        [self setPostNumberLabel:[[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:vInsetsValue]];
        [_postNumberLabel setBackgroundColor:CDZColorOfClearColor];
        [_postNumberLabel setTextColor:CDZColorOfBlack];
        [_postNumberLabel setFont:systemFontBold(fontSize)];
        [_postNumberLabel setText:@"4"];
        [subContentView addSubview:_postNumberLabel];
        
    }
    
    
    UIImage *arrowImage = ImageHandler.getRightArrow;
    
    UIImageView *arrowIV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(subContentRect)-vInsetsValue.left-arrowImage.size.width, 0.0f, arrowImage.size.width, arrowImage.size.height)];
    [arrowIV setImage:arrowImage];
    [arrowIV setCenter:CGPointMake(arrowIV.center.x, CGRectGetHeight(subContentRect)/2.0f)];
    [subContentView addSubview:arrowIV];
}
@end
