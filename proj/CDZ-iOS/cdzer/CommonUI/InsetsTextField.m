//
//  InsetsTextField.m
//  cdzer
//
//  Created by KEns0n on 3/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "InsetsTextField.h"

@implementation InsetsTextField

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}


- (void)setandEdgeInsetsValue:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame andEdgeInsetsValue:(UIEdgeInsets)edgeInsets {
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = edgeInsets;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder andEdgeInsetsValue:(UIEdgeInsets)edgeInsets {
    self = [super initWithCoder:aDecoder];
    if(self){
        self.edgeInsets = edgeInsets;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self){
        self.edgeInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds{
    return [super clearButtonRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}


@end
