//
//  EditCustomerViewController.h
//  ASRPro
//
//  Created by Santosh Kvss on 2/6/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerController.h"
#import "AppDelegate.h"

@class DemoAppDelegate;
@interface EditCustomerViewController : UIViewController<UITextFieldDelegate,DatePickerControllerDelegate> {
    
    UITextField *mActiveTxtFld_;
    AppDelegate *mAppDelegate_;
}

@property (weak, nonatomic) IBOutlet UIButton *mCancelBtn_;
@property (weak, nonatomic) IBOutlet UIButton *mSaveBtn_;
@property (weak, nonatomic) IBOutlet UILabel *mEditCustomerTitleLbl_;
@property (weak, nonatomic) IBOutlet UIScrollView *mContactScrollView;

- (IBAction)cancelBtnAction:(id)sender;
- (IBAction)saveBtnAction:(id)sender;

@end
