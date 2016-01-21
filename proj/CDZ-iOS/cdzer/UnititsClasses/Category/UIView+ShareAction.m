//
//  UIView+ShareAction.m
//  cdzer
//
//  Created by KEns0n on 3/3/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "UIView+ShareAction.h"
#import <UIView+Borders/UIView+Borders.h>

@implementation UIView (ShareAction)
@dynamic shapeLayer;
static char key;

- (void) setShapeLayer:(CAShapeLayer *)shapeLayer {
    objc_setAssociatedObject(self,&key,shapeLayer,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *) shapeLayer {
     return (id)objc_getAssociatedObject(self, &key);
}

- (void)setBackgroundImageByCALayerWithImage:(UIImage *)image {
    @autoreleasepool {
        if (!image) return;
        
        if (self.layer.contents) self.layer.contents = nil;
        
        self.layer.contents = (id) image.CGImage;
    }
}

- (void)setBorderWithColor:(UIColor *)color borderWidth:(CGFloat)width {
    if (!color) color = [UIColor colorWithRed:0.847f green:0.843f blue:0.835f alpha:1.00f];
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    
}

- (void)setViewCornerWithRectCorner:(UIRectCorner)rectCorner cornerSize:(CGFloat)cornerSize {
    @autoreleasepool {
        static NSString *cornerSetting  = @"CornerSetting";
        self.layer.masksToBounds = YES;
        if (self.layer.mask&&[self.layer.mask.name isEqualToString:cornerSetting]) {
            [self.layer.mask removeFromSuperlayer];
        }
        if (rectCorner == UIRectCornerAllCorners||rectCorner==(UIRectCornerBottomLeft|UIRectCornerBottomRight|UIRectCornerTopLeft|UIRectCornerTopRight)) {
            self.layer.cornerRadius = cornerSize;
            return;
        }
        if (cornerSize<=0) {
            cornerSize = 5.0f;
        }
        self.layer.mask = nil;
        UIBezierPath *maskPath;
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:rectCorner
                                               cornerRadii:CGSizeMake(cornerSize, cornerSize)];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.name = cornerSetting;
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
    
}

- (void)setViewBorderWithRectBorder:(UIRectBorder)rectBorder borderSize:(CGFloat)borderSize withColor:(UIColor *)color withBroderOffset:(BorderOffsetObject *)borderOffset {
    @autoreleasepool {
        static NSString *borderTop = @"BorderTop";
        static NSString *borderLeft = @"BorderLeft";
        static NSString *borderBottom = @"BorderBottom";
        static NSString *borderRight = @"BorderRight";
        self.layer.borderColor = nil;
        self.layer.borderWidth = 0.0f;
        
        NSArray *array = @[borderTop, borderLeft, borderBottom, borderRight];
        NSArray *sublayer = self.layer.sublayers;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [sublayer enumerateObjectsUsingBlock:^(id layer, NSUInteger layerIdx, BOOL *subStop) {
                if ([layer isKindOfClass:CALayer.class]) {
                    if ([[(CALayer *)layer name] isEqualToString:obj]) {
                        [(CALayer *)layer removeFromSuperlayer];
                        NSLog(@"%@",[(CALayer *)layer name]);
                    }
                }
            }];
        }];
        
        if (rectBorder&UIRectBorderNone&&rectBorder!=UIRectBorderAllBorderEdge) {
            [self setBorderWithColor:CDZColorOfClearColor borderWidth:0.0f];
            return;
        }
        
        if (rectBorder == UIRectBorderAllBorderEdge||rectBorder==(UIRectBorderTop|UIRectBorderLeft|UIRectBorderBottom|UIRectBorderRight)) {
            [self setBorderWithColor:color borderWidth:borderSize];
            return;
        }
        if (!borderOffset) {
            borderOffset = [BorderOffsetObject new];
        }
        if (UIRectBorderLeft&rectBorder) {
            CALayer *layer = [self createLeftBorderWithWidth:borderSize color:color
                                                  leftOffset:borderOffset.leftOffset
                                                   topOffset:borderOffset.leftUpperOffset
                                             andBottomOffset:borderOffset.leftBottomOffset ];
            layer.name = borderLeft;
            [self.layer addSublayer:layer];
        }
        if (UIRectBorderRight&rectBorder) {
            CALayer *layer = [self createRightBorderWithWidth:borderSize color:color
                                                  rightOffset:borderOffset.rightOffset
                                                    topOffset:borderOffset.rightUpperOffset
                                              andBottomOffset:borderOffset.rightBottomOffset ];
            layer.name = borderRight;
            [self.layer addSublayer:layer];
            
        }
        if (UIRectBorderBottom&rectBorder) {
            CALayer *layer = [self createBottomBorderWithHeight:borderSize color:color
                                                     leftOffset:borderOffset.bottomLeftOffset
                                                    rightOffset:borderOffset.bottomRightOffset
                                                andBottomOffset:borderOffset.bottomOffset];
            layer.name = borderBottom;
            [self.layer addSublayer:layer];
            
        }
        if (UIRectBorderTop&rectBorder) {
            CALayer *layer = [self createTopBorderWithHeight:borderSize color:color
                                                  leftOffset:borderOffset.upperLeftOffset
                                                 rightOffset:borderOffset.upperRightOffset
                                                andTopOffset:borderOffset.upperOffset];
            layer.name = borderTop;
            [self.layer addSublayer:layer];
            
        }
        
    }
    
}


- (UIColor *)getDefaultBGColor {
    return [SupportingClass colorWithHexString:@"EEEEEE"];
}

- (UIColor *)getDefaultSeparatorLineColor {
    return [SupportingClass colorWithHexString:@"E5E5E5"];
}

- (UIColor *)getDefaultSeparatorLineDarkColor {
    return [SupportingClass colorWithHexString:@"CCCCCC"];
}

- (UIColor *)getDefaultTextColor {
    return [SupportingClass colorWithHexString:@"666666"];
}

- (UIColor *)getDefaultTextDarkColor {
    return [SupportingClass colorWithHexString:@"333333"];
}

- (UIColor *)getDefaultTimeTextColor {
    return [SupportingClass colorWithHexString:@"999999"];
}

@end

@implementation BorderOffsetObject

- (instancetype)init {
    self = [super init];
    if (self) {
        
        
        self.upperOffset = 0.0f;
        
        self.upperLeftOffset = 0.0f;
        
        self.upperRightOffset = 0.0f;
        
        
        self.bottomOffset = 0.0f;
        
        self.bottomLeftOffset = 0.0f;
        
        self.bottomRightOffset = 0.0f;
        
        
        self.leftOffset = 0.0f;
        
        self.leftUpperOffset = 0.0f;
        
        self.leftBottomOffset = 0.0f;
        
        
        self.rightOffset = 0.0f;
        
        self.rightUpperOffset = 0.0f;
        
        self.rightBottomOffset = 0.0f;

    }
    return self;
}

@end

