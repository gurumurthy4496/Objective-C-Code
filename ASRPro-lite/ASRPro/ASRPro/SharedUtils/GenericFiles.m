//
//  GenericFiles.m
//  ASRPro
//
//  Created by Santosh Kvss on 10/26/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "GenericFiles.h"
static GenericFiles *genericFiles = nil;
@implementation GenericFiles
+ (id)genericFiles {
    @synchronized(self) {
        if(genericFiles == nil)
            genericFiles = [[super allocWithZone:NULL] init];
    }
    return genericFiles;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self genericFiles] ;
}
- (id)init {
    if (self = [super init]) {
    }
    return self;
}


//generic methods
- (void)createUIButtonInstance:(UIButton*)buttonInstance
                   buttonTitle:(NSString*)btnTitle
              buttonTitleColor:(UIColor*)btnTitleColor
               buttonTitleFont:(UIFont*)btnTitleFont
                  controlState:(UIControlState)controlstate
       buttoncontentEdgeInsets:(UIEdgeInsets)butncontentEdgeInsets
buttoncontentHorizontalAlignment:(UIControlContentHorizontalAlignment)butncontentHorizontalAlignment
         buttonBackgroundImage:(UIImage *)btnImage {
    [buttonInstance setTitle:btnTitle forState:controlstate];
    //[buttonInstance setTitleColor:btnTitleColor forState:UIControlStateHighlighted];
	[buttonInstance setTitleColor:btnTitleColor forState:controlstate];
	[[buttonInstance titleLabel]setFont:btnTitleFont];
    buttonInstance.contentHorizontalAlignment = butncontentHorizontalAlignment;
    buttonInstance.contentEdgeInsets = butncontentEdgeInsets;
    [buttonInstance setBackgroundImage:btnImage forState:controlstate];
    
}
- (void)createUITextFieldInstance:(UITextField*)textfieldInstance
                   textfieldTitle:(NSString*)textfieldTitle
              textfieldTitleColor:(UIColor*)textfieldTitleColor
               textfieldTitleFont:(UIFont*)textfieldTitleFont
                  BackgroundColor:(UIColor *)backgroundColor {
[textfieldInstance setBackgroundColor:backgroundColor];
[textfieldInstance setTextColor:textfieldTitleColor];
//[self setUserInteractionEnabled:YES];
//[self setBorderStyle:UITextBorderStyleLine];
[textfieldInstance.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
[textfieldInstance.layer setBorderWidth:1.0];
[textfieldInstance setFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey]];
textfieldInstance.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}
- (void)createUILabelWithInstance:(UILabel*)labelInstance_
                  labelTitleFont :(UIFont*)labeltitleFont_
                       labelTitle:(NSString*)labelTitle_
                   labelTextColor:(UIColor*)labelTextColor_
               labelTextAlignment:(NSTextAlignment)labeltextAlignment_
             labelBackgroundColor:(UIColor*)labelBackgroundColor_ {
	
	[labelInstance_ setFont:labeltitleFont_];
	[labelInstance_ setNumberOfLines:2];
	[labelInstance_ setTextColor:labelTextColor_];
	[labelInstance_ setBackgroundColor:labelBackgroundColor_];
	[labelInstance_ setText:labelTitle_];
	[labelInstance_ setTextAlignment:labeltextAlignment_];
    [labelInstance_ setLineBreakMode:NSLineBreakByWordWrapping];
	
}
#pragma mark --
#pragma mark PrivateMethods
// ----------------------------;
// Method to find top most viewcontroller;
// ----------------------------;
- (UIViewController*)topViewController:(UIViewController *)aViewController {
    return [self topViewControllerWithRootViewController:aViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

- (void)createUIButtonInstancewithIcon:(UIButton*)buttonInstance
                           buttonTitle:(NSString*)btnTitle
                      buttonTitleColor:(UIColor*)btnTitleColor
                       buttonTitleFont:(UIFont*)btnTitleFont
                 buttonTitleEdgeInsets:(UIEdgeInsets)btnTitleEdgeInsets
                           buttonImage:(UIImage*)btnImage
                 buttonImageEdgeInsets:(UIEdgeInsets)btnImageEdgeInsets
                          controlState:(UIControlState)controlstate
               buttoncontentEdgeInsets:(UIEdgeInsets)butncontentEdgeInsets
      buttoncontentHorizontalAlignment:(UIControlContentHorizontalAlignment)butncontentHorizontalAlignment
                 buttonBackgroundColor:(UIColor *)btnColor {
    [buttonInstance setTitle:btnTitle forState:controlstate];
    [buttonInstance setTitleColor:btnTitleColor forState:controlstate];
	[[buttonInstance titleLabel]setFont:btnTitleFont];
    buttonInstance.contentHorizontalAlignment = butncontentHorizontalAlignment;
    buttonInstance.contentEdgeInsets = butncontentEdgeInsets;
    [buttonInstance setBackgroundImage:[UIImage imageWithColor:btnColor] forState:controlstate];
    [buttonInstance setImage:btnImage forState:controlstate];
    [buttonInstance setImageEdgeInsets:btnImageEdgeInsets];
    [buttonInstance setTitleEdgeInsets:btnTitleEdgeInsets];
}


/*- (void)setDynamicHeightFortLabel:(UILabel*)labelInstance_
                  labelTitleFont :(UIFont*)labeltitleFont_
                       labelTitle:(NSString*)labelTitle_
                   labelTextColor:(UIColor*)labelTextColor_
               labelTextAlignment:(UITextAlignment)labeltextAlignment_
             labelBackgroundColor:(UIColor*)labelBackgroundColor_
               labelNumberOfLines:(NSUInteger *)labelSetNumberOfLines_
               labelLineBreakMode:(NSLineBreakMode *)labelSetLineBreakMode_{
    
    labelInstance_.numberOfLines = labelSetNumberOfLines_;
    [labelInstance_ setLineBreakMode:labelSetLineBreakMode_];
    
    CGSize maximumLabelSize = CGSizeMake(310,9999);
    
    CGSize expectedLabelSize = [labelTitle_ sizeWithFont:labeltitleFont_
                                       constrainedToSize:maximumLabelSize
                                           lineBreakMode:labelInstance_.lineBreakMode];
    
    CGRect newFrame = labelInstance_.frame;
    newFrame.size.height = expectedLabelSize.height;
    labelInstance_.frame = newFrame;
	[labelInstance_ setText:labelTitle_];
    [labelInstance_ setFont:labeltitleFont_];
	[labelInstance_ setNumberOfLines:0];
	[labelInstance_ setTextColor:labelTextColor_];
	[labelInstance_ setBackgroundColor:labelBackgroundColor_];
	[labelInstance_ setTextAlignment:labeltextAlignment_];
    
    [labelInstance_ sizeToFit];
    
}*/

-(int)dynamiclabelHeightForText:(NSString *)text :(int)width :(UIFont *)font
{
	
	CGSize maximumLabelSize = CGSizeMake(width,2500);
	
	CGSize expectedLabelSize = [text sizeWithFont:font
								constrainedToSize:maximumLabelSize
									lineBreakMode:NSLineBreakByWordWrapping];
	
	
	return expectedLabelSize.height+2;
	
	
}


@end
