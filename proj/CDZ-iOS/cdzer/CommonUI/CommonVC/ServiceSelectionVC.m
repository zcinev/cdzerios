//
//  ServiceSelectionVC.m
//  cdzer
//
//  Created by KEns0n on 3/13/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vTagStartValue 800

#import "ServiceSelectionVC.h"

@interface ServiceSelectionVC ()

@property (nonatomic, strong) NSMutableArray *selectedBtnTagArray;

@property (nonatomic, strong) NSArray *buttonArray;

@end

@implementation ServiceSelectionVC


- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:CDZColorOfWhite];
    [self setTitle:getLocalizationString(@"service_select")];
    [self setButtonArray:@[@"minor_repair",
                           @"major_repair",
                           @"replace_filter",
                           @"replace_refrigerant",
                           @"replace_wiper",
                           @"replace_spark_plug",
                           @"replace_battery",
                           @"replace_power_steering_fluid",
                           @"replace_brake_fluid",
                           @"replace_brake_lining",
                           @"replace_brake_disk",
                           @"replace_tire",
                           @"replace_shock_absorber",
                           @"replace_anti-freezing_fluid",
                           @"replace_timing_belt",
                           @"replace_headlight",
                           @"replace_automatic_transmission_fluid",
                           @"replace_auxiliary_belt",]];
    [self initializationUI];
}

- (UIButton *)buttonViewInitWithFrame:(CGRect)frame
                            stringSize:(CGSize)stringSize
                                tagID:(NSInteger)tagID
                                  title:(NSString *)text
                             titleColor:(UIColor *)color
                               btnImage:(UIImage *)image
                                   font:(UIFont *)font
                              superview:(UIView *)superview {
    
    UIColor *selectColor = [UIColor colorWithRed:0.988f green:0.424f blue:0.133f alpha:1.00f];
    UIImage *selectImage = [ImageHandler ipMaskedImage:image color:selectColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [button setFrame:frame];
    [button setTitle:text forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateSelected];
    [button setImage:selectImage forState:UIControlStateHighlighted];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:selectColor forState:UIControlStateSelected];
    [button setTitleColor:selectColor forState:UIControlStateHighlighted];
    [button.titleLabel setFont:font];
    [button.titleLabel setNumberOfLines:-1];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button setTag:tagID+vTagStartValue];
    [button addTarget:self action:@selector(btnSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [superview addSubview:button];
    
    if (stringSize.width > CGRectGetWidth(frame)) {
        CGFloat newWidthGap = (CGRectGetWidth(frame) - stringSize.width)/2;
        CGRect newFrame = frame;
        newFrame.size.width = stringSize.width;
        newFrame.origin.x += newWidthGap;
        [button setFrame:newFrame];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -(newWidthGap), 0.0f, 0.0f)];
    }
    BOOL isSingleLine = ([text rangeOfString:@"\n"].location==NSNotFound);
    if (isSingleLine) stringSize.height = stringSize.height*0.75f;
    CGFloat textPositionX = CGRectGetHeight(frame)-stringSize.height;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(textPositionX, -CGRectGetWidth(frame), 0.0f, 0.0f)];
    
    return button;
    
}

- (void)initializationUI {
    @autoreleasepool {
        
        NSString *imageFileName = @"service_bkg";
        UIImage *bgImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                               fileName:imageFileName
                                                                                   type:FMImageTypeOfPNG
                                                                        scaleWithPhone4:YES
                                                                           needToUpdate:YES];
        [self.contentView setBackgroundImageByCALayerWithImage:bgImage];
 
        
        NSInteger columnPerRow = 4;
        CGFloat btn2BtnRowSpace = vAdjustByScreenRatio(8.0f);
        CGFloat leftSideMargin = vAdjustByScreenRatio(20.0f);
        CGFloat topSideMargin = vAdjustByScreenRatio(10.0f);
        CGFloat image2TitleSpace = vAdjustByScreenRatio(3.0f);
        UIFont *font = [UIFont systemFontOfSize:vAdjustByScreenRatio(12.0f)];
        UIColor *textColor = CDZColorOfWhite;
 
        for (int counting = 0; counting<[_buttonArray count]; counting++) {
            NSString *fileName = [NSString stringWithFormat:@"%02d_%@",(counting+1),_buttonArray[counting]];
            UIImage *image = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches fileName:fileName type:FMImageTypeOfPNG scaleWithPhone4:NO needToUpdate:NO];
            NSString *text = getLocalizationString(_buttonArray[counting)];
            CGSize stringSize = [SupportingClass getStringSizeWithString:text font:font widthOfView:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
            
            NSInteger currentRow = counting/columnPerRow;
            NSInteger currentColumn = counting%columnPerRow;
            CGFloat btn2BtnColumnSpace = (CGRectGetWidth(self.contentView.frame)-(leftSideMargin*2.0f+ image.size.width*columnPerRow))/(columnPerRow-1.0f);
            
            BOOL isSingleLine = ([text rangeOfString:@"\n"].location==NSNotFound);
            if (isSingleLine) stringSize.height += stringSize.height;
            CGRect btnRect = CGRectZero;
            CGSize readjustSize = image.size;
            readjustSize.width = image.size.width;
            readjustSize.height = image.size.height+ image2TitleSpace + stringSize.height;
            btnRect.size = readjustSize;
            btnRect.origin.x = leftSideMargin + currentColumn*(btn2BtnColumnSpace + btnRect.size.width);
            btnRect.origin.y = topSideMargin + currentRow*(btn2BtnRowSpace + btnRect.size.height);
            
            [self buttonViewInitWithFrame:btnRect
                               stringSize:stringSize
                                    tagID:counting
                                    title:text
                               titleColor:textColor
                                 btnImage:image
                                     font:font
                                superview:self.contentView];
        }

    }
}

- (void)btnSelectedAction:(UIButton *)button {
    if (!_selectedBtnTagArray) {
        [self setSelectedBtnTagArray:[NSMutableArray array]];
    }
    
    NSNumber *currentNumber = [NSNumber numberWithInteger:button.tag];
    __block NSInteger isExistID = -1;
    __block BOOL btnSelected = NO;
    
    [_selectedBtnTagArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSNumber *)obj compare:currentNumber]==NSOrderedSame) {
            isExistID = idx;
            btnSelected = YES;
            *stop = YES;
        }
    }];
    
    if (isExistID > -1) {
        [_selectedBtnTagArray removeObjectAtIndex:isExistID];
        [button setSelected:NO];
    }else{
        [_selectedBtnTagArray addObject:currentNumber];
        [button setSelected:YES];
    }
}


@end
