//
//  MessageAlertCell.m
//  cdzer
//
//  Created by KEns0n on 6/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vTopHeight 25.0f
#define vMediumHeight 18.0f

#import "MessageAlertCell.h"
#import "InsetsLabel.h"
@interface MessageAlertCell ()
@property (nonatomic, strong) InsetsLabel *titleLabel;

@property (nonatomic, strong) InsetsLabel *dateTimeLabel;

@property (nonatomic, strong) InsetsLabel *statusLabel;

@property (nonatomic, strong) InsetsLabel *messageDetailLabel;

@end

@implementation MessageAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializationUI];
    }
    return self;
}

- (void)initializationUI {
    @autoreleasepool {
        UIEdgeInsets insetsValue = DefaultEdgeInsets;
        if (!_titleLabel) {
            self.titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.frame), vTopHeight)
                                                       andEdgeInsetsValue:insetsValue];
            _titleLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 17, NO);
            _titleLabel.textAlignment = NSTextAlignmentLeft;
            _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
            _titleLabel.translatesAutoresizingMaskIntoConstraints = YES;
            _titleLabel.textColor = CDZColorOfBlack;
            [self.contentView addSubview:_titleLabel];
        }
        
        if (!_statusLabel) {
            self.statusLabel = [[InsetsLabel alloc] initWithFrame:_titleLabel.frame
                                                        andEdgeInsetsValue:insetsValue];
            
            _statusLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfLight, 14, NO);
            _statusLabel.textAlignment = NSTextAlignmentRight;
            _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
            _statusLabel.translatesAutoresizingMaskIntoConstraints = YES;
            _statusLabel.textColor = CDZColorOfDeepGray;
            [self.contentView addSubview:_statusLabel];
        }
        
        if (!_dateTimeLabel) {
            self.dateTimeLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(self.contentView.frame), vMediumHeight)
                                                          andEdgeInsetsValue:insetsValue];
            _dateTimeLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfLight, 14, NO);
            _dateTimeLabel.textAlignment = NSTextAlignmentLeft;
            _dateTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin;
            _dateTimeLabel.translatesAutoresizingMaskIntoConstraints = YES;
            _dateTimeLabel.textColor = CDZColorOfDeepGray;
            [self.contentView addSubview:_dateTimeLabel];
        }
        
        if (!_messageDetailLabel) {
            self.messageDetailLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_dateTimeLabel.frame), CGRectGetWidth(self.contentView.frame),
                                                                                    CGRectGetHeight(self.contentView.frame)-CGRectGetMaxY(_dateTimeLabel.frame))
                                                               andEdgeInsetsValue:insetsValue];
            
            _messageDetailLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16, NO);
            _messageDetailLabel.textAlignment = NSTextAlignmentLeft;
            _messageDetailLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleHeight;
            _messageDetailLabel.translatesAutoresizingMaskIntoConstraints = YES;
            _messageDetailLabel.textColor = CDZColorOfDeepGray;
            _messageDetailLabel.numberOfLines = 0;
            [self.contentView addSubview:_messageDetailLabel];
        }
    }
}

- (void)updateUIDataWithData:(NSDictionary *)dataDetail {
//content: "亲爱的用户，百城1已经接受了您的预约，请您在2015-06-30 09前去维修！【车队长】",
//msg_type: "维修消息",
//create_time: "2015-06-06 09:24:08 ",
//state_name: "未读"
    
    _titleLabel.text = dataDetail[@"msg_type"];
    _dateTimeLabel.text = [@"发送时间：" stringByAppendingString:dataDetail[@"create_time"]];
    _statusLabel.text = [@"状态：" stringByAppendingString:dataDetail[@"state_name"]];
    _messageDetailLabel.text = dataDetail[@"content"];
    
}

+ (CGFloat)getDynamicHeight:(NSDictionary *)dataDetail {
    UIEdgeInsets insetsValue = DefaultEdgeInsets;
    NSString *string = dataDetail[@"content"];
    CGFloat width = CGRectGetWidth(UIScreen.mainScreen.bounds)-insetsValue.left-insetsValue.right;
    CGFloat height = [SupportingClass getStringSizeWithString:string font:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16, NO) widthOfView:CGSizeMake(width, CGFLOAT_MAX)].height;
    height += (vMediumHeight+vTopHeight+18.0f);
    
    return height;
}

@end
