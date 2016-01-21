//
//  SupportingClass.m
//  cdzer
//
//  Created by KEns0n on 2/7/15.
//  Copyright (c) 2015 CDZER. All rights reserved.
//
#define k_car_staOn @"0"    //在线
#define k_car_staOff @"1"   //熄火
#define k_car_staOver @"2"  //离线
#define k_car_staNo @"3"    //无信号

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <PinYin4Objc/PinYin4Objc.h>
#import "SupportingClass.h"

@implementation SupportingClass

+ (void)showToast:(NSString *)msg  {
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 5 ;
    view.tag = 600 ;
    CGFloat width = [self getStringSizeWithString:msg font:[UIFont systemFontOfSize:15] widthOfView:CGSizeMake(MAXFLOAT, 30)].width;
    view.frame = CGRectMake(0, 0, width+30, 50);
    view.backgroundColor = [UIColor blackColor];
    view.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2+80);
    UILabel *msgLa = [[UILabel alloc] init];
    msgLa.frame = CGRectMake(0, 0, width+30, 50) ;
    msgLa.text = msg ;
    msgLa.textAlignment = NSTextAlignmentCenter ;
    msgLa.font = [self boldAndSizeFont:15];
    msgLa.backgroundColor = [UIColor clearColor];
    msgLa.textColor = [UIColor whiteColor];
    [view addSubview:msgLa];
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void)
     {
         [view setAlpha:0.8];
     }completion:^(BOOL finished)
     {
         [view removeFromSuperview];
     }];
}

+ (NSString *)getLocalizationString:(NSString *)localizationKey{
    if (!localizationKey||[localizationKey isEqualToString:@""]) {
        return @"Untitled";
    }
    return NSLocalizedStringFromTable(localizationKey, @"Localization", nil);
}

+ (BOOL)isOS7Plus {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.00000) {
        return YES;
    }
    return NO;
}

+ (BOOL)isOS8Plus {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.10000) {
        return YES;
    }
    return NO;
}

+ (CGFloat)getKeyboardHeight {
    CGFloat height = 253.0f;
    if (IS_IPHONE_6P) height = 271.0f;
    if (IS_IPHONE_6) height = 258.0f;
    return height;
}

+ (BOOL)isTripleSizeRetinaScreen {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
            ([UIScreen mainScreen].scale >= 3.0));
}

+ (BOOL)isTwiceSizeRetinaScreen {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
            ([UIScreen mainScreen].scale >= 2.0));
}

+ (id)deepMutableObject:(id)object {
    if ([object isKindOfClass:NSArray.class]||[object isKindOfClass:NSDictionary.class]) {
        BOOL isArray = [object isKindOfClass:NSArray.class];
        return  isArray?(NSMutableArray *)CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault,
                                                                                         (CFArrayRef)object,
                                                                                         kCFPropertyListMutableContainersAndLeaves))
                       :(NSMutableDictionary *)CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault,
                                                                                              (CFDictionaryRef)object,
                                                                                              kCFPropertyListMutableContainersAndLeaves));
    }
    return nil;
}

+ (BOOL)analyseCarStatus:(NSString*)sta withParentView:(UIView *)parentView {
    BOOL flag = NO;
    if ([k_car_staOn isEqualToString:sta] || [k_car_staOff isEqualToString:sta]) {
        flag = YES;
    }else{
        NSString *text = @"离线";
        if ([k_car_staNo isEqualToString:sta]) {
            text = @"无信号";
        }
        CGRect frame = alertFrame;
        NSString *msg = [NSString stringWithFormat:@"您当前的车辆处于%@状态，无法操作！",text];
        if (!parentView) {
            parentView = [UIApplication sharedApplication].keyWindow;
        }
        [self addLabelWithFrame:frame content:msg radius:5 fontSize:13 parentView:parentView isAlertShow:YES  pushBlock:^{
        }];
    }
    return flag;
}

+ (UIFont *)getHelveticaNeueFontType:(HelveticaNeueFontType)fontType withFontSize:(CGFloat)fontSize isAdjustByRatio:(BOOL)isNeedAdjust {
    @autoreleasepool {
        NSArray *fontTypeNameList =  @[@"HelveticaNeue-BoldItalic",
                                       @"HelveticaNeue-Light",
                                       @"HelveticaNeue-Italic",
                                       @"HelveticaNeue-UltraLightItalic",
                                       @"HelveticaNeue-CondensedBold",
                                       @"HelveticaNeue-MediumItalic",
                                       @"HelveticaNeue-Thin",
                                       @"HelveticaNeue-Medium",
                                       @"HelveticaNeue-ThinItalic",
                                       @"HelveticaNeue-LightItalic",
                                       @"HelveticaNeue-UltraLight",
                                       @"HelveticaNeue-Bold",
                                       @"HelveticaNeue",
                                       @"HelveticaNeue-CondensedBlack"];
        CGFloat size = (isNeedAdjust)?vAdjustByScreenRatio(fontSize):fontSize;
        if (fontType>fontTypeNameList.count-1) fontType =HelveticaNeueFontTypeOfRegular;
        
        NSString *fontTypeName = fontTypeNameList[fontType];
        UIFont *font = nil;
        switch (fontType) {
            case HelveticaNeueFontTypeOfBoldItalic:
            case HelveticaNeueFontTypeOfItalic:
            case HelveticaNeueFontTypeOfUltraLightItalic:
            case HelveticaNeueFontTypeOfMediumItalic:
            case HelveticaNeueFontTypeOfThinItalic:
            case HelveticaNeueFontTypeOfLightItalic:{
                CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(15 * (CGFloat)M_PI / 180), 1, 0, 0);
                UIFontDescriptor *desc = [UIFontDescriptor fontDescriptorWithName:fontTypeName matrix:matrix];
                font = [UIFont fontWithDescriptor:desc size:size];
            }
                break;
                
            default:
                font = [UIFont fontWithName:fontTypeName size:size];
                break;
        }
        return font;
    }
    
}

+ (CGFloat)ratioOfiP5TOiP4 {
    CGFloat maxHeight = 568.0f;
    CGFloat miniHeight = 480.0f;
    return miniHeight/maxHeight;
}

+ (CGFloat)screenRatioOfiP5TOiP6P {
    CGFloat minHeight = 568.0f;
    CGFloat currentHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    return currentHeight/minHeight;
}

+ (UIFont *)boldAndSizeFont:(int) sizeValue {
    UIFont *font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:sizeValue];
    return font ;
}


+ (NSString *)verifyAndConvertDataToString:(id)data {
    NSString *string = data;
    if ([data isKindOfClass:NSNumber.class]) {
        string = [(NSNumber*)data stringValue];
    }
    if (!string) {
        string = @"";
    }
    return string;
}

+ (NSNumber *)verifyAndConvertDataToNumber:(id)data {
    NSNumber *number = data;
    if ([data isKindOfClass:NSString.class]) {
        if ([data rangeOfString:@"."].location!=NSNotFound) {
            number = @([(NSString*)data doubleValue]);
        }else {
            number = @([(NSString*)data longLongValue]);
        }
    }
    if (!number) {
        number = @(0);
    }
    return number;
}

static HanyuPinyinOutputFormat *outputFormat = nil;
+ (NSString *)chineseStringConvertToPinYinStringWithString:(NSString *)words {
    @autoreleasepool {
        
        if (!outputFormat) {
            outputFormat=[[HanyuPinyinOutputFormat alloc] init];
            [outputFormat setToneType:ToneTypeWithoutTone];
            [outputFormat setVCharType:VCharTypeWithV];
            [outputFormat setCaseType:CaseTypeLowercase];
        }
        NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:words withHanyuPinyinOutputFormat:outputFormat withNSString:@" "];
        if ([words isEqualToString:@"长沙市"]||[words isEqualToString:@"长春市"]||[words isEqualToString:@"长治市"]) {
            outputPinyin = [outputPinyin stringByReplacingOccurrencesOfString:@"zhang" withString:@"chang"];
        }
        return outputPinyin;
    }
}

+ (CGSize)getStringSizeWithString:(NSString *)string font:(UIFont *)font widthOfView:(CGSize)size {
    CGSize newSize = CGSizeZero;
    if ([string respondsToSelector:
         @selector(boundingRectWithSize:options:attributes:context:)])
    {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.alignment = NSTextAlignmentLeft;
        
        NSDictionary * attributes = @{NSFontAttributeName : font,
                                      NSParagraphStyleAttributeName : paragraphStyle};
        
        newSize = [string boundingRectWithSize:size
                                          options:NSStringDrawingUsesLineFragmentOrigin
                |NSStringDrawingUsesLineFragmentOrigin
                                       attributes:attributes
                                          context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        newSize = [string sizeWithFont:font
                        constrainedToSize:size
                            lineBreakMode:NSLineBreakByWordWrapping];
#pragma clang diagnostic pop
    }
    return newSize;
}

+ (CGSize)getAttributedStringSizeWithString:(NSMutableAttributedString *)string widthOfView:(CGSize)size {
    CGSize newSize = CGSizeZero;
    if ([string respondsToSelector: @selector(boundingRectWithSize:options:context:)]) {
        
        newSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    }
    return newSize;
    
}

+ (UIAlertView *)showAlertViewWithTitle:(NSString *)title
                                message:(NSString *)message
                        isShowImmediate:(BOOL)isShowImmediate
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                      otherButtonTitles:(id)otherButtonTitles
          clickedButtonAtIndexWithBlock:(void (^)(NSNumber *btnIdx, UIAlertView *alertView))clickedButtonBlock {
    @autoreleasepool {
        if (!title) title = @"alert_remind";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:getLocalizationString(title)
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:getLocalizationString(cancelButtonTitle)
                                                  otherButtonTitles:nil];
        if (otherButtonTitles) {
            if ([otherButtonTitles isKindOfClass:[NSArray class]]) {
                [(NSArray *)otherButtonTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj isKindOfClass:[NSString class]]) {
                        [alertView addButtonWithTitle:getLocalizationString(obj)];
                    }
                }];
            }else if([otherButtonTitles isKindOfClass:[NSString class]]){
                [alertView addButtonWithTitle:getLocalizationString(otherButtonTitles)];
            }
        }
        
        [alertView.rac_buttonClickedSignal subscribeNext:^(NSNumber *btnIdx) {
            if (clickedButtonBlock) {
                clickedButtonBlock(btnIdx, alertView);
            }
        }];
        
        if(isShowImmediate){
            [alertView show];
        }
        return alertView;
    }
}

+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(float)opacity {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]  uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:opacity];
}

+ (void)addLabelWithFrame:(CGRect)frame content:(NSString*)text radius:(CGFloat)radius fontSize:(CGFloat)size  parentView:(UIView *)parentView isAlertShow:(BOOL)isAlertShow pushBlock:(void (^)(void))pushBlock {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = radius;
    btn.layer.shadowOffset =  CGSizeMake(3, 5);
    btn.layer.shadowOpacity = 0.6;
    btn.layer.shadowColor =  [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1].CGColor;
    CGSize textSize = [self getStringSizeWithString:text font:systemFontBoldWithoutRatio(size) widthOfView:CGSizeMake(MAXFLOAT, 20)];
    int num = (int)(textSize.width/(frame.size.width));
    num++;
    CGFloat textHeight = num*textSize.height+14;
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, textHeight);
    
    btn.frame = frame;
    btn.backgroundColor =  [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    btn.alpha = 0;
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(10, 0, frame.size.width-20, frame.size.height);
    
    label.backgroundColor =  [UIColor clearColor];
    label.textColor = [UIColor whiteColor ];
    label.text = text;
    label.font = [UIFont boldSystemFontOfSize:size];
    label.alpha = 0;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [btn addSubview:label];
    CGFloat delay = 2.0;
    if (num==1) {
        delay = 1.7;
        CGFloat h = textHeight+6;
        CGFloat w = textSize.width+50;
        if (textSize.width>130) {
            w = textSize.width+34;
        }else{
            delay = 1.5;
        }
        if (w>frame.size.width) {
            w = frame.size.width;
        }
        btn.frame = CGRectMake(frame.origin.x, frame.origin.y-20, w, h);
        btn.center = CGPointMake(SCREEN_WIDTH*0.5,btn.frame.origin.y+h*0.5);
        label.frame = CGRectMake(0, 0, w, h);
        label.textAlignment = NSTextAlignmentCenter;
    }
    
    if (isAlertShow) {
        btn.alpha = 0.2;
        label.alpha = 0.2;
        btn.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        [parentView addSubview:btn];
        [UIView animateWithDuration:0.2
                         animations:^{
                             btn.alpha = 1;
                             label.alpha = 1;
                             btn.transform = CGAffineTransformMakeScale(1.1, 1.1);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.1
                                              animations:^{
                                                  btn.transform = CGAffineTransformIdentity;
                                                  
                                                  
                                              }];
                             [UIView animateWithDuration:1.2 delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
                                 label.alpha = 0;
                                 btn.alpha = 0;
                             } completion:^(BOOL finished) {
                                 [label removeFromSuperview];
                                 [btn removeFromSuperview];
                                 pushBlock();
                                 
                             }];
                             
                         }];
    }else{
        [parentView addSubview:btn];
        delay = delay-0.1;
        [UIView animateWithDuration:1.2 animations:^{
            label.alpha = 1;
            btn.alpha = 1;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.2 delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
                label.alpha = 0;
                btn.alpha = 0;
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
                [btn removeFromSuperview];
                pushBlock();
                
            }];
        }];
    }
    
    
}

+ (void)makeACall:(NSString *)number {
    NSLog(@"%d",IS_SIMULATOR);
    NSLog(@"%d",IS_IPHONE);
    if (IS_IPHONE&&/* DISABLES CODE */ (!IS_SIMULATOR)) {
        [SupportingClass showAlertViewWithTitle:@"alert_remind"
                                        message:[NSString stringWithFormat:@"系统将会拨打以下号码：\n%@", number]
                                isShowImmediate:YES cancelButtonTitle:@"cancel"
                              otherButtonTitles:@"ok" clickedButtonAtIndexWithBlock:^(NSNumber *btnIdx, UIAlertView *alertView) {
                                  if (btnIdx.integerValue == 1) {
                                      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:number]]];
                                  }
                              }];
    }else {
        [SupportingClass showAlertViewWithTitle:@"alert_remind"
                                        message:[@"本机不支援拨号功能！\n请用有拨号功能的电话拨打以下号码：\n" stringByAppendingString:number]
                                isShowImmediate:YES cancelButtonTitle:@"ok"
                              otherButtonTitles:nil clickedButtonAtIndexWithBlock:nil];
    }
    
}


+ (NSString *)removeHTML:(NSString *)html {
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    
    
    
    theScanner = [NSScanner scannerWithString:html];
    
    
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        
        
        // find end of tag
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        
        
        // replace the found tag with a space
        
        //(you can filter multi-spaces out later if you wish)
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
        
        
        
    }
    
    return html;
    
}

@end
