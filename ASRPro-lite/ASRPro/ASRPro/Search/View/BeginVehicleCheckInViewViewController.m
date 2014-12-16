//
//  BeginVehicleCheckInViewViewController.m
//  Demo
//
//  Created by Santosh Kvss on 1/29/14.
//  Copyright (c) 2014 valuelabs. All rights reserved.
//

#import "BeginVehicleCheckInViewViewController.h"
#define KROWHEIGHT 59
#define kKeyboardHeight_CustomerCheckin 100

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
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, 384, 211);
}

#pragma mark -  ***************** Generic Methods ****************

- (void)initData {

    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    self.mTextFieldsArr_ = [NSMutableArray new];
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

    [self setFontsAndTextToSearchScreenView];
}

- (void)setFontsAndTextToSearchScreenView {
    
    [self.mSelectApptTitleLbl_ setText:NSLocalizedString(@"Select_Appointment", nil)];
    [self.mContinueWithOutAppointmentBtn_ setTitle:NSLocalizedString(@"Continue_Without_Appointment", nil) forState:UIControlStateNormal];
}

- (void)setBorderColor {

    for(UIView *lView in self.view.subviews) {
        if ([lView isKindOfClass:[UIView class]] && lView.tag == 50) {
            [lView.layer setBorderColor:[[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0] CGColor]];
            [lView.layer setBorderWidth:1.0];
        }
    }
}

- (void)setActivityIndicatorToSearchView {

    [self.mCheckInTitleLbl_ setText:@"Search"];
    [_mContinueBtn_ setHidden:TRUE];
    [_mCancelBtn_ setEnabled:NO];
    [_mSearchView_ setHidden:NO];
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
    NSMutableArray* ltempArray=[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_  valueForKey:@"Vehicles"];
    if ([ ltempArray count] > 0) {
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVehicleID_:[[ltempArray objectAtIndex:0] objectForKey:@"ID"]];
        NSMutableArray*lTempArray1=[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_  valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"];
    if ([lTempArray1 count] > 0) {
        [self.mCheckInSearchTableView_ setHidden:FALSE];
        [self.mAddCustomerBtn_ setSelected:YES];
        [self.mCheckInSearchTableView_ reloadData];
    }
    }else {
        [self.mCustomerNotFoundLbl_ setHidden:FALSE];
        [self.mAddCustomerBtn_ setSelected:NO];
    }
    [self.mAddCustomerView_ setHidden:FALSE];
}

- (void)errorResponseForVINDecoder {
    
    [[self mSearchView_] setHidden:TRUE];
    [[self mContinueBtn_] setHidden:FALSE];
    [[self mCancelBtn_] setEnabled:TRUE];
}

- (void)filterAppointmentsBasedOnVINAndCustomer {
    
    NSString *mVINandCustomerSearchString = [NSString stringWithFormat:@"SELF.Customer.FirstName LIKE[c] '%@' AND SELF.Customer.MiddleName LIKE[c] '%@' AND SELF.Customer.LastName LIKE[c] '%@' AND SELF.Vehicle.VIN LIKE[c] '%@'",[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:self.mCheckInSearchTableView_.mselectedCustomerindex_] objectForKey:@"FirstName"],[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:self.mCheckInSearchTableView_.mselectedCustomerindex_] objectForKey:@"MiddleName"],[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:self.mCheckInSearchTableView_.mselectedCustomerindex_] objectForKey:@"LastName"],[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"VIN"]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:mVINandCustomerSearchString];
    NSArray *tempData = [mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ filteredArrayUsingPredicate:predicate];
    if ([tempData count]>0) {
        [mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ addObjectsFromArray:tempData];
    }else {
        NSString *mVINSearchString = [NSString stringWithFormat:@"SELF.Vehicle.VIN LIKE[c] '%@'",[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"VIN"]];
        NSPredicate *lVINPredicate = [NSPredicate predicateWithFormat:mVINSearchString];
        NSArray *lVINTempData = [mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ filteredArrayUsingPredicate:lVINPredicate];
        if ([lVINTempData count]>0) {
            [mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ addObjectsFromArray:lVINTempData];
        }else {
            NSString *mCustomerSearchString = [NSString stringWithFormat:@"SELF.Customer.FirstName LIKE[c] '%@' OR SELF.Customer.MiddleName LIKE[c] '%@' OR SELF.Customer.LastName LIKE[c] '%@'",[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:self.mCheckInSearchTableView_.mselectedCustomerindex_] objectForKey:@"FirstName"],[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:self.mCheckInSearchTableView_.mselectedCustomerindex_] objectForKey:@"MiddleName"],[[[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:self.mCheckInSearchTableView_.mselectedCustomerindex_] objectForKey:@"LastName"]];
            NSPredicate *lCustomerPredicate = [NSPredicate predicateWithFormat:mCustomerSearchString];
            NSArray *lCustomerTempData = [mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ filteredArrayUsingPredicate:lCustomerPredicate];
            if ([lCustomerTempData count]>0) {
                [mAppDelegate_.mModelForSearchScreen_.mSelectApptArray_ addObjectsFromArray:lCustomerTempData];
            }else {
                [mAppDelegate_.mBeginVehicleCheckInView_.mNoAppointmentsLbl_ setText:NSLocalizedString(@"No_Appointment", nil)];
                [mAppDelegate_.mBeginVehicleCheckInView_.mSelectAppointmentTableView_ setHidden:TRUE];
            }
        }
    }
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                            ** this method is used to checkin the customer to create temp RO  **..
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)postRequestforCheckin  {
    mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ = ShowVehicleHistoryPopUpFromAppointments;
    NSLog(@"dfd %@",mAppDelegate_.mModelForEditVehicleScreen_.mVIN_);
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
            [[SharedUtilities sharedUtilities] createLoadView];
            [mAppDelegate_.mRequestMethods_ postRequestForCheckin:mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ VehicleID:mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_ Mileage:mAppDelegate_.mModelForSearchScreen_.mMileage AdvisorID:mAppDelegate_.mModelForSearchScreen_.mAdvisorID_!=nil?mAppDelegate_.mModelForSearchScreen_.mAdvisorID_:@"" VIN:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_!=nil?mAppDelegate_.mModelForEditVehicleScreen_.mVIN_:@"" CustomerID:mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ FirstName:mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_ LastName:mAppDelegate_.mModelForEditCustomerScreen_.mLastName_];
            [mAppDelegate_.mModelForEditVehicleScreen_ setMMileage_:mAppDelegate_.mModelForSearchScreen_.mMileage];
    } else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

#pragma mark -  ***************** Button Actions ****************

- (IBAction)ContinueWithoutApptBtnAction:(id)sender {
    mAppDelegate_.mModelForSearchScreen_.mAppointmentNumber_ = @"";
    [self postRequestforCheckin];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addCustomerBtnAction:(id)sender {
    
    EditCustomerViewController *lEditCustomerViewController = [[EditCustomerViewController alloc] initWithNibName:@"EditCustomerViewController" bundle:nil];
    [mAppDelegate_ setMEditCustomerViewController_:lEditCustomerViewController];
    mAppDelegate_.mViewReference_ = self;
    mAppDelegate_.mEditCustomerViewController_.modalPresentationStyle=UIModalPresentationPageSheet;
    mAppDelegate_.mEditCustomerViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:mAppDelegate_.mEditCustomerViewController_ animated:YES completion:nil];
}

- (IBAction)cancelBtnAction:(id)sender {
    if ([mAppDelegate_.mViewReference_ isKindOfClass:[MasterViewController class]]) {
        [mAppDelegate_.mModelForSearchScreen_ setMMileage:@""];
    }
    [mAppDelegate_.mSearchVehicleInfoView_.mVehiclesTableView_ reloadData];
    [mAppDelegate_.mSearchViewController_.mContinueBtn_ setHidden:TRUE];
    [mAppDelegate_.mModelForSearchScreen_ setMTag_:@""];
    self.isAnyCustomerSelected = FALSE;
    self.isAnyApponimentSelected = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)continueBtnAction:(id)sender {

    for(int i=0;i<[self.mTextFieldsArr_ count];i++) {
        [((UITextField*)[self.mTextFieldsArr_ objectAtIndex:i]) endEditing:TRUE];
    }
    if([self customerCheckinValidations:self.mTextFieldsArr_]) {
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[MasterViewController class]] || [mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]] || [mAppDelegate_.mViewReference_ isKindOfClass:[EditCustomerViewController class]]) {
            if (!_isAnyCustomerSelected) {
            [self setActivityIndicatorToSearchView];
            mAppDelegate_.mViewReference_ = self;
            [[SearchSupportWebEngine sharedInstance] threadRequestForVINDecoder:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_];
            }else {/*
                [self filterAppointmentsBasedOnVINAndCustomer];
                [self.mSelectAppointmentTableView_ reloadData];
                [self.mSelectedApptView_ setHidden:FALSE];
                [self.mSelectedApptContinueBtn_ setHidden:TRUE];
                    */
                [self postRequestforCheckin];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else {
            [self postRequestforCheckin];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (IBAction)SelectedApptContinueAction:(id)sender {
    
    [self postRequestforCheckin];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)barcodeBtnAction:(id)sender {
    
    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    // TODO: (optional) additional reader configuration here
    
    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    // present and release the controller
    [self presentViewController:reader animated:YES completion:nil];
}

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
    [lVINTextField setText:symbol.data];
    [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:lVINTextField.text];
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
    lTextField.frame = CGRectMake(xCoord, yCoord, 325, 59);
    if (indexPath.row == 0) {
        lTextField.returnKeyType = UIReturnKeyNext;
        lTextField.placeholder = @"VIN";
        lTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        UIButton *lBtn = (UIButton*)[tableViewCell.contentView viewWithTag:4];
        lBtn.frame = CGRectMake(lTextField.frame.size.width+8, yCoord+20, 31, 17);
        [lBtn setBackgroundImage:[UIImage imageNamed:@"Barcode.png"] forState:UIControlStateNormal];
        [lBtn addTarget:self action:@selector(barcodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[MasterViewController class]]) {
            [lTextField setText:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForEditVehicleScreen_.mVIN_!=nil?mAppDelegate_.mModelForEditVehicleScreen_.mVIN_:@""]];
            [lTextField setEnabled:YES];
            [lBtn setHidden:FALSE];
        }else {
            [lTextField setText:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForEditVehicleScreen_.mVIN_!=nil?mAppDelegate_.mModelForEditVehicleScreen_.mVIN_:@""]];
            [lTextField setEnabled:NO];
            [lBtn setHidden:TRUE];
        }
    }else if (indexPath.row == 1) {
        lTextField.returnKeyType = UIReturnKeyNext;
        lTextField.placeholder = @"Mileage";
        lTextField.keyboardType = UIKeyboardTypeNumberPad;
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[MasterViewController class]]) {
            [lTextField setText:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSearchScreen_.mMileage!=nil?mAppDelegate_.mModelForSearchScreen_.mMileage:@""]];
            [lTextField setEnabled:YES];
        }else {
            [lTextField setText:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSearchScreen_.mMileage!=nil?mAppDelegate_.mModelForSearchScreen_.mMileage:@""]];
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
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag==1) {
        [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:textField.text];
    }else if (textField.tag==2)
        [mAppDelegate_.mModelForSearchScreen_ setMMileage:textField.text];
    else
        [mAppDelegate_.mModelForSearchScreen_ setMTag_:textField.text];
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mTableView_.contentInset = contentInsets;
    self.mTableView_.scrollIndicatorInsets = contentInsets;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
