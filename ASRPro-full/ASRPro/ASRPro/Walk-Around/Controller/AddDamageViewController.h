//
//  AddDamageViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 10/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildInspectionDetailsViewController.h"
@class BuildInspectionDetailsViewController;

@interface AddDamageViewController : UIViewController

@property (nonatomic, retain) BuildInspectionDetailsViewController *mBuildInspectionDetailsViewController_;
/**
 * Add Damage Button Instance.
 */
@property (weak, nonatomic) IBOutlet UIButton *mAddDamageButton_;

/**
 * Damage Point ImageView.
 */
@property (weak, nonatomic) IBOutlet UIImageView *mDamagePointImageView_;

/**
 * Add Damage Button Action.
 */
- (IBAction)addDamageButtonAction:(id)sender;

/**
 * Method to Show the Add Damage View at point.
 *@Param CGPoint = aCGPoint.
 */
- (void)setGCPointForAddDamageView :(CGPoint)aCGPoint;
@end
