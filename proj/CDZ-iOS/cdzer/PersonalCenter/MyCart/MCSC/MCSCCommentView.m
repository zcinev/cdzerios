//
//  MCSCCommentView.m
//  cdzer
//
//  Created by KEns0n on 7/20/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MCSCCommentView.h"
#import "InsetsLabel.h"

@interface MCSCCommentView ()<UITextViewDelegate>

@property (nonatomic, assign) CGPoint lastPoint;

@property (nonatomic, assign) CGRect keyboardRect;

@property (nonatomic, assign) id target;

@property (nonatomic, assign) SEL action;

@end

@implementation MCSCCommentView

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
    self.target = nil;
    self.action = nil;
    self.containerView = nil;
}

- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializationUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGRect rect = self.textView.frame;
    rect.size.width = CGRectGetWidth(frame)-30.0f;
    self.textView.frame = rect;
}

- (void)initializationUI {
    self.contentView.backgroundColor = CDZColorOfWhite;
    
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
    
    _titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 26.0f) andEdgeInsetsValue:DefaultEdgeInsets];
    _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = YES;
    [self.contentView addSubview:_titleLabel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(15.0f, CGRectGetMaxY(_titleLabel.frame), 30.0f, 60.0f)];
    _textView.delegate = self;
    _textView.inputAccessoryView = toolbar;
    [_textView setViewBorderWithRectBorder:UIRectBorderAllBorderEdge borderSize:0.5f withColor:nil withBroderOffset:nil];
    [_textView setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
    [self addSubview:_textView];
    

}

- (void)hiddenKeyboard {
    [_textView resignFirstResponder];
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        if ([self.containerView isKindOfClass:UIScrollView.class]) {
            [(UIScrollView *)self.containerView setContentOffset:self.lastPoint];
        }else {
            CGRect frame = [(UIView *)self.containerView frame];
            frame.origin.y = self.lastPoint.y;
            [(UIView *)self.containerView setFrame:frame];
        }
    }];
}



- (void)keyboardWillShow:(NSNotification *)notifyObject {
    if ([_textView isFirstResponder]) {
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
    CGRect txtViewRect = [self convertRect:_textView.frame toView:self.superview];
    CGRect convertRect = [self.superview convertRect:txtViewRect toView:_containerView];
    CGFloat contanierViewMaxY = CGRectGetMidY(convertRect);
    CGFloat visibleContentsHeight = (CGRectGetHeight([(UIView *)_containerView frame])-CGRectGetHeight(_keyboardRect))/2.0f;
    if (contanierViewMaxY > visibleContentsHeight) {
        CGFloat offsetY = contanierViewMaxY-visibleContentsHeight;
        point.y = offsetY;
    }
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        if ([self.containerView isKindOfClass:UIScrollView.class]) {
            [(UIScrollView *)self.containerView setContentOffset:point];
        }else {
            CGRect frame = [(UIView *)self.containerView frame];
            frame.origin.y = self.lastPoint.y - point.y;
            [(UIView *)self.containerView setFrame:frame];
        }
    }];
    
}

- (void)addTarget:(id)target action:(SEL)action {
    self.target = target;
    self.action = action;
}


#pragma mark- UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([_containerView isKindOfClass:UIScrollView.class]) {
        self.lastPoint = [(UIScrollView *)_containerView contentOffset];
    }else {
        self.lastPoint = [(UIView *)_containerView frame].origin;
    }
    
    if (!CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        [self shiftScrollViewWithAnimation];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [_target performSelectorInBackground:_action withObject:self];
}

- (void)textViewDidChange:(UITextView *)textView {
    [_target performSelectorInBackground:_action withObject:self];
}

@end
