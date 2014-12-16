//
//  EditVehicleViewController.h
//  ASRPro
//
//  Created by Santosh Kvss on 2/6/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerController.h"

@interface EditVehicleViewController : UIViewController<UITextFieldDelegate,DatePickerControllerDelegate> {
    UITextField *mActiveTxtFld_;
    AppDelegate *mAppDelegate_;
}

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView_;
@property (weak, nonatomic) IBOutlet UIButton *mCancelBtn_;
@property (weak, nonatomic) IBOutlet UIButton *mSaveBtn_;
@property (weak, nonatomic) IBOutlet UILabel *mTitleLbl_;

- (IBAction)cancelBtnAction:(id)sender;
- (IBAction)saveBtnAction:(id)sender;
- (void)setValuesToViews;

@end
