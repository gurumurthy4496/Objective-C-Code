//
//  PrintEmailPopupViewViewController.h
//  ASRPro
//
//  Created by Kalyani on 26/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicesTextField.h"

@interface PrintEmailPopupViewViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *mBookletbtn_;
@property (strong, nonatomic) IBOutlet UIButton *mMPIbtn_;
@property (strong, nonatomic) IBOutlet UIButton *mEstimatebtn_;
@property (strong, nonatomic) IBOutlet UIButton *mClientMailBtn_;
@property (strong, nonatomic) IBOutlet UIButton *mCustomMailBtn;
@property (strong, nonatomic) IBOutlet UIButton *mEmailBtn_;
@property (strong, nonatomic) IBOutlet UIButton *mPrintBtn;
@property (strong, nonatomic) IBOutlet UILabel *mHeadingLabel_;
@property (strong, nonatomic) IBOutlet UIButton *mCancelBtn_;
@property(strong,nonatomic) UITextField* mInspectionFormTextField_;
@property (strong, nonatomic) IBOutlet UIButton *mCustomerPlan;
@property (strong, nonatomic) IBOutlet UIButton *mPreROEstimate;
@property (strong, nonatomic) IBOutlet UILabel *mCustomerEmailLabel_;
@property (weak, nonatomic) IBOutlet UILabel *preRoEstimateLabel;
- (IBAction)sendMailTypeAction:(id)sender;
- (IBAction)FormTypeAction:(id)sender;
- (IBAction)EmailAction:(id)sender;
- (IBAction)PrintAction:(id)sender;
- (IBAction)CancelAction:(id)sender;
-(void)requestForEmail;
-(void)dismisstheView;

@end
