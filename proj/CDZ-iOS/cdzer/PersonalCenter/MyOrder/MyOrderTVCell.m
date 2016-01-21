//
//  MyOrderTVCell.m
//  cdzer
//
//  Created by KEns0n on 3/26/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vMiddleViewHeight (80.0f)
#import "MyOrderTVCell.h"
#import "InsetsLabel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIView+Borders/UIView+Borders.h>


@interface MyOrderTVSubCell : UITableViewCell
@end

@implementation MyOrderTVSubCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15.0f , 5.0f, 70.0f, 70.0f);
    CGRect textFrame = self.textLabel.frame;
    textFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+25.0f;
    self.textLabel.frame = textFrame;
    
    CGRect detailTextFrame = self.detailTextLabel.frame;
    detailTextFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+25.0f;
    self.detailTextLabel.frame = detailTextFrame;
    
    [self.imageView setAutoresizingMask:UIViewAutoresizingNone];
}

@end




@interface MyOrderTVCell () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *upperView;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UITableView *middleTV;

@property (nonatomic, strong) InsetsLabel *statusLabel;

@property (nonatomic, strong) InsetsLabel *OrderIDLabel;

@property (nonatomic, strong) InsetsLabel *dateTimeLabel;

@property (nonatomic, strong) InsetsLabel *totalPriceLabel;

@property (nonatomic, strong) UIButton *logisticsCheckBtn;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation MyOrderTVCell

- (void)setReactiveRules {

    @weakify(self)
    [RACObserve(self, contentView.frame) subscribeNext:^(id theFrame) {
        @strongify(self)
        CGRect rect = [theFrame CGRectValue];
        CGRect frame = self.bottomView.frame;
        frame.origin.y = CGRectGetHeight(rect)-CGRectGetHeight(frame)-10;
        self.bottomView.frame = frame;
    }];
    
    [RACObserve(self, bottomView.frame) subscribeNext:^(id theFrame) {
        @strongify(self)
        CGRect rect = [theFrame CGRectValue];
        CGRect frame = self.middleTV.frame;
        frame.origin.y = CGRectGetMaxY(self.upperView.frame);
        frame.size.height = CGRectGetMinY(rect)-CGRectGetMaxY(self.upperView.frame);
        self.middleTV.frame = frame;
    }];
    
}

- (void)initializationUI {
    
    @autoreleasepool {
        self.backgroundColor = [UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f];
        UIEdgeInsets insetsValue = DefaultEdgeInsets;
        UIFont *commentFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 13.0f, NO);
        UIFont *commentBoldFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfBold, 13.0f, NO);

        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect upperViewRect = self.bounds;
        upperViewRect.size.height = 50.0f;
        self.upperView = [[UIView alloc] initWithFrame:upperViewRect];
        [_upperView setBackgroundColor:CDZColorOfWhite];
        [self.contentView addSubview:_upperView];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        if (!_dateTimeLabel) {
            NSString *statusLabelString = @"测试状态中中";
//            CGFloat statusLabelWidth = [SupportingClass getStringSizeWithString:statusLabelString
//                                                                        font:commentFont
//                                                                 widthOfView:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(upperViewRect))].width;

            CGRect statusLabelRect = _upperView.bounds;
//            statusLabelRect.size.width = statusLabelWidth+insetsValue.right;
//            statusLabelRect.origin.x = CGRectGetWidth(_upperView.frame)-CGRectGetWidth(statusLabelRect);
            self.statusLabel = [[InsetsLabel alloc] initWithFrame:statusLabelRect andEdgeInsetsValue:insetsValue];//UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, insetsValue.right)];

            _statusLabel.backgroundColor = CDZColorOfClearColor;
            [_statusLabel setTextColor:CDZColorOfRed];
            [_statusLabel setFont:commentBoldFont];
            [_statusLabel setText:statusLabelString];
            [_statusLabel setTextAlignment:NSTextAlignmentRight];
            
            
            CGRect dataTimeLabelRect = _upperView.bounds;
            self.dateTimeLabel = [[InsetsLabel alloc] initWithFrame:dataTimeLabelRect andEdgeInsetsValue:insetsValue];//UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, CGRectGetWidth(statusLabelRect))];
            [_dateTimeLabel setFont:commentFont];
            [_dateTimeLabel setText:@"2014-12-19 16:21:30"];
            [_dateTimeLabel setTextColor:CDZColorOfBlack];
            _dateTimeLabel.numberOfLines = 0;
            [_upperView addSubview:_dateTimeLabel];
            [_dateTimeLabel addSubview:_statusLabel];
        }
        
        
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CGRect bottomViewRect = upperViewRect;
        bottomViewRect.origin.y = CGRectGetHeight(self.frame)-CGRectGetHeight(bottomViewRect)-10;
        self.bottomView = [[UIView alloc] initWithFrame:bottomViewRect];
        [_bottomView setBackgroundColor:CDZColorOfWhite];
        [_bottomView addTopBorderWithHeight:0.5f color:[UIColor colorWithRed:0.847f green:0.843f blue:0.835f alpha:1.00f]
                                 leftOffset:insetsValue.left rightOffset:insetsValue.left andTopOffset:0.0f];
        [self.contentView addSubview:_bottomView];
        
        if (!_totalPriceLabel) {
            
            NSMutableAttributedString *tpString = [NSMutableAttributedString new];
            
            [tpString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:getLocalizationString(@"order_total_amount")
                                              attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                                           }]];
            [tpString appendAttributedString:[[NSAttributedString alloc]
                                              initWithString:@"¥55.00"
                                              attributes:@{NSForegroundColorAttributeName:CDZColorOfRed
                                                           }]];
            
            CGRect totalPriceLabelRect = _bottomView.bounds;
            UIEdgeInsets newInsets = insetsValue;
            newInsets.right = insetsValue.left;
            
            self.totalPriceLabel = [[InsetsLabel alloc] initWithFrame:totalPriceLabelRect andEdgeInsetsValue:newInsets];
            [_totalPriceLabel setFont:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO)];
            [_totalPriceLabel setAttributedText:tpString];
            [_totalPriceLabel setTextAlignment:NSTextAlignmentRight];
            [_bottomView addSubview:_totalPriceLabel];
            
        }
        
        if (!_logisticsCheckBtn) {
            CGRect logBtnRect = _totalPriceLabel.frame;
            logBtnRect.size.width = CGRectGetWidth(_totalPriceLabel.frame)*0.4f;
            
            self.logisticsCheckBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [_logisticsCheckBtn setFrame:logBtnRect];
            [_logisticsCheckBtn setTitle:getLocalizationString(@"check_logist_info") forState:UIControlStateNormal];
            [_logisticsCheckBtn setTitle:getLocalizationString(@"check_logist_info") forState:UIControlStateHighlighted];
            [_logisticsCheckBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
            [_logisticsCheckBtn setTitleColor:CDZColorOfDefaultColor forState:UIControlStateHighlighted];
            _logisticsCheckBtn.alpha = 0;
            [_bottomView addSubview:_logisticsCheckBtn];
            
        }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        CGRect middleViewRect = upperViewRect;
        middleViewRect.origin.y = CGRectGetMaxY(upperViewRect);
        middleViewRect.size.height = CGRectGetMinY(_bottomView.frame)-CGRectGetMaxY(_upperView.frame);
        
        self.middleTV = [[UITableView alloc] initWithFrame:middleViewRect];
        _middleTV.showsHorizontalScrollIndicator = NO;
        _middleTV.showsVerticalScrollIndicator = NO;
        _middleTV.scrollEnabled = NO;
        _middleTV.userInteractionEnabled = NO;
        _middleTV.bounces = YES;
        _middleTV.delegate = self;
        _middleTV.dataSource = self;
        _middleTV.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_middleTV addTopBorderWithHeight:0.5f color:[UIColor colorWithRed:0.847f green:0.843f blue:0.835f alpha:1.00f]
                                    leftOffset:insetsValue.left rightOffset:insetsValue.left andTopOffset:0.0f];
        [self.contentView addSubview:_middleTV];
        
        
        [self setReactiveRules];
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
    
    }
}

- (void)updateUIDataWith:(NSDictionary *)dataDetail {
    //    {
    //    order_main_id: "MD150709135654411451",
    //        id: "15070913565423146501",
    //    lmap: [
    //        {
    //        product_img: "http://cdz.cdzer.com:80/imgUpload/demo/common/product/150706143651ZvBXYIXR6i.png",
    //        goodname: "燃油系统清洗剂",
    //        good_id: "PD150706143659699169",
    //        shop_name: "车队长麓谷配件商"
    //        },
    //        {
    //        product_img: "http://cdz.cdzer.com:80/imgUpload/demo/common/product/150706085102HfYnE6mBED.png",
    //        goodname: "节气门清洗剂",
    //        good_id: "PD150706085105358703",
    //        shop_name: "车队长麓谷配件商"
    //        }
    //           ],
    //    isSelect: "1",
    //    color: "#ffffff",
    //    state: "14111810395277918719",
    //    goods_sum_price: "74.0",
    //    add_time: "2015-07-09 13:56:54 ",
    //    state_name: "退货完成"
    //    }
    //
    
    
//    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:testString];
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle1 setLineSpacing:15];
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [testString length])];
//    [cLabel setAttributedText:attributedString1];
//    [cLabel sizeToFit];
    
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.numberOfLines = 0;
    self.textLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16, NO);
    if (!dataDetail) {
        _upperView.hidden = YES;
        _middleTV.hidden = YES;
        _bottomView.hidden = YES;
        self.textLabel.text = @"没更多的订单，\n请前往配件中心购买下单！";
        return;
    }
    self.textLabel.text = nil;
    _upperView.hidden = NO;
    _middleTV.hidden = NO;
    _bottomView.hidden = NO;
    @autoreleasepool {
        self.dataList = dataDetail[@"lmap"];
        [_middleTV reloadData];
        
        NSMutableAttributedString* upperText = [NSMutableAttributedString new];
        [upperText appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"order_id")
                                                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray}]];
        [upperText appendAttributedString:[[NSAttributedString alloc] initWithString:dataDetail[@"order_main_id"]
                                                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack}]];
        
        [upperText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        
        [upperText appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"order_datetime")
                                                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray}]];
        [upperText appendAttributedString:[[NSAttributedString alloc] initWithString:dataDetail[@"add_time"]
                                                                          attributes:@{NSForegroundColorAttributeName:CDZColorOfBlack}]];
        
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:4];
        [upperText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, upperText.length)];
        
        _dateTimeLabel.attributedText = upperText;
        
        
        NSMutableAttributedString *tpString = [NSMutableAttributedString new];
        [tpString appendAttributedString:[[NSAttributedString alloc] initWithString:getLocalizationString(@"order_total_amount")
                                                                         attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray}]];
        [tpString appendAttributedString:[[NSAttributedString alloc] initWithString:[@"¥" stringByAppendingString:dataDetail[@"goods_sum_price"]]
                                                                         attributes:@{NSForegroundColorAttributeName:CDZColorOfRed}]];
        _totalPriceLabel.attributedText = tpString;
        
        _statusLabel.text = dataDetail[@"state_name"];
        _statusLabel.textColor = CDZColorOfRed;
        _statusLabel.backgroundColor = [SupportingClass colorWithHexString:dataDetail[@"color"]];
    }
  
    
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MyOrderTVSubCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MyOrderTVSubCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        [cell setFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), tableView.rowHeight)];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.textLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 13.0f, NO);
        cell.detailTextLabel.textColor = CDZColorOfDeepGray;
    }
    
    [cell.layer.sublayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CALayer *layer = (CALayer *)obj;
        if ([layer.name isEqualToString:@"buttomBorder"]) {
            [layer removeFromSuperlayer];
        }
    }];
    if (indexPath.row!=0) {
        CALayer *layer = [cell createTopBorderWithHeight:0.5f color:[UIColor colorWithRed:0.847f green:0.843f blue:0.835f alpha:1.00f]
                                                  leftOffset:110.0f rightOffset:15.0f andTopOffset:0.0f];
        layer.name = @"buttomBorder";
        [cell.layer addSublayer:layer];
    }
    
    NSDictionary *data = _dataList[indexPath.row];
    cell.imageView.image = [ImageHandler getWhiteLogo];
    cell.textLabel.text = data[@"goodname"];
    cell.detailTextLabel.text = data[@"shop_name"];
    NSString *urlString = data[@"product_img"];
    if ([urlString rangeOfString:@"http"].location!=NSNotFound) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[ImageHandler getWhiteLogo]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}
@end
