//
//  DamagePopupViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 14/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildInspectionDetailsViewController.h"
@class BuildInspectionDetailsViewController;

@interface DamagePopupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *mDamagePopupButton_;
@property (nonatomic, retain) BuildInspectionDetailsViewController *mBuildInspectionDetailsViewController_;
- (IBAction)damagePopupButtonAction:(id)sender;
- (void)setDamageString :(NSString *)aDamageString_;
/**
 * Method to Show the Add Damage View at point.
 *@Param CGPoint = aCGPoint.
 */
- (void)setGCPointForDamagePopupView :(CGPoint)aCGPoint;
@end
