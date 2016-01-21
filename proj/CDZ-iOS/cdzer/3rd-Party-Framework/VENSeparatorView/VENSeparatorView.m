#import "VENSeparatorView.h"

#define DefaultFillColor [UIColor lightGrayColor]
#define DefaultStrokeColor [UIColor grayColor]
#define DefaultContentFillColor CDZColorOfWhite

static CGFloat DefaultBorderWidth = 0.50f;
static NSInteger DefaultJaggedEdgeHorizontalVertexDistance = 6;
static NSInteger DefaultJaggedEdgeVerticalVertexDistance = 5;
static

@interface VENSeparatorView ()

@property (nonatomic, strong) NSMutableArray *separatorTopPointArray;

@property (nonatomic, strong) NSMutableArray *separatorBottomPointArray;

@property (nonatomic, assign) CGFloat jaggedSeparatorTopLastStrokePositionY;

@property (nonatomic, assign) CGFloat jaggedSeparatorBottomLastStrokePositionY;

@end

@implementation VENSeparatorView

- (instancetype)initWithFrame:(CGRect)frame
         topLineSeparatorType:(VENSeparatorType)topLineSeparatorType
      bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor    = [UIColor clearColor];
        _topSeparatorType       = topLineSeparatorType;
        _bottomSeparatorType    = bottomLineSeparatorType;
        _jaggedSeparatorTopLastStrokePositionY = 0;
        _jaggedSeparatorBottomLastStrokePositionY = CGRectGetHeight(frame);
        _isNeedLRSideBorder = NO;
        _isNeedSetContentColor = YES;
        if (!_separatorTopPointArray) {
            [self setSeparatorTopPointArray:[NSMutableArray array]];
        }
        if (!_separatorBottomPointArray) {
            [self setSeparatorBottomPointArray:[NSMutableArray array]];
        }
        
    }
    return self;
}

- (void)setIsNeedLRSideBorder:(BOOL)isNeedLRSideBorder {
    _isNeedLRSideBorder = isNeedLRSideBorder;
}

- (void)setTopLineSeparatorType:(VENSeparatorType)topLineSeparatorType
        bottomLineSeparatorType:(VENSeparatorType)bottomLineSeparatorType {
    self.topSeparatorType       = topLineSeparatorType;
    self.bottomSeparatorType    = bottomLineSeparatorType;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    UIColor *topStrokeColor  = self.topStrokeColor ?: DefaultStrokeColor;
    UIColor *bottomStrokeColor  = self.bottomStrokeColor ?: DefaultStrokeColor;
    
    CGFloat topBorderWidth = self.topBorderWidth ?: DefaultBorderWidth;
    CGFloat bottomBorderWidth = self.bottomBorderWidth ?: DefaultBorderWidth;

    switch (self.topSeparatorType) {
        case VENSeparatorTypeStraight:
            [self drawSeparatorAtPosition:VENSeparatorPositionTop
                                     type:VENSeparatorTypeStraight
                              strokeColor:topStrokeColor
                              borderWidth:topBorderWidth];
            break;
        case VENSeparatorTypeJagged:
            [self drawSeparatorAtPosition:VENSeparatorPositionTop
                                     type:VENSeparatorTypeJagged
                              strokeColor:topStrokeColor
                              borderWidth:topBorderWidth];
            break;
        default:
            break;
    }
    switch (self.bottomSeparatorType) {
        case VENSeparatorTypeStraight:
            [self drawSeparatorAtPosition:VENSeparatorPositionBottom
                                     type:VENSeparatorTypeStraight
                              strokeColor:bottomStrokeColor
                              borderWidth:bottomBorderWidth];
            break;
        case VENSeparatorTypeJagged:
            [self drawSeparatorAtPosition:VENSeparatorPositionBottom
                                     type:VENSeparatorTypeJagged
                              strokeColor:bottomStrokeColor
                              borderWidth:bottomBorderWidth];
            break;
        default:
            break;
    }
    
    [self drawContentColor];
    [self drawLRSideleftBorder];
}

- (void)drawContentColor {
    if (!_isNeedSetContentColor) return;
    @weakify(self)    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat topBorderWidth = self.topBorderWidth ?: DefaultBorderWidth;
    CGFloat bottomBorderWidth = self.bottomBorderWidth ?: DefaultBorderWidth;
    
    [path moveToPoint:CGPointMake(topBorderWidth, CGRectGetHeight(self.frame)-bottomBorderWidth)];
    [path addLineToPoint:CGPointMake(0.0f, 0.0f)];
    if(_topSeparatorType == VENSeparatorTypeJagged){
        [_separatorTopPointArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @strongify(self)
            if ([obj isKindOfClass:[NSString class]]) {
                CGPoint point = CGPointFromString((NSString *)obj);
                if ([obj isEqual:[self.separatorTopPointArray lastObject]]) {
                    point.y = self.jaggedSeparatorTopLastStrokePositionY;
                }
                [path addLineToPoint:point];
            }
        }];
    }else {
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-topBorderWidth, 0.0f)];
    }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-bottomBorderWidth, _jaggedSeparatorTopLastStrokePositionY)];
    
    if(_bottomSeparatorType == VENSeparatorTypeJagged){
        [_separatorBottomPointArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @strongify(self)
            if ([obj isKindOfClass:[NSString class]]) {
                CGPoint point = CGPointFromString((NSString *)obj);
                if ([obj isEqual:[self.separatorBottomPointArray firstObject]]) {
                    point.y = self.jaggedSeparatorBottomLastStrokePositionY;
                }
                [path addLineToPoint:point];
            }
        }];
    }else {
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-bottomBorderWidth, CGRectGetHeight(self.frame))];
    }
    
    UIColor *fillColor = self.contentFillColor ?: DefaultContentFillColor;
    [fillColor setFill];
    [path closePath];
    [path fill];
    
}

- (void)drawLRSideleftBorder {
    if (!_isNeedLRSideBorder) return;
    
    
    CGFloat topBorderWidth = self.topBorderWidth ?: DefaultBorderWidth;
    CGFloat bottomBorderWidth = self.bottomBorderWidth ?: DefaultBorderWidth;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = self.leftRightOfSideBorderWidth ?: DefaultBorderWidth;
    
    CGFloat offset = path.lineWidth/2;
    
    [path moveToPoint:CGPointMake(offset, 0.0f)];
    
    [path addLineToPoint:CGPointMake(offset, CGRectGetHeight(self.frame)-offset*2)];
    
    [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame)-offset, _jaggedSeparatorTopLastStrokePositionY ?: topBorderWidth)];
    
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)-offset, _jaggedSeparatorBottomLastStrokePositionY ?: CGRectGetHeight(self.frame)-bottomBorderWidth)];
    
    UIColor *strokeColor = self.leftRightOfSideStrokeColor ?: DefaultStrokeColor;
    [strokeColor setStroke];
    [path closePath];
    [path stroke];
}

- (void)drawSeparatorAtPosition:(VENSeparatorPosition)position
                           type:(VENSeparatorType)type
                    strokeColor:(UIColor *)strokeColor
                    borderWidth:(CGFloat)borderWidth {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = borderWidth;
    NSInteger x = 0;
    NSInteger y = (position == VENSeparatorPositionTop) ? borderWidth : CGRectGetHeight(self.frame) - borderWidth;
    [path moveToPoint:CGPointMake(x, y)];
 
    NSMutableArray *separatorTmpPointArray = [NSMutableArray array];
    
    if (type == VENSeparatorTypeJagged) {
        NSUInteger verticalDisplacement = self.jaggedEdgeVerticalVertexDistance ?: DefaultJaggedEdgeVerticalVertexDistance;
        NSUInteger horizontalDisplacement = self.jaggedEdgeHorizontalVertexDistance ?: DefaultJaggedEdgeHorizontalVertexDistance;
        verticalDisplacement *= (position == VENSeparatorPositionTop) ? +1 : -1;
        BOOL shouldMoveUp = YES;
        while (x <= CGRectGetWidth(self.frame)) {
            x += horizontalDisplacement;
            if (shouldMoveUp) {
                y += verticalDisplacement;
            }
            else {
                y -= verticalDisplacement;
            }
            [path addLineToPoint:CGPointMake(x, y)];
            [separatorTmpPointArray addObject:NSStringFromCGPoint(CGPointMake(x, y))];
            shouldMoveUp = !shouldMoveUp;
        }
        
    }
    else if (type == VENSeparatorTypeStraight) {
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), y)];
    }
    
    
    switch (position) {
        case VENSeparatorPositionTop:
            if ([_separatorTopPointArray count]>0) {
                [_separatorTopPointArray removeAllObjects];
            }
            if (type == VENSeparatorTypeJagged) {
                [_separatorTopPointArray addObjectsFromArray:separatorTmpPointArray];
            }
            break;
        case VENSeparatorPositionBottom:
            if ([_separatorBottomPointArray count]>0) {
                [_separatorBottomPointArray removeAllObjects];
            }
            if (type == VENSeparatorTypeJagged) {
                [_separatorBottomPointArray addObjectsFromArray:separatorTmpPointArray];
            }
            break;
        default:
            break;
    }
    
    
    CGFloat offSet = 2 * borderWidth;
    
    NSUInteger verticalDisplacement = self.jaggedEdgeVerticalVertexDistance ?: DefaultJaggedEdgeVerticalVertexDistance;
    NSUInteger horizontalDisplacement = self.jaggedEdgeHorizontalVertexDistance ?: DefaultJaggedEdgeHorizontalVertexDistance;
    switch (position) {
        case VENSeparatorPositionTop:{
            if (_topSeparatorType == VENSeparatorTypeJagged) {
                _jaggedSeparatorTopLastStrokePositionY = verticalDisplacement*(CGRectGetWidth(self.frame)-x+horizontalDisplacement)/horizontalDisplacement;            }
        }
            break;
        case VENSeparatorPositionBottom:{
            if (_bottomSeparatorType == VENSeparatorTypeJagged) {
                
                _jaggedSeparatorBottomLastStrokePositionY = CGRectGetHeight(self.frame) - verticalDisplacement*(CGRectGetWidth(self.frame)-x+horizontalDisplacement)/horizontalDisplacement;
            }
        }
            break;
            
        default:
            break;
    }
    
    x = CGRectGetWidth(self.frame) + offSet;
    y = (position == VENSeparatorPositionTop) ? -offSet : CGRectGetHeight(self.frame) + offSet;
    [path addLineToPoint:CGPointMake(x,y)];

    x = -offSet;
    [path addLineToPoint:CGPointMake(x, y)];
    
    [strokeColor setStroke];
    [self drawBezierPath:path];
}

- (void)drawBezierPath:(UIBezierPath *)path {
    UIColor *fillColor = self.fillColor ?: DefaultFillColor;
    [fillColor setFill];
    [path closePath];
    [path fill];
    [path stroke];
}

@end
