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
@property (strong, nonatomic) UIButton *waiterButton;
@property (strong, nonatomic) UITextField *promiseDateTextField;
@property (strong, nonatomic) UITextField *promiseTimeTextField;
@property (strong, nonatomic) UILabel *customerAndVehicleLabel;

- (void)setBorderForCustomerAndVehicleInfoView;
- (void)setLabelsForCustomerAndVehicleInfoView;
@end
