//
//  ProductDetailView.m
//  cdzer
//
//  Created by KEns0n on 3/31/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMinHeight 170.0f

#define vCellHeight 90.0f

#import "InsetsLabel.h"
#import "ProductDetailView.h"
#import <UIView+Borders/UIView+Borders.h>
#import <SDWebImage/UIImageView+WebCache.h>


@interface ProductDetailCell : UITableViewCell

@property (nonatomic, strong) InsetsLabel *priceLabel;

@property (nonatomic, assign) MyOrderStatus status;

@property (nonatomic, assign) BOOL isTwoRowAbove;

@property (nonatomic, assign) BOOL allOfUncomment;

@end

@implementation ProductDetailCell

- (void)initializationUI {
    if (!_priceLabel) {
        self.priceLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.frame)-30.0f, CGRectGetWidth(self.frame), 30.0f)
                                          andEdgeInsetsValue:DefaultEdgeInsets];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_priceLabel];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(15.0f , (vCellHeight-70.0f)/2, 70.0f, 70.0f);
    CGRect textFrame = self.textLabel.frame;
    textFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+10.0f;
    textFrame.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(self.imageView.frame)-25.0f;
    self.textLabel.frame = textFrame;
    
    CGRect detailTextFrame = self.detailTextLabel.frame;
    detailTextFrame.origin.x = CGRectGetMinX(self.textLabel.frame);
    detailTextFrame.size.width = CGRectGetWidth(self.textLabel.frame);
    self.detailTextLabel.frame = detailTextFrame;
    
    CGPoint center = self.detailTextLabel.center;
    self.priceLabel.center = CGPointMake(self.priceLabel.center.x, center.y);
    
    [self.imageView setAutoresizingMask:UIViewAutoresizingNone];
    
    if (_status!=MyOrderStatusOfOrderFinish||!_isTwoRowAbove||!_allOfUncomment) {
        BorderOffsetObject *offset = [BorderOffsetObject new];
        offset.bottomLeftOffset = 15.0f;
        offset.bottomRightOffset = 15.0f;
        [self setViewBorderWithRectBorder:UIRectBorderBottom borderSize:0.5f withColor:CDZColorOfDeepGray withBroderOffset:offset];
    }
}

@end

@interface ProductDetailView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) NSDictionary *detailInfo;

@property (nonatomic, assign) MyOrderStatus status;

@property (nonatomic, assign) BOOL allOfUncomment;

@property (nonatomic) id target;

@property (nonatomic) SEL action;

@end

@implementation ProductDetailView

- (void)dealloc {
    
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
    self.action = nil;
    self.target = nil;
    self.dataList = nil;
    self.detailInfo = nil;
}

- (void)initializationUIWithDetailInfo:(NSDictionary *)detailInfo andOrderStatus:(MyOrderStatus)orderStatus isAutoResize:(BOOL)isAutoResize {
    @autoreleasepool {
        
        self.status = orderStatus;
        
        if (!detailInfo) return;
        [self setBorderWithColor:nil borderWidth:(0.5f)];
        [self setBackgroundColor:CDZColorOfWhite];
        
        self.detailInfo = detailInfo;
        self.dataList = _detailInfo[@"product_list"];
        self.delegate = self;
        self.bounces = NO;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        NSArray *array = [_dataList valueForKey:@"reg_tag"];
        NSNumber *wasCommentedCount = [array valueForKeyPath:@"@sum.self"];
        self.allOfUncomment = (_dataList.count>1&&wasCommentedCount.unsignedIntegerValue<=(_dataList.count-2));
        
        
        if (isAutoResize) {
            [self setReactiveRules];
        }
        
        [self setHeaderAndFooterView];
        [self reloadData];
    }
}

- (void)setPopCommentVCActionTarget:(id)target action:(SEL)action {
    self.target = target;
    self.action = action;
}

- (void)setHeaderAndFooterView {
    @autoreleasepool {
        
        UIEdgeInsets insetsValue = DefaultEdgeInsets;;
        InsetsLabel *headerTextLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 30.0f) andEdgeInsetsValue:insetsValue];
        headerTextLabel.backgroundColor = CDZColorOfWhite;
        headerTextLabel.textColor = UIColor.blackColor;
        headerTextLabel.textAlignment = NSTextAlignmentCenter;
        headerTextLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 16.0f, NO);
        headerTextLabel.text = getLocalizationString(@"product_detail");
        BorderOffsetObject *offset = [BorderOffsetObject new];
        offset.bottomLeftOffset = insetsValue.left;
        offset.bottomRightOffset = insetsValue.right;
        offset.upperLeftOffset = insetsValue.left;
        offset.upperRightOffset = insetsValue.right;
        [headerTextLabel setViewBorderWithRectBorder:UIRectBorderBottom borderSize:0.5f withColor:CDZColorOfDeepGray withBroderOffset:offset];
        self.tableHeaderView = headerTextLabel;
        
        
        InsetsLabel *footerTextLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 50.0f) andEdgeInsetsValue:insetsValue];
        footerTextLabel.backgroundColor = CDZColorOfWhite;
        footerTextLabel.numberOfLines = 0;
        footerTextLabel.textAlignment = NSTextAlignmentRight;
        [footerTextLabel setViewBorderWithRectBorder:UIRectBorderTop borderSize:0.5f withColor:CDZColorOfDeepGray withBroderOffset:offset];
        self.tableFooterView = footerTextLabel;
        
        NSString *postage = [SupportingClass verifyAndConvertDataToString:_detailInfo[@"send_price_dou"]];
        
        NSMutableAttributedString *footerString = [NSMutableAttributedString new];
        [footerString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"运费："
                                              attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],
                                                           NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO)
                                                           }]];
        [footerString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:([postage isEqualToString:@""])?@"¥0.00":[@"¥" stringByAppendingString:postage]
                                              attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                           NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO)
                                                           }]];
        
        [footerString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"\n实付："
                                              attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                           NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO)
                                                           }]];
        [footerString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:[@"¥" stringByAppendingString:[SupportingClass verifyAndConvertDataToString:_detailInfo[@"order_price"]]]
                                              attributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                           NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO)
                                                           }]];
        footerTextLabel.attributedText = footerString;
        
    }
}

- (void)setReactiveRules {
    @weakify(self)
    [RACObserve(self, contentSize) subscribeNext:^(id theSize) {
        @strongify(self)
        CGSize size = [theSize CGSizeValue];
        CGRect frame = self.frame;
        frame.size.height = size.height+10.0f;
        self.frame = frame;
    }];
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    ProductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[ProductDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        [cell initializationUI];
        cell.isTwoRowAbove = (_dataList.count>=2);
        cell.status = _status;
        cell.allOfUncomment = _allOfUncomment;
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
        cell.detailTextLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 13.0f, NO);
        cell.detailTextLabel.textColor = CDZColorOfDeepGray;
        cell.textLabel.numberOfLines = 0;
    }
    
    NSDictionary *data = _dataList[indexPath.section];
    cell.imageView.image = [ImageHandler getWhiteLogo];
    cell.textLabel.text = data[@"autopartinfo_name"];
    cell.detailTextLabel.text = [@"数量：" stringByAppendingString:data[@"quantity"]];
    
    
    NSString *urlString = data[@"product_img"];
    if ([urlString rangeOfString:@"http"].location!=NSNotFound) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[ImageHandler getWhiteLogo]];
    }
    
    NSMutableAttributedString *priceString = [NSMutableAttributedString new];
    [priceString appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:@"价格："
                                          attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                       NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO)
                                                       }]];
    [priceString appendAttributedString:[[NSAttributedString alloc]
                                          initWithString:[@"¥" stringByAppendingString:data[@"price"]]
                                          attributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                       NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO)
                                                       }]];
    [cell.priceLabel setAttributedText:priceString];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return vCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    @autoreleasepool {
        static NSString *footerIdentifier = @"footer";
        UITableViewHeaderFooterView *myFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
        
        if(!myFooter) {
            myFooter = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:footerIdentifier];
            myFooter.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), 40.0f);
            myFooter.contentView.backgroundColor = CDZColorOfWhite;
            
            UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeSystem];
            commentButton.tag = 9090;
            commentButton.backgroundColor = CDZColorOfDefaultColor;
            commentButton.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(myFooter.frame)*0.75f, 30.0f);
            commentButton.center = CGPointMake(CGRectGetWidth(myFooter.frame)/2.0f, CGRectGetHeight(myFooter.frame)/2.0f);
            [commentButton setTitle:@"评论订单" forState:UIControlStateNormal];
            [commentButton setTitle:@"订单已评论" forState:UIControlStateDisabled];
            [commentButton setTitleColor:CDZColorOfWhite forState:UIControlStateNormal];
            [commentButton setTitleColor:CDZColorOfWhite forState:UIControlStateDisabled];
            [commentButton setViewCornerWithRectCorner:UIRectCornerAllCorners cornerSize:5.0f];
            [myFooter.contentView addSubview:commentButton];
            
            if ([_target respondsToSelector:_action]) {
                [commentButton addTarget:_target action:_action forControlEvents:UIControlEventTouchUpInside];
            }
        }
        UIButton *commentButton = (UIButton *)[myFooter viewWithTag:9090];
        commentButton.accessibilityIdentifier = @(section).stringValue;
        NSDictionary *detail = _dataList[section];
        BOOL wasCommented = [[SupportingClass verifyAndConvertDataToString:detail[@"reg_tag"]] boolValue];
        commentButton.backgroundColor = (!wasCommented)?[UIColor colorWithRed:0.992f green:0.427f blue:0.133f alpha:1.00f]:CDZColorOfDeepGray;
        commentButton.enabled = !wasCommented;
        
        BorderOffsetObject *offset = [BorderOffsetObject new];
        offset.bottomLeftOffset = DefaultEdgeInsets.left;
        offset.bottomRightOffset = DefaultEdgeInsets.right;
        [myFooter setViewBorderWithRectBorder:UIRectBorderBottom borderSize:0.5f withColor:CDZColorOfDeepGray withBroderOffset:offset];
        
        return myFooter;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_status==MyOrderStatusOfOrderFinish&&(_dataList.count>=2&&_allOfUncomment)) {
        return 40.0f;
    }
    return 0;
}


- (void)setFrame:(CGRect)frame {
    
    if (vMinHeight>CGRectGetHeight(frame)) {
        frame.size.height = vMinHeight;
    }
    [super setFrame:frame];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
