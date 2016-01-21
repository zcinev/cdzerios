//
//  PersonalDataVC.m
//  cdzer
//
//  Created by KEns0n on 3/24/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define vStartSpace vAdjustByScreenRatio(16.0f)
#import "PersonalDataVC.h"
#import "InsetsLabel.h"

@interface PersonalDataVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation PersonalDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.953f green:0.953f blue:0.953f alpha:1.00f]];
    [self setTitle:[SupportingClass getLocalizationString:@"personal_data"]];
    [self initializationUI];
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

- (void)initializationUI {
    @autoreleasepool {
        [self setScrollView:[[UIScrollView alloc] initWithFrame:self.contentView.bounds]];
        [_scrollView setBackgroundColor:sCommonBGColor];
        [_scrollView setBounces:NO];
        [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)*2.0f)];
        [self.contentView addSubview:_scrollView];

        
        NSArray *titleArray = @[@{@"title":@"head_portrait",
                                  @"extData":@{@"type":@"image"},
                                  @"isArrow":@NO},
                                @{@"title":@"pwd_change",
                                  @"extData":@{@"type":@""},
                                  @"isArrow":@YES},
                                
                                @{@"title":@"user_name",
                                  @"extData":@{@"type":@"string",@"data":@"summer"},
                                  @"isArrow":@NO},
                                @{@"title":@"gender",
                                  @"extData":@{@"type":@"string",@"data":@"女"},
                                  @"isArrow":@NO},
                                
                                @{@"title":@"dob",
                                  @"extData":@{@"type":@"string",@"data":@"1988-03-19"},
                                  @"isArrow":@NO},
                                @{@"title":@"mobile",
                                  @"extData":@{@"type":@"string",@"data":@"13799883713"},
                                  @"isArrow":@NO},
                                
                                @{@"title":@"qq",
                                  @"extData":@{@"type":@"string",@"data":@"12312312"},
                                  @"isArrow":@NO},
                                @{@"title":@"email",
                                  @"extData":@{@"type":@"string",@"data":@""},
                                  @"isArrow":@NO}];
        __block CGRect lastRowRect = CGRectZero;
        lastRowRect.size.width = CGRectGetWidth(_scrollView.frame);
        lastRowRect.size.height = vAdjustByScreenRatio(40.0f);
        UIEdgeInsets insetsValue = UIEdgeInsetsMake(0.0f, vStartSpace, 0.0f, vStartSpace);
        UIImage *arrowImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kSysImageCaches
                                                                                  fileName:@"right_arrow"
                                                                                      type:@"png"
                                                                           scaleWithPhone4:NO
                                                                              needToUpdate:NO];
        
        UIImage *portraitImage = [ImageHandler getImageFromCacheByScreenRatioWithFileRootPath:kUserPathWithUser([SupportingClass getUserName])
                                                                                                             fileName:@"baby_mountain_lion"
                                                                                                                 type:@"jpg"
                                                                                                      scaleWithPhone4:NO
                                                                                                         needToUpdate:NO];
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        [titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            BOOL isArrow = NO;
            if (obj[@"isArrow"]) isArrow = [obj[@"isArrow"] boolValue];
            NSString *extDataType = [obj[@"extData"] objectForKey:@"type"];
            if (!isArrow&&[extDataType isEqualToString:@"image"]) {
                lastRowRect.size.height = portraitImage.size.height+vAdjustByScreenRatio(10.0f);
            }else {
                lastRowRect.size.height = vAdjustByScreenRatio(40.0f);
            }
            
            UIView *containerView = [[UIView alloc] initWithFrame:lastRowRect];
            [containerView setBackgroundColor:CDZWhite];
            [containerView setBorderWithColor:nil borderWidth:(0.5f)];
            [self.scrollView addSubview:containerView];
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            UIButton *button = [UIButton buttonWithType:(isArrow?UIButtonTypeSystem:UIButtonTypeCustom)];
            [button setFrame:containerView.bounds];
            [button setBackgroundColor:[UIColor clearColor]];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:vAdjustByScreenRatio(15.0f)]];
            
            [button setTitleEdgeInsets:insetsValue];
            [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [button setTitle:[SupportingClass getLocalizationString:obj[@"title"]] forState:UIControlStateNormal];
            [button setTitleColor:CDZBlack forState:UIControlStateNormal];
            if (isArrow) {
                [button setTitle:[SupportingClass getLocalizationString:obj[@"title"]] forState:UIControlStateHighlighted];
                [button setTitleColor:CDZBlack forState:UIControlStateHighlighted];

            }
            [button setTintColor:CDZDefaultColor];
            [containerView addSubview:button];
//            [button addTarget:self action:[nsValue pointerValue] forControlEvents:UIControlEventTouchUpInside];
            
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            UIImageView *arrowImageView = nil;
            if (isArrow) {
                arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(lastRowRect)-arrowImage.size.height-insetsValue.right,
                                                                               (CGRectGetHeight(lastRowRect)-arrowImage.size.height)/2.0f,
                                                                               arrowImage.size.width,
                                                                               arrowImage.size.height)];
                [arrowImageView setImage:arrowImage];
                [containerView addSubview:arrowImageView];
            }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if ([extDataType isEqualToString:@"string"]) {
                NSString *selectedCarText = [obj[@"extData"] objectForKey:@"data"];
                UIFont *selectedCarFont = [UIFont systemFontOfSize:vAdjustByScreenRatio(14.0f)];
                CGSize textSize = [SupportingClass getStringSizeWithString:selectedCarText
                                                                      font:selectedCarFont
                                                               widthOfView:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(lastRowRect))];
                CGFloat originalWidth = isArrow?CGRectGetMinX(arrowImageView.frame):CGRectGetWidth(containerView.frame);
                CGRect selectedCarRect = containerView.bounds;
                selectedCarRect.size.width = textSize.width+vStartSpace*2.0f;
                selectedCarRect.origin.x = originalWidth-CGRectGetWidth(selectedCarRect);
                
                InsetsLabel *selectedCarLabel = [[InsetsLabel alloc] initWithFrame:selectedCarRect andInsets:insetsValue];
                [selectedCarLabel setText:selectedCarText];
                [selectedCarLabel setTextColor:CDZDefaultColor];
                [selectedCarLabel setFont:selectedCarFont];
                [containerView addSubview:selectedCarLabel];
                
            }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (!isArrow&&[extDataType isEqualToString:@"image"]) {
                CGRect portraitIVRect = CGRectZero;
                portraitIVRect.size = portraitImage.size;
                portraitIVRect.origin.x = CGRectGetWidth(containerView.frame)-CGRectGetWidth(portraitIVRect)-insetsValue.right;
                portraitIVRect.origin.y = (CGRectGetHeight(containerView.frame)-CGRectGetHeight(portraitIVRect))/2.0f;
                
                UIImageView *portraitImageView = [[UIImageView alloc] initWithFrame:portraitIVRect];
                [portraitImageView.layer setMasksToBounds:YES];
                [portraitImageView.layer setCornerRadius:portraitImage.size.width/2.0f];
                [portraitImageView setImage:portraitImage];
                [containerView addSubview:portraitImageView];
            }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (![[titleArray lastObject] isEqual:obj]) {
                CGFloat o2oSpace = ([obj[@"o2o_space"] boolValue]?vAdjustByScreenRatio(16.0f):0.0f);
                CGFloat lastRowMaxY = CGRectGetMaxY(lastRowRect);
                lastRowRect.origin.y = lastRowMaxY+o2oSpace;
                
            }
        }];
        
        [_scrollView setContentSize:CGSizeMake(_scrollView.contentSize.width, CGRectGetMaxY(lastRowRect)+vAdjustByScreenRatio(10.f))];
    }
    
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
