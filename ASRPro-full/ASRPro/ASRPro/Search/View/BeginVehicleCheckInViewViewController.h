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
#import "AdvancedSearchTextField.h"
#import "AdvancedSearchTableView.h"
#import "ZBarSDK.h"
#import "BarcodeTextField.h"

@class CheckInSearchTableView;
@class SelectAppointmentTableView;
@class AdvancedSearchTableView;
@class BarcodeTextField;

@interface BeginVehicleCheckInViewViewController : UIViewController<UITextFieldDelegate,ZBarReaderDelegate> {
    
    int mCurrentField_;
    AppDelegate *mAppDelegate_;
}

@property (weak, nonatomic) IBOutlet UITableView *mTableView_;
@property (weak, nonatomic) IBOutlet UILabel *mCheckInTitleLbl_;
@property (weak, nonatomic) IBOutlet UILabel *mCustomerNotFoundLbl_;
@property (weak, nonatomic) IBOutlet UILabel *mNoAppointmentsLbl_;
@property (retain, nonatomic) NSMutableArray *mTextFieldsArr_;
@property (retain, nonatomic) NSMutableArray *mAdvancedSearchTextFieldsArr_;
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
@property (strong, nonatomic) IBOutlet AdvancedSearchTableView *mAdvancedSearchTableView_;
@property (weak, nonatomic) IBOutlet UIButton *mContinueWithOutAppointmentBtn_;
@property (weak, nonatomic) IBOutlet UIButton *mContinueWithoutCustomerInfo_;
@property (nonatomic) BOOL isAnyCustomerSelected;
@property (nonatomic) BOOL isAnyApponimentSelected;
@property (nonatomic, retain) NSString *mFirstName_;
@property (nonatomic, retain) NSString *mLastName_;
@property (weak, nonatomic) IBOutlet UIButton *mAdvancedSearchBtn_;
@property (weak, nonatomic) IBOutlet UILabel *mAdvancedSearchNoCustomerLbl_;
@property (weak, nonatomic) IBOutlet UIScrollView *mAdvancedSearchScrollView_;
@property (weak, nonatomic) IBOutlet UIView *mAdvancedSearchView_;
@property (weak, nonatomic) IBOutlet UIView *mAdvancedSearchResultView_;
@property (weak, nonatomic) IBOutlet UIButton *mAdvancedSearchContinueBtn_;
@property (weak, nonatomic) IBOutlet UIButton *mAdvancedSearchResultContinueBtn_;
@property (weak, nonatomic) ZBarReaderViewController *zBarReaderViewController;
@property (weak, nonatomic) BarcodeTextField *barcodeTextField;
- (IBAction)ContinueWithoutApptBtnAction:(id)sender;
- (IBAction)addCustomerBtnAction:(id)sender;
- (IBAction)cancelBtnAction:(id)sender;
- (IBAction)continueBtnAction:(id)sender;
- (IBAction)advancedSearchResultContinueBtnAction:(id)sender;
- (IBAction)advancedSearchContinueBtnAction:(id)sender;
- (IBAction)advancedSearchBtnAction:(id)sender;
- (IBAction)continueWithoutCustomerInfoButtonAction:(id)sender;
- (void)reloadSearchTableData;
- (void)reloadApptTableData;
- (void)setActivityIndicatorToSearchView;
- (IBAction)SelectedApptContinueAction:(id)sender;
- (void)errorResponseForVINDecoder;
- (void)filterAppointmentsBasedOnVINAndCustomer;
- (void)errorResponseForCustomerSearch;
-(void)postRequestforCheckin;
-(void)setContinueHiddenTRueorFalse;
- (void)reloadAdvancedSearchTableData;
- (void)showApptView;
- (void)getVinNumberFromBarCode :(NSString *)aVinNumber barCodeViewController :(id)aBarCodeViewController;
- (void)setVINTextToBeginVehicleCheckIn:(NSString *)aVinNumber;
@end
