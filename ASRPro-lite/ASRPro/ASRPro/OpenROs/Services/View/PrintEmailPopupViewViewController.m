//
//  PrintEmailPopupViewViewController.m
//  ASRPro
//
//  Created by Kalyani on 26/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PrintEmailPopupViewViewController.h"

@interface PrintEmailPopupViewViewController ()

@end

@implementation PrintEmailPopupViewViewController
@synthesize mBookletbtn_;
@synthesize mCancelBtn_;
@synthesize mClientMailBtn_;
@synthesize mCustomMailBtn;
@synthesize mEmailBtn_;
@synthesize mEstimatebtn_;
@synthesize mHeadingLabel_;
@synthesize mMPIbtn_;
@synthesize mPrintBtn;
@synthesize mInspectionFormTextField_;
@synthesize mCustomerEmailLabel_;

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
    [self initTheViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.superview.bounds = CGRectMake(0, 0, 385,400);
}

-(void)initTheViews{
    [[GenericFiles genericFiles] createUIButtonInstance:mBookletbtn_ buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_UNSELECT];
        [[GenericFiles genericFiles] createUIButtonInstance:mBookletbtn_ buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_SELECT];
    
    [[GenericFiles genericFiles] createUIButtonInstance:mEstimatebtn_ buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_UNSELECT];
    [[GenericFiles genericFiles] createUIButtonInstance:mEstimatebtn_ buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_SELECT];

    [[GenericFiles genericFiles] createUIButtonInstance:mMPIbtn_ buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_UNSELECT];
    [[GenericFiles genericFiles] createUIButtonInstance:mMPIbtn_ buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_SELECT];

    [[GenericFiles genericFiles] createUIButtonInstance:mCustomMailBtn buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_UNSELECT];
    [[GenericFiles genericFiles] createUIButtonInstance:mCustomMailBtn buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_SELECT];
    
    [[GenericFiles genericFiles] createUIButtonInstance:mClientMailBtn_ buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_UNSELECT];
    [[GenericFiles genericFiles] createUIButtonInstance:mClientMailBtn_ buttonTitle:@"" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:IMG_CHECK_SELECT];

    [[GenericFiles genericFiles] createUIButtonInstance:mEmailBtn_ buttonTitle:@"Email" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(19.0/255.0) green:(124.0/255.0) blue:(253.0/255.0) alpha:1.0]]];
    [[GenericFiles genericFiles] createUIButtonInstance:mEmailBtn_ buttonTitle:@"Email" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateDisabled buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(124.0/255.0) green:(124.0/255.0) blue:(124.0/255.0) alpha:1.0]]];

    [[GenericFiles genericFiles] createUIButtonInstance:mPrintBtn buttonTitle:@"Print" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(19.0/255.0) green:(124.0/255.0) blue:(253.0/255.0) alpha:1.0]]];
    [[GenericFiles genericFiles] createUIButtonInstance:mPrintBtn buttonTitle:@"Print" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateDisabled buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(124.0/255.0) green:(124.0/255.0) blue:(124.0/255.0) alpha:1.0]]];
    
    [mCancelBtn_ setTitle:@"Cancel" forState:UIControlStateNormal];
    [mHeadingLabel_ setText:@"Print/Email"];
    [mEmailBtn_ setEnabled:FALSE];
    [mPrintBtn setEnabled:FALSE];
    if([[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mEmail_ isEqualToString:@""]){
        [mCustomerEmailLabel_ setText:@"No Email Address Found"];
        [mCustomerEmailLabel_ setTextColor:[UIColor redColor]];

        [mClientMailBtn_ setEnabled:FALSE];
    }
    else
        [mCustomerEmailLabel_ setText:[NSString stringWithFormat:@"%@ %@ (%@)",[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mFirstName_,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mLastName_,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mEmail_]];

    
    mInspectionFormTextField_ =[[UITextField alloc] initWithFrame:CGRectMake(50, 260, 300, 30)];
    [mInspectionFormTextField_ setBackgroundColor:[UIColor whiteColor]];
    [mInspectionFormTextField_ setTextColor:[UIColor blackColor]];
    [mInspectionFormTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
    [mInspectionFormTextField_.layer setBorderWidth:1.0];
    [mInspectionFormTextField_ setFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey]];
    [mInspectionFormTextField_ setReturnKeyType:UIReturnKeyDone];
    mInspectionFormTextField_.enablesReturnKeyAutomatically=NO;
    mInspectionFormTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [mInspectionFormTextField_ setDelegate:self];
    UIView *leftView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10,40)];
    mInspectionFormTextField_.leftView =leftView;
    mInspectionFormTextField_.leftViewMode= UITextFieldViewModeAlways;
    
    leftView.userInteractionEnabled=NO;
    
    mInspectionFormTextField_.clearButtonMode=UITextFieldViewModeWhileEditing;

    [self.view addSubview:mInspectionFormTextField_];
    
    [mInspectionFormTextField_ setHidden:TRUE];
  //  [mInspectionFormTextField_ setText:@"test@test.com"];

}
- (IBAction)sendMailTypeAction:(id)sender {
    UIButton* mFormtype=(UIButton*)sender;
    if(mFormtype.isSelected)
        [mFormtype setSelected:FALSE];
    else
        [mFormtype setSelected:TRUE];
    if(mEstimatebtn_.isSelected||mMPIbtn_.isSelected||mBookletbtn_.isSelected)
        [mPrintBtn setEnabled:TRUE];
    if((mEstimatebtn_.isSelected||mMPIbtn_.isSelected||mBookletbtn_.isSelected)&&(mClientMailBtn_.isSelected||mCustomMailBtn.isSelected))
        [mEmailBtn_ setEnabled:TRUE];
if(mCustomMailBtn.isSelected)
  [ mInspectionFormTextField_ setHidden:FALSE];
    else
       [ mInspectionFormTextField_ setHidden:TRUE];
    if(mClientMailBtn_.tag!=mFormtype.tag)
        [mClientMailBtn_ setSelected:FALSE];
    if(mCustomMailBtn.tag!=mFormtype.tag)
        [mCustomMailBtn setSelected:FALSE];


}

- (IBAction)FormTypeAction:(id)sender {
    
    UIButton* mFormtype=(UIButton*)sender;
    if(mFormtype.isSelected)
       [mFormtype setSelected:FALSE];
    else
        [mFormtype setSelected:TRUE];
    if(mMPIbtn_.tag!=mFormtype.tag)
       [mMPIbtn_ setSelected:FALSE];
    if(mBookletbtn_.tag!=mFormtype.tag)
        [mBookletbtn_ setSelected:FALSE];
    if(mEstimatebtn_.tag!=mFormtype.tag)
        [mEstimatebtn_ setSelected:FALSE];

    if(mEstimatebtn_.isSelected||mMPIbtn_.isSelected||mBookletbtn_.isSelected)
       [mPrintBtn setEnabled:TRUE];
    if((mEstimatebtn_.isSelected||mMPIbtn_.isSelected||mBookletbtn_.isSelected)&&(mClientMailBtn_.isSelected||mCustomMailBtn.isSelected))
        [mEmailBtn_ setEnabled:TRUE];
    

}

- (IBAction)EmailAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if(mCustomMailBtn.isSelected){
        [[SharedUtilities sharedUtilities] createLoadView];
        [[[SharedUtilities sharedUtilities] appDelegateInstance] setMViewReference_:self];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mEmail_=mInspectionFormTextField_.text;
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mRequestMethods_ putRequestToUpdateCustomerDetails:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mCustomerID_ StoreID:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mStoreID_ CustomerNumber:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mCustomerNumber_ FirstName:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mFirstName_ LastName:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mLastName_ MiddleName:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mMiddleName_ Email:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mEmail_ HomePhone:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mHomePhone_ WorkPhone:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mWorkPhone_ MobilePhone:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mMobilePhone_ Address1:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mAddress1_ Address2:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mAddress2_ Country:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mCountry_ State:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mState_ City:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mCity_ Zipcode:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mZipCode_ ContactEmail:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mContactEmail_ ContactPhone:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mPhone_ ContactSMS:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mSMS_];
 
    }
    else{
    [self requestForEmail];
    }

}

- (IBAction)PrintAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if(mBookletbtn_.isSelected){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ RequestForLoadingBooklet:[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_ DocumentType:@"Booklet" LineType:@"All" Language:@"EN" EmailType:@"false"];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mOpenRoServiceDataGetter_ setMPdfTitle:@"Booklet"];
    }
    else     if(mMPIbtn_.isSelected){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ RequestForLoadingBooklet:[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_ DocumentType:@"InspectionForm" LineType:@"All" Language:@"EN" EmailType:@"false"];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mOpenRoServiceDataGetter_ setMPdfTitle:@"MPI Form"];

    }
    
    else     if(mEstimatebtn_.isSelected){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ RequestForLoadingBooklet:[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_ DocumentType:@"RepairEstimate" LineType:@"All" Language:@"EN" EmailType:@"false"];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mOpenRoServiceDataGetter_ setMPdfTitle:@"Estimate"];

    }


}


-(void)requestForEmail{
    if(mBookletbtn_.isSelected){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ RequestForLoadingBooklet:[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_ DocumentType:@"Booklet" LineType:@"All" Language:@"EN" EmailType:@"true"];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mOpenRoServiceDataGetter_ setMPdfTitle:@"Booklet"];

    }
    else     if(mMPIbtn_.isSelected){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ RequestForLoadingBooklet:[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_ DocumentType:@"InspectionForm" LineType:@"All" Language:@"EN" EmailType:@"true"];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mOpenRoServiceDataGetter_ setMPdfTitle:@"MPI Form"];

    }
    
    else     if(mEstimatebtn_.isSelected){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ RequestForLoadingBooklet:[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_ DocumentType:@"RepairEstimate" LineType:@"All" Language:@"EN" EmailType:@"true"];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mOpenRoServiceDataGetter_ setMPdfTitle:@"Estimate"];
 
    }

}

- (IBAction)CancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


# pragma mark ***** TextFieldDelegatemethods *****
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    UIScrollView* lScrollView=(UIScrollView*)self.superview;
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,240, 0.0);
//    lScrollView.contentInset = contentInsets;
//    lScrollView.scrollIndicatorInsets = contentInsets;
//    [UIView commitAnimations];
//    CGRect lFrame=[lScrollView convertRect:self.bounds fromView:self];
//    [lScrollView scrollRectToVisible:lFrame animated:NO];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
//    UIScrollView* lScrollView=(UIScrollView*)self.superview;
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    lScrollView.contentInset = contentInsets;
//    lScrollView.scrollIndicatorInsets = contentInsets;
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

@end
