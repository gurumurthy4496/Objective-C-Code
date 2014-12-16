//
//  UIColor+ASRProColorCategory.m
//  ASRPro
//
//  Created by GuruMurthy on 03/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "UIColor+ASRProColorCategory.h"

@implementation UIColor (ASRProColorCategory)

+ (UIColor *)ASRProLoginButtonBackGroundColor {
    return [self colorWithRed:230/255.0 green:127.0/255.0 blue:34.0/255.0 alpha:1.0f];
}

+ (UIColor *)ASRProForgotUserNamePasswordBackGroundColor {
    return [self colorWithRed:81/255.0 green:146/255.0 blue:194/255.0 alpha:1.0f];
}

+ (UIColor *)ASRProSelectedTableViewCellColor {
    return [self colorWithRed:229/255.0 green:125/255.0 blue:37/255.0 alpha:1.0f];
}

+ (UIColor *)ASRProLeftViewBackGroundColor {
    return [self colorWithRed:3/255.0 green:13/255.0 blue:21/255.0 alpha:1.0f];
}

+ (UIColor *)ASRProRGBColor:(CGFloat)aRed Green:(CGFloat)aGreen Blue:(CGFloat)aBlue {
    return [self colorWithRed:aRed/255.0 green:aGreen/255.0 blue:aBlue/255.0 alpha:1.0f];
}

+ (UIColor *)ASRProCustomAlertSelectedStateColor {
    return [self colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1.0f];
}

//-------------------------------- ASR Pro iPad US Colors --------------------------------
+ (UIColor *)ASRProLoginBackgroundColor {
    return [self colorWithRed:40/255.0 green:127/255.0 blue:184/255.0 alpha:1.0f];
}

+ (UIColor *)ASRProLoginErrorViewBackgroundColor {
    return [self colorWithRed:231/255.0 green:75/255.0 blue:60/255.0 alpha:1.0f];
}

+ (UIColor *)ASRProBlueColor {
    return [self colorWithRed:21/255.0 green:125/255.0 blue:251/255.0 alpha:1.0f];
}

+ (UIColor *)ASRProGreenColor {
    return [self colorWithRed:38/255.0 green:174/255.0 blue:97/255.0 alpha:1.0f];
}
//----------------------------------------------------------------------------------------

+ (UIColor *)ASRProArchesColor {
	return [self colorWithPatternImage:[UIImage imageNamed:@"arches"]];
}


+ (UIColor *)ASRProTextColor {
	return [self colorWithWhite:0.267f alpha:1.0f];
}


+ (UIColor *)ASRProLightTextColor {
	return [self colorWithWhite:0.651f alpha:1.0f];
}

+ (UIColor *)ASRProSteelColor {
	return [self colorWithRed:0.376f green:0.408f blue:0.463f alpha:1.0f];
}


+ (UIColor *)ASRProHighlightColor {
	return [self colorWithRed:1.000f green:0.996f blue:0.792f alpha:1.0f];
}


+ (UIColor *)ASRProOrangeColor {
	return [self colorWithRed:1.000f green:0.447f blue:0.263f alpha:1.0f];
}

@end
