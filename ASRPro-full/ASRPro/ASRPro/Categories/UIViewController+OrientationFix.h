//
//  UIViewController+OrientationFix.h
//  ASRPro
//
//  Created by GuruMurthy on 25/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (OrientationFix)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
- (BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;
@end
