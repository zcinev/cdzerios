//
//  MyCartSubmitConfirmVC.m
//  cdzer
//
//  Created by KEns0n on 6/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "MyCartSubmitConfirmVC.h"
#import "MCSCAddressView.h"
#import "InsetsLabel.h"
#import "QuantityControlView.h"
//#import "ExpressSelectionView.h"
#import "MCSCCommentView.h"
#import "MCSCCreditView.h"
#import <UIView+Borders/UIView+Borders.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MyOrderVC.h"
#import "PaymentASV.h"

@interface MCSCTableViewCell : UITableViewCell
@property (nonatomic, strong) QuantityControlView *countView;
@end
@implementation MCSCTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.countView = [QuantityControlView new];
        [self.contentView addSubview:_countView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat txtImageSpace = 10.0f;
    
    self.imageView.frame = CGRectMake(10.0f, 0.0f, 70.0f, 70.0f);
    self.imageView.center = CGPointMake(self.imageView.center.x, CGRectGetHeight(self.frame)/2.0f);
    
    CGRect textFrame = self.textLabel.frame;
    textFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+txtImageSpace;
    textFrame.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(self.imageView.frame)-25.0f;
    self.textLabel.frame = textFrame;
    
    CGRect detailTextFrame = self.detailTextLabel.frame;
    detailTextFrame.origin.x = CGRectGetMaxX(self.imageView.frame)+txtImageSpace;
    detailTextFrame.size.width = CGRectGetWidth(self.frame)-CGRectGetMaxX(self.imageView.frame)-25.0f;
    self.detailTextLabel.frame = detailTextFrame;
    
    
    CGRect countViewRect = self.countView.frame;
    countViewRect.origin.x = CGRectGetWidth(self.frame)-CGRectGetWidth(countViewRect)-15.0f;
    countViewRect.origin.y = CGRectGetHeight(self.frame)-CGRectGetHeight(countViewRect)-5.0f;
    self.countView.frame = countViewRect;
    
    [self.imageView setAutoresizingMask:UIViewAutoresizingNone];
    @autoreleasepool {
        BorderOffsetObject *offset = [BorderOffsetObject new];
        offset.bottomLeftOffset = CGRectGetMaxY(self.imageView.frame)+txtImageSpace;
        offset.bottomRightOffset = 15.0f;
        [self setViewBorderWithRectBorder:UIRectBorderBottom borderSize:0.5 withColor:CDZColorOfLightGray withBroderOffset:offset];
    }
}

@end


@interface MyCartSubmitConfirmVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MCSCAddressView *addressView;

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) ExpressSelectionView *expressView;

@property (nonatomic, strong) NSString *creditRatio;

@property (nonatomic, strong) MCSCCreditView *creditView;

@property (nonatomic, strong) NSMutableArray *productsList;
@property (nonatomic, strong) NSMutableArray *cellFoldList;
@property (nonatomic, strong) NSMutableArray *quantityCountList;
@property (nonatomic, strong) NSMutableArray *commentList;

@property (nonatomic, strong) NSArray *expressList;

@property (nonatomic, strong) NSString *credits;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *totalExpressFee;

@property (nonatomic, strong) NSNumberFormatter *numFormatter;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) InsetsLabel *finalPriceLabel;
@property (nonatomic, strong) InsetsLabel *creditPriceLabel;
@property (nonatomic, strong) InsetsLabel *totalItemsPriceLabel;
@property (nonatomic, strong) InsetsLabel *totalExpressFeeLabel;
@property (nonatomic, strong) InsetsLabel *warningLabel;


@end

@implementation MyCartSubmitConfirmVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:getLocalizationString(@"my_cart_order_confirm")];
    
    [self componentSetting];
    [self initializationUI];
    [self setReactiveRules];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)componentSetting {
    @autoreleasepool {
        @weakify(self)
        self.numFormatter = [NSNumberFormatter new];
        [self setRightNavButtonWithTitleOrImage:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(submitAction) titleColor:nil isNeedToSet:YES];
        self.productsList = [_infoConfirmData[@"shop_detail"] mutableCopy];
        self.credits = _infoConfirmData[@"credits"];
        self.creditRatio = [SupportingClass verifyAndConvertDataToString:_infoConfirmData[@"credits_proportion"]];
        self.expressList = _infoConfirmData[@"expressage"];
        self.totalExpressFee = @"0.00";
        
        
        NSMutableArray *array = [_productsList valueForKey:@"center"];
        
        self.cellFoldList = [NSMutableArray array];
        self.commentList = [NSMutableArray array];
        for (int i=0; i<_productsList.count; i++) {
            [_cellFoldList addObject:@(NO)];
            [_commentList addObject:@""];
            double fee = [[_productsList[i] objectForKey:@"send_cost"] doubleValue];
            self.totalExpressFee = @(_totalExpressFee.doubleValue+fee).stringValue;
        }
        
        
        self.quantityCountList = [NSMutableArray array];
        __block CGFloat totalProductPrice = 0.0f;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @strongify(self)
            NSMutableArray *countList = [NSMutableArray array];
            [obj enumerateObjectsUsingBlock:^(id subObj, NSUInteger subIdx, BOOL *subStop) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.productId == %@",subObj[@"product_id"]];
                NSDictionary *result = [[self.stockCountList filteredArrayUsingPredicate:predicate] lastObject];
                
                double price = [[SupportingClass verifyAndConvertDataToString:subObj[@"tprice"]] doubleValue];
                double count = [[SupportingClass verifyAndConvertDataToString:subObj[@"buy_count"]] doubleValue];
                
                NSDictionary *data = @{@"stock_count":result[@"stocknum"], @"count":subObj[@"buy_count"]};
                [countList addObject:data];
                
                totalProductPrice += (price*count);
            }];
            [self.quantityCountList addObject:countList];
            
        }];
        
        self.totalPrice = @(_totalExpressFee.doubleValue+totalProductPrice).stringValue;
        
    }
    
}

- (void)setReactiveRules {
    @weakify(self)
    
    [RACObserve(self, creditView.usedCredit) subscribeNext:^(NSString *usedCredit) {
        @strongify(self)
        [self updateTotalPrice];
    }];
    
    [RACObserve(self, creditView.isUseCredit) subscribeNext:^(NSNumber *isUseCredit) {
        @strongify(self)
        [self updateTotalPrice];
        BOOL enableSubmitBtn = YES;
        if (isUseCredit.boolValue&&(!self.creditView.verifyCode||self.creditView.verifyCode.length<4||
                                    [self.creditView.verifyCode isEqualToString:@""])) {
            enableSubmitBtn = NO;
        }
        self.navigationItem.rightBarButtonItem.enabled = enableSubmitBtn;
    }];
    
    [RACObserve(self, creditView.verifyCode) subscribeNext:^(NSString *verifyCode) {
        @strongify(self)
        [self updateTotalPrice];
        BOOL enableSubmitBtn = YES;
        if (self.creditView.isUseCredit&&(!verifyCode||[verifyCode isEqualToString:@""]||verifyCode.length<4)) {
            enableSubmitBtn = NO;
        }
        self.navigationItem.rightBarButtonItem.enabled = enableSubmitBtn;
    }];
    
    [RACObserve(self, creditView.frame) subscribeNext:^(id theRect) {
        @strongify(self)
        CGRect rect = [theRect CGRectValue];
        CGRect frame = self.tableView.frame;
        frame.origin.y = CGRectGetMaxY(rect);
        self.tableView.frame = frame;
        
    }];
    
    [RACObserve(self, tableView.contentSize) subscribeNext:^(id contentSize) {
        @strongify(self)
        CGSize size = [contentSize CGSizeValue];
        CGRect frame = self.tableView.frame;
        frame.size.height = size.height;
        self.tableView.frame = frame;
        
    }];
    [RACObserve(self, tableView.frame) subscribeNext:^(id theRect) {
        @strongify(self)
        CGRect rect = [theRect CGRectValue];
        CGFloat maxHeight =CGRectGetMaxY(rect)+CGRectGetHeight(self.bottomView.frame)+20.0f;
        if (maxHeight<CGRectGetHeight(self.scrollView.frame)) {
            self.scrollView.contentOffset = CGPointZero;
            maxHeight = CGRectGetHeight(self.scrollView.frame);
        }
        
        CGSize contentSize = self.scrollView.contentSize;
        contentSize.height = maxHeight;
        self.scrollView.contentSize = contentSize;
        
    }];
    

}

- (void)initializationUI {
    @autoreleasepool {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        [self.contentView addSubview:_scrollView];
        
        self.addressView = [[MCSCAddressView alloc] init];
        [_addressView setSuperContainer:self];
        [_scrollView addSubview:_addressView];
        
//        self.expressView = [[ExpressSelectionView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_addressView.frame), CGRectGetWidth(_scrollView.frame), 40.0f)];
//        [_expressView setExpressList:_expressList];
//        [_scrollView addSubview:_expressView];
        
        self.creditView = [[MCSCCreditView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_addressView.frame), CGRectGetWidth(_scrollView.frame), 40.0f)];
        [_creditView setTotalPrice:_totalPrice currenCredit:_credits withRatio:_creditRatio];
        [_scrollView addSubview:_creditView];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(_creditView.frame), CGRectGetWidth(_scrollView.frame), 100.0f)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        _tableView.allowsMultipleSelection = NO;
        [_scrollView addSubview:_tableView];
        
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.contentView.frame)-90.0f, CGRectGetWidth(self.contentView.bounds), 90.0f)];
        _bottomView.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.00f];
        [self.contentView addSubview:_bottomView];
        [self initialButtomViewSubView];
        
        self.warningLabel = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(self.contentView.frame), CGRectGetWidth(_bottomView.frame), CGRectGetHeight(_bottomView.frame)) andEdgeInsetsValue:DefaultEdgeInsets];
        _warningLabel.textColor = CDZColorOfWhite;
        _warningLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
        _warningLabel.textAlignment = NSTextAlignmentCenter;
        _warningLabel.numberOfLines = 0;
        _warningLabel.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.00f];
        [self.contentView addSubview:_warningLabel];
        
        [self updateTotalPrice];
    }
}

- (void)titleLabel:(NSString *)title andTarget:(InsetsLabel *)targetView {
    InsetsLabel *label = [[InsetsLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, CGRectGetHeight(targetView.frame))
                                      andEdgeInsetsValue:UIEdgeInsetsMake(0.0f, 15.0f, 0.0f, 0.0f)];
    label.font = targetView.font;
    label.text = title;
    label.textColor = CDZColorOfLightGray;
    [targetView addSubview:label];
}

- (void)initialButtomViewSubView {
    @autoreleasepool {
        
        CGRect totalPriceFrame = _bottomView.bounds;
        totalPriceFrame.size.height = 26.0f;
        self.totalItemsPriceLabel = [[InsetsLabel alloc] initWithFrame:totalPriceFrame andEdgeInsetsValue:DefaultEdgeInsets];
        _totalItemsPriceLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14.0f, NO);
        _totalItemsPriceLabel.textAlignment = NSTextAlignmentRight;
        _totalItemsPriceLabel.textColor = UIColor.redColor;
        [_bottomView addSubview:_totalItemsPriceLabel];
        [self titleLabel:@"配件总价" andTarget:_totalItemsPriceLabel];
        
        CGRect expressFeeFrame = _totalItemsPriceLabel.bounds;
        expressFeeFrame.origin.y = CGRectGetMaxY(_totalItemsPriceLabel.frame);
        self.totalExpressFeeLabel = [[InsetsLabel alloc] initWithFrame:expressFeeFrame andEdgeInsetsValue:DefaultEdgeInsets];
        _totalExpressFeeLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14.0f, NO);
        _totalExpressFeeLabel.textAlignment = NSTextAlignmentRight;
        _totalExpressFeeLabel.textColor = UIColor.redColor;
        [_bottomView addSubview:_totalExpressFeeLabel];
        [self titleLabel:@"运费总价" andTarget:_totalExpressFeeLabel];
        
//        CGRect creditFrame = _totalExpressFeeLabel.bounds;
//        creditFrame.origin.y = CGRectGetMaxY(_totalExpressFeeLabel.frame);
//        self.creditPriceLabel = [[InsetsLabel alloc] initWithFrame:creditFrame andEdgeInsetsValue:DefaultEdgeInsets];
//        _creditPriceLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14.0f, NO);
//        _creditPriceLabel.textAlignment = NSTextAlignmentRight;
//        _creditPriceLabel.textColor = UIColor.redColor;
//        [_bottomView addSubview:_creditPriceLabel];
//        [self titleLabel:@"积分支付" andTarget:_creditPriceLabel];
//        
//        _creditPriceLabel.hidden = YES;
        
        CGRect finalPriceFrame = _bottomView.bounds;
        finalPriceFrame.origin.y = CGRectGetMaxY(_totalExpressFeeLabel.frame);
        finalPriceFrame.size.height = 38.0f;
        self.finalPriceLabel = [[InsetsLabel alloc] initWithFrame:finalPriceFrame andEdgeInsetsValue:DefaultEdgeInsets];
        _finalPriceLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
        _finalPriceLabel.textAlignment = NSTextAlignmentRight;
        _finalPriceLabel.textColor = UIColor.redColor;
        [_finalPriceLabel setViewBorderWithRectBorder:UIRectBorderTop borderSize:0.5 withColor:CDZColorOfLightGray withBroderOffset:nil];
        [_bottomView addSubview:_finalPriceLabel];
        
        
    }
}

- (void)updateProductQuantityCount:(QuantityControlView *)countView {
    @autoreleasepool {
        NSIndexPath *indexPath = countView.identifierIndexPath;
        
        NSMutableArray *quantityCountList = [self mutableArrayValueForKey:@"quantityCountList"];
        NSMutableArray *subList = quantityCountList[indexPath.section];
        NSMutableDictionary *detail = [subList[indexPath.row] mutableCopy];
        
        [detail setValue:@(countView.value).stringValue forKey:@"count"];
        [subList replaceObjectAtIndex:indexPath.row withObject:detail];
        [quantityCountList replaceObjectAtIndex:indexPath.section withObject:subList];
        
        __block double componentTotalPrice = 0;
        [_quantityCountList enumerateObjectsUsingBlock:^(id componentList, NSUInteger idx, BOOL *stop) {
            [componentList enumerateObjectsUsingBlock:^(id countDetail, NSUInteger subIdx, BOOL *subStop) {
                NSDictionary *detail = [[self.productsList[idx] objectForKey:@"center"] objectAtIndex:subIdx];
                NSString *price = detail[@"tprice"];
                NSInteger count = [countDetail[@"count"] integerValue];
                componentTotalPrice += count*price.doubleValue;
                
            }];
        }];
        [_creditView setTotalPrice:@(componentTotalPrice+_totalExpressFee.doubleValue).stringValue currenCredit:_credits withRatio:_creditRatio];
        [self updateTotalPrice];
    }
}

- (void)updateCommentText:(MCSCCommentView *)commentView {
    @autoreleasepool {
        NSString *string = commentView.textView.text;
        if (!string) string = @"";
        [_commentList replaceObjectAtIndex:commentView.identTag withObject:string];
    }
}

- (void)showWarningViewWithText:(NSString *)text {
    
    @weakify(self)
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self)
        CGRect frame = self.warningLabel.frame;
        frame.origin.y = CGRectGetMinY(self.bottomView.frame);
        self.warningLabel.frame = frame;
        self.warningLabel.text = text;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hiddenWarningView) withObject:nil afterDelay:1.5];
    }];
}

- (void)hiddenWarningView{
    
    @weakify(self)
    [UIView animateWithDuration:0.4 animations:^{
        @strongify(self)
        CGRect frame = self.warningLabel.frame;
        frame.origin.y = CGRectGetHeight(self.contentView.frame);
        self.warningLabel.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            @strongify(self)
            self.warningLabel.text = @"";
        }
    }];
}

- (void)submitAction {
    
    @autoreleasepool {
        if (!_addressView.addressID) {
            [_addressView shakeView];
            [self showWarningViewWithText:@"请选择收货地址"];
            return;
        }
        
        if (_creditView.isUseCredit&&_creditView.usedCredit.longLongValue==0) {
            [_creditView shakeView];
            [self showWarningViewWithText:@"请输入积分"];
            return;
        }
    
        [SupportingClass showAlertViewWithTitle:@"确认提交订单" message:@"你已确认所有订单信息请按确认提交。如不，请按取消返回！" isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"ok" clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            if (btnIdx.integerValue >0) {
                [self confirmCartOrder];
            }
        }];
    }
    
}

- (void)paymentFinish {
    
    [NSNotificationCenter.defaultCenter postNotificationName:CDZNotiKeyOfSelectOrderViewInTabBarVC object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma -mark UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return _productsList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    BOOL isFold = [_cellFoldList[section] boolValue];
    if (isFold) {
        return [[_productsList[section] objectForKey:@"center"] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    MCSCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[MCSCTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.numberOfLines = 0;
        cell.textLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
        [cell.countView addTarget:self action:@selector(updateProductQuantityCount:) forControlEvents:UIControlEventValueChanged];
        
    }

    NSDictionary *countData = [_quantityCountList[indexPath.section] objectAtIndex:indexPath.row];
    cell.countView.identifierIndexPath = indexPath;
    cell.countView.maxValue = [[_numFormatter numberFromString:countData[@"stock_count"]] unsignedIntegerValue];
    cell.countView.value = [[_numFormatter numberFromString:countData[@"count"]] unsignedIntegerValue];
    
    
    NSDictionary *detail = [[_productsList[indexPath.section] objectForKey:@"center"] objectAtIndex:indexPath.row];
    cell.imageView.image = ImageHandler.getWhiteLogo;
    NSString *imageURL = detail[@"product_img"];
    if (imageURL&&[imageURL rangeOfString:@"http"].location!=NSNotFound) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:ImageHandler.getWhiteLogo];
    }
    // Configure the cell...
    cell.textLabel.text = detail[@"product_name"];
    
    
    NSMutableAttributedString *textString = [NSMutableAttributedString new];
    [textString appendAttributedString:[[NSAttributedString alloc]
                                        initWithString:@"单价："
                                        attributes:@{NSForegroundColorAttributeName:CDZColorOfDeepGray,
                                                     NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14, NO)}]];
    [textString appendAttributedString:[[NSAttributedString alloc]
                                        initWithString:[@"¥" stringByAppendingString:detail[@"tprice"]]
                                        attributes:@{NSForegroundColorAttributeName:CDZColorOfRed,
                                                     NSFontAttributeName:vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 14, NO)}]];
    cell.detailTextLabel.attributedText = textString;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    BOOL isFold = [_cellFoldList[section] boolValue];
    if (isFold) {
        return 96.0f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    @autoreleasepool {
        static NSString *footerIdentifier = @"footer";
        MCSCCommentView *myFooter = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
        if(!myFooter) {
            myFooter = [[MCSCCommentView alloc] initWithReuseIdentifier:footerIdentifier];
            myFooter.containerView = _scrollView;
            myFooter.contentView.backgroundColor = CDZColorOfGray;
            [myFooter addTopBorderWithHeight:1.0f andColor:CDZColorOfLightGray];
            [myFooter addTarget:self action:@selector(updateCommentText:)];

        }
        myFooter.identTag = section;
        myFooter.titleLabel.text = [NSString stringWithFormat:@"留言给%@：",[_productsList[section] objectForKey:@"center_name"]];
        myFooter.textView.text = _commentList[section];
        
        return myFooter;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    @autoreleasepool {
        static NSString *headerIdentifier = @"header";
        UITableViewCell *myHeader = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        if(!myHeader) {
            myHeader = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:headerIdentifier];
            myHeader.contentView.backgroundColor = CDZColorOfPinkGray;
            myHeader.textLabel.text = @"";
            myHeader.detailTextLabel.text = @"";
            myHeader.textLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 16.0f, NO);
            myHeader.detailTextLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 13.0f, NO);
            myHeader.textLabel.textColor = CDZColorOfBlack;
            myHeader.detailTextLabel.textColor = CDZColorOfDeepGray;
            [myHeader addTopBorderWithHeight:1.0f andColor:CDZColorOfLightGray];
            
            BOOL isFold = [_cellFoldList[section] boolValue];
            CGRect buttonRect = myHeader.bounds;
            buttonRect.size.width = 60.0f;
            buttonRect.origin.x = CGRectGetWidth(tableView.bounds)-CGRectGetWidth(buttonRect);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = buttonRect;
            button.titleLabel.font = myHeader.textLabel.font;
            button.selected = isFold;
            button.accessibilityIdentifier = @(section).stringValue;
            button.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [button setTitle:@"展开＋" forState:UIControlStateNormal];
            [button setTitle:@"收缩－" forState:UIControlStateSelected];
            [button setTitleColor:CDZColorOfDefaultColor forState:UIControlStateNormal];
            [button setTitleColor:CDZColorOfOrangeColor forState:UIControlStateSelected];
            [button addTarget:self action:@selector(showHiddenTableViewDetail:) forControlEvents:UIControlEventTouchUpInside];
            [myHeader.contentView addSubview:button];
        }
        myHeader.textLabel.text = [[_productsList[section] objectForKey:@"center_name"] stringByAppendingString:@"\n"];
        myHeader.detailTextLabel.text = [NSString stringWithFormat:@"（共有%d件）",[[_productsList[section] objectForKey:@"center"] count]];
        return myHeader;
    }
}

- (void)showHiddenTableViewDetail:(UIButton *)button {
//    [_expressView hiddenKeyboard];
    [_creditView hiddenKeyboard];
    [_cellFoldList replaceObjectAtIndex:button.accessibilityIdentifier.integerValue withObject:@(!button.selected)];
    [_tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_scrollView]) {
    }
}

- (void)updateTotalPrice {
    @autoreleasepool {
        __block double componentTotalPrice = 0;
        [_quantityCountList enumerateObjectsUsingBlock:^(id componentList, NSUInteger idx, BOOL *stop) {
            [componentList enumerateObjectsUsingBlock:^(id countDetail, NSUInteger subIdx, BOOL *subStop) {
               NSDictionary *detail = [[self.productsList[idx] objectForKey:@"center"] objectAtIndex:subIdx];
                NSString *price = detail[@"tprice"];
                NSInteger count = [countDetail[@"count"] integerValue];
                componentTotalPrice += count*price.doubleValue;
                
            }];
        }];
//
//        
//        NSMutableAttributedString *upperString = [NSMutableAttributedString new];
//        
//        [upperString appendAttributedString:[[NSAttributedString alloc]
//                                             initWithString:@"配件总价"
//                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfLightGray}]];
//        [upperString appendAttributedString:[[NSAttributedString alloc]
//                                             initWithString:[NSString stringWithFormat:@"¥%0.02f", componentTotalPrice]
//                                             attributes:@{NSForegroundColorAttributeName:UIColor.redColor}]];
//        [upperString appendAttributedString:[[NSAttributedString alloc]
//                                             initWithString:@" + "
//                                             attributes:@{NSForegroundColorAttributeName:UIColor.redColor}]];
//        
//        [upperString appendAttributedString:[[NSAttributedString alloc]
//                                             initWithString:@"运费总价"
//                                             attributes:@{NSForegroundColorAttributeName:CDZColorOfLightGray}]];
//        [upperString appendAttributedString:[[NSAttributedString alloc]
//                                             initWithString:[NSString stringWithFormat:@"¥%0.02f", _totalExpressFee.doubleValue]
//                                             attributes:@{NSForegroundColorAttributeName:UIColor.redColor}]];
//        self.totalPrice = @(componentTotalPrice).stringValue;
//        _upperLabel.attributedText = upperString;
//        
//        _bottomLabel.textColor = UIColor.redColor;
//        _bottomLabel.text = [NSString stringWithFormat:@"价格总价：¥%0.02f", _totalExpressFee.doubleValue+componentTotalPrice];
        _totalItemsPriceLabel.text = [NSString stringWithFormat:@"¥%0.02f", componentTotalPrice];
        _totalExpressFeeLabel.text = [NSString stringWithFormat:@"+ ¥%0.02f", _totalExpressFee.doubleValue];
        long long int credit = _creditView.usedCredit.longLongValue;
        _creditPriceLabel.text = [NSString stringWithFormat:@"- %lld", _creditView.usedCredit.longLongValue];
        if (!_creditView.isUseCredit) {
            credit =0;
            _creditPriceLabel.text = @"--";
        }
        _finalPriceLabel.text = [NSString stringWithFormat:@"实付总价：¥%0.02f", _totalExpressFee.doubleValue+componentTotalPrice-credit*_creditRatio.doubleValue];
        
    }
}

- (NSArray *)convertProductAndFrameIDListToStringForAPI {
    @autoreleasepool {
        NSMutableString *productIDs = [NSMutableString string];
        NSMutableString *frameNumbers = [NSMutableString string];
        NSMutableString *feeString = [NSMutableString string];
        
        @weakify(self)
        [_productsList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @strongify(self)
            NSArray *pidLists = [(NSDictionary *)obj objectForKey:@"center"];
            [productIDs appendString:[[pidLists valueForKey:@"product_id"] componentsJoinedByString:@","]];
            [frameNumbers appendString:[[pidLists valueForKey:@"frame_no"] componentsJoinedByString:@","]];
            [feeString appendString:[(NSDictionary *)obj objectForKey:@"send_cost"]];
            if (pidLists.count>1) {
                for (int i=0; i<(pidLists.count-1); i++) {
                    [feeString appendString:@",0.0"];
                }
            }
            if (![self.productsList.lastObject isEqual:obj]) {
                [productIDs appendString:@","];
                [frameNumbers appendString:@","];
                [feeString appendString:@","];
            }
        }];
        
        return @[productIDs, frameNumbers, feeString];
    }
}

- (NSString *)convertProductCountListToStringForAPI {
    @autoreleasepool {
        NSMutableString *productCountString = [NSMutableString string];
        @weakify(self)
        [_quantityCountList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @strongify(self)
            [productCountString appendString:[[obj valueForKey:@"count"] componentsJoinedByString:@","]];
            if (![self.quantityCountList.lastObject isEqual:obj]) {
                [productCountString appendString:@","];
            }
        }];
        
        return productCountString;
    }
}

- (NSString *)convertCommentsListToStringForAPI {
    @autoreleasepool {
        NSMutableString *commentsString = [NSMutableString string];
        @weakify(self)
        [_commentList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @strongify(self)
            [commentsString appendString:obj];
            if (![self.commentList.lastObject isEqual:obj]) {
                [commentsString appendString:@"-"];
            }
        }];
        
        return commentsString;
    }
}

- (NSString *)convertFrameNumberListToStringForAPI {
    @autoreleasepool {
        NSMutableString *frameNumbers = [NSMutableString string];
        @weakify(self)
        [_productsList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @strongify(self)
            NSArray *pidLists = [(NSDictionary *)obj objectForKey:@"center"];
            [frameNumbers appendString:[[pidLists valueForKey:@"frame_no"] componentsJoinedByString:@","]];
            if (![self.productsList.lastObject isEqual:obj]) {
                [frameNumbers appendString:@","];
            }
        }];
        
        return frameNumbers;
    }
}

#pragma mark- API Access Code Section

- (void)handleSubmitFinish:(id)responseObject {
    @weakify(self)
    void (^theBlock)(NSNumber *btnIdx, UIAlertView *alertView);
    NSString *partOfMessage = [responseObject objectForKey:CDZKeyOfMessageKey];
    NSString *message = partOfMessage;
    NSString *cancelBtn = @"cancel";
    NSString *confirmBtn = @"ok";

    NSString *wasPaiedString = [responseObject[CDZKeyOfResultKey] objectForKey:@"state_name"];
    BOOL wasPaied = (wasPaiedString&&[wasPaiedString isEqualToString:@"已付款"]);
    
    if (self.creditView.isUseCredit&&wasPaied) {
        cancelBtn = @"ok";
        confirmBtn = nil;
    }
    NSDictionary *paymentData = responseObject[CDZKeyOfResultKey];
    
    theBlock = ^(NSNumber *btnIdx, UIAlertView *alertView) {
        @strongify(self)
        if (btnIdx.unsignedIntegerValue==1) {
            [PaymentASV showPaymentViewWithPayAfterDelivery:!self.creditView.isUseCredit paymentData:paymentData withResultBlock:^(NSString *resultMessage, NSInteger errorCode) {
                if (errorCode==0) {
                }
                [self paymentFinish];
            }];
        }
        
        if (btnIdx.unsignedIntegerValue==0) {
            if (self.creditView.isUseCredit&&wasPaied) {
                [PaymentASV updatePaymentStatusAndPaymentData:paymentData withResultBlock:^(NSString *resultMessage, NSInteger errorCode) {
                    [self paymentFinish];
                }];
            }else {
                [self paymentFinish];
            }
        }
        
    };
    
    [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:cancelBtn otherButtonTitles:confirmBtn clickedButtonAtIndexWithBlock:theBlock];
    
    
//
//    if (!self.creditView.isUseCredit) {
//        NSString *wasPaied = [responseObject[CDZKeyOfResultKey] objectForKey:@"state_name"];
//        if (wasPaied) {
//            
//        }
//        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"ok" clickedButtonAtIndexWithBlock:theBlock];
//        return;
//    }
//    
//    
//    [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"cancel" otherButtonTitles:@"ok" clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
//        @strongify(self)
//        if (btnIdx.unsignedIntegerValue==0) {
//            [self paymentFinish];
//            return;
//        }
//        [PaymentASV showPaymentViewWithPayAfterDelivery:YES paymentData:nil withResultBlock:^(NSString *resultMessage, NSInteger errorCode) {
//            if (errorCode==0) {
//                [self paymentFinish];
//            }
//        }];
//    }];
}

- (void)confirmCartOrder {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUD];
    NSArray *pidNFrame = [self convertProductAndFrameIDListToStringForAPI];
    NSString *productIDs = pidNFrame[0];
    NSString *frameIDs = pidNFrame[1];
    NSString *productCounts = [self convertProductCountListToStringForAPI];
    NSString *commentsString = [self convertCommentsListToStringForAPI];
    NSString *feeString = pidNFrame[2];
    @weakify(self)

    [[APIsConnection shareConnection] personalCenterAPIsPostConfirmOrderAndPaymentWithAccessToken:self.accessToken isRedeemPoint:_creditView.isUseCredit redeemPoint:_creditView.usedCredit userRemarks:commentsString productIDList:productIDs productCountList:productCounts frameNumberList:frameIDs logisticsFee:feeString addressID:_addressView.addressID totalPrice:_totalPrice verifyCode:_creditView.verifyCode success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUDHandler dismissHUD];
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSLog(@"%@",message);
        if(errorCode!=0){
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {}];
            return;
        }
        
        [self handleSubmitFinish:responseObject];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
        [SupportingClass showAlertViewWithTitle:@"error" message:@"提交失败请稍后再试！" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
