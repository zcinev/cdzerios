//
//  ExifReader.h
//  ExifReader
//
//  Created by KEns0n on 28/10/14.
//  Copyright (c) 2014 KEns0nLau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>


@interface ExifReader : NSObject{
    @private
    CGImageSourceRef imageRef;
}

/*
 *parms imageUrl Image Path
 */
- (id)initWithURL:(NSURL*)imageUrl;

//EXIF Image
@property(strong) NSDictionary * imageExifDictionary;
//Tiff Image
@property(strong) NSDictionary * imageTiffDictionary;

//All Image Info
@property(strong) NSDictionary * imageProperty;

@property(assign,nonatomic) NSInteger  imageFileSize;
@property(strong)           NSString * imageFileType;
@end
