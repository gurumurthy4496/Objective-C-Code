//
//  UIViewController+OrientationFix.m
//  ASRPro
//
//  Created by GuruMurthy on 25/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "UIViewController+OrientationFix.h"

@implementation UIViewController (OrientationFix)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
