//
//  ImageFallsTV.m
//  cdzer
//
//  Created by KEns0n on 9/25/15.
//  Copyright © 2015 CDZER. All rights reserved.
//

#import "ImageFallsTV.h"
#import "InsetsLabel.h"
#import <SDWebImage/SDWebImageManager.h>
@interface ImageFallsTV () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageList;

@property (nonatomic, strong) NSMutableArray *imageTmpList;

@end

@implementation ImageFallsTV

- (void)dealloc {
    [self.imageTmpList removeAllObjects];
    [self.imageList removeAllObjects];
    
    self.imageTmpList = nil;
    self.imageList = nil;
}

- (instancetype)init{
    self = [self initWithFrame:CGRectZero];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setReactiveRules];
        self.delegate = self;
        self.dataSource = self;
        if (!self.imageList) {
            self.imageList = [@[] mutableCopy];
        }
        if (!self.imageTmpList) {
            self.imageTmpList = [@[] mutableCopy];
        }
    }
    return self;
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, contentSize) subscribeNext:^(id size) {
        @strongify(self)
        CGSize contentSize = [size CGSizeValue];
        CGRect frame = self.frame;
        frame.size.height = contentSize.height;
        self.frame = frame;
    }];
}


- (void)setupImageList:(NSArray *)imageList {
    
    [_imageTmpList removeAllObjects];
    [_imageList removeAllObjects];
    if (imageList.count==0||!imageList) {
        [_imageList addObject:@"NoList"];
        [_imageTmpList addObject:@"NoList"];
    }else {
        [imageList enumerateObjectsUsingBlock:^(id   obj, NSUInteger idx, BOOL *  stop) {
            NSString *imageURL = obj;
            if (![imageURL isEqualToString:@""]&&imageURL&&[imageURL rangeOfString:@"http"].location!=NSNotFound) {
                [self.imageTmpList addObject:imageURL];
                [self.imageList addObject:@{@"url":imageURL,@"image":[NSNull null],@"downloading":@NO,@"downloadFail":@NO}];
            }
        }];
    }
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _imageList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        imageView.translatesAutoresizingMaskIntoConstraints = YES;
        imageView.tag = 1010;
        [cell.contentView addSubview:imageView];
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:cell.contentView.bounds];
        indicatorView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        indicatorView.translatesAutoresizingMaskIntoConstraints = YES;
        indicatorView.tag = 1011;
        indicatorView.hidden = NO;
        indicatorView.hidesWhenStopped = NO;
        [cell.contentView addSubview:indicatorView];
        
        InsetsLabel *label = [[InsetsLabel alloc] initWithFrame:cell.contentView.bounds
                                             andEdgeInsetsValue:DefaultEdgeInsets];
        label.tag = 1012;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"抱歉！暂无更多图文信息！";
        label.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 18.0f, NO);
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        label.translatesAutoresizingMaskIntoConstraints = YES;
        label.hidden = YES;
        [cell.contentView addSubview:label];
    }
    // Configure the cell...
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1010];
    imageView.image = nil;
    imageView.hidden = NO;
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[cell viewWithTag:1011];
    indicatorView.hidden = NO;
    InsetsLabel *label = (InsetsLabel *)[cell viewWithTag:1012];
    label.hidden = YES;
    
    if ([_imageList[indexPath.row] isKindOfClass:NSString.class]) {
        imageView.hidden = YES;
        indicatorView.hidden = YES;
        label.hidden = NO;
    }else {
        NSMutableDictionary *deatil = [_imageList[indexPath.row] mutableCopy];
        NSString *urlString = deatil[@"url"];
        if (![deatil[@"image"] isKindOfClass:NSNull.class]) {
            imageView.image = deatil[@"image"];
            indicatorView.hidden = YES;
        }else {
            BOOL downloading = [deatil[@"downloading"] boolValue];
            if (!downloading) {
                [self downloadImage:urlString withIndex:indexPath];
                [deatil setObject:@YES forKey:@"downloading"];
                [_imageList replaceObjectAtIndex:indexPath.row withObject:deatil];
            }
        }
    }
    
    
    return cell;
}

- (void)downloadImage:(NSString *)urlString withIndex:(NSIndexPath *)indexPath {
    @weakify(self)
    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:urlString]
                                                        options:SDWebImageDelayPlaceholder|SDWebImageAvoidAutoSetImage
                                                       progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                                           
                                                       } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                                                           NSMutableDictionary *deatil = [self.imageList[indexPath.row] mutableCopy];
                                                           [deatil setObject:@YES forKey:@"downloadFail"];
                                                           @strongify(self)
                                                           if (!error&&image) {
                                                               [deatil setObject:image forKey:@"image"];
                                                               [deatil setObject:@NO forKey:@"downloadFail"];
                                                           }
                                                           [deatil setObject:@NO forKey:@"downloading"];
                                                           [self.imageList replaceObjectAtIndex:indexPath.row withObject:deatil];
                                                           if (!error&&image) {
                                                               [self reloadData];
                                                           }
                                                       }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_imageList[indexPath.row] isKindOfClass:NSDictionary.class]) {
        NSDictionary *deatil = _imageList[indexPath.row];
        if (deatil&&![deatil[@"image"] isKindOfClass:NSNull.class]) {
            UIImage *image = deatil[@"image"];
            CGSize size = CGSizeMake(image.size.width*image.scale, image.size.height*image.scale);
            CGFloat finalHeight = size.height/(size.width/CGRectGetWidth(self.frame));
            return finalHeight;
        }
    }
    return 36;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
