//
//  SelectionStepFlowView.m
//  cdzer
//
//  Created by KEns0n on 3/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vOffsetX vAdjustByScreenRatio(10.0f)

#define disableColor [UIColor grayColor]
#define enableColor [UIColor colorWithRed:0.820f green:0.545f blue:0.325f alpha:1.00f]
#define kArrowBtnDefaultTag 900
#define kObjNameKey @"name"
#define kObjIDKey @"id"
#define kObjIconKey @"icon"

#import "SelectionStepFlowView.h"
#import "InsetsLabel.h"
#import "InsetsTextField.h"
#import "UserSelectedAutosInfoDTO.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SelectionStepFlowView ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIButton *_stepOneArrowBtn;
    UIButton *_stepTwoArrowBtn;
    UIButton *_stepThreeArrowBtn;
    UIButton *_stepFourArrowBtn;
}

//@property (nonatomic, strong) AutoDataObject *dataContainer;

@property (nonatomic, assign) CGFloat arrowOverlayWidth;
@property (nonatomic, assign) CGRect arrowDefaultRect;
@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, strong) InsetsLabel *infoLabel;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIImageView *trickImageView;

@property (nonatomic, strong) UITextField *infoTextField;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIBarButtonItem *previousButton, *nextButton, *doneButton;

@property (nonatomic, strong) UIButton *activeSelectionBtn;

@property (nonatomic, strong) NSNumber *currentStep;
@property (nonatomic, strong) NSMutableArray *innerDataList, *selectionStringList, *selectionIdxList;
@property (nonatomic, strong) NSArray* autoDealershipList;
@property (nonatomic, strong) NSArray* autoSeriesList;
@property (nonatomic, strong) NSArray* autoModelList;

@end

@implementation SelectionStepFlowView

@synthesize arrowBtn1 = _stepOneArrowBtn;
@synthesize arrowBtn2 = _stepTwoArrowBtn;
@synthesize arrowBtn3 = _stepThreeArrowBtn;
@synthesize arrowBtn4 = _stepFourArrowBtn;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self componentSetting];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self componentSetting];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self componentSetting];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = 0;
    frame.size.width = CGRectGetWidth([UIScreen mainScreen].bounds);
    [super setFrame:frame];
}

- (void)componentSetting {
    self.isReady = @(NO);
    self.isSelected = @(NO);
    self.innerDataList = [NSMutableArray array];
    self.selectionStringList = [NSMutableArray arrayWithCapacity:4];
    [self.selectionStringList addObjectsFromArray:@[@"",@"",@"",@""]];
    self.selectionIdxList = [NSMutableArray arrayWithCapacity:4];
    [self.selectionIdxList addObjectsFromArray:@[@(-1),@(-1),@(-1),@(-1)]];
    self.currentStep = @(0);
}

- (void)setAutoData:(UserSelectedAutosInfoDTO *)autoData {
    _autoData = autoData;
}

- (void)setAutoBrandList:(NSArray *)autoBrandList {
    if (_autoBrandList) {
        _autoBrandList = nil;
    }
    _autoBrandList = autoBrandList;
}

- (void)setReactiveRules {
    //Signal to handle is data ready
    @weakify(self)
    [RACObserve(self, currentStep) subscribeNext:^(NSNumber *idx) {
        
        self->_stepOneArrowBtn.selected = NO;
        self->_stepTwoArrowBtn.selected = NO;
        self->_stepThreeArrowBtn.selected = NO;
        self->_stepFourArrowBtn.selected = NO;
        UIButton *btn = (UIButton *)[self viewWithTag:kArrowBtnDefaultTag+self.currentStep.intValue];
        if (btn) {
            btn.selected = YES;
        }
        [self arrowAppearRule];
        [self handleInnerDataSwitch];
        [self setTextInInfoTextField];
    }];
    
    [RACObserve(self, selectionIdxList) subscribeNext:^(id x) {
        @strongify(self)
        [self arrowAppearRule];
        [self.selectionIdxList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqual:@(-1)]) {
                if (self.autoData) {
                    self.autoData = nil;
                }
                self.trickImageView.hidden = YES;
                *stop = YES;
            }else if (idx==3){
                self.trickImageView.hidden = NO;
                [self autoDataSelectReady];
            }
        }];
    }];
}

- (void)autoDataSelectReady {
    @autoreleasepool {
        NSNumberFormatter *formatter = [NSNumberFormatter new];
        NSInteger index1 = [_selectionIdxList[0] integerValue];
        NSInteger index2 = [_selectionIdxList[1] integerValue];
        NSInteger index3 = [_selectionIdxList[2] integerValue];
        NSInteger index4 = [_selectionIdxList[3] integerValue];
        NSDictionary * autoData = @{@"id":UserBehaviorHandler.shareInstance.getUserID,
                                    CDZAutosKeyOfBrandID:[formatter numberFromString:[_autoBrandList[index1] objectForKey:kObjIDKey]],
                                    @"select_from_online":@(NO),
                                    CDZAutosKeyOfBrandName:[_autoBrandList[index1] objectForKey:kObjNameKey],
                                    CDZAutosKeyOfBrandIcon:[_autoBrandList[index1] objectForKey:kObjIconKey],
                                    CDZAutosKeyOfDealershipID:[formatter numberFromString:[_autoDealershipList[index2] objectForKey:kObjIDKey]],
                                    CDZAutosKeyOfDealershipName:[_autoDealershipList[index2] objectForKey:kObjNameKey],
                                    CDZAutosKeyOfSeriesID:[formatter numberFromString:[_autoSeriesList[index3] objectForKey:kObjIDKey]],
                                    CDZAutosKeyOfSeriesName:[_autoSeriesList[index3] objectForKey:kObjNameKey],
                                    CDZAutosKeyOfModelID:[formatter numberFromString:[_autoModelList[index4] objectForKey:kObjIDKey]],
                                    CDZAutosKeyOfModelName:[_autoModelList[index4] objectForKey:kObjNameKey]};
        self.autoData = [UserSelectedAutosInfoDTO new];
        [_autoData processDBDataToObjectWithDBData:autoData];
    }
}

- (void)arrowAppearRule {
    @autoreleasepool {
        NSInteger number = [self.selectionIdxList[_currentStep.intValue] integerValue];
        NSLog(@"%ld",(long)number);
        _previousButton.enabled = YES;
        _nextButton.enabled = YES;
        [self.doneButton setTitle:getLocalizationString(@"cancel")];
        [_activeSelectionBtn setTitle:getLocalizationString(@"click_to_continue_select") forState:UIControlStateNormal];
        [_activeSelectionBtn setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.6]];
        switch (_currentStep.intValue) {
            case 0:{
                [self hideStepThreeView];
                [self hideStepFourView];
                if (number<0) {
                    [_activeSelectionBtn setTitle:getLocalizationString(@"click_to_select") forState:UIControlStateNormal];
                    [self hideStepTwoView];
                    [_logoImageView setImage:[ImageHandler getWhiteLogo]];
                    _previousButton.enabled = NO;
                    _nextButton.enabled = NO;
                }else {
                    [self showStepTwoView];
                    _previousButton.enabled = NO;
                    NSInteger idx = [_selectionIdxList[0] integerValue];
                    if (idx!=-1) {
                        NSString *URL = [_autoBrandList[idx] objectForKey:kObjIconKey];
                        [_logoImageView sd_setImageWithURL:[NSURL URLWithString:URL] placeholderImage:[ImageHandler getWhiteLogo]];
                    }

                }
            }
                break;
                
            case 1:{
                if (_stepTwoArrowBtn.alpha==0) {
                    [self showStepTwoView];
                }
                [self hideStepFourView];
                if (number<0) {
                    [self hideStepThreeView];
                    _nextButton.enabled = NO;
                }else {
                    [self showStepThreeView];
                }

            }
                break;
                
            case 2:{
                if (_stepTwoArrowBtn.alpha==0) {
                    [self showStepTwoView];
                }
                if (_stepThreeArrowBtn.alpha==0) {
                    [self showStepThreeView];
                }
                if (number<0) {
                    [self hideStepFourView];
                    _nextButton.enabled = NO;
                }else {
                    [self showStepFourView];
                }
            }
                break;
                
            case 3:{
                if (_stepTwoArrowBtn.alpha==0) {
                    [self showStepTwoView];
                }
                if (_stepThreeArrowBtn.alpha==0) {
                    [self showStepThreeView];
                }
                if (_stepFourArrowBtn.alpha==0) {
                    [self showStepFourView];
                }
                _nextButton.enabled = NO;
                if (number>-1) {
                    [self.doneButton setTitle:getLocalizationString(@"finish")];
                    [self.activeSelectionBtn setTitle:@"" forState:UIControlStateNormal];
                    [_activeSelectionBtn setBackgroundColor:CDZColorOfClearColor];
                    
                }
            }
                break;
            default:
                break;
        }

    }
}

- (void)addKeyboardObserve {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)removeKeyboardObserve {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark getter setting

#pragma mark setter setting
- (void)setIsReady:(NSNumber *)isReady {
    _isReady = nil;
    _isReady = isReady;
}

- (void)setIsSelected:(NSNumber *)isSelected {
    _isSelected = nil;
    _isSelected = isSelected;
}

#pragma mark- Private Function
- (void)selectedSelf {
    self.isSelected = @(YES);
    [self setBorderWithColor:CDZColorOfDefaultColor borderWidth:1.5f];
    [self showSelectedAnimation];
    [self.infoTextField becomeFirstResponder];
    NSLog(@"%d",[self.infoTextField becomeFirstResponder]);
}

- (void)deselectedSelf {
    self.isSelected = @(NO);
    [self setBorderWithColor:CDZColorOfClearColor borderWidth:1.5f];
    [self resignKeyboard];
}

- (void)resignKeyboard {
    [self.infoTextField resignFirstResponder];
    [self showDeselectedAnimation];
}

- (void)detectSelection:(UIButton *)button {
    NSNumber *currentIdx = @(button.tag-kArrowBtnDefaultTag);
    self.currentStep = currentIdx;
}

- (void)barButtonAction:(UIBarButtonItem *)barButton {
    @autoreleasepool {
        NSInteger currentStep = _currentStep.integerValue;
        if ([barButton isEqual:_nextButton]&&currentStep!=3) {
            currentStep++;
            
        }else if([barButton isEqual:_previousButton]&&currentStep!=0) {
            currentStep--;
        }
        UIButton *button = (UIButton *)[self viewWithTag:kArrowBtnDefaultTag+currentStep];
        if (button) {
            [self detectSelection:button];
        }
    }
}

- (void)setTextInInfoTextField {
    @autoreleasepool {
        __block NSMutableString *string = [NSMutableString stringWithString:@""];
        @weakify(self)
        [self.selectionStringList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @strongify(self)
            if (![obj isEqualToString:@""]) {
                if ([obj isKindOfClass:NSString.class]) {
                    [string appendFormat:@"%@\n",obj];
                }
            }
            *stop = (idx==self.currentStep.integerValue);
        }];
        NSLog(@"%@",string);
        self.infoLabel.text = string;
    }
}

#pragma mark- Animation
- (void)showSelectedAnimation {
    [UIView animateWithDuration:0.3 animations:^{
        [(UIButton *)[self viewWithTag:kArrowBtnDefaultTag+self.currentStep.integerValue] setSelected:YES];
        self.activeSelectionBtn.alpha = 0;
        self.logoImageView.alpha = 1;
        self.infoLabel.alpha = 1;
        [self showStepOneView];
        [self arrowAppearRule];
    }];
    
}

- (void)showDeselectedAnimation {
    self.activeSelectionBtn.alpha = 1;
    for (int i=0; i<4; i++) {
        [(UIButton *)[self viewWithTag:kArrowBtnDefaultTag+i] setSelected:NO];
    }
    [UIView animateWithDuration:0.3 animations:^{
        if ([self.selectionIdxList[0] integerValue]<0) {
            self.logoImageView.alpha = 0;
            self.infoLabel.alpha = 0;
            [self hideStepOneView];
            [self hideStepTwoView];
            [self hideStepThreeView];
            [self hideStepFourView];
        }
    }];
    
}

- (void)hideStepOneView {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.arrowBtn1.frame;
        rect.origin.x = -CGRectGetWidth(self.arrowDefaultRect);
        self.arrowBtn1.frame = rect;
        self.arrowBtn1.alpha = 0.0f;
    }];
}

- (void)hideStepTwoView {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.arrowBtn2.frame;
        rect.origin.x = 0;
        self.arrowBtn2.frame = rect;
        self.arrowBtn2.alpha = 0.0f;
    }];
}

- (void)hideStepThreeView {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.arrowBtn3.frame;
        rect.origin.x = CGRectGetMaxX(self.arrowBtn1.frame)-self.arrowOverlayWidth;
        self.arrowBtn3.frame = rect;
        self.arrowBtn3.alpha = 0.0f;
    }];
}

- (void)hideStepFourView {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.arrowBtn4.frame;
        rect.origin.x = (CGRectGetMaxX(self.arrowBtn1.frame)-self.arrowOverlayWidth)*2;
        self.arrowBtn4.frame = rect;
        self.arrowBtn4.alpha = 0.0f;
    }];
}

- (void)showStepOneView {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.arrowDefaultRect;
        self.arrowBtn1.frame = rect;
        self.arrowBtn1.alpha = 1.0f;
    }];
}

- (void)showStepTwoView {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.arrowBtn1.frame;
        rect.origin.x = CGRectGetMaxX(self.arrowBtn1.frame)-self.arrowOverlayWidth;
        self.arrowBtn2.frame = rect;
        self.arrowBtn2.alpha = 1.0f;
    }];
}

- (void)showStepThreeView {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.arrowBtn1.frame;
        rect.origin.x = (CGRectGetMaxX(self.arrowBtn1.frame)+CGRectGetWidth(self.arrowBtn1.frame))-self.arrowOverlayWidth*2;
        self.arrowBtn3.frame = rect;
        self.arrowBtn3.alpha = 1.0f;
    }];
}

- (void)showStepFourView {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.arrowBtn1.frame;
        rect.origin.x = (CGRectGetMaxX(self.arrowBtn1.frame)+CGRectGetWidth(self.arrowBtn1.frame)*2)-self.arrowOverlayWidth*3;
        self.arrowBtn4.frame = rect;
        self.arrowBtn4.alpha = 1.0f;
    }];
}

- (void)shiftScrollViewWithAnimation{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        CGPoint point = CGPointZero;
        CGFloat contanierViewMaxY = CGRectGetMidY(self.frame);
        CGFloat visibleContentsHeight = (CGRectGetHeight(scrollView.frame)-CGRectGetHeight(_keyboardRect))/2.0f;
        if (contanierViewMaxY > visibleContentsHeight) {
            CGFloat offsetY = contanierViewMaxY-visibleContentsHeight;
            point.y = offsetY;
        }
        
        [scrollView setContentOffset:point animated:NO];
    }
    
}

- (void)restoreScrollViewToTop {
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        [scrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
    }
}

#pragma mark- UI Setting
- (void)initializationUI {
    @autoreleasepool {
        
        self.backgroundColor = CDZColorOfWhite;
        CGFloat titleInnerSpace = vAdjustByScreenRatio(15.0f);
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vOffsetX, 0.0f, vOffsetX);
        CGFloat offset = vAdjustByScreenRatio(8.0f);
        
        InsetsLabel *titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, offset, CGRectGetWidth(self.frame), vAdjustByScreenRatio(25.0f))
                                                           andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, titleInnerSpace, 0.0f, titleInnerSpace)];
        titleLabel.font = systemFontBold(16.0f);
        titleLabel.textColor = CDZColorOfDeepGray;
        titleLabel.text = getLocalizationString(@"independent_select");
        [self addSubview:titleLabel];
        
        [self arrowButtonSetup:CGRectGetMaxY(titleLabel.frame)+offset leftSideOffset:insetsValue.left];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        CGFloat remainHieight = CGRectGetHeight(self.frame)-CGRectGetMaxY(_stepFourArrowBtn.frame)+offset;
        
        self.logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(titleInnerSpace,
                                                                           CGRectGetMaxY(_stepFourArrowBtn.frame)+offset,
                                                                           vAdjustByScreenRatio(70.0f),
                                                                           vAdjustByScreenRatio(70.0f))];
        _logoImageView.center = CGPointMake(_logoImageView.center.x,
                                            CGRectGetHeight(self.frame)-remainHieight/2.0f);
        _logoImageView.image = [ImageHandler getWhiteLogo];
        _logoImageView.alpha = 0.0f;
        [self addSubview:_logoImageView];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGFloat maxX = CGRectGetMaxX(_logoImageView.frame)+offset;
        self.infoLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(maxX,
                                                                       CGRectGetMinY(_logoImageView.frame),
                                                                       CGRectGetWidth(self.frame)-maxX-titleInnerSpace,
                                                                       vAdjustByScreenRatio(80.0f))
                                                  andEdgeInsetsValue:insetsValue];
        _infoLabel.center = CGPointMake(_infoLabel.center.x,
                                        _logoImageView.center.y);
        _infoLabel.backgroundColor = CDZColorOfWhite;
        _infoLabel.alpha = 0.0f;
        _infoLabel.numberOfLines = 0;
        _infoLabel.font = systemFont(16.0f);
        _infoLabel.userInteractionEnabled = YES;
        [self addSubview:_infoLabel];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        self.toolBar =  [[UIToolbar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), 40.0f)];
        [_toolBar setBarStyle:UIBarStyleDefault];
        self.doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"cancel")
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(resignKeyboard)];
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:self
                                                                                    action:nil];
        self.previousButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:101
                                                                           target:self
                                                                           action:@selector(barButtonAction:)];
        _previousButton.enabled = NO;
        UIBarButtonItem *fixSpaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                       target:self
                                                                                       action:nil];
        fixSpaceButton.width = 10.0f;
        self.nextButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:102
                                                                       target:self
                                                                       action:@selector(barButtonAction:)];
        self.nextButton.enabled = NO;
        NSArray * buttonsArray = [NSArray arrayWithObjects:_doneButton,spaceButton,_previousButton,fixSpaceButton,_nextButton,fixSpaceButton,nil];
        if (_onlyForSelection) {
            buttonsArray = [NSArray arrayWithObjects:spaceButton,_previousButton,fixSpaceButton,_nextButton,fixSpaceButton,nil];
        }
        [_toolBar setItems:buttonsArray];
        

        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(UIScreen.mainScreen.bounds), 218.0f)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        self.infoTextField = [[UITextField alloc] initWithFrame:_infoLabel.frame];
        _infoTextField.inputView = _tableView;
        _infoTextField.inputAccessoryView = _toolBar;
        _infoTextField.delegate = self;
        _infoTextField.alpha = 0.0f;
        [self insertSubview:_infoTextField belowSubview:_infoLabel];
        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        CGFloat trickImageSize = vAdjustByScreenRatio(20.0f);
        self.trickImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-trickImageSize-vAdjustByScreenRatio(3.0f),
                                                                            vAdjustByScreenRatio(3.0f),
                                                                            trickImageSize, trickImageSize)];
        UIImage *trickImage = [ImageHandler drawRotundityWithTick:YES size:_trickImageView.frame.size strokeColor:nil fillColor:nil];
        self.trickImageView.image = trickImage;
        self.trickImageView.hidden = YES;
        [self addSubview:_trickImageView];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        self.activeSelectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _activeSelectionBtn.frame = self.bounds;
        _activeSelectionBtn.titleLabel.font = systemFontBold(18.0f);
        [_activeSelectionBtn setTitle:getLocalizationString(@"click_to_select") forState:UIControlStateNormal];
        [_activeSelectionBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
        [_activeSelectionBtn addTarget:self action:@selector(selectedSelf) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_activeSelectionBtn];
        
    }
    [self setReactiveRules];
    
    if (_onlyForSelection) {
        [self selectedSelf];
    }
}

- (void)arrowButtonSetup:(CGFloat)lastYPoint leftSideOffset:(CGFloat)leftOffset{
    
    CGSize arrowSize = CGSizeMake((CGRectGetWidth(self.frame)-vOffsetX*0.2)/4.0f,
                                  vAdjustByScreenRatio(30.0f));
    _arrowOverlayWidth = arrowSize.width*0.2;
    
    UIImage *arrowSelectedImage = [self drawRectangeleArrow:UIColor.orangeColor withSize:arrowSize];
    UIImage *arrowImage = [self drawRectangeleArrow:CDZColorOfDefaultColor withSize:arrowSize];
    
    
    
    self.arrowDefaultRect = CGRectMake(leftOffset,
                                       lastYPoint,
                                       arrowSize.width+_arrowOverlayWidth/2.0f,
                                       arrowSize.height);
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    UIFont *arrowFont = systemFont(15);
    _stepOneArrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _stepOneArrowBtn.frame = CGRectMake(-CGRectGetWidth(self.arrowDefaultRect),
                                        CGRectGetMinY(self.arrowDefaultRect),
                                        CGRectGetWidth(self.arrowDefaultRect),
                                        CGRectGetHeight(self.arrowDefaultRect));
    _stepOneArrowBtn.titleLabel.font = arrowFont;
    _stepOneArrowBtn.alpha = 0.0f;
    [_stepOneArrowBtn setBackgroundImage:arrowImage forState:UIControlStateNormal];
    [_stepOneArrowBtn setTitle:getLocalizationString(@"auto_brand") forState:UIControlStateNormal];
    [_stepOneArrowBtn setBackgroundImage:arrowSelectedImage forState:UIControlStateSelected];
    [_stepOneArrowBtn setTitle:getLocalizationString(@"auto_brand") forState:UIControlStateSelected];
    [_stepOneArrowBtn setTag:kArrowBtnDefaultTag];
    [self addSubview:_stepOneArrowBtn];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect stepTwoRect = self.arrowDefaultRect;
    //    stepTwoRect.origin.x = CGRectGetMaxX(_stepOneArrowBtn.frame)-_arrowOverlayWidth;
    _stepTwoArrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _stepTwoArrowBtn.frame = stepTwoRect;
    _stepTwoArrowBtn.alpha = 0.0f;
    _stepTwoArrowBtn.titleLabel.font = arrowFont;
    [_stepTwoArrowBtn setBackgroundImage:arrowImage forState:UIControlStateNormal];
    [_stepTwoArrowBtn setTitle:getLocalizationString(@"auto_dealership") forState:UIControlStateNormal];
    [_stepTwoArrowBtn setBackgroundImage:arrowSelectedImage forState:UIControlStateSelected];
    [_stepTwoArrowBtn setTitle:getLocalizationString(@"auto_dealership") forState:UIControlStateSelected];
    [_stepTwoArrowBtn setTag:kArrowBtnDefaultTag+1];
    [self addSubview:_stepTwoArrowBtn];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect stepThreeRect = self.arrowDefaultRect;
    //    stepThreeRect.origin.x = CGRectGetMaxX(_stepTwoArrowBtn.frame)-_arrowOverlayWidth;
    _stepThreeArrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _stepThreeArrowBtn.frame = stepThreeRect;
    _stepThreeArrowBtn.alpha = 0.0f;
    _stepThreeArrowBtn.titleLabel.font = arrowFont;
    [_stepThreeArrowBtn setBackgroundImage:arrowImage forState:UIControlStateNormal];
    [_stepThreeArrowBtn setTitle:getLocalizationString(@"auto_series") forState:UIControlStateNormal];
    [_stepThreeArrowBtn setBackgroundImage:arrowSelectedImage forState:UIControlStateSelected];
    [_stepThreeArrowBtn setTitle:getLocalizationString(@"auto_series") forState:UIControlStateSelected];
    [_stepThreeArrowBtn setTag:kArrowBtnDefaultTag+2];
    [self addSubview:_stepThreeArrowBtn];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    CGRect stepFourRect = self.arrowDefaultRect;
    //    stepFourRect.origin.x = CGRectGetMaxX(_stepThreeArrowBtn.frame)-_arrowOverlayWidth;
    _stepFourArrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _stepFourArrowBtn.frame = stepFourRect;
    _stepFourArrowBtn.alpha = 0.0f;
    _stepFourArrowBtn.titleLabel.font = arrowFont;
    [_stepFourArrowBtn setBackgroundImage:arrowImage forState:UIControlStateNormal];
    [_stepFourArrowBtn setTitle:getLocalizationString(@"auto_model") forState:UIControlStateNormal];
    [_stepFourArrowBtn setBackgroundImage:arrowSelectedImage forState:UIControlStateSelected];
    [_stepFourArrowBtn setTitle:getLocalizationString(@"auto_model") forState:UIControlStateSelected];
    [_stepFourArrowBtn setTag:kArrowBtnDefaultTag+3];
    [self addSubview:_stepFourArrowBtn];
    
    for (int i=0; i<4; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:kArrowBtnDefaultTag+i];
        [button addTarget:self action:@selector(detectSelection:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setupUIInfoData {
    if (!self.autoBrandList) {
        [self getAutoBrandList];
    }
}

#pragma mark- UITextField Delegate And KeyBoard
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (!CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        [self shiftScrollViewWithAnimation];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self restoreScrollViewToTop];
}

- (void)keyboardWillShow:(NSNotification *)notifyObject {
    CGRect keyboardRect = [[notifyObject.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (!CGRectEqualToRect(keyboardRect, _keyboardRect)) {
        self.keyboardRect = keyboardRect;
        [self shiftScrollViewWithAnimation];
    }
    NSLog(@"Step One");
}


#pragma -mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _innerDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        [cell setBackgroundColor:CDZColorOfWhite];
        
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = CDZColorOfBlack;
    if (indexPath.row==0) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = CDZColorOfDeepGray;
    }
    cell.textLabel.text = _innerDataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.isReady = @(NO);
    [ProgressHUDHandler showHUDWithTitle:nil onView:tableView.superview.superview];
    [self selectionHandleWithRow:indexPath.row];
}

- (void)selectionHandleWithRow:(NSInteger)row {
    @autoreleasepool {
        NSMutableArray *idxList = [self mutableArrayValueForKey:@"selectionIdxList"];
        [idxList replaceObjectAtIndex:_currentStep.integerValue withObject:@(row-1)];
        
        NSString *nameString = self.innerDataList[row];
        if (row==0) nameString = @"";
        [_selectionStringList replaceObjectAtIndex:_currentStep.integerValue withObject:nameString];
    
    }
    
    NSInteger realIdx = row-1;
    if (realIdx==-1) {
        self.isReady = @(YES);
        [self setTextInInfoTextField];
        return;
    }
    switch (_currentStep.intValue) {
        case 0:
            [self getAutoDealershipListWith:[[_autoBrandList objectAtIndex:realIdx] objectForKey:kObjIDKey]];
            break;
        case 1:
            [self getAutoSeriesListWith:[[_autoDealershipList objectAtIndex:realIdx] objectForKey:kObjIDKey]];
            break;
        case 2:
            [self getAutoModelListWith:[[_autoSeriesList objectAtIndex:realIdx] objectForKey:kObjIDKey]];
            break;
            
        default:
            [self setTextInInfoTextField];
            self.isReady = @(YES);
            break;
    }
    
    
}

#pragma mark- Data Handle
- (void)handleInnerDataSwitch{
    @autoreleasepool {
        NSUInteger selectedIdx = [_selectionIdxList[_currentStep.integerValue] integerValue];
        [_innerDataList removeAllObjects];
        switch (_currentStep.intValue) {
            case 0:
                [_innerDataList addObject:getLocalizationString(@"please_select_auto_brand")];
                [_innerDataList addObjectsFromArray:[self.autoBrandList valueForKey:kObjNameKey]];
                break;
            case 1:
                [_innerDataList addObject:getLocalizationString(@"please_select_auto_dealership")];
                [_innerDataList addObjectsFromArray:[self.autoDealershipList valueForKey:kObjNameKey]];
                break;
            case 2:
                [_innerDataList addObject:getLocalizationString(@"please_select_auto_series")];
                [_innerDataList addObjectsFromArray:[self.autoSeriesList valueForKey:kObjNameKey]];
                break;
            case 3:
                [_innerDataList addObject:getLocalizationString(@"please_select_auto_model")];
                [_innerDataList addObjectsFromArray:[self.autoModelList valueForKey:kObjNameKey]];
                break;
            default:
                break;
        }
        [_tableView reloadData];
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIdx+1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (void)clearSelectedIdxWithStepIdx:(NSInteger)idx {
    @autoreleasepool {
        switch (idx) {
            case 1:
                [_selectionIdxList replaceObjectAtIndex:0 withObject:@(-1)];
                [_selectionIdxList replaceObjectAtIndex:1 withObject:@(-1)];
                [_selectionIdxList replaceObjectAtIndex:2 withObject:@(-1)];
                [_selectionStringList replaceObjectAtIndex:0 withObject:@""];
                [_selectionStringList replaceObjectAtIndex:1 withObject:@""];
                [_selectionStringList replaceObjectAtIndex:2 withObject:@""];
                [_selectionStringList replaceObjectAtIndex:3 withObject:@""];
                break;
            case 2:
                [_selectionIdxList replaceObjectAtIndex:1 withObject:@(-1)];
                [_selectionIdxList replaceObjectAtIndex:2 withObject:@(-1)];
                break;
            case 3:
                [_selectionIdxList replaceObjectAtIndex:2 withObject:@(-1)];
                break;
                
            default:
                break;
        }
        [_selectionIdxList replaceObjectAtIndex:3 withObject:@(-1)];
        [_selectionStringList replaceObjectAtIndex:3 withObject:@""];
        [self setTextInInfoTextField];
    }
}

- (void)handleResponseData:(NSArray *)responseObject withIdent:(NSInteger)ident{
    @autoreleasepool {
        if (responseObject.count==0||!responseObject) {
            NSString *messageKey = [NSString stringWithFormat:@"auto_data_error_%ld",(long)ident];
            NSString *errorStr = getLocalizationString(messageKey);
            NSLog(@"%@",errorStr);
            return;
        }
        [self clearSelectedIdxWithStepIdx:ident];
        switch (ident) {
            case 1:
                self.autoBrandList = responseObject;
                [self handleInnerDataSwitch];
                break;
            case 2:
                self.autoDealershipList = responseObject;
                [_selectionIdxList replaceObjectAtIndex:1 withObject:@(-1)];
                [_selectionIdxList replaceObjectAtIndex:2 withObject:@(-1)];
                [_selectionIdxList replaceObjectAtIndex:3 withObject:@(-1)];
                break;
            case 3:
                self.autoSeriesList = responseObject;
                [_selectionIdxList replaceObjectAtIndex:2 withObject:@(-1)];
                [_selectionIdxList replaceObjectAtIndex:3 withObject:@(-1)];
                break;
            case 4:
                self.autoModelList = responseObject;
                [_selectionIdxList replaceObjectAtIndex:3 withObject:@(-1)];
                break;
            default:
                break;
        }
    }
}

#pragma mark- Access Net Data
- (void)getAutoBrandList {
    self.isReady = @(NO);
    [[APIsConnection shareConnection] commonAPIsGetAutoBrandListWithSuccessBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(1)};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)getAutoDealershipListWith:(NSString *)autoBrandID {
    [[APIsConnection shareConnection] commonAPIsGetAutoBrandDealershipListWithBrandID:autoBrandID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(2)};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)getAutoSeriesListWith:(NSString *)autoDealershipID {
    [[APIsConnection shareConnection] commonAPIsGetAutoSeriesListWithBrandDealershipID:autoDealershipID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(3)};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)getAutoModelListWith:(NSString *)autoSeriesID {
    [[APIsConnection shareConnection] commonAPIsGetAutoModelListWithAutoSeriesID:autoSeriesID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        operation.userInfo = @{@"ident":@(4)};
        [self requestResultHandle:operation responseObject:responseObject withError:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestResultHandle:operation responseObject:nil withError:error];
    }];
}

- (void)requestResultHandle:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject withError:(NSError *)error {
    if (error&&!responseObject) {
        NSLog(@"Error:::>%@",error);
    }else if (!error&&responseObject) {
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSInteger identID = [[operation.userInfo objectForKey:@"ident"] integerValue];
        switch (errorCode) {
            case 0:
                [self handleResponseData:[responseObject objectForKey:CDZKeyOfResultKey] withIdent:identID];
                break;
            case 2:{
                NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
                NSLog(@"%@",message);
            }
                break;
                
            default:
                break;
        }
    }
    self.isReady = @(YES);
}

#pragma mark- draw Image
- (UIImage *)drawRectangeleArrow:(UIColor *)arrowColor withSize:(CGSize)size{
    
    size.width *= [[UIScreen mainScreen] scale];
    size.height *= [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Shadow Declarations
    UIColor* shadow = UIColor.lightGrayColor;
    CGSize shadowOffset = CGSizeMake(-4.1, -0.1);
    CGFloat shadowBlurRadius = size.width*0.1f;
    
    UIBezierPath* starPath = UIBezierPath.bezierPath;
    [starPath moveToPoint: CGPointMake(size.width*0.1f, 0.0f)];
    [starPath addLineToPoint: CGPointMake(size.width*0.8f, 0.0f)];
    [starPath addLineToPoint: CGPointMake(size.width, size.height/2.0f)];
    [starPath addLineToPoint: CGPointMake(size.width*0.8f, size.height)];
    [starPath addLineToPoint: CGPointMake(size.width*0.1f, size.height)];
    //    [starPath addLineToPoint: CGPointMake(size.width*0.2f, size.height/2.0f)];
    [starPath closePath];
    if (!arrowColor) {
        arrowColor = UIColor.grayColor;
    }
    
    //    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, [shadow CGColor]);
    [arrowColor setFill];
    [starPath fill];
    
    CGContextAddPath(context, starPath.CGPath);
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


@end

