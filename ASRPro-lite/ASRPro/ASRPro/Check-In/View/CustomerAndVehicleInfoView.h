//
//  CustomerAndVehicleInfoView.h
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopOverViewControllerForDatePickerView.h"
@class  PopOverViewControllerForDatePickerView;

@interface CustomerAndVehicleInfoView : UIView <UITextFieldDelegate,PopOverViewControllerForDatePickerDelegate,UIPopoverControllerDelegate>
@property (nonatomic, retain) UIPopoverController *mPopoverController;

@property (strong, nonatomic) UIButton *mCustomerPlanButton_;



- (void)setBorderForCustomerAndVehicleInfoView;
- (void)setLabelsForCustomerAndVehicleInfoView;
@end
