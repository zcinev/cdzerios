//
//  NAUIViewWithBorders.h
//  NAUIViewWithBordersDemo
//
//  Created by Nathan Rowe on 1/3/14.
//  Copyright (c) 2014 Natrosoft LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kNABorderTop;
extern NSString * const kNABorderBottom;
extern NSString * const kNABorderLeft;
extern NSString * const kNABorderRight;

/*!
 @abstract
 UIView subview that allows individual borders to be drawn.
 Nil colors for a side will not be drawn.  If borderColorAll
 is used, it will have priority and each individual color does
 not need to be assigned.  Be sure to set borderWidths accordingly.
 Borders are drawn from the view's edge inward.
 */
@interface NAUIViewWithBorders : UIView
{}
@property UIEdgeInsets borderWidths;                    /* For specifying individual widths */
@property CGFloat borderWidthsAll;                      /* If set, overrides individual widths */
@property (nonatomic, strong) UIColor *borderColorAll;  /* If set, overrides individual colors */
@property (nonatomic, strong) UIColor *borderColorTop;
@property (nonatomic, strong) UIColor *borderColorBottom;
@property (nonatomic, strong) UIColor *borderColorLeft;
@property (nonatomic, strong) UIColor *borderColorRight;
/*!
 @abstract
 Optional.  Specifies the order of drawing the sides.
 Defaults to kNABorderLeft, kNABorderRight, kNABorderTop, kNABorderBottom.
 If provided, any omitted sides will not be drawn.
 
 @discussion
 For example, the default order will draw the top and bottom borders over top of the
 left and right borders.
 e.g.
 --------
 |      |
 --------
 An order of top, right, bottom, left would look like:
 |-------|
 |       |
 |--------
 */
@property (nonatomic, strong) NSOrderedSet *drawOrder;



@end
