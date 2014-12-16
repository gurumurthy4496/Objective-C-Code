//
//  UIFont+ASRProFontCategory.m
//  ASRPro
//
//  Created by GuruMurthy on 26/09/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "UIFont+ASRProFontCategory.h"

@implementation UIFont (ASRProFontCategory)

#pragma mark - Font Names

+ (NSDictionary *)FontMapForFontKey:(NSString *)key {
	static NSDictionary *fontDictionary = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		fontDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:
						  [NSDictionary dictionaryWithObjectsAndKeys:
						   @"HelveticaNeue", kFontRegularKey,
						   @"HelveticaNeue-Italic", kFontItalicKey,
						   @"HelveticaNeue-Bold", kFontBoldKey,
						   @"HelveticaNeue-BoldItalic", kFontBoldItalicKey,
						   nil], kFontNameHelveticaNeueKey,
						  [NSDictionary dictionaryWithObjectsAndKeys:
						   @"OpenSans", kFontRegularKey,
						   @"OpenSans-Semibold", kFontSemiBoldKey,
						   @"OpenSans-Italic", kFontItalicKey,
						   nil], kFontNameOpenSansKey,
						  nil];
});
	return [fontDictionary objectForKey:key];
}

+ (NSString *)FontNameForFontKey:(NSString *)key style:(NSString *)style {
	return [[self FontMapForFontKey:key] objectForKey:style];
}


#pragma mark - Fonts

+ (UIFont *)regularFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key {
	NSString *fontName = [self FontNameForFontKey:key style:kFontRegularKey];
	return [self fontWithName:fontName size:fontSize];
}

+ (UIFont *)italicFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key {
	NSString *fontName = [self FontNameForFontKey:key style:kFontItalicKey];
	return [self fontWithName:fontName size:fontSize];
}


+ (UIFont *)boldFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key {
	NSString *fontName = [self FontNameForFontKey:key style:kFontBoldKey];
	return [self fontWithName:fontName size:fontSize];
}


+ (UIFont *)boldItalicFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key {
	NSString *fontName = [self FontNameForFontKey:key style:kFontBoldItalicKey];
	return [self fontWithName:fontName size:fontSize];
}

+ (UIFont *)semiBoldFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key {
	NSString *fontName = [self FontNameForFontKey:key style:kFontBoldItalicKey];
	return [self fontWithName:fontName size:fontSize];
}

@end
