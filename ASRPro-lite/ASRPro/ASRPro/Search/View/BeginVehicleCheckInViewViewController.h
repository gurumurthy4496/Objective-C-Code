//
//  BeginVehicleCheckInViewViewController.h
//  Demo
//
//  Created by Santosh Kvss on 1/29/14.
//  Copyright (c) 2014 valuelabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckInSearchTableView.h"
#import "SelectAppointmentTableView.h"
#import "ZBarSDK.h"

@class CheckInSearchTableView;
@class SelectAppointmentTableView;
@interface BeginVehicleCheckInViewViewController : UIViewController<UITextFieldDelegate,ZBarReaderDelegate> {
    
    int mCurrentField_;
    AppDelegate *mAppDelegate_;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView_;
@property (weak, nonatomic) IBOutlet UILabel *mCheckInTitleLbl_;
@property (weak, nonatomic) IBOutlet UILabel *mCustomerNotFoundLbl_;
@property (weak, nonatomic) IBOutlet UILabel *mNoAppointmentsLbl_;
@property (retain, nonatomic) NSMutableArray *mTextFieldsArr_;
@property (weak, nonatomic) IBOutlet UIView *mSearchView_;
@property (retain, nonatomic) UIActivityIndicatorView *mActivityIndicator_;
@property (weak, nonatomic) IBOutlet UIButton *mContinueBtn_;
@property (weak, nonatomic) IBOutlet UIButton *mCancelBtn_;
@property (retain, nonatomic) UILabel *mLoadingLbl_;
@property (weak, nonatomic) IBOutlet UIView *mAddCustomerView_;
@property (weak, nonatomic) IBOutlet UIButton *mAddCustomerBtn_;
@property (weak, nonatomic) IBOutlet UIView *mSelectedApptView_;
@property (weak, nonatomic) IBOutlet UIButton *mSelectedApptContinueBtn_;
@property (weak, nonatomic) IBOutlet UILabel *mSelectApptTitleLbl_;
@property (strong, nonatomic) IBOutlet CheckInSearchTableView *mCheckInSearchTableView_;
@property (strong, nonatomic) IBOutlet SelectAppointmentTableView *mSelectAppointmentTableView_;
@property (weak, nonatomic) IBOutlet UIButton *mContinueWithOutAppointmentBtn_;
@property (nonatomic) BOOL isAnyCustomerSelected;
@property (nonatomic) BOOL isAnyApponimentSelected;

- (IBAction)ContinueWithoutApptBtnAction:(id)sender;
- (IBAction)addCustomerBtnAction:(id)sender;
- (IBAction)cancelBtnAction:(id)sender;
- (IBAction)continueBtnAction:(id)sender;
- (void)reloadSearchTableData;
- (void)setActivityIndicatorToSearchView;
- (IBAction)SelectedApptContinueAction:(id)sender;
- (void)errorResponseForVINDecoder;
@end
