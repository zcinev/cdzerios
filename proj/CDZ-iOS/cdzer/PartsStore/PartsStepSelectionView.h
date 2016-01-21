//
//  PartsStepSelectionView.h
//  cdzer
//
//  Created by KEns0n on 5/25/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PartsSearchReferenceObject;
@interface PartsStepSelectionView : UINavigationController

@property (nonatomic, strong, readonly) NSMutableArray *stepStringList;

@property (nonatomic, strong, readonly) NSString *lastStepID;

@property (nonatomic, strong, readonly) NSDictionary *searchReference;

@end
