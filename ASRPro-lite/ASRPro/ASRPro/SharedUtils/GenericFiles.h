//
//  GenericFiles.h
//  ASRPro
//
//  Created by Santosh Kvss on 10/26/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenericFiles : NSObject
/**
 * method for getting the instance of class
 */
+ (id)genericFiles;
/**
 * method for allocWithZone
 */
+ (id)allocWithZone:(NSZone *)zone;
- (void)createUIButtonInstance:(UIButton*)buttonInstance
                   buttonTitle:(NSString*)btnTitle
              buttonTitleColor:(UIColor*)btnTitleColor
               buttonTitleFont:(UIFont*)btnTitleFont
                  controlState:(UIControlState)controlstate
       buttoncontentEdgeInsets:(UIEdgeInsets)butncontentEdgeInsets
buttoncontentHorizontalAlignment:(UIControlContentHorizontalAlignment)butncontentHorizontalAlignment
         buttonBackgroundImage:(UIImage *)btnImage;


- (void)createUILabelWithInstance:(UILabel*)labelInstance_
                  labelTitleFont :(UIFont*)labeltitleFont_
                       labelTitle:(NSString*)labelTitle_
                   labelTextColor:(UIColor*)labelTextColor_
               labelTextAlignment:(NSTextAlignment)labeltextAlignment_
             labelBackgroundColor:(UIColor*)labelBackgroundColor_;

- (void)createUITextFieldInstance:(UITextField*)textfieldInstance
                      textfieldTitle:(NSString*)textfieldTitle
                 textfieldTitleColor:(UIColor*)textfieldTitleColor
                  textfieldTitleFont:(UIFont*)textfieldTitleFont
                  BackgroundColor:(UIColor *)backgroundColor;

- (UIViewController*)topViewController:(UIViewController *)aViewController;
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
                 buttonBackgroundColor:(UIColor *)btnColor;
/*- (void)setDynamicHeightFortLabel:(UILabel*)labelInstance_
                  labelTitleFont :(UIFont*)labeltitleFont_
                       labelTitle:(NSString*)labelTitle_
                   labelTextColor:(UIColor*)labelTextColor_
               labelTextAlignment:(UITextAlignment)labeltextAlignment_
             labelBackgroundColor:(UIColor*)labelBackgroundColor_
               labelNumberOfLines:(NSUInteger *)labelSetNumberOfLines_
               labelLineBreakMode:(NSLineBreakMode *)labelSetLineBreakMode_;*/
-(int)dynamiclabelHeightForText:(NSString *)text :(int)width :(UIFont *)font;
@end
