//
//  NAUIViewWithBorders.m
//  NAUIViewWithBordersDemo
//
//  Created by Nathan Rowe on 1/3/14.
//  Copyright (c) 2014 Natrosoft LLC. All rights reserved.
//

#import "NAUIViewWithBorders.h"

NSString * const kNABorderTop                   = @"com.natrosoft.NABorderTop";
NSString * const kNABorderBottom                = @"com.natrosoft.NABorderBottom";
NSString * const kNABorderLeft                  = @"com.natrosoft.NABorderLeft";
NSString * const kNABorderRight                 = @"com.natrosoft.NABorderRight";
#define kNAUIViewWithBorders_DefaultDrawOrder   @[kNABorderLeft, kNABorderRight, kNABorderTop, kNABorderBottom]


@interface NAUIViewWithBorders ()
@end



@implementation NAUIViewWithBorders

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _borderWidthsAll = -1.0f;
        //custom initialization
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    if (_borderColorAll) {
        _borderColorTop = _borderColorBottom = _borderColorLeft = _borderColorRight = _borderColorAll;
    }
    
    //ivars for speed
    CGFloat xMin = CGRectGetMinX(rect);
    CGFloat xMax = CGRectGetMaxX(rect);
    
    CGFloat yMin = CGRectGetMinY(rect);
    CGFloat yMax = CGRectGetMaxY(rect);
    
    CGFloat fWidth = self.frame.size.width;
    CGFloat fHeight = self.frame.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (!_drawOrder) {
        _drawOrder = [NSOrderedSet orderedSetWithArray:kNAUIViewWithBorders_DefaultDrawOrder];
    }
    if (_borderWidthsAll > 0) {
        _borderWidths = UIEdgeInsetsMake(_borderWidthsAll, _borderWidthsAll, _borderWidthsAll, _borderWidthsAll);
    }
    
    //Draw the borders in the specified order-----
    for (id item in _drawOrder)
    {
        if ([item isKindOfClass:[NSString class]])
        {
            [self drawBorder:(NSString*)item
                   inContext:context
                        xMin:xMin
                        xMax:xMax
                        yMin:yMin
                        yMax:yMax
                  frameWidth:fWidth
                 frameHeight:fHeight];
        }
    }
}


- (void) drawBorder:(NSString *)borderName
          inContext:(CGContextRef)context
               xMin:(CGFloat)xMin
               xMax:(CGFloat)xMax
               yMin:(CGFloat)yMin
               yMax:(CGFloat)yMax
         frameWidth:(CGFloat)fWidth
        frameHeight:(CGFloat)fHeight
{
    //Draw the respective border if valid--------------
    
    if (borderName == kNABorderLeft)
    {
        if ( _borderColorLeft) {
            CGContextSetFillColorWithColor(context, _borderColorLeft.CGColor);
            CGContextFillRect(context, CGRectMake(xMin, yMin, _borderWidths.left, fHeight));
        }
    }
    else if (borderName == kNABorderRight)
    {
        if (_borderColorRight) {
            CGContextSetFillColorWithColor(context, _borderColorRight.CGColor);
            CGContextFillRect(context, CGRectMake(xMax - _borderWidths.right, yMin, _borderWidths.right, fHeight));
        }
    }
    else if (borderName == kNABorderBottom)
    {
        if ( _borderColorBottom) {
            CGContextSetFillColorWithColor(context, _borderColorBottom.CGColor);
            CGContextFillRect(context, CGRectMake(xMin, yMax - _borderWidths.bottom, fWidth, _borderWidths.bottom));
        }
    }
    else if (borderName == kNABorderTop)
    {
        if ( _borderColorTop) {
            CGContextSetFillColorWithColor(context, _borderColorTop.CGColor);
            CGContextFillRect(context, CGRectMake(xMin, yMin, fWidth, _borderWidths.top));
        }
    }
}

@end
