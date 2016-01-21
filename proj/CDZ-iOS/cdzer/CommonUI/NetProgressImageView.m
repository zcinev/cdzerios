//
//  NetProgressImageView.m
//  cdzer
//
//  Created by KEns0n on 4/22/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "NetProgressImageView.h"
#import "FileManager.h"
#import "AMTumblrHud.h"
#import "ExifContainer.h"
#import "ExifReader.h"
@interface NetProgressImageView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) AFHTTPRequestOperation *operation;

@property (nonatomic, strong) AMTumblrHud *loadingHUD;
@end

static UIImage *placeHolderImage = nil;
@implementation NetProgressImageView

- (void)setPlaceHolderImage {
    placeHolderImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                           fileName:@"white_logo"
                                                                               type:FMImageTypeOfPNG
                                                                    scaleWithPhone4:NO
                                                                       needToUpdate:NO];
}

- (void)initHUDUIWithFrame:(CGRect)frame {
    self.loadingHUD = [[AMTumblrHud alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 55, 20)];
    [_loadingHUD setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    _loadingHUD.hudColor = UIColorFromRGB(0xF1F2F3);
    if (!CGRectEqualToRect(frame, CGRectZero)) {
        [_loadingHUD setCenter:CGPointMake(CGRectGetWidth(frame)/2.0f, CGRectGetHeight(frame)/2.0f)];
    }
    [_loadingHUD hide];
    [self addSubview:_loadingHUD];
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (_loadingHUD) {
        [_loadingHUD setCenter:CGPointMake(CGRectGetWidth(frame)/2.0f, CGRectGetHeight(frame)/2.0f)];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setPlaceHolderImage];
        self.imageView = [[UIImageView alloc] initWithImage:placeHolderImage];
        [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [self addSubview:_imageView];
        [self initHUDUIWithFrame:CGRectZero];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setPlaceHolderImage];
        self.imageView = [[UIImageView alloc] initWithImage:placeHolderImage];
        [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [self addSubview:_imageView];
        [self initHUDUIWithFrame:CGRectZero];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceHolderImage];
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_imageView setImage:placeHolderImage];
        [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [self addSubview:_imageView];
        [self initHUDUIWithFrame:frame];
    }
    return self;
}

- (instancetype)initWithImageURL:(NSString *)imageURL frame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceHolderImage];
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_imageView setImage:placeHolderImage];
        [_imageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        [self addSubview:_imageView];
        [self initHUDUIWithFrame:frame];
    }
    return self;
}

- (void)dealloc {
    if (![_operation isFinished]) {
        [_operation cancel];
    }
    _operation = nil;
}

- (void)clearImage {
    [_imageView setImage:nil];
    [_imageView setImage:placeHolderImage];
    [_loadingHUD hide];
}

- (BOOL)imageCacheFileExistAndVaildWithFileName:(NSString *)fileName extType:(NSString *)extType isUserPortrait:(BOOL)isPortrait sourceImageURL:(NSString *)urlStr{

    if (!_imageURL||!fileName||!extType) {
        return NO;
    }
    
    @autoreleasepool {
        if ([FileManager checkFileIsExistWithtRootType:FMRootFolderTypeOfCache
                                               subPath:kUserPortraitCaches
                                               theFile:[FileManager convertImageNameByScale:fileName]
                                               extType:extType
                                           isDirectory:NO]) {
            NSString *fullPath = [FileManager getFileFullPathFromCacheWithRootFolder:FMRootFolderTypeOfCache fileName:fileName extType:extType subFolder:kUserPortraitCaches isImage:YES];
            
            ExifReader * imageInfo = [[ExifReader alloc]initWithURL:[NSURL fileURLWithPath:fullPath]];
            NSDictionary *exifInfo = imageInfo.imageExifDictionary;
            if (exifInfo&&[exifInfo objectForKey:(NSString*)kCGImagePropertyExifUserComment]) {
                return [[exifInfo objectForKey:(NSString*)kCGImagePropertyExifUserComment] isEqualToString:urlStr];
            }
            
        }
    }
    
    return NO;
}

- (void)fire {
    @autoreleasepool {
        
        if (!_imageURL) {
            NSLog(@"Did not setup imageURL!");
            return;
        }
        [_loadingHUD showAnimated:YES];
        __weak __typeof(self)weakSelf = self;
        NSString *fileName = [[_imageURL lastPathComponent] stringByDeletingPathExtension];
        NSString *extType = [_imageURL pathExtension];
        BOOL isExist = [self imageCacheFileExistAndVaildWithFileName:fileName extType:extType isUserPortrait:YES sourceImageURL:_imageURL];
        
        if (isExist) {
            NSString *path = [FileManager getFileFullPathFromCacheWithRootFolder:FMRootFolderTypeOfCache fileName:fileName extType:extType subFolder:kUserPortraitCaches isImage:NO];
            UIImage *imageTab = nil;
            imageTab = [UIImage imageWithContentsOfFile:path];
            [_imageView setImage:nil];
            [_imageView setImage:imageTab];
            [_loadingHUD hide];
            return;
        }
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_imageURL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        self.operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [_operation setResponseSerializer:[[AFImageResponseSerializer alloc] init]];
        [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            ExifContainer *exifData = [ExifContainer new];
            [exifData addUserComment:strongSelf.imageURL];
            
            UIImage *image = [ImageHandler getImageFromCacheByRatioFromImage:responseObject
                                                                fileRootPath:kUserPortraitCaches
                                                                    fileName:fileName
                                                                        type:[FileManager getImageTypeNumWithString:extType]
                                                                    exifData:exifData
                                                                needToUpdate:YES];
            
            [strongSelf.imageView setImage:image];
            [strongSelf.loadingHUD hide];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;

            NSLog(@"%@",error);
            [strongSelf.loadingHUD hide];
        }];
        [_operation start];

    }
}

- (void)setImageURL:(NSString *)imageURL
{
    if ([imageURL isEqualToString:@""]||[imageURL rangeOfString:@"http"].location == NSNotFound) {
        NSLog(@"No Portrait URL Was Found!");
        return;
    }
    _imageURL = nil;
    _imageURL = imageURL;
    [self fire];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
