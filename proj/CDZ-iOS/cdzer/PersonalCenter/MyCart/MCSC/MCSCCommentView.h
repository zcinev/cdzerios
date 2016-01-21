//
//  MCSCCommentView.h
//  cdzer
//
//  Created by KEns0n on 7/20/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InsetsLabel;

@interface MCSCCommentView : UITableViewHeaderFooterView

@property (nonatomic, readonly, strong) InsetsLabel *titleLabel;

@property (nonatomic, readonly, strong) UITextView *textView;

@property (nonatomic, assign) id containerView;

@property (nonatomic, assign) NSUInteger identTag;

- (void)addTarget:(id)target action:(SEL)action;

@end
