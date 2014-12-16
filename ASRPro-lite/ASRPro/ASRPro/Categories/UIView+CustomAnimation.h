//
//  UIView+CustomAnimation.h
//  ASRPro
//
//  Created by GuruMurthy on 08/11/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CustomAnimation)
/**
 * Methods for Presenting Transparent Modal View (This is UIView Category)[UIView Amimation like Presenting Modal View controller].
 */
-(void) presentTransparentModalViewController: (UIViewController *) aViewController
                                     animated: (BOOL) isAnimated
                                    withAlpha: (CGFloat) anAlpha;
/**
 * Methods for Dismiss Transparent Modal View.
 */
-(void) dismissTransparentModalViewControllerAnimated: (UIViewController *) aViewController
                                             animated: (BOOL) isAnimated;

@end
