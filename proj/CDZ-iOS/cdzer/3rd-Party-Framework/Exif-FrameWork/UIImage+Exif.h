//
//  UIImage+Exif.h
//  Pods
//
//  Created by Nikita Tuk on 12/02/15.
//
//

#import <UIKit/UIKit.h>

@class ExifContainer;

typedef NS_ENUM(NSInteger, ExifImageType) {
    ExifImageTypeOfPNG = FMImageTypeOfPNG,
    ExifmageTypeOfJPEG = FMImageTypeOfJPEG,
};

@interface UIImage (Exif)

- (NSData *)addExif:(ExifContainer *)container toImageType:(ExifImageType)type;

@end
