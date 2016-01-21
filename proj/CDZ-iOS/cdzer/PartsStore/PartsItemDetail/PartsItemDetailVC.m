//
//  PartsItemDetailVC.m
//  cdzerq//
//  Created by KEns0n on 3/20/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vStartSpace (22.0f)

#import "PartsItemDetailVC.h"
#import "HCSStarRatingView.h"
#import "InsetsLabel.h"
#import "PartsInfoView.h"
#import "PartsStoreSearchResultVC.h"
#import "UserSelectedAutosInfoDTO.h"
#import "MyCartVC.h"
#import "PartsCommentVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface PartsItemDetailVC ()

@property (nonatomic, assign) BOOL isPriceNeedToEnquire;

@property (nonatomic, strong) UserSelectedAutosInfoDTO *autoData;

@property (nonatomic, strong) NSArray *commentList;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *itemImageView;

@property (nonatomic, strong) InsetsLabel *itemForAutoLabel;

@property (nonatomic, strong) PartsInfoView *infoView;

#pragma mark - contentView
@property (nonatomic, strong) InsetsLabel *itemTitleLabel;

@property (nonatomic, strong) InsetsLabel *itemDescriptionLabel;

@property (nonatomic, strong) InsetsLabel *itemPriceLabel;

@property (nonatomic, strong) InsetsLabel *itemOPriceLabel;


#pragma mark - BottomView
@property (nonatomic, strong) UIView *buttomContainerView;

@property (nonatomic, strong) UIButton *addCartButton;

@property (nonatomic, strong) UIButton *cartButton;

@property (nonatomic, strong) UIButton *addFavorite;

@end

@implementation PartsItemDetailVC

- (void)dealloc {
    NSLog(@"Passing Dealloc At %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    self.title = getLocalizationString(@"item_detail");
    self.autoData = [[DBHandler shareInstance] getSelectedAutoData];
    self.isPriceNeedToEnquire = NO;
    if (!_itemDetail[@"no_yes"]&&![_itemDetail[@"no_yes"] boolValue]) {
        self.isPriceNeedToEnquire = YES;
    }
    self.commentList = @[];
    [self initializationUI];
    [self setReactiveRules];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getCollectedStoreListWithPageNums:@"1" pageSize:@"100"];
}

- (void)setReactiveRules {
    @weakify(self)
    
    [RACObserve(self, infoView.frame) subscribeNext:^(id theRect) {
        @strongify(self)
        CGRect rect = [theRect CGRectValue];
         [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetMaxY(rect)+(30.0f))];
    }];
}

- (void)initializationUI {
    
//    all = 1;
//    allstar = "1.0";
//    autopartinfoName = "\U706b\U82b1\U585e";
//    "car_shop_num" = 0;
//    "center_name" = "\U957f\U6c99\U9ad8\U6865\U91c7\U8d2d\U4e2d\U5fc3";
//    description =     (
//                       "",
//                       "http://cdz.cdzer.com:80/imgUpload/demo/common/product/150916154706LzyaDpue9g.jpg",
//                       "http://cdz.cdzer.com:80/imgUpload/demo/common/product/150916154707fSX5Ir3YOk.jpg",
//                       "http://cdz.cdzer.com:80/imgUpload/demo/common/product/150916154707SpgH7ezsR6.jpg",
//                       "http://cdz.cdzer.com:80/imgUpload/demo/common/product/150916154707GnWdueWVyC.jpg",
//                       "http://cdz.cdzer.com:80/imgUpload/demo/common/product/150916154707Glb0RYYYQ5.jpg"
//                       );
//    factory = 15090110490849799931;
//    factoryName = "\U535a\U4e16";
//    id = 15091615470912620536;
//    img = "http://cdz.cdzer.com:80/imgUpload/demo/common/product/150916154650fXtQStzAlG.png";
//    len = 1;
//    leng = 4;
//    marketprice = 105;
//    memberprice = 100;
//    name = "\U535a\U4e16\U94f1\U91d1\U706b\U82b1\U585e4\U652f\U88c5";
//    number = PD150916154709779321;
//    pjsId = 15090110111178107017;
//    "pjs_logo" = "http://cdz.cdzer.com:80/imgUpload/uploads/20150902151733xpZ99sObPZ.png";
//    sendcostName = "";
//    "speci_speci_name" =     (
//                              {
//                                  "speci_name_str" = "2015\U6b3e 30 TFSI \U624b\U52a8\U8212\U9002\U578b";
//                                  "speci_str" = 19485;
//                              },
//                              {
//                                  "speci_name_str" = "2015\U6b3e 30 TFSI \U624b\U52a8\U8212\U9002\U578b";
//                                  "speci_str" = 19485;
//                              }
//                              );
//    stocknum = 933;
//    "store_name" = "\U6e56\U5357\U4e30\U8fbe\U6c7d\U8f66\U914d\U4ef6";

    @autoreleasepool {
        
        
        
        CGFloat bottomLabelHeight = 40.0f;
        CGRect bottomLabelRect = CGRectMake(0.0f, CGRectGetHeight(self.contentView.frame)-bottomLabelHeight,
                                            CGRectGetWidth(self.contentView.frame), bottomLabelHeight);
        self.buttomContainerView = [[UIView alloc] initWithFrame:bottomLabelRect];
        _buttomContainerView.clipsToBounds = YES;
        _buttomContainerView.backgroundColor = [UIColor colorWithRed:0.227f green:0.227f blue:0.227f alpha:1.00f];
        [self.contentView addSubview:_buttomContainerView];
        
        
        self.addCartButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_addCartButton setFrame:CGRectMake(CGRectGetWidth(_buttomContainerView.frame)*0.6, 0.0f,
                                            CGRectGetWidth(_buttomContainerView.frame)*0.4, CGRectGetHeight(bottomLabelRect))];
        _addCartButton.backgroundColor = UIColor.redColor;
        [_addCartButton setTitle:getLocalizationString(@"add_cart") forState:UIControlStateNormal];
        [_addCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addCartButton addTarget:self action:@selector(addPartsToCart) forControlEvents:UIControlEventTouchUpInside];
        [_buttomContainerView addSubview:_addCartButton];
        
        UIImage *image = [ImageHandler getImageFromCacheWithByFixdeRatioFileRootPath:kSysImageCaches
                                                                            fileName:@"favorite"
                                                                                type:FMImageTypeOfPNG
                                                                         needToUpdate:NO];
        
        self.addFavorite = [UIButton buttonWithType:UIButtonTypeCustom];
        _addFavorite.tintColor = CDZColorOfClearColor;
        _addFavorite.frame = CGRectMake(CGRectGetMinX(_addCartButton.frame)-bottomLabelHeight, 0.0f, bottomLabelHeight, bottomLabelHeight);
        [_addFavorite setImage:image forState:UIControlStateNormal];
        [_addFavorite setImage:[ImageHandler ipMaskedImage:image color:CDZColorOfYellow] forState:UIControlStateSelected];
        [_addFavorite addTarget:self action:@selector(changeFavorite) forControlEvents:UIControlEventTouchUpInside];
        [_buttomContainerView addSubview:_addFavorite];
        
        __block BOOL isFoundCartVC = NO;
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:MyCartVC.class]) {
                *stop = YES;
                isFoundCartVC = YES;
            }
        }];
        if (!isFoundCartVC) {
            UIImage *cartImage = [ImageHandler getImageFromCacheWithByFixdeRatioFileRootPath:kSysImageCaches
                                                                                    fileName:@"cart"
                                                                                        type:FMImageTypeOfPNG
                                                                                needToUpdate:NO];
            
            self.cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _cartButton.tintColor = CDZColorOfClearColor;
            _cartButton.frame = CGRectMake(0.0f, 0.0f, bottomLabelHeight, bottomLabelHeight);
            [_cartButton setImage:cartImage forState:UIControlStateNormal];
            [_cartButton addTarget:self action:@selector(pushToCartView) forControlEvents:UIControlEventTouchUpInside];
            [_buttomContainerView addSubview:_cartButton];
        }
        

        
        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.contentView.bounds),
                                                                           CGRectGetHeight(self.contentView.bounds)-CGRectGetHeight(_buttomContainerView.frame))];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)*2.0f);
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = CDZColorOfWhite;
        [self.contentView addSubview:_scrollView];
        
        self.itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.contentView.frame)-130.0f)/2.0f, 0.0f, 130.0f, 130.0f)];
        [_scrollView addSubview:_itemImageView];
        NSString *imageURL = _itemDetail[@"img"];
        if ([imageURL isEqualToString:@""]||!imageURL||[imageURL rangeOfString:@"http"].location==NSNotFound) {
            _itemImageView.image = [ImageHandler getWhiteLogo];
        }else {
            [_itemImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[ImageHandler getWhiteLogo]];
        }
        
        NSString *modelName = [_autoData.seriesName stringByAppendingFormat:@" %@",_autoData.modelName];
        CGRect itemSuitableRect = CGRectZero;
        itemSuitableRect.origin.x = vStartSpace;
        itemSuitableRect.origin.y = CGRectGetMaxY(_itemImageView.frame);//+(22.0f);
        itemSuitableRect.size.width = CGRectGetWidth(self.contentView.frame)-vStartSpace*2.0f;
        itemSuitableRect.size.height = (57.0f);
        
        
        
        __block NSString *itemSuitForTitle = getLocalizationString(@"item_non_suitable_for");
        NSString *modelID = [_autoData.modelID stringValue];
        if (!modelID) {
            modelID = @"";
        }
        NSArray *array = _itemDetail[@"speci_speci_name"];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *detail = (NSDictionary *)obj;
            if ([detail[@"speci_str"] isEqualToString:modelID]||[detail[@"speci_str"] isEqualToString:@"适用所有车型id"]) {
                itemSuitForTitle = getLocalizationString(@"item_suitable_for");
                *stop = YES;
            }
        }];
        
        self.itemForAutoLabel = [[InsetsLabel alloc] initWithFrame:itemSuitableRect];
        [_itemForAutoLabel setBackgroundColor:[UIColor colorWithRed:1.000f green:0.992f blue:0.996f alpha:1.00f]];
        [_itemForAutoLabel setBorderWithColor:[UIColor colorWithRed:0.847f green:0.843f blue:0.835f alpha:1.00f] borderWidth:(1.0f)];
        [_itemForAutoLabel setTextAlignment:NSTextAlignmentCenter];
        [_itemForAutoLabel setFont:[UIFont systemFontOfSize:(14.0f)]];
        [_itemForAutoLabel setNumberOfLines:2];
        _itemForAutoLabel.text = [itemSuitForTitle stringByAppendingString:modelName];
        [_scrollView addSubview:_itemForAutoLabel];
        
        CGRect infoRect = _scrollView.bounds;
        infoRect.origin.y = CGRectGetMaxY(_itemForAutoLabel.frame)+(12.0f);
        self.infoView = [[PartsInfoView alloc] initWithFrame:infoRect];
        [_infoView updateUIDataWithDetailData:_itemDetail];
        [_infoView setShowCommnetViewTarget:self action:@selector(pushToCommentView)];
        [_scrollView addSubview:_infoView];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetMaxY(_infoView.frame)+(30.0f))];
    }
    
}

- (void)pushToCartView {
    @autoreleasepool {
        MyCartVC *vc = [MyCartVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)pushToCommentView {
    NSUInteger commentCount = [SupportingClass verifyAndConvertDataToString:_itemDetail[@"all"]].integerValue;
    if (commentCount==0) {
        [SupportingClass showAlertViewWithTitle:@"alert_remind" message:@"没有跟多的评论" isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
        return;
    }
    NSString *partsID = [SupportingClass verifyAndConvertDataToString:_itemDetail[@"id"]];
    if (!partsID) return;
        NSLog(@"%@ accessing network change parts favorite request",NSStringFromClass(self.class));
    
    PartsCommentVC *vc = [PartsCommentVC new];
    vc.partsID = partsID;
    [self setNavBarBackButtonTitleOrImage:nil titleColor:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getCollectedStoreListWithPageNums:(NSString *)pageNums pageSize:(NSString *)pageSize {
    if (!self.accessToken) return;
    NSLog(@"%@",[self.navigationController.viewControllers valueForKeyPath:@"class"]);
    @autoreleasepool {
        
        NSArray* array = self.navigationController.viewControllers;
        if (![array[array.count-2] isKindOfClass:PartsStoreSearchResultVC.class]&&[array.lastObject isKindOfClass:self.class]) {
            [ProgressHUDHandler showHUD];
        }
    }
    @weakify(self)
    NSLog(@"%@ accessing network product list request",NSStringFromClass(self.class));
    NSString *theID = _itemDetail[@"id"];
    [[APIsConnection shareConnection] personalCenterAPIsGetProductiWasCollectedWithAccessToken:self.accessToken collectionID:theID
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUDHandler dismissHUD];
        @strongify(self)
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        if (errorCode==0) {
            BOOL isAdd = [responseObject[@"state_name"] boolValue];
            self.addFavorite.selected = !isAdd;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
    }];
}

- (void)changeFavorite {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUD];
    @weakify(self)
    NSLog(@"%@ accessing network change parts favorite request",NSStringFromClass(self.class));
    NSString *theID = _itemDetail[@"number"];
    if (_addFavorite.selected) {
        [[APIsConnection shareConnection] personalCenterAPIsPostDeleteProductsCollectionWithAccessToken:self.accessToken collectionIDList:@[theID] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            @strongify(self)
            [ProgressHUDHandler dismissHUD];
            NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            if (errorCode!=0) {
                [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                    
                }];
                return;
            }
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            self.addFavorite.selected = NO;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ProgressHUDHandler dismissHUD];
        }];
    }else {
        [[APIsConnection shareConnection] personalCenterAPIsPostInsertProductCollectionWithAccessToken:self.accessToken productIDList:@[theID] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            @strongify(self)
            [ProgressHUDHandler dismissHUD];
            NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
            NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
            if (errorCode!=0) {
                [SupportingClass showAlertViewWithTitle:@"error" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                    
                }];
                return;
            }
            [SupportingClass showAlertViewWithTitle:@"alert_remind" message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                
            }];
            self.addFavorite.selected = YES;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [ProgressHUDHandler dismissHUD];
        }];
    }
    
}

- (void)addPartsToCart {
    if (!self.accessToken) return;
    [ProgressHUDHandler showHUD];
    NSString *theID = _itemDetail[@"id"];
    NSLog(@"%@ accessing network add parts to cart request",NSStringFromClass(self.class));
    UserSelectedAutosInfoDTO *autosData = [[DBHandler shareInstance] getSelectedAutoData];
    NSString *brandID = autosData.brandID.stringValue;
    NSString *brandDealershipID = autosData.dealershipID.stringValue;
    NSString *seriesID = autosData.seriesID.stringValue;
    NSString *modelID = autosData.modelID.stringValue;
    [[APIsConnection shareConnection] personalCenterAPIsPostInsertProductToTheCartWithAccessToken:self.accessToken
                                                                                        productID:theID
                                                                                          brandID:brandID
                                                                                brandDealershipID:brandDealershipID
                                                                                         seriesID:seriesID
                                                                                          modelID:modelID
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUDHandler dismissHUD];
        NSInteger errorCode = [[responseObject objectForKey:CDZKeyOfErrorCodeKey] integerValue];
        NSString *message = [responseObject objectForKey:CDZKeyOfMessageKey];
        NSString *title = getLocalizationString(@"alert_remind");
        if (errorCode!=0) title = getLocalizationString(@"error");
        [SupportingClass showAlertViewWithTitle:title message:message isShowImmediate:YES cancelButtonTitle:@"ok" otherButtonTitles:nil clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
            
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUDHandler dismissHUD];
    }];
    
}

@end
