//
//  QuantityControlView.m
//  cdzer
//
//  Created by KEns0n on 7/18/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMaxSize CGSizeMake(90.0f, 30.0f)

#import "QuantityControlView.h"
#import "InsetsLabel.h"
@interface QuantityControlView ()

@property (nonatomic, strong) NSNumber *maxValueNum;

@property (nonatomic, strong) NSNumber *valueForRAC;

@property (nonatomic, strong) UIButton *minusBtn;

@property (nonatomic, strong) UIButton *plusBtn;

@property (nonatomic, strong) InsetsLabel *quantityLabel;

@end

@implementation QuantityControlView

- (instancetype)init {
    CGRect frame = CGRectZero;
    frame.size = vMaxSize;
    self = [self initWithFrame:frame];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    frame.size = vMaxSize;
    self = [super initWithFrame:frame];
    if (self) {
        self.value = 0;
        self.value = 0;
        self.valueForRAC = @(_value);
        self.maxValueNum = @50;
        [self initializationUI];
        [self setReactiveRules];
    }
    return self;
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, valueForRAC) subscribeNext:^(NSNumber *value) {
        @strongify(self)
        self.minusBtn.enabled = YES;
        self.plusBtn.enabled = YES;
        if (value.unsignedIntegerValue<=1) {
            self.minusBtn.enabled = NO;
        }
        
        if (self.valueForRAC.unsignedIntegerValue>=self.maxValueNum.unsignedIntegerValue) {
            self.plusBtn.enabled = NO;
        }
        
        self.quantityLabel.text = value.stringValue;
    }];
}

- (void)updateValue:(UIButton *)button {
    if (button==_minusBtn) {
        self.value--;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    if (button==_plusBtn) {
        self.value++;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)initializationUI {
    CGFloat btnWidth = vMaxSize.height;
    
    self.backgroundColor = CDZColorOfClearColor;
    [self setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:3.0f];
    [self setViewBorderWithRectBorder:UIRectBorderAllBorderEdge borderSize:1.0f withColor:CDZColorOfDefaultColor withBroderOffset:nil];
    
    self.quantityLabel = [[InsetsLabel alloc] initWithFrame:self.bounds];
    _quantityLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_quantityLabel];
    
    
    self.minusBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _minusBtn.backgroundColor = CDZColorOfClearColor;
    _minusBtn.frame = CGRectMake(0.0f, 0.0f, btnWidth, btnWidth);
    _minusBtn.titleLabel.textColor = CDZColorOfDefaultColor;
    _minusBtn.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 22.0f, NO);
    [_minusBtn setTitle:@"-" forState:UIControlStateNormal];
    [_minusBtn setTitle:@"-" forState:UIControlStateDisabled];
    [_minusBtn setTitle:@"-" forState:UIControlStateHighlighted];
    [_minusBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentFill];
    [_minusBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_minusBtn setTitleColor:CDZColorOfLightGray forState:UIControlStateDisabled];
    [_minusBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
    [_minusBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateHighlighted];
    [_minusBtn addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_minusBtn];
    
    self.plusBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _plusBtn.backgroundColor = CDZColorOfClearColor;
    _plusBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-btnWidth, 0.0f, btnWidth, btnWidth);
    _plusBtn.titleLabel.textColor = CDZColorOfDefaultColor;
    _plusBtn.titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 22.0f, NO);
    [_plusBtn setTitle:@"+" forState:UIControlStateNormal];
    [_plusBtn setTitle:@"+" forState:UIControlStateDisabled];
    [_plusBtn setTitle:@"+" forState:UIControlStateHighlighted];
    [_plusBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentFill];
    [_plusBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_plusBtn setTitleColor:CDZColorOfLightGray forState:UIControlStateDisabled];
    [_plusBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
    [_plusBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateHighlighted];
    [_plusBtn addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_plusBtn];
}

- (void)setValue:(NSUInteger)value {
    _value = value;
    self.valueForRAC = @(_value);
}

- (void)setMaxValue:(NSUInteger)maxValue {
    _maxValue = maxValue;
    if (_maxValue==0) {
        self.maxValueNum = @(50);
    }
    if (_valueForRAC.unsignedIntegerValue>=_maxValueNum.unsignedIntegerValue) {
        self.valueForRAC = _maxValueNum;
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
