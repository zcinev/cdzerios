//
//  ERepairFormCell.m
//  cdzer
//
//  Created by KEns0n on 11/4/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "ERepairFormCell.h"
#import "InsetsTextField.h"
#import "IQDropDownTextField.h"

@interface ERepairFormCell() <IQDropDownTextFieldDelegate, UITextFieldDelegate>

@property (nonatomic, strong) InsetsLabel *displayLabel;

@property (nonatomic, assign) CGRect keyboardRect;

@end

@implementation ERepairFormCell

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializationUI];
        self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}


- (void)initializationUI {
    @autoreleasepool {
        
        UIToolbar *toolBar =  [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 40.0f)];
        [toolBar setBarStyle:UIBarStyleDefault];
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                    target:self
                                                                                    action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:getLocalizationString(@"finish")
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(hiddenKeyboard)];
        NSArray * buttonsArray = [NSArray arrayWithObjects:spaceButton,doneButton,nil];
        [toolBar setItems:buttonsArray];
        
        UIEdgeInsets insetValue = DefaultEdgeInsets;
        insetValue.right = 5.0f;
        
        self.textField = [[InsetsTextField alloc] initWithFrame:self.bounds
                                             andEdgeInsetsValue:insetValue];
        _textField.hidden = YES;
        _textField.delegate = self;
        _textField.inputAccessoryView = toolBar;
        _textField.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14.0f, NO);
        [self addSubview:_textField];
        
        self.dateTimeTextField = [[IQDropDownTextField alloc] initWithFrame:self.bounds
                                                         andEdgeInsetsValue:insetValue];
        _dateTimeTextField.hidden = YES;
        _dateTimeTextField.delegate = self;
        _dateTimeTextField.font = _textField.font;
        _dateTimeTextField.inputAccessoryView = toolBar;
        _dateTimeTextField.dropDownMode = IQDropDownModeTimePicker;
        [self addSubview:_dateTimeTextField];
        
        self.displayLabel = [[InsetsLabel alloc] initWithFrame:self.bounds
                                            andEdgeInsetsValue:insetValue];
        _displayLabel.hidden = YES;
        _displayLabel.font = _textField.font;
        [self addSubview:_displayLabel];
        
        self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.hidden = YES;
        [self addSubview:_actionButton];
        
        self.textLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 17.0f, NO);;
        self.contentView.backgroundColor = CDZColorOfClearColor;
        self.backgroundColor = CDZColorOfClearColor;

        self.accessoryView = [[UIImageView alloc] initWithImage:ImageHandler.getRightArrow];
    }
}

- (void)keyboardWillShow:(NSNotification *)notifyObject {
    CGRect keyboardRect = [[notifyObject.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (!self.dateTimeTextField.isFirstResponder&&!self.textField.isFirstResponder) return;
    if (!CGRectEqualToRect(keyboardRect, _keyboardRect)) self.keyboardRect = keyboardRect;
    
    NSLog(@"%@",self.description);
    NSDictionary *userInfo = @{@"indexPath":_indexPath, @"keyboardRect":[NSValue valueWithCGRect:_keyboardRect], @"resignResponder":@NO};
    [NSNotificationCenter.defaultCenter postNotificationName:CDZNotiKeyOfUpdateScrollViewOffset object:nil userInfo:userInfo];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"stepOne");
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"stepTwo");
    return YES;
}

- (void)hiddenKeyboard {
    [_textField resignFirstResponder];
    [_dateTimeTextField resignFirstResponder];
    NSDictionary *userInfo = @{@"indexPath":_indexPath, @"resignResponder":@YES};
    [NSNotificationCenter.defaultCenter postNotificationName:CDZNotiKeyOfUpdateScrollViewOffset object:nil userInfo:userInfo];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    [self bringSubviewToFront:self.accessoryView];
    
    CGFloat width = CGRectGetWidth(self.frame)*0.6f;
    CGFloat offsetX = CGRectGetWidth(self.frame)*0.4f-10.0f;
    self.textField.frame = CGRectMake(offsetX, 4.0f, width, 40.0f);
    self.dateTimeTextField.frame = self.textField.frame;
    self.displayLabel.frame = self.textField.frame;
    self.actionButton.frame = self.textField.frame;
    
    
    [_textField setViewBorderWithRectBorder:UIRectBorderAllBorderEdge borderSize:0.5 withColor:CDZColorOfDeepGray withBroderOffset:nil];
    [_dateTimeTextField setViewBorderWithRectBorder:UIRectBorderAllBorderEdge borderSize:0.5 withColor:CDZColorOfDeepGray withBroderOffset:nil];
    [_displayLabel setViewBorderWithRectBorder:UIRectBorderAllBorderEdge borderSize:0.5 withColor:CDZColorOfDeepGray withBroderOffset:nil];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
