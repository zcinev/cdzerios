//
//  ExpressSelectionView.m
//  cdzer
//
//  Created by KEns0n on 7/20/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define vMinHeight 40.0f

#import "ExpressSelectionView.h"
#import <UIView+Borders/UIView+Borders.h>
#import "InsetsLabel.h"


@interface ExpressSelectionView () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, strong) NSArray *expressData;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) InsetsLabel *titleLabel;

@property (nonatomic, strong) InsetsLabel *detailTitleLabel;


@end

@implementation ExpressSelectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    CGRect frame = UIScreen.mainScreen.bounds;
    frame.size.height = vMinHeight;
    self = [self initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.height<vMinHeight) {
        frame.size.height = vMinHeight;
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CDZColorOfWhite;
        self.expressData = @[];
        [self initializationUI];
        [self addTopBorderWithHeight:1.0f andColor:CDZColorOfLightGray];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)initializationUI {
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 44.0f)];
    [toolbar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                target:self
                                                                                action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"finish")
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(hiddenKeyboard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButton,doneButton,nil];
    [toolbar setItems:buttonsArray];
    
    self.pickerView = [UIPickerView new];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    self.textField = [[UITextField alloc] initWithFrame:self.bounds];
    _textField.inputView = _pickerView;
    _textField.inputAccessoryView = toolbar;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    self.titleLabel = [[InsetsLabel alloc] initWithFrame:self.bounds andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
    _titleLabel.backgroundColor = CDZColorOfWhite;
    _titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, _titleLabel.font.pointSize, NO);
    _titleLabel.text = @"配送方式";
    [self addSubview:_titleLabel];
    
    UIImage *arrowImage = ImageHandler.getRightArrow;
    
    UIButton *arrowView = [UIButton buttonWithType:UIButtonTypeCustom];
    arrowView.userInteractionEnabled = NO;
    arrowView.frame = CGRectMake(CGRectGetWidth(self.frame)-arrowImage.size.width-15.0f, 0.0f, arrowImage.size.width, CGRectGetHeight(self.frame));
    [arrowView setImage:arrowImage forState:UIControlStateNormal];
    [self addSubview:arrowView];
    
    self.detailTitleLabel = [[InsetsLabel alloc] initWithFrame:self.bounds andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, arrowImage.size.width+25.0f)];
    _detailTitleLabel.text = @"未设置";
    _detailTitleLabel.textColor = CDZColorOfDefaultColor;
    _detailTitleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, _titleLabel.font.pointSize, NO);
    _detailTitleLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_detailTitleLabel];
    
    
    
}

- (void)setExpressList:(NSArray *)expressData {
    self.expressData = expressData;
    if (_expressData&&_expressData.count>0) {
        [_pickerView reloadComponent:0];
        [self pickerView:_pickerView didSelectRow:0 inComponent:0];
    }

}

- (void)hiddenKeyboard {
    [_textField resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        if ([self.superview isKindOfClass:UIScrollView.class]) {
            [(UIScrollView *)self.superview setScrollEnabled:YES];
            [(UIScrollView *)self.superview setContentOffset:CGPointZero];
        }else {
            CGRect frame = self.superview.frame;
            frame.origin.y = 0.0f;
            self.superview.frame = frame;
        }
    }];
}

- (void)keyboardWillShow:(NSNotification *)notifyObject {
    if ([_textField isFirstResponder]) {
        CGRect keyboardRect = [[notifyObject.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        if (!CGRectEqualToRect(keyboardRect, _keyboardRect)) {
            self.keyboardRect = keyboardRect;
        }
        [self shiftScrollViewWithAnimation];
        NSLog(@"Step One");
    }
}

- (void)shiftScrollViewWithAnimation{
    CGPoint point = CGPointZero;
    CGFloat contanierViewMaxY = CGRectGetMidY(self.frame);
    CGFloat visibleContentsHeight = (CGRectGetHeight(self.superview.frame)-CGRectGetHeight(_keyboardRect))/2.0f;
    if (contanierViewMaxY > visibleContentsHeight) {
        CGFloat offsetY = contanierViewMaxY-visibleContentsHeight;
        point.y = offsetY;
    }
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        if ([self.superview isKindOfClass:UIScrollView.class]) {
            [(UIScrollView *)self.superview setContentOffset:point];
        }else {
            @strongify(self)
            CGRect frame = self.superview.frame;
            frame.origin.y = 0.0f - point.y;
            self.superview.frame = frame;
        }
    }];
    
}

#pragma mark- UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_expressData.count==0) return NO;
    if ([self.superview isKindOfClass:UIScrollView.class]) {
        [(UIScrollView *)self.superview setScrollEnabled:NO];
    }
    if (!CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        [self shiftScrollViewWithAnimation];
    }
    return YES;
}


#pragma mark- UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _expressData.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    @autoreleasepool {
        UILabel *labelText = [UILabel new];
        [labelText setTextAlignment:NSTextAlignmentCenter];
        labelText.backgroundColor = [UIColor clearColor];
        labelText.font = [UIFont boldSystemFontOfSize:20.0];
        labelText.textColor = [UIColor blackColor];
        NSDictionary *detail = _expressData[row];
        [labelText setText:detail[@"name"]];
        return labelText;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    @autoreleasepool {
        NSDictionary *detail = _expressData[row];
        self.expressID = detail[@"id"];
        self.expressName = detail[@"name"];
        self.detailTitleLabel.text = _expressName;
    }
    
    
}
@end
