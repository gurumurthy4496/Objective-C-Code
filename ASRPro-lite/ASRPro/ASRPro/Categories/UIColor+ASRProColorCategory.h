//
//  UIColor+ASRProColorCategory.h
//  ASRPro
//
//  Created by GuruMurthy on 03/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ASRProColorCategory)

/**
 * Methods for UIColor (This is UIColor Category).
 */
+ (UIColor *)ASRProLoginButtonBackGroundColor;
+ (UIColor *)ASRProForgotUserNamePasswordBackGroundColor;
+ (UIColor *)ASRProSelectedTableViewCellColor;
+ (UIColor *)ASRProLeftViewBackGroundColor;
+ (UIColor *)ASRProRGBColor:(CGFloat)aRed Green:(CGFloat)aGreen Blue:(CGFloat)aBlue;
+ (UIColor *)ASRProCustomAlertSelectedStateColor;
+ (UIColor *)ASRProLoginBackgroundColor;
+ (UIColor *)ASRProLoginErrorViewBackgroundColor;

+ (UIColor *)ASRProArchesColor;
+ (UIColor *)ASRProTextColor;
+ (UIColor *)ASRProLightTextColor;
+ (UIColor *)ASRProBlueColor;
+ (UIColor *)ASRProGreenColor;
+ (UIColor *)ASRProSteelColor;
+ (UIColor *)ASRProHighlightColor;
+ (UIColor *)ASRProOrangeColor;

@end
