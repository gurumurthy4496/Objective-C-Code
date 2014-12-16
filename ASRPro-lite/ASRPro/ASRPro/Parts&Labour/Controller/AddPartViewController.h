//
//  AddPartViewController.h
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPartViewController : UIViewController<UITextFieldDelegate>{
    AppDelegate* mAppDelegate_;
}
@property (strong, nonatomic) IBOutlet UILabel *mTitleLabel_;
@property (strong, nonatomic) IBOutlet UIButton *mCancelButton_;
@property (strong, nonatomic) IBOutlet UIButton *mAddButton_;

- (IBAction)CancelButtonAction:(id)sender;
- (IBAction)AddButtonAction:(id)sender;

@end
