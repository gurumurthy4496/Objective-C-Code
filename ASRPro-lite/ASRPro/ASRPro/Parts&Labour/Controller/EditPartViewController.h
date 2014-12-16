//
//  EditPartViewController.h
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditPartViewController : UIViewController<UITextFieldDelegate>{
    AppDelegate* mAppDelegate_;
}

@property (strong, nonatomic) IBOutlet UILabel *mHeadingLabel_;
@property (strong, nonatomic) IBOutlet UIButton *mCancelButton_;
@property (strong, nonatomic) IBOutlet UIButton *mSaveButton_;
@property (strong, nonatomic) IBOutlet UIScrollView *mEditScrollView_;
@property (strong, nonatomic) IBOutlet UILabel *mDeleteLabel_;
@property (strong, nonatomic) IBOutlet UIButton *mYesDeleteLabel_;
@property (strong, nonatomic) IBOutlet UIButton *mNoDeleteLabel_;
@property (strong, nonatomic) IBOutlet UIView *mDeleteView_;
- (IBAction)CancelAction:(id)sender;
- (IBAction)SaveAction:(id)sender;
- (IBAction)DeleteAction:(id)sender;
- (IBAction)CancelDeleteAction:(id)sender;

@end
