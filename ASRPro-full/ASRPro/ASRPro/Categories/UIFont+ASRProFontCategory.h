//
//  UIFont+ASRProFontCategory.h
//  ASRPro
//
//  Created by GuruMurthy on 26/09/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (ASRProFontCategory)

#pragma mark - Font Names
/**
 * Method to get required Fonts[Regular,Italic,Bold,BoldItalic,SemiBold] Do not access below two methods directly.
 */
+ (NSDictionary *)FontMapForFontKey:(NSString *)key;
+ (NSString *)FontNameForFontKey:(NSString *)key style:(NSString *)style;

#pragma mark - Fonts
/**
 * Method for Fonts[Regular,Italic,Bold,BoldItalic,SemiBold] (This is Fonts Category).
 */
+ (UIFont *)regularFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)italicFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)boldFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)boldItalicFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)semiBoldFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
@end
