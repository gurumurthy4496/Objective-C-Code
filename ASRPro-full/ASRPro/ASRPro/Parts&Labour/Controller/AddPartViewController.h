//
//  AddPartViewController.h
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownView.h"

@interface AddPartViewController : UIViewController<UITextFieldDelegate,DropDownViewClassDelegate>{
    /**
     * AppDelegate object creating
     */
    AppDelegate* mAppDelegate_;
    UITextField* mActiveTextField_;
}

/**
 * * IBOutlet for Title Label
 */
@property (strong, nonatomic) IBOutlet UILabel *mTitleLabel_;

/**
 * * IBOutlet for Scrool View
 */
@property (strong, nonatomic) IBOutlet UIScrollView *mPartsScrollView_;

/**
 * * IBOutlet for Cancel Button
 */
@property (strong, nonatomic) IBOutlet UIButton *mCancelButton_;

/**
 * IBOutlet for Add Button
 */
@property (strong, nonatomic) IBOutlet UIButton *mAddButton_;

/**
 * method action for Cancel button
 */
- (IBAction)CancelButtonAction:(id)sender;

/**
 * method action for add button
 */
- (IBAction)AddButtonAction:(id)sender;

@end
