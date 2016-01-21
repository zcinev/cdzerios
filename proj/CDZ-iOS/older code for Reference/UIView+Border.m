//
//  UIView+Border.m
//  cdzer
//
//  Created by KEns0n on 3/3/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)
@dynamic shapeLayer;
static char key;

- (void) setShapeLayer:(CAShapeLayer *)shapeLayer {
    objc_setAssociatedObject(self,&key,shapeLayer,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *) shapeLayer {
     return (id)objc_getAssociatedObject(self, &key);
}
@end
