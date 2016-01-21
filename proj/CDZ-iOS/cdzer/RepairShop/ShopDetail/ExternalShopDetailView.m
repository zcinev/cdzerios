//
//  ExternalShopDetailView.m
//  cdzer
//
//  Created by KEns0n on 8/29/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define view2ViewSpace (8.0f)
#import "ExternalShopDetailView.h"
#import "InsetsLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface CertImageTVC : UITableViewCell
@end
@implementation CertImageTVC

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0.0f , 0.0f, 60.0f, 60.0f);
    self.imageView.center = CGPointMake(CGRectGetWidth(self.frame)/2.0f, CGRectGetHeight(self.frame)/2.0f);
    [self.imageView setAutoresizingMask:UIViewAutoresizingNone];
}
@end

@interface ExternalShopDetailView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) InsetsLabel *titleLabel;

@property (nonatomic, strong) InsetsLabel *introLabel;

@property (nonatomic, strong) InsetsLabel *serviceItems;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ExternalShopDetailView

- (void)initializationUIWithShopDetail:(NSDictionary *)shopDetail {
    
    [self setBackgroundColor:CDZColorOfWhite];
    [self setBorderWithColor:[UIColor lightGrayColor] borderWidth:(0.5f)];
    
    CGFloat lastHeight = 0.0f;
    BorderOffsetObject *offset = [BorderOffsetObject new];
    offset.bottomLeftOffset = 10.0f;
    offset.bottomRightOffset = 10.0f;
    
    @autoreleasepool {
        UIColor *commonTextColor = [UIColor colorWithRed:0.353f green:0.345f blue:0.349f alpha:1.00f];
        UIEdgeInsets insetsValue = DefaultEdgeInsets;
        CGFloat width = CGRectGetWidth(self.frame)-insetsValue.left-insetsValue.right;
        CGSize standardSize = CGSizeMake(width, CGFLOAT_MAX);
        
        if (!_titleLabel) {
            self.titleLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 32.0f)
                                              andEdgeInsetsValue:insetsValue];
            _titleLabel.text = @"关于此店";
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleLabel];
            lastHeight = CGRectGetMaxY(_titleLabel.frame);
            [_titleLabel setViewBorderWithRectBorder:UIRectBorderBottom borderSize:1.0f withColor:UIColor.lightGrayColor withBroderOffset:nil];
        }
        
        NSString *htmlCode = shopDetail[@"user_content"];
        BOOL codeExist = (htmlCode&&![htmlCode isEqualToString:@""]);
        if (!_introLabel&&codeExist) {

            
            CGRect titleRect = self.bounds;
            titleRect.origin.y = lastHeight+view2ViewSpace;
            titleRect.size.height = 30.0f;
            InsetsLabel *serviceTitle = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:insetsValue];
            serviceTitle.text =  @"简介：";
            [self addSubview:serviceTitle];
            
            NSString *text = [[SupportingClass removeHTML:htmlCode] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            UIFont *font = [UIFont systemFontOfSize:(15.0f)];
            CGRect rect = self.bounds;
            rect.origin.y = CGRectGetMaxY(serviceTitle.frame);
            rect.size.height = [SupportingClass getStringSizeWithString:text font:font widthOfView:standardSize].height+10.0f;
            
            self.introLabel = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetsValue];
            _introLabel.numberOfLines = 0;
            _introLabel.textAlignment = NSTextAlignmentLeft;
            [_introLabel setText:text];
            [_introLabel setTextColor:commonTextColor];
            [_introLabel setFont:font];
            [self addSubview:_introLabel];
            
            lastHeight = CGRectGetMaxY(_introLabel.frame);
        }
        
        if (!_serviceItems) {
            [_introLabel setViewBorderWithRectBorder:UIRectBorderBottom borderSize:1.0f withColor:UIColor.lightGrayColor withBroderOffset:offset];
            
            CGRect titleRect = self.bounds;
            titleRect.origin.y = lastHeight+view2ViewSpace;
            titleRect.size.height = 30.0f;
            InsetsLabel *serviceTitle = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:insetsValue];
            serviceTitle.text =  @"商店设施：";
            [self addSubview:serviceTitle];
            
            NSArray *itemsList = shopDetail[@"list_delivery_facility_name"];
            NSString *text = @"";
            if (itemsList&&itemsList.count>0) {
                NSArray *convertList = [itemsList valueForKey:@"delivery_facility_name"];
                text = [convertList componentsJoinedByString:@","];
            }
            
            UIFont *font = [UIFont systemFontOfSize:(15.0f)];
            CGRect rect = self.bounds;
            rect.origin.y = CGRectGetMaxY(serviceTitle.frame);
            rect.size.height = [SupportingClass getStringSizeWithString:text font:font widthOfView:standardSize].height+10.0f;
            
            self.serviceItems = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetsValue];
            _serviceItems.numberOfLines = 0;
            _serviceItems.textAlignment = NSTextAlignmentLeft;
            [_serviceItems setText:text];
            [_serviceItems setTextColor:commonTextColor];
            [_serviceItems setFont:font];
            [self addSubview:_serviceItems];
            
            lastHeight = CGRectGetMaxY(_serviceItems.frame);
            
        }
        
        
        self.dataArray = @[];
        if (shopDetail[@"certificate_honor_list"]&&[shopDetail[@"certificate_honor_list"] isKindOfClass:NSArray.class]) {
            self.dataArray = shopDetail[@"certificate_honor_list"];
        }
        if (!_tableView&&_dataArray.count>0) {
            [_serviceItems setViewBorderWithRectBorder:UIRectBorderBottom borderSize:1.0f withColor:UIColor.lightGrayColor withBroderOffset:offset];
            CGRect titleRect = self.bounds;
            titleRect.origin.y = lastHeight+view2ViewSpace+5.0f;
            titleRect.size.height = 30.0f;
            InsetsLabel *serviceTitle = [[InsetsLabel alloc] initWithFrame:titleRect andEdgeInsetsValue:insetsValue];
            serviceTitle.text =  @"荣誉证书：";
            [self addSubview:serviceTitle];
            
            
            CGRect serviceCommentRect = self.bounds;
            serviceCommentRect.origin.y =  CGRectGetMaxY(serviceTitle.frame);
            serviceCommentRect.size.height = 70.0f;
            self.tableView = [[UITableView alloc] init];
            _tableView.backgroundColor = CDZColorOfClearColor;
            [_tableView setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
            [_tableView setFrame:serviceCommentRect];
            [_tableView setBounces:NO];
            [_tableView setShowsHorizontalScrollIndicator:NO];
            [_tableView setShowsVerticalScrollIndicator:NO];
            [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            [_tableView setDelegate:self];
            [_tableView setDataSource:self];
            [self addSubview:_tableView];
            
            _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetHeight(_tableView.frame), 15.0f)];
            lastHeight = CGRectGetMaxY(_tableView.frame);
        }
        
        
        CGRect frame = self.frame;
        frame.size.height = lastHeight+10.0f;
        self.frame = frame;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    CertImageTVC *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[CertImageTVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setBackgroundColor:CDZColorOfClearColor];
        [cell.contentView setBackgroundColor:CDZColorOfClearColor];
        [cell setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.hidden = YES;
    }
    cell.imageView.image = ImageHandler.getWhiteLogo;
    if (_dataArray.count>0) {
        NSString *url = _dataArray[indexPath.row];
        if ([url rangeOfString:@"http"].location!=NSNotFound) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:cell.imageView.image];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetHeight(tableView.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
