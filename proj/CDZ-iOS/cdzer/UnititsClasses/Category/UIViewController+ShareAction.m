//
//  UIViewController+ShareAction.m
//  cdzer
//
//  Created by KEns0n on 3/12/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//

#import "UIViewController+ShareAction.h"

@implementation UIViewController (ShareAction)

- (void)setNavBarBackButtonTitleOrImage:(id)titleOrImage titleColor:(UIColor *)color {
    
    [self setNavBarBackButtonTitleOrImage:titleOrImage titleColor:color withTarget:nil action:NULL];
}

- (void)setNavBarBackButtonTitleOrImage:(id)titleOrImage titleColor:(UIColor *)color withTarget:(id)target action:(SEL)action {
    if (!titleOrImage||[titleOrImage isEqualToString:@""]) {
        titleOrImage = getLocalizationString(@"back");
    }else {
        titleOrImage = getLocalizationString(titleOrImage);
    }
    
    if (!color) {
        color = CDZColorOfWhite;
    }
    
    UINavigationItem *navigationItem = self.tabBarController.navigationItem;
    
    if (!navigationItem) {
        navigationItem = self.navigationItem;
    }
    
    if ([SupportingClass isOS7Plus]) {
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] initWithTitle:titleOrImage
                                             style:UIBarButtonItemStylePlain target:target action:action];
//        returnButtonItem.target = target;
//        returnButtonItem.action = action;
        returnButtonItem.title = titleOrImage;
        returnButtonItem.tintColor = color;
        navigationItem.backBarButtonItem = returnButtonItem;
    } else {
        // 设置返回按钮的文本
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                       initWithTitle:titleOrImage
                                       style:UIBarButtonItemStylePlain target:target action:action];
        [navigationItem setBackBarButtonItem:backButton];
        
        // 设置返回按钮的背景图片
        UIImage *img = [UIImage imageNamed:@"ic_back_nor"];
        img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 18.0f, 0.0f, 0.0f)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:img
                                                          forState:UIControlStateNormal
                                                        barMetrics:UIBarMetricsDefault];
        // 设置文本与图片的偏移量
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(5.0f, 0.0f)
                                                             forBarMetrics:UIBarMetricsDefault];
        // 设置文本的属性
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16.0f],
                                     NSShadowAttributeName:[NSValue valueWithUIOffset:UIOffsetZero]};
        [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
}

- (UIBarButtonItem *)setRightNavButtonWithTitleOrImage:(id)sender style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action titleColor:(UIColor *)color isNeedToSet:(BOOL)isNeedToSet {
    @autoreleasepool {
        if (!sender)  return nil;
        
        UIBarButtonItem *rightButton;
        if ([sender isKindOfClass:[NSString class]]) {
            NSString *title = getLocalizationString((NSString*)sender);
            if ([(NSString*)sender isEqualToString:@""]) {
                title = (NSString*)sender;
            }
            rightButton = [[UIBarButtonItem alloc] initWithTitle:title style:style target:target action:action];
            
            if (!color) color = CDZColorOfWhite;
            rightButton.tintColor = color;
            
        }else if([sender isKindOfClass:[UIImage class]]){
            
            rightButton = [[UIBarButtonItem alloc] initWithImage:(UIImage*)sender style:style target:target action:action];
        }
        //        [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: color,  NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
        UINavigationItem *navigationItem = self.tabBarController.navigationItem;
        
        if (!navigationItem) {
            navigationItem = self.navigationItem;
        }
        if (isNeedToSet) {
            navigationItem.rightBarButtonItem = rightButton;
        }
        return rightButton;
    }
}

- (UIBarButtonItem *)setRightNavButtonWithSystemItemStyle:(UIBarButtonSystemItem)style target:(id)target action:(SEL)action isNeedToSet:(BOOL)isNeedToSet {
    @autoreleasepool {
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:style target:target action:action];
        UINavigationItem *navigationItem = self.tabBarController.navigationItem;
        if (!navigationItem) {
            navigationItem = self.navigationItem;
        }
        if (isNeedToSet) {
            navigationItem.rightBarButtonItem = rightButton;
        }
        return rightButton;
    }
}


- (UIBarButtonItem *)setLeftNavButtonWithTitleOrImage:(id)sender style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action titleColor:(UIColor *)color isNeedToSet:(BOOL)isNeedToSet {
    @autoreleasepool {
        if (!sender)  return nil;
        
        UIBarButtonItem *leftButton;
        if ([sender isKindOfClass:[NSString class]]) {
            NSString *title = getLocalizationString((NSString*)sender);
            if ([(NSString*)sender isEqualToString:@""]) {
                title = (NSString*)sender;
            }
            leftButton = [[UIBarButtonItem alloc] initWithTitle:title style:style target:target action:action];
            
            if (!color) color = CDZColorOfWhite;
            leftButton.tintColor = color;
            
        }else if([sender isKindOfClass:[UIImage class]]){
            
            leftButton = [[UIBarButtonItem alloc] initWithImage:(UIImage*)sender style:style target:target action:action];
        }
        //        [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: color,  NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
        if (isNeedToSet) {
            self.navigationItem.leftBarButtonItem = leftButton;
        }
        return leftButton;
    }
}

- (UIBarButtonItem *)setLeftNavButtonWithSystemItemStyle:(UIBarButtonSystemItem)style target:(id)target action:(SEL)action isNeedToSet:(BOOL)isNeedToSet {
    @autoreleasepool {
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:style target:target action:action];
        UINavigationItem *navigationItem = self.tabBarController.navigationItem;
        if (!navigationItem) {
            navigationItem = self.navigationItem;
        }
        if (isNeedToSet) {
            navigationItem.rightBarButtonItem = leftButton;
        }
        return leftButton;
    }
}

@end
