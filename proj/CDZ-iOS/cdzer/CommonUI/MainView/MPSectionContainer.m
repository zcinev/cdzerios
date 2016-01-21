//
//  MPSectionContainer.m
//  cdzer
//
//  Created by KEns0n on 2/28/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight 247.0f


#import "MPSectionButton.h"
#import "MPSectionContainer.h"

@implementation MPSectionContainer

- (CGRect)checkIsMinimumSizeAtRect:(CGRect)frame{
    CGRect newRect = frame;
    CGSize newSize = frame.size;
    if (frame.size.width < vMinPhoneWidth) newSize.width = vMinPhoneWidth;
    if (frame.size.height < vMinHeight) newSize.height = vMinHeight;
    newRect.size = newSize;
    return newRect;
}


- (instancetype)init {
    
    self = [self initWithFrame:CGRectZero];
    
    if (self) {}
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {}
    
    return self;
}

- (instancetype)initWithOrigin:(CGPoint)origin {
    
    CGRect rect = CGRectZero;
    rect.origin = origin;
    self = [self initWithFrame:rect];
    
    if (self) {}
    
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    CGRect newRect = [self checkIsMinimumSizeAtRect:frame];
    
    [super setFrame:newRect];
}

- (void)initializationUI {
    
    NSArray *configArray = @[@{kMPSButtonType:fIntegerToNumber(MPSButtonTypeOfGPS),},
                             
                             @{kMPSButtonType:fIntegerToNumber(MPSButtonTypeOfRepair),},
                             
                             @{kMPSButtonType:fIntegerToNumber(MPSButtonTypeOfParts),},
                             
                             @{kMPSButtonType:fIntegerToNumber(MPSButtonTypeOfUsedCars),},
                             
                             @{kMPSButtonType:fIntegerToNumber(MPSButtonTypeOfTrafficViolation),},
                             
                             @{kMPSButtonType:fIntegerToNumber(MPSButtonTypeOfVehicleManagement),},
                                 
                             @{kMPSButtonType:fIntegerToNumber(MPSButtonTypeOfGPSAppiontment),},
                             
                             @{kMPSButtonType:fIntegerToNumber(MPSButtonTypeOfMessageHistory),},
                             
                             @{kMPSButtonType:fIntegerToNumber(MPSButtonTypeOfCS)}];
    
    [configArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        
        [self mpBtnInitializationByType:[[(NSDictionary *)obj objectForKey:kMPSButtonType] integerValue]];
    }];
}

- (MPSectionButton *)mpBtnInitializationByType:(MPSButtonType)type {
    @autoreleasepool {
        MPSectionButton *mpSBtn = [[MPSectionButton alloc] initWithButtonType:type ContainerSize:self.bounds.size];
        [mpSBtn initializationUI];
        [mpSBtn.button addTarget:self action:@selector(MPSBAction:) forControlEvents:UIControlEventTouchUpInside];
        [mpSBtn setTag:type];
        [self addSubview:mpSBtn];
        return mpSBtn;
    }
}

- (void)MPSBAction:(MPSectionButton *)button {
    MPSButtonType type = button.tag;
    if ([_delegate respondsToSelector:@selector(MPSButtonResponseByType:)]) {
        [_delegate MPSButtonResponseByType:type];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
