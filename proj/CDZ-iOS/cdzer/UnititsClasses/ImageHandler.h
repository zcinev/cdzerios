//
//  ImageHandler.h
//  cdzer
//
//  Created by KEns0n on 2/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "FileManager.h"

typedef NS_ENUM(NSInteger, BorderType)
{
    BorderTypeDashed,
    BorderTypeSolid
};


@interface ImageHandler : NSObject
+ (UIImage *)getImageScale:(NSString *)imageName;

+ (UIImage *)getWhiteLogo;

+ (UIImage *)getDefaultWhiteLogo;

+ (UIImage *)getLeftArrow;

+ (UIImage *)getRightArrow;

+ (UIImage *)getCouponOnImage;

+ (UIImage *)getCouponOffImage;

+ (UIImage *)createImageWithColor:(UIColor*)color withRect:(CGRect)rect;

+ (UIImage *)drawRotundityWithTick:(BOOL)isSelected
                              size:(CGSize)size
                       strokeColor:(UIColor *)strokColor
                         fillColor:(UIColor *)fillColor;

+ (CGSize)getImageTureSizeFromIamge:(UIImage *)image;

+ (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size;

+ (UIImage *)ipMaskedImage:(UIImage *)image color:(UIColor *)color;

+ (UIImage *)croppingImageWithImage:(UIImage *)imageToCrop toRect:(CGRect)rect;

+ (UIImage *)imageResizeToNormalRetinaByFixedRatioWithPath:(NSString *)imagePath;

+ (UIImage *)imageResizeToRetinaByScreenHeightRatioWithPath:(NSString *)imageFullPath scaleWithPhone4:(BOOL)needScale;

+ (UIImage *)getImageFromCacheWithByFixdeRatioFileRootPath:(NSString *)rootPath
                                                  fileName:(NSString *)fileName
                                                      type:(FMImageType)type
                                              needToUpdate:(BOOL)isUpdate;

+ (UIImage *)getImageFromCacheByRatioFromImage:(UIImage *)image
                                  fileRootPath:(NSString *)rootPath
                                      fileName:(NSString *)fileName
                                          type:(FMImageType)type
                                      exifData:(ExifContainer *)exifData
                                  needToUpdate:(BOOL)isUpdate;

+ (UIImage *)getImageFromCacheByScreenRatioWithFileRootPath:(NSString *)rootPath
                                                   fileName:(NSString *)fileName
                                                       type:(FMImageType)type
                                            scaleWithPhone4:(BOOL)needScale
                                               needToUpdate:(BOOL)isUpdate;

+ (CAShapeLayer *)drawDashedBorderByType:(BorderType)borderType
                                  target:(UIView *)target
                              shapeLayer:(CAShapeLayer *)shapeLayer
                             borderColor:(UIColor *)borderColor
                            cornerRadius:(CGFloat)cornerRadius
                             borderWidth:(CGFloat)borderWidth
                             dashPattern:(NSInteger)dashPattern
                            spacePattern:(NSInteger)spacePattern
                         numberOfColumns:(NSInteger)columns
                            numberOfRows:(NSInteger)rows;

+ (UIImage *)getCircleColorImage:(UIColor *)colors
                       imageSize:(CGSize)imageSize
                       setborder:(BOOL)isSelected
                 borderWithColor:(UIColor *)borderColor
                     borderWidth:(CGFloat)borderWidth;

+ (UIImage *)getCircleImage:(UIImage *)originImage
                  setborder:(BOOL)isSelected
            borderWithColor:(UIColor *)borderColor
                borderWidth:(CGFloat)borderWidth;
@end
