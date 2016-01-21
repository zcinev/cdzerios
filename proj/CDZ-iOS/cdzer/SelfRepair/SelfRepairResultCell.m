//
//  SelfRepairResultCell.m
//  cdzer
//
//  Created by KEns0n on 6/23/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#define cellHeight 40.0f
#import "SelfRepairResultCell.h"
#import "InsetsLabel.h"
@interface SelfRepairResultCell ()

@property (nonatomic, strong) InsetsLabel *partsName;

@property (nonatomic, strong) InsetsLabel *priceLabel;

@property (nonatomic, strong) InsetsLabel *projectName;

@property (nonatomic, strong) InsetsLabel *projectDescription;


@end

@implementation SelfRepairResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializationUI];
    }
    return self;
}

- (void)initializationUI {
    // Initialization code
    UIEdgeInsets insetValueLR = DefaultEdgeInsets;
    UIFont *commonFont = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
    @autoreleasepool {
        
        if (!_projectName) {
            CGRect rect = self.contentView.bounds;
            rect.origin.y = CGRectGetHeight(self.contentView.frame)*0.1f;
            rect.size.height = CGRectGetHeight(self.contentView.frame)*0.25f;
            rect.size.width = CGRectGetWidth(self.contentView.frame);
            
            self.projectName = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueLR];
            _projectName.text = @"维修项目：机油";
            _projectName.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|
            UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            _projectName.translatesAutoresizingMaskIntoConstraints = YES;
            _projectName.font = commonFont;
            _projectName.numberOfLines = 0;
            [self.contentView addSubview:_projectName];
        }
        
        if (!_partsName) {
            CGRect rect = _projectName.frame;
            rect.origin.y = CGRectGetMaxY(_projectName.frame)+CGRectGetHeight(self.contentView.frame)*0.05f;;
            self.partsName = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueLR];
            _partsName.text = @"建议配件：";
            _partsName.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            _partsName.translatesAutoresizingMaskIntoConstraints = YES;
            _partsName.font = commonFont;
            [self.contentView addSubview:_partsName];
        }
        
        self.detailTextLabel.font = commonFont;
        self.detailTextLabel.textColor = CDZColorOfRed;
//        if (!_priceLabel) {
//            CGRect rect = _partsName.frame;
//            self.priceLabel = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueLR];
//            _priceLabel.text = @"单价：¥";
//            _priceLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
//            _priceLabel.translatesAutoresizingMaskIntoConstraints = YES;
//            _priceLabel.font = vGetHelveticaNeueFont(HelveticaNeueFontTypeOfRegular, 15.0f, NO);
//            _priceLabel.textAlignment = NSTextAlignmentRight;
//            [self.contentView addSubview:_priceLabel];
//        }
        
        
        if (!_projectDescription) {
            CGRect rect = _partsName.bounds;
            rect.origin.y = CGRectGetMaxY(_partsName.frame);
            rect.size.height = CGRectGetHeight(self.contentView.frame)*0.3f;
            self.projectDescription = [[InsetsLabel alloc] initWithFrame:rect andEdgeInsetsValue:insetValueLR];
            _projectDescription.text = @"";
            _projectDescription.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
            _projectDescription.translatesAutoresizingMaskIntoConstraints = YES;
            _projectDescription.font = commonFont;
            _projectDescription.numberOfLines = 0;
            _projectDescription.textColor = CDZColorOfDeepGray;
            [self.contentView addSubview:_projectDescription];
        }

    }
}

- (void)updateUIDataWithData:(NSDictionary *)dataDetail {
    //    id: "15062316263047654587",
    //    project: "机油",
    //    price: "-",
    //    description: null,
    //    name: "机油"
    
    NSString *projectName = dataDetail[@"project"];
    NSString *partsName = dataDetail[@"name"];
    
    _projectName.text = [@"维修项目：" stringByAppendingString:projectName];
    _partsName.text = [@"建议配件：" stringByAppendingString:partsName];
    
    
    NSString *priceName = @"";
    if ([dataDetail[@"price"] isKindOfClass:NSNumber.class]) {
        priceName = [dataDetail[@"price"] stringValue];
    }else {
        priceName = dataDetail[@"price"];
    }
    if (!priceName||[priceName isEqualToString:@""]||[priceName isEqualToString:@"-"]) {
        self.detailTextLabel.text = @"单价：--";
    }else {
        self.detailTextLabel.text = [@"单价" stringByAppendingString:priceName];
    }
    
    
    NSString *projectDescription = @"没有更多的资讯！";
    if (![dataDetail[@"description"] isKindOfClass:NSNull.class]&&!dataDetail[@"description"]&&[dataDetail[@"description"] isEqualToString:@""]) {
        projectDescription = dataDetail[@"description"];
    }
    _projectDescription.text = projectDescription;
}

@end
