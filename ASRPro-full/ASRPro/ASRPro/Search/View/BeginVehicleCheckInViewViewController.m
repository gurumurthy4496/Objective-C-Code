//
//  BeginVehicleCheckInViewViewController.m
//  Demo
//
//  Created by Santosh Kvss on 1/29/14.
//  Copyright (c) 2014 valuelabs. All rights reserved.
//

#import "BeginVehicleCheckInViewViewController.h"
#define KROWHEIGHT 60
#define kKeyboardHeight_CustomerCheckin 100
#import "BarcodeViewController.h"
#import "TTiOSVINScannerVC.h"

@interface BeginVehicleCheckInViewViewController ()

- (void)initData;
@end

@implementation BeginVehicleCheckInViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    self.isAnyCustomerSelected = FALSE;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
//    {
        self.view.superview.bounds = CGRectMake(0, 0, 384, 225);
//    }
}

#pragma mark -  ***************** Generic Methods ****************

- (void)initData {
    
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    self.mTextFieldsArr_ = [NSMutableArray new];
    self.mAdvancedSearchTextFieldsArr_ = [NSMutableArray new];
    [self setBorderColor];
    _mCheckInSearchTableView_.mBeginCheckInView_ = self;
    _mCheckInSearchTableView_->mAppDelegate_ = mAppDelegate_;
    [_mCheckInSearchTableView_ setDelegatesForSearchListTableview_];
    if ([_mTableView_ respondsToSelector:@selector(setSeparatorInset:)]) {
        [_mTableView_ setSeparatorInset:UIEdgeInsetsZero];
    }
    _mSelectAppointmentTableView_.mBeginCheckInView_ = self;
    _mSelectAppointmentTableView_->mAppDelegate_ = mAppDelegate_;
    [_mSelectAppointmentTableView_ setDelegatesForSearchListTableview_];
    _mAdvancedSearchTableView_.mBeginCheckInView_ = self;
    _mAdvancedSearchTableView_->mAppDelegate_ = mAppDelegate_;
    [_mAdvancedSearchTableView_ setDelegatesForAdvancedSearchTableview_];
    [self.mCancelBtn_ setEnabled:YES];
    [self.mAdvancedSearchScrollView_ setContentSize:CGSizeMake(self.mAdvancedSearchScrollView_.frame.size.width, self.mAdvancedSearchScrollView_.frame.size.height+50)];
    [self setFontsAndTextToSearchScreenView];
    
    NSIndexPath *selectedIndexPath = [mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ indexPathForSelectedRow];
    
    if (selectedIndexPath == nil) {
        mAppDelegate_.mModelForWalkAround_.mTempPRE_RONumber = nil;
    }
}

- (void)setFontsAndTextToSearchScreenView {
    
    [self.mSelectApptTitleLbl_ setText:NSLocalizedString(@"Select_Appointment", nil)];
    [self.mContinueWithOutAppointmentBtn_ setTitle:NSLocalizedString(@"Continue_Without_Appointment", nil) forState:UIControlStateNormal];
}

- (void)setBorderColor {
    for(UIView *lView in self.view.subviews) {
        if ([lView isKindOfClass:[UIView class]]) {
            if(lView.tag == 50 || lView.tag == 60 || lView.tag == 70 || lView.tag == 80) {
                for(UIView *pView in lView.subviews) {
                    if([pView isKindOfClass:[UIView class]] && (pView.tag == 100 || pView.tag == 55 || pView.tag == 500 || pView.tag == 65 || pView.tag == 75 || pView.tag == 600)) {
                        [pView.layer setBorderColor:[[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0] CGColor]];
                        [pView.layer setBorderWidth:0.5];
                    }
                }
            }
        }
    }
}

- (void)resetData {
    
    [mAppDelegate_.mModelForEditCustomerScreen_ resetallData];
}

- (void)setAdvancedSearchFieldsForScrollView {
    
    if ([_mAdvancedSearchTextFieldsArr_ count]>0) {
        [_mAdvancedSearchTextFieldsArr_ removeAllObjects];
    }
    CGFloat xPos = 0.0, yPos = 0.0;
    NSString *lTitleStr = @"First Name,Last Name,Phone,Email";
    NSArray *lTitleArr = [lTitleStr componentsSeparatedByString:@","];
    for (int i=0; i<[lTitleArr count]; i++) {
        
        UIView *lCellView = [[UIView alloc] init];
        [lCellView setFrame:CGRectMake(xPos, yPos, 384, 44)];
        [lCellView.layer setBorderColor:[[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0] CGColor]];
        [lCellView.layer setBorderWidth:0.5];
        
        AdvancedSearchTextField *lTextField = [[AdvancedSearchTextField alloc] initWithFrame:CGRectMake(xPos, 15, 384, 25)];
        lTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        lTextField.tag = i;
        [lTextField setTextColor:[UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0]];
        [lTextField setBackground:[UIImage imageWithColor:[UIColor whiteColor]]];
        [lTextField setDisabledBackground:[UIImage imageWithColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:0.7]]];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
        lTextField.leftView = leftView;
        lTextField.leftViewMode = UITextFieldViewModeAlways;
        if (i==[lTitleArr count]-1) {
            lTextField.returnKeyType = UIReturnKeyDone;
        }else
            lTextField.returnKeyType = UIReturnKeyNext;
        switch (i) {
            case 0:
                lTextField.text = mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_;
                break;
            case 2:{
                lTextField.text = mAppDelegate_.mModelForEditCustomerScreen_.mHomePhone_;
                lTextField.keyboardType = UIKeyboardTypeNumberPad;
            }
                break;
            case 3:{
                lTextField.text = mAppDelegate_.mModelForEditCustomerScreen_.mEmail_;
                lTextField.keyboardType = UIKeyboardTypeEmailAddress;
            }
                break;
            case 1:{
                lTextField.text = mAppDelegate_.mModelForEditCustomerScreen_.mLastName_;
                lTextField.keyboardType = UIKeyboardTypeEmailAddress;
                
            }
                break;
            default:lTextField.keyboardType = UIKeyboardTypeDefault;
                break;
        }
        lTextField.borderStyle = UITextBorderStyleNone;
        [lTextField setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
        lTextField.placeholder = [lTitleArr objectAtIndex:i];
        [lTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self.mAdvancedSearchTextFieldsArr_ addObject:lTextField];
        [lCellView addSubview:lTextField];
        [_mAdvancedSearchScrollView_ addSubview:lCellView];
        if ([lTextField.text length] != 0 || ![lTextField.text isEqualToString:@""]) {
            [lTextField showCheckInLabels:lTextField];
        }
        yPos += lCellView.frame.size.height;
    }
    [self setContinueHiddenTRueorFalse];
    
}

-(void)setContinueHiddenTRueorFalse {
    __block BOOL hidden=TRUE;
    
    [self.mAdvancedSearchScrollView_.subviews enumerateObjectsUsingBlock:^(id object,NSUInteger index,BOOL *stop) {
        if ([object isKindOfClass:[UIView class]]) {
            [((UIView*)object).subviews enumerateObjectsUsingBlock:^(id object1,NSUInteger index1,BOOL *stop1) {
                if ([object1 isKindOfClass:[AdvancedSearchTextField class]]) {
                    AdvancedSearchTextField *lTextfield = (AdvancedSearchTextField*)object1;
                    if ([[lTextfield text] length] !=0) {
                        hidden = FALSE;
                    }
                }
            }];
        }
    }];
    
    [self.mAdvancedSearchContinueBtn_ setHidden:hidden];
}

- (void)setActivityIndicatorToSearchView {
    
    [self.mCheckInTitleLbl_ setText:@"Search"];
    [_mContinueBtn_ setHidden:TRUE];
    [_mAdvancedSearchContinueBtn_ setHidden:TRUE];
    [_mCancelBtn_ setEnabled:NO];
    [_mSearchView_ setHidden:FALSE];
    [_mAddCustomerView_ setHidden:TRUE];
    [_mCheckInSearchTableView_ setHidden:TRUE];
    [_mCustomerNotFoundLbl_ setHidden:TRUE];
    //Create and add the Activity Indicator to splashView
    if (self.mActivityIndicator_ == nil) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self setMActivityIndicator_:activityIndicator];
    }
    _mActivityIndicator_.alpha = 1.0;
    _mActivityIndicator_.center = CGPointMake(140, (_mSearchView_.frame.size.height/2)-5);
    _mActivityIndicator_.hidesWhenStopped = NO;
    [_mSearchView_ addSubview:_mActivityIndicator_];
    [_mActivityIndicator_ startAnimating];
    if (self.mLoadingLbl_ == nil) {
        UILabel *pLoadingLbl_ = [[UILabel alloc] init];
        [self setMLoadingLbl_:pLoadingLbl_];
    }
    [_mLoadingLbl_ setFrame:CGRectMake(165, (_mSearchView_.frame.size.height/2)-15, 100, 21)];
    [_mLoadingLbl_ setText:@"Loading"];
    [_mSearchView_ addSubview:_mLoadingLbl_];
    [self.view bringSubviewToFront:_mSearchView_];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                   ** this method is used to validate the fields and returns the true/false **..
//--------------------------------------------------- ************** ------------------------------------------------------
- (BOOL)customerCheckinValidations:(NSMutableArray *)textFieldsArr {
    
    UITextField *lTempValidatinTxtfld;
    lTempValidatinTxtfld=[textFieldsArr objectAtIndex:0];
    if(![lTempValidatinTxtfld.text isEqualToString:@""]&&lTempValidatinTxtfld.text!=nil){
        mAppDelegate_.mModelForEditVehicleScreen_.mVIN_ = lTempValidatinTxtfld.text;
    }else{
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:NSLocalizedString(@"NO_VIN_ERROR", nil)];
        return FALSE;
    }
    lTempValidatinTxtfld=[textFieldsArr objectAtIndex:1];
    if(![lTempValidatinTxtfld.text isEqualToString:@""]&&lTempValidatinTxtfld.text!=nil){
        if ([lTempValidatinTxtfld.text intValue] <= 0) {
            [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:NSLocalizedString(@"Mileage_Zero_Error", nil)];
            return FALSE;
        }else if ([lTempValidatinTxtfld.text intValue] < [mAppDelegate_.mModelForSearchScreen_.mVehicleMileage intValue]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"lERROR", nil) message:NSLocalizedString(@"Mileage_Lessthan_Actual", nil) delegate:self cancelButtonTitle:@"Back" otherButtonTitles:@"Change", nil];
            [alertView show];
            RELEASE_NIL(alertView);
            return FALSE;
        }else
            mAppDelegate_.mModelForSearchScreen_.mMileage = lTempValidatinTxtfld.text;
    }else{
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:NSLocalizedString(@"NO_MILEAGE_ERROR", nil)];
        return FALSE;
    }
    lTempValidatinTxtfld=[textFieldsArr objectAtIndex:2];
    if(![lTempValidatinTxtfld.text isEqualToString:@""]&&lTempValidatinTxtfld.text!=nil){
        mAppDelegate_.mModelForSearchScreen_.mTag_ = lTempValidatinTxtfld.text;
    }else{
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:NSLocalizedString(@"NO_TAG_ERROR", nil)];
        return FALSE;
    }
    return TRUE;
}

- (void)reloadSearchTableData {
    
    [_mActivityIndicator_ stopAnimating];
    [_mActivityIndicator_ removeFromSuperview];
    [_mLoadingLbl_ removeFromSuperview];
    [_mCancelBtn_ setEnabled:YES];
    NSMutableArray* ltempArray=[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_  valueForKey:@"Vehicles"];
    if ([ ltempArray count] > 0) {
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVehicleID_:[[ltempArray objectAtIndex:0] objectForKey:@"ID"]];
        NSMutableArray*lTempArray1 = [[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_  valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"];
        if ([lTempArray1 count] > 0) {
            [self.mCheckInSearchTableView_ setHidden:FALSE];
            [self.mAdvancedSearchBtn_ setSelected:YES];
            [self.mCheckInSearchTableView_ reloadData];
        }
        else {
            [self.mCustomerNotFoundLbl_ setHidden:FALSE];
            [self.mAdvancedSearchBtn_ setSelected:NO];
            [self.mCheckInSearchTableView_ setHidden:TRUE];
        }
    }else {
        [self.mCustomerNotFoundLbl_ setHidden:FALSE];
        [self.mAdvancedSearchBtn_ setSelected:NO];
        [self.mCheckInSearchTableView_ setHidden:TRUE];
    }
    if ([mAppDelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"LITE"]) {
        [self showContinueWithoutCustomerButton];
    }
    [self.mAddCustomerView_ setHidden:FALSE];
}

- (void)showContinueWithoutCustomerButton {
    
    [self.mAdvancedSearchBtn_ setFrame:CGRectMake(self.mAdvancedSearchBtn_.frame.origin.x, self.mSearchView_.frame.origin.x, self.mAdvancedSearchBtn_.frame.size.width, self.mAdvancedSearchBtn_.frame.size.height)];
    [self.mContinueWithoutCustomerInfo_ setHidden:FALSE];
}

- (void)reloadAdvancedSearchTableData {
    
    [_mActivityIndicator_ stopAnimating];
    [_mActivityIndicator_ removeFromSuperview];
    [_mLoadingLbl_ removeFromSuperview];
    [_mCancelBtn_ setEnabled:YES];
    NSMutableArray* ltempArray=[mAppDelegate_.mSearchDataGetter_.mAdvancedSearchData_  valueForKey:@"Customers"];
    if ([ ltempArray count] > 0) {
        [self.mAdvancedSearchTableView_ setHidden:FALSE];
        [self.mAddCustomerBtn_ setSelected:YES];
        [self.mAdvancedSearchTableView_ reloadData];
        
    }else {
        [self.mCustomerNotFoundLbl_ setHidden:FALSE];
        [self.mAddCustomerBtn_ setSelected:NO];
        [self.mAdvancedSearchTableView_ setHidden:TRUE];
    }
    [self.mAdvancedSearchResultContinueBtn_ setHidden:TRUE];
    [self.mAdvancedSearchResultView_ setHidden:FALSE];
    [self.view bringSubviewToFront:self.mAdvancedSearchResultView_];
}

- (void)reloadApptTableData {
    
    [_mActivityIndicator_ stopAnimating];
    [_mActivityIndicator_ removeFromSuperview];
    [_mLoadingLbl_ removeFromSuperview];
    [_mCancelBtn_ setEnabled:YES];
}

- (void)showApptView {
    
    [self filterAppointmentsBasedOnVINAndCustomer];
    [self.mSelectAppointmentTableView_ reloadData];
    [self.mSelectedApptView_ setHidden:FALSE];
    [self.view bringSubviewToFront:self.mSelectedApptView_];
    [self.mSelectedApptContinueBtn_ setHidden:TRUE];
    if ([mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ count]>0) {
        [self.mSelectAppointmentTableView_ onSelectionOfCustomer];
    }
}

- (void)errorResponseForVINDecoder {
    
    [[self mSearchView_] setHidden:TRUE];
    [[self mContinueBtn_] setHidden:FALSE];
    [[self mCancelBtn_] setEnabled:TRUE];
}

- (void)errorResponseForCustomerSearch {
    
    [_mActivityIndicator_ stopAnimating];
    [_mActivityIndicator_ removeFromSuperview];
    [_mLoadingLbl_ removeFromSuperview];
    [_mCancelBtn_ setEnabled:YES];
}

- (void)filterAppointmentsBasedOnVINAndCustomer {
    [mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ removeAllObjects];
    
    NSString *mVINandCustomerSearchString = [NSString stringWithFormat:@"(SELF.Customer.FirstName=='%@') AND (SELF.Customer.LastName=='%@') AND (SELF.Vehicle.VIN=='%@')",mAppDelegate_.mBeginVehicleCheckInView_.mFirstName_,mAppDelegate_.mBeginVehicleCheckInView_.mLastName_,mAppDelegate_.mModelForSearchScreen_.mBeginVehicleCheckInVIN];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:mVINandCustomerSearchString];
    NSArray *tempData = [mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ filteredArrayUsingPredicate:predicate];
    if ([tempData count]>0) {
        //            [mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ addObjectsFromArray:tempData];
        [mAppDelegate_.mModelForSearchScreen_ setMSelectApptArray_:[tempData mutableCopy]];
    }else {
        NSString *mVINSearchString = [NSString stringWithFormat:@"SELF.Vehicle.VIN LIKE[c] '%@'",mAppDelegate_.mModelForSearchScreen_.mBeginVehicleCheckInVIN];
        NSPredicate *lVINPredicate = [NSPredicate predicateWithFormat:mVINSearchString];
        NSArray *lVINTempData = [mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ filteredArrayUsingPredicate:lVINPredicate];
        if ([lVINTempData count]>0) {
            //                [mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ addObjectsFromArray:lVINTempData];
            [mAppDelegate_.mModelForSearchScreen_ setMSelectApptArray_:[lVINTempData mutableCopy]];
        }else {
            NSString *mCustomerSearchString = [NSString stringWithFormat:@"(SELF.Customer.FirstName=='%@') AND (SELF.Customer.LastName=='%@')",mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_,mAppDelegate_.mModelForEditCustomerScreen_.mLastName_];
            NSPredicate *lCustomerPredicate = [NSPredicate predicateWithFormat:mCustomerSearchString];
            NSArray *lCustomerTempData = [mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ filteredArrayUsingPredicate:lCustomerPredicate];
            if ([lCustomerTempData count]>0) {
                [mAppDelegate_.mModelForSearchScreen_ setMSelectApptArray_:[lCustomerTempData mutableCopy]];
            }else {
                NSString *mCustomerSearchString = [NSString stringWithFormat:@"(SELF.Customer.FirstName == nil) AND (SELF.Customer.LastName == nil) AND (SELF.Vehicle.VIN == nil)"];
                NSPredicate *lCustomerPredicate = [NSPredicate predicateWithFormat:mCustomerSearchString];
                NSArray *pTempData = [mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ filteredArrayUsingPredicate:lCustomerPredicate];
                if ([pTempData count]>0) {
                    [mAppDelegate_.mModelForSearchScreen_ setMSelectApptArray_:[pTempData mutableCopy]];
                }else {
                    [mAppDelegate_.mBeginVehicleCheckInView_.mNoAppointmentsLbl_ setText:NSLocalizedString(@"No_Appointment", nil)];
                    [mAppDelegate_.mBeginVehicleCheckInView_.mSelectAppointmentTableView_ setHidden:TRUE];
                }
            }
        }
    }
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                            ** this method is used to checkin the customer to create temp RO  **..
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)postRequestforCheckin  {
    DLog(@"VIN %@",mAppDelegate_.mModelForEditVehicleScreen_.mVIN_);
    DLog(@"Begin VehicleCheckIn VIN : %@",mAppDelegate_.mModelForSearchScreen_.mBeginVehicleCheckInVIN);
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppDelegate_.mRequestMethods_ postRequestForCheckin:mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ VehicleID:(![mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_ isEqualToString:@"00000000000000000000000000000000"])?mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_:@"" Mileage:mAppDelegate_.mModelForSearchScreen_.mMileage AdvisorID:mAppDelegate_.mModelForSearchScreen_.mAdvisorID_!=nil?mAppDelegate_.mModelForSearchScreen_.mAdvisorID_:@"" VIN:[mAppDelegate_.mModelForEditVehicleScreen_.mVIN_ length] != 0?mAppDelegate_.mModelForEditVehicleScreen_.mVIN_:mAppDelegate_.mModelForSearchScreen_.mBeginVehicleCheckInVIN CustomerID:(![mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ isEqualToString:@"00000000000000000000000000000000"])?mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_:@"" FirstName:[mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_ length]!=0?mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_:@"" LastName:mAppDelegate_.mModelForEditCustomerScreen_.mLastName_!=nil?mAppDelegate_.mModelForEditCustomerScreen_.mLastName_:@""TagNumber:mAppDelegate_.mModelForSearchScreen_.mTag_];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMMileage_:mAppDelegate_.mModelForSearchScreen_.mMileage];
    } else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

- (void)showCheckInLabels:(UITextField*)textField {
    
    for(UIView *lView in textField.superview.subviews) {
        if ([lView isKindOfClass:[UILabel class]]) {
            UILabel *lTargetLbl = (UILabel*)lView;
            [lTargetLbl removeFromSuperview];
        }
    }
    UILabel *lLbl;
    if (lLbl == nil) {
        lLbl = [[UILabel alloc] init];
    }
    lLbl.frame = CGRectMake(20, 7, 120, 14);
    lLbl.font = [UIFont systemFontOfSize:13.0];
    if (textField.tag == 1) {
        lLbl.text = @"VIN";
    }else if (textField.tag == 2) {
        lLbl.text = @"Mileage";
    }else {
        lLbl.text = @"Tag";
    }
    lLbl.textColor = [UIColor ASRProBlueColor];
    [textField.superview addSubview:lLbl];
}

- (void)removeCheckInLabels:(UITextField*)textField {
    
    for(UIView *lView in textField.superview.subviews) {
        if ([lView isKindOfClass:[UILabel class]]) {
            [lView removeFromSuperview];
        }
    }
}

- (void)pushToSearchCustomerView {
    
    [mAppDelegate_.mModelForSearchScreen_ setMBeginVehicleCheckInVIN:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_];
    if (! mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_) {
        if (!_isAnyCustomerSelected) {
            [[SearchSupportWebEngine sharedInstance] threadRequestForVINDecoder:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_];
        }
        if (![mAppDelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"FULL"]) {
            mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = TRUE;
        }
        [self setActivityIndicatorToSearchView];
    }
    if (!_isAnyCustomerSelected) {
        mAppDelegate_.mViewReference_ = self;
    }else {
        if ([mAppDelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"FULL"]) {
            [self showApptView];
        }else {
            mAppDelegate_.mModelForSearchScreen_.mAppointmentNumber_ = @"";
            mAppDelegate_.mModelForSearchScreen_.mAdvisorID_ = @"";
            mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = TRUE;
            [mAppDelegate_.mSearchViewController_ displayEditCustomerPopup];
            //                        [self postRequestforCheckin];
            //                        [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark -  ***************** Button Actions ****************

- (IBAction)ContinueWithoutApptBtnAction:(id)sender {
    mAppDelegate_.mModelForSearchScreen_.mAppointmentNumber_ = @"";
    mAppDelegate_.mModelForSearchScreen_.mAdvisorID_ = @"";
    mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = TRUE;
    [mAppDelegate_.mModelForEditVehicleScreen_ setMMileage_:mAppDelegate_.mModelForSearchScreen_.mMileage];
    if (![mAppDelegate_.mModelForSearchScreen_.mTempCustomerID_ isEqualToString:mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_]) {
        [mAppDelegate_.mSearchViewController_ displayEditCustomerPopup];
    }else
        [mAppDelegate_.mSearchViewController_ displayEditVehiclePopup];
    
    //    [self postRequestforCheckin];
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addCustomerBtnAction:(id)sender {
    //        [self resetData];
    [self.mAdvancedSearchTableView_ reloadData];
    [self.mAdvancedSearchResultContinueBtn_ setHidden:TRUE];
    mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = FALSE;
    EditCustomerViewController *lEditCustomerViewController = [[EditCustomerViewController alloc] initWithNibName:@"EditCustomerViewController" bundle:nil];
    [mAppDelegate_ setMEditCustomerViewController_:lEditCustomerViewController];
    mAppDelegate_.mViewReference_ = self;
    mAppDelegate_.mEditCustomerViewController_.modalPresentationStyle=UIModalPresentationPageSheet;
    mAppDelegate_.mEditCustomerViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:mAppDelegate_.mEditCustomerViewController_ animated:YES completion:nil];
}

- (IBAction)cancelBtnAction:(id)sender {
    if (!mAppDelegate_.mMasterViewController_->isAnyAppointmentSelected) {
        [mAppDelegate_.mModelForSearchScreen_ setMMileage:@""];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:@""];
    }
    [mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ reloadData];
    [mAppDelegate_.mSearchVehicleInfoView_.mVehiclesTableView_ reloadData];
    [mAppDelegate_.mSearchViewController_.mContinueBtn_ setHidden:TRUE];
    [mAppDelegate_.mMasterViewController_ resetAllData];
    if (!mAppDelegate_.mMasterViewController_.mSearchedListTableView_.hidden) {
        if ([mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mSearchListArray count] != 0) {
            [mAppDelegate_.mModelForEditCustomerScreen_ setValues:[mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mSearchListArray objectAtIndex:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_]];
        }
    }
    
    if ([[[SearchSupportWebEngine sharedInstance] mCustomersArray] count] !=0) {
        [[[SearchSupportWebEngine sharedInstance] mCustomersArray] removeAllObjects];
    }
    [mAppDelegate_.mModelForSearchScreen_ setMTag_:@""];
    mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = FALSE;
    self.isAnyCustomerSelected = FALSE;
    self.isAnyApponimentSelected = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)continueBtnAction:(id)sender {
    
    for(int i=0;i<[self.mTextFieldsArr_ count];i++) {
        [((UITextField*)[self.mTextFieldsArr_ objectAtIndex:i]) endEditing:TRUE];
    }
    if([self customerCheckinValidations:self.mTextFieldsArr_]) {
        [self pushToSearchCustomerView];
    }
}

- (IBAction)advancedSearchResultContinueBtnAction:(id)sender {
    [mAppDelegate_.mModelForEditCustomerScreen_ setValues:(NSMutableDictionary*)[[mAppDelegate_.mSearchDataGetter_.mAdvancedSearchData_ valueForKey:@"Customers"] objectAtIndex:self.mAdvancedSearchTableView_.mselectedCustomerindex_]];
    [mAppDelegate_.mBeginVehicleCheckInView_ setMFirstName_:mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_];
    [mAppDelegate_.mBeginVehicleCheckInView_ setMLastName_:mAppDelegate_.mModelForEditCustomerScreen_.mLastName_];
    
    if ([mAppDelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"FULL"]) {
        [self showApptView];
    }else {
        mAppDelegate_.mModelForSearchScreen_.mAppointmentNumber_ = @"";
        mAppDelegate_.mModelForSearchScreen_.mAdvisorID_ = @"";
        mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = TRUE;
        [mAppDelegate_.mModelForEditVehicleScreen_ setMMileage_:mAppDelegate_.mModelForSearchScreen_.mMileage];
        [mAppDelegate_.mSearchViewController_ displayEditCustomerPopup];
    }
}

- (IBAction)advancedSearchContinueBtnAction:(id)sender {
    
    for(int i=0;i<[self.mAdvancedSearchTextFieldsArr_ count];i++) {
        [((UITextField*)[self.mAdvancedSearchTextFieldsArr_ objectAtIndex:i]) endEditing:TRUE];
    }
    [self setActivityIndicatorToSearchView];
    NSString *mSearchStr = [NSString stringWithFormat:@"FirstName=%@&LastName=%@&Phone=%@&Email=%@",mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_!=nil?mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_:nil,mAppDelegate_.mModelForEditCustomerScreen_.mLastName_!=nil?mAppDelegate_.mModelForEditCustomerScreen_.mLastName_:nil,mAppDelegate_.mModelForEditCustomerScreen_.mMobilePhone_!=nil?mAppDelegate_.mModelForEditCustomerScreen_.mMobilePhone_:nil,mAppDelegate_.mModelForEditCustomerScreen_.mEmail_!=nil?mAppDelegate_.mModelForEditCustomerScreen_.mEmail_:nil];
    DLog(@"Advanced Search String :- %@",mSearchStr);
    [mAppDelegate_.mModelForSearchScreen_ threadRequestForAdvancedCustomerSearchInfo:mSearchStr];
}

- (IBAction)advancedSearchBtnAction:(id)sender {
    
    [self.mAdvancedSearchView_ setHidden:FALSE];
    [self.view bringSubviewToFront:_mAdvancedSearchView_];
    [self setAdvancedSearchFieldsForScrollView];
}

- (IBAction)SelectedApptContinueAction:(id)sender {
    
    mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = TRUE;
    [mAppDelegate_.mModelForEditVehicleScreen_ setMMileage_:mAppDelegate_.mModelForSearchScreen_.mMileage];
    if (![[mAppDelegate_.mModelForSearchScreen_.mTempCustomerID_ stringByReplacingOccurrencesOfString:@"-" withString:@""] isEqualToString:mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_]) {
        [mAppDelegate_.mSearchViewController_ displayEditCustomerPopup];
    }else
        [mAppDelegate_.mSearchViewController_ displayEditVehiclePopup];
    //    [self postRequestforCheckin];
    //    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)barcodeBtnAction:(id)sender {
    
//    if (mAppDelegate_.barcodeViewController == nil) {
//        BarcodeViewController *barcodeViewController = [[BarcodeViewController alloc] initWithNibName:@"BarcodeViewController" bundle:nil];
//        [mAppDelegate_ setBarcodeViewController:barcodeViewController];
//    }
//    [self presentViewController:mAppDelegate_.barcodeViewController animated:YES completion:nil];
    
    // DataMatrix first available in iOS 8, so use iOS scanner if DataMatrix is available
    if (&AVMetadataObjectTypeDataMatrixCode != NULL) {
        TTiOSVINScannerVC *scannerVC = [TTiOSVINScannerVC new];
        // present and release the controller
        [self presentViewController:scannerVC animated:YES completion:nil];
    } else {
        // Use zbar with DataMatrix add-on for < iOS 8
        // ADD: present a barcode reader that scans from the camera feed
        if ([[SharedUtilities sharedUtilities] appDelegateInstance].zBarReaderViewController == nil) {
            ZBarReaderViewController *reader = [ZBarReaderViewController new];
            ZBarImageScanner *scanner = reader.scanner;
            // TODO: (optional) additional reader configuration here
            [self setBarCodeBGImageView:reader.view];
            reader.wantsFullScreenLayout = YES;
            reader.hidesBottomBarWhenPushed = YES;
            reader.showsZBarControls = NO;
            reader.view.frame=CGRectMake(0, 0, 1024, 768);
            reader.readerView.frame=reader.view.frame;
            [self setZBarReaderViewController:reader];
            // EXAMPLE: disable rarely used I2/5 to improve performance
            [scanner setSymbology: ZBAR_I25
                           config: ZBAR_CFG_ENABLE
                               to: 0];
            reader.readerDelegate = self;
            reader.supportedOrientationsMask = ZBarOrientationMaskAll;
            
            [[SharedUtilities sharedUtilities] appDelegateInstance].zBarReaderViewController = reader;
        }
        
        // present and release the controller
        [self presentViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].zBarReaderViewController animated:YES completion:nil];
    }
    
    
    
}

- (void)setBarCodeBGImageView:(UIView *)aView {
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView setFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [bgImageView setImage:[UIImage imageNamed:@"barcode-bg"]];
    [aView addSubview:bgImageView];
    [self setCancelButtonOnImageView:aView];
    [self setCustomBarCodeTextField:aView];
    [self setLightButtonOnImageView:aView];
    [self setQuickAddButtonOnImageView:aView];
    [self setManualEntryButtonOnImageView:aView];
}

- (void)setCancelButtonOnImageView:(UIView *) aImageView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(kScreenWidth - 130, 20, 100, 60)];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    [button setTitle:@"Cancel" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[button titleLabel] setFont:[UIFont regularFontOfSize:25 fontKey:kFontRegularKey]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aImageView addSubview:button];
}

- (void)setCustomBarCodeTextField:(UIView *)aImageView {
    BarcodeTextField *textField = [[BarcodeTextField alloc] init];
    [textField setFrame:CGRectMake(138, 315, 747, 138)];
    [textField initializeTextField];
    [textField showOrHideTextField:YES];
    [aImageView addSubview:textField];
    [self setBarcodeTextField:textField];
}

- (void)setLightButtonOnImageView:(UIView *) aImageView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(40, 20, 100, 60)];
    [button setTitle:@"    Light" forState:UIControlStateNormal];
    [button setTitle:@"    Light" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"bulb"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"bulb"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"bulb"] forState:UIControlStateSelected];
    [[button titleLabel] setFont:[UIFont regularFontOfSize:25 fontKey:kFontRegularKey]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(lightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aImageView addSubview:button];
}

- (void)setManualEntryButtonOnImageView:(UIView *) aImageView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 629, 511, 140)];
    [button setTitle:@"    Manual Entry" forState:UIControlStateNormal];
    [button setTitle:@"    Manual Entry" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
    [[button titleLabel] setFont:[UIFont regularFontOfSize:25 fontKey:kFontRegularKey]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [button addTarget:self action:@selector(manualEntryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aImageView addSubview:button];
}

- (void)setQuickAddButtonOnImageView:(UIView *) aImageView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(513, 629, 512, 140)];
    [button setTitle:@"    Quick Add" forState:UIControlStateNormal];
    [button setTitle:@"    Quick Add" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"car"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"car"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"car"] forState:UIControlStateSelected];
    [[button titleLabel] setFont:[UIFont regularFontOfSize:25 fontKey:kFontRegularKey]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [button addTarget:self action:@selector(quickAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aImageView addSubview:button];
}

- (IBAction)lightButtonAction:(id)sender {
}

- (IBAction)manualEntryButtonAction:(id)sender {
    [self.barcodeTextField showOrHideTextField:NO];
    [self.barcodeTextField becomeFirstResponder];
}

- (IBAction)quickAddButtonAction:(id)sender {
}

- (IBAction)cancelButtonAction:(id)sender {
    if (self.barcodeTextField.text != nil) {
        [self setVINTextToBeginVehicleCheckIn:self.barcodeTextField.text];
    }
    [self.zBarReaderViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)continueWithoutCustomerInfoButtonAction:(id)sender {
    
    mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = TRUE;
    [mAppDelegate_.mModelForEditVehicleScreen_ setMMileage_:mAppDelegate_.mModelForSearchScreen_.mMileage];
    [mAppDelegate_.mSearchViewController_ displayEditVehiclePopup];
}

- (void)getVinNumberFromBarCode :(NSString *)aVinNumber barCodeViewController :(id)aBarCodeViewController {
    TTiOSVINScannerVC *barcodeViewController = (TTiOSVINScannerVC*)aBarCodeViewController;
    // Setting scanned Barcode data to textfield
    /*if (aVinNumber.length == 18) {
        [lVINTextField setText:[aVinNumber substringFromIndex:1]];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:lVINTextField.text];
        [mAppDelegate_.mModelForSearchScreen_ setMBeginVehicleCheckInVIN:lVINTextField.text];
        
    }else {
        [lVINTextField setText:aVinNumber];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:lVINTextField.text];
        [mAppDelegate_.mModelForSearchScreen_ setMBeginVehicleCheckInVIN:lVINTextField.text];
    }*/
    [self setVINTextToBeginVehicleCheckIn:aVinNumber];
    
    // dismiss the controller
    [barcodeViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setVINTextToBeginVehicleCheckIn:(NSString *)aVinNumber {
    UITextField *lVINTextField = (UITextField*)[_mTextFieldsArr_ objectAtIndex:0];

    if (aVinNumber.length == 18) {
        NSString *string = [aVinNumber substringToIndex:(aVinNumber.length - (aVinNumber.length -1))];
        if ([string isEqualToString:@"I"]) {
            [lVINTextField setText:[aVinNumber substringFromIndex:1]];
        }else {
            [lVINTextField setText:[aVinNumber substringToIndex:(aVinNumber.length -1)]];
        }
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:lVINTextField.text];
        [mAppDelegate_.mModelForSearchScreen_ setMBeginVehicleCheckInVIN:lVINTextField.text];
        
    }else {
        [lVINTextField setText:aVinNumber];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:lVINTextField.text];
        [mAppDelegate_.mModelForSearchScreen_ setMBeginVehicleCheckInVIN:lVINTextField.text];
    }
}

#pragma mark --
#pragma mark ZBAR Delegate Method
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    // Setting scanned Barcode data to textfield
    UITextField *lVINTextField = (UITextField*)[_mTextFieldsArr_ objectAtIndex:0];
    if (symbol.data.length == 18) {
        NSString *string = [symbol.data substringToIndex:(symbol.data.length - (symbol.data.length -1))];
        if ([string isEqualToString:@"I"]) {
            [lVINTextField setText:[symbol.data substringFromIndex:1]];
        }else {
            [lVINTextField setText:[symbol.data substringToIndex:(symbol.data.length -1)]];
        }
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:lVINTextField.text];
        [mAppDelegate_.mModelForSearchScreen_ setMBeginVehicleCheckInVIN:lVINTextField.text];
        
    }else {
        [lVINTextField setText:symbol.data];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:lVINTextField.text];
        [mAppDelegate_.mModelForSearchScreen_ setMBeginVehicleCheckInVIN:lVINTextField.text];
    }
    // dismiss the controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -  ***************** TableView Delegate methods ****************
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KROWHEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIView *leftview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 59)];
        UITextField *lUITextField = [UITextField new];
        lUITextField.borderStyle = UITextBorderStyleNone;
        lUITextField.delegate = self;
        lUITextField.leftView = leftview;
        lUITextField.leftViewMode = UITextFieldViewModeAlways;
        [lUITextField setTag:indexPath.row+1];
        [_mTextFieldsArr_ addObject:lUITextField];
        [cell.contentView addSubview:lUITextField];
        if (indexPath.row == 0) {
            UIButton *lBarCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            lBarCodeBtn.tag = 4;
            [cell.contentView addSubview:lBarCodeBtn];
        }
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  {
    int tagCount = 1;
	// reset UILabels;
	for (; tagCount <= 3; tagCount ++) {
        UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
        lUILabel.text = nil;
	}
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 0, yCoord = 0;
    
    // ----------------------------;
    // To display time and customer name for labels;
    // ----------------------------;
    UITextField *lTextField = (UITextField*)[tableViewCell.contentView viewWithTag:indexPath.row+1];
    lTextField.frame = CGRectMake(xCoord, yCoord+12, 315, 49);
    if (indexPath.row == 0) {
        lTextField.returnKeyType = UIReturnKeyNext;
        lTextField.placeholder = @"VIN";
        lTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        UIButton *lBtn = (UIButton*)[tableViewCell.contentView viewWithTag:4];
        UIImage *image = [UIImage imageNamed:@"Barcode"];
        lBtn.frame = CGRectMake(lTextField.frame.size.width + 3, (KROWHEIGHT - image.size.height)/2, image.size.width, image.size.height);
        [lBtn setBackgroundImage:[UIImage imageNamed:@"Barcode.png"] forState:UIControlStateNormal];
        [lBtn addTarget:self action:@selector(barcodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[MasterViewController class]] || [mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]]) {
            [lTextField setText:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForEditVehicleScreen_.mVIN_!=nil?mAppDelegate_.mModelForEditVehicleScreen_.mVIN_:@""]];
            if(lTextField.text.length>0)
                [self showCheckInLabels:lTextField];
            [lTextField setEnabled:YES];
            [lBtn setHidden:FALSE];
        }else {
            [lTextField setText:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForEditVehicleScreen_.mVIN_!=nil?mAppDelegate_.mModelForEditVehicleScreen_.mVIN_:@""]];
            if(lTextField.text.length>0)
                [self showCheckInLabels:lTextField];
            [lTextField setEnabled:YES];
            [lBtn setHidden:FALSE];
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [lBtn setHidden:YES];
        }else {
            [lBtn setHidden:NO];
        }
        [lBtn setHidden:NO];
    }else if (indexPath.row == 1) {
        lTextField.returnKeyType = UIReturnKeyNext;
        lTextField.placeholder = @"Mileage";
        lTextField.keyboardType = UIKeyboardTypeNumberPad;
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[MasterViewController class]]) {
            [lTextField setText:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSearchScreen_.mMileage!=nil?mAppDelegate_.mModelForSearchScreen_.mMileage:@""]];
            if(lTextField.text.length>0)
                [self showCheckInLabels:lTextField];
            [lTextField setEnabled:YES];
        }else {
            [lTextField setText:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSearchScreen_.mMileage!=nil?mAppDelegate_.mModelForSearchScreen_.mMileage:@""]];
            if(lTextField.text.length>0)
                [self showCheckInLabels:lTextField];
            [lTextField setEnabled:YES];
        }
        
    }else {
        lTextField.returnKeyType = UIReturnKeyDone;
        lTextField.placeholder = @"Tag";
        [lTextField setText:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSearchScreen_.mTag_!=nil?mAppDelegate_.mModelForSearchScreen_.mTag_:@""]];
    }
    [lTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark -  ***************** TextField Delegate methods ****************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    int i=[_mTextFieldsArr_ count];
    int x=textField.tag;
    if (x==1) {
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:textField.text];
        [mAppDelegate_.mModelForSearchScreen_ setMBeginVehicleCheckInVIN:textField.text];
        
    }else if (x==2)
        [mAppDelegate_.mModelForSearchScreen_ setMMileage:textField.text];
    else
        [mAppDelegate_.mModelForSearchScreen_ setMTag_:textField.text];
    if (x<i) {
        UITextField *nextTextField = (UITextField *)[_mTextFieldsArr_ objectAtIndex:x];
        [nextTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.0];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight_CustomerCheckin, 0.0);
    self.mTableView_.contentInset = contentInsets;
    self.mTableView_.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
    CGRect lFrame=[self.mTableView_ convertRect:textField.bounds fromView:textField];
    [self.mTableView_ scrollRectToVisible:lFrame animated:NO];
    
    DLog(@"%@",NSStringFromCGAffineTransform(self.view.superview.transform));
    
    if( [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
    {
        if (self.view.superview.transform.tx == 0) {
            [UIView animateWithDuration:0.0 animations:^ {
                self.view.superview.transform = CGAffineTransformTranslate(self.view.superview.transform,0,-100);
            }];
        }
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([[textField text] length]>0) {
        [self showCheckInLabels:textField];
    }else
        [self removeCheckInLabels:textField];
    
    if (textField.tag==1) {
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:textField.text];
        [mAppDelegate_.mModelForSearchScreen_ setMBeginVehicleCheckInVIN:textField.text];
    }else if (textField.tag==2)
        [mAppDelegate_.mModelForSearchScreen_ setMMileage:textField.text];
    else
        [mAppDelegate_.mModelForSearchScreen_ setMTag_:textField.text];
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mTableView_.contentInset = contentInsets;
    self.mTableView_.scrollIndicatorInsets = contentInsets;
    
    /*[UIView animateWithDuration:0.4 animations:^ {
     self.view.superview.transform = CGAffineTransformTranslate(self.view.superview.transform,0,100);
     }];*/
}

#pragma mark -  ***************** AlertView Delegate Methods ****************

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:DLog(@"button index : %d", buttonIndex);
            break;
        case 1:DLog(@"button index : %d", buttonIndex);
            [mAppDelegate_.mModelForSearchScreen_ setMVehicleMileage:mAppDelegate_.mModelForSearchScreen_.mMileage];
            [self pushToSearchCustomerView];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
