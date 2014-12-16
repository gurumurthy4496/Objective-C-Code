//
//  UIView+CustomAnimation.m
//  ASRPro
//
//  Created by GuruMurthy on 08/11/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "UIView+CustomAnimation.h"

@implementation UIView (CustomAnimation)

#pragma mark --
#pragma mark Transparent Modal View
-(void) presentTransparentModalViewController: (UIViewController *) aViewController
                                     animated: (BOOL) isAnimated
                                    withAlpha: (CGFloat) anAlpha {
    
    UIView *view = aViewController.view;
    //setting frame for UIImageview
    view.opaque = NO;
    view.alpha = anAlpha;
    [view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *each = obj;
        each.opaque = NO;
        each.alpha = anAlpha;
    }];
    
    if (isAnimated) {
        //Animated
        CGRect mainrect = [[UIScreen mainScreen] bounds];
        CGRect newRect = CGRectMake(0, mainrect.size.height, mainrect.size.width, mainrect.size.height);
        
        [[[[UIApplication sharedApplication] windows] lastObject] addSubview:view];
        view.frame = newRect;
        
        [UIView animateWithDuration:0.8
                         animations:^{
                             view.frame = mainrect;
                         } completion:^(BOOL finished) {
                             //nop
                         }];
        
    }else {
        view.frame = [[UIScreen mainScreen] bounds];
        [[[[UIApplication sharedApplication] windows] lastObject] addSubview:view];
    }
    
}

-(void) dismissTransparentModalViewControllerAnimated: (UIViewController *) aViewController
                                             animated: (BOOL) isAnimated {
    __block UIView *lView = aViewController.view;
    if (isAnimated) {
        CGRect mainrect = [[UIScreen mainScreen] bounds];
        CGRect newRect = CGRectMake(0, mainrect.size.height, mainrect.size.width, mainrect.size.height);
        [UIView animateWithDuration:0.8
                         animations:^{
                             lView.frame = newRect;
                         } completion:^(BOOL finished) {
                             [lView removeFromSuperview];
                             lView = nil;
                         }];
    }else {
        [lView removeFromSuperview];
        lView = nil;
    }
}

@end
