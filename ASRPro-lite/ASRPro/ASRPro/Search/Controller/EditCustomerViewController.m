//
//  EditCustomerViewController.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/6/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "EditCustomerViewController.h"
#define kKeyboardHeight 260

@interface EditCustomerViewController ()

@property(nonatomic,retain) UIToolbar  *mToolBar_;

@end

@implementation EditCustomerViewController

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
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self initData];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, 597, 523);
}

- (void)initData {
    
    [self.mContactScrollView setContentSize:CGSizeMake(self.mContactScrollView.frame.size.width, self.mContactScrollView.frame.size.height+70)];
    [self setFontsAndTextToSearchScreenView];
//    [self setLabelsAndTextFieldsForProfile];
    [self setLabelsAndTextFieldsForContact];
    [self enableOrDisableTextFieldsForTechAndAdvisor];
    [self setBorderColor];
    [self setValuesForViews];
    [self inputviewForKeyboard];
}

- (void)setFontsAndTextToSearchScreenView {

    [self.mEditCustomerTitleLbl_ setText:(mAppDelegate_.mSearchViewController_.mEditCustomerBtn_.selected || mAppDelegate_.mSearchCustomerInfoView_.mEditButton_.selected)?NSLocalizedString(@"Add_Customer_Title", nil):NSLocalizedString(@"Edit_Customer_Title", nil)];
    [self.mSaveBtn_ setTitle:NSLocalizedString(@"Save_Button_Title", nil) forState:UIControlStateNormal];
    [self.mCancelBtn_ setTitle:NSLocalizedString(@"Cancel_Button_Title", nil) forState:UIControlStateNormal];
}

- (void)setBorderColor {
}

- (void)setLabelsAndTextFieldsForContact {
    
    CGFloat xPos = 0.0, yPos = 0.0;
    NSString *lTitleStr = @"First Name,Last Name,Home Phone,Work Phone,Mobile Phone,Email,Address 1,Address 2,Country,State,City,Zip Code,Contact Method";
    NSArray *lTitleArr = [lTitleStr componentsSeparatedByString:@","];
    for (int i=0; i<[lTitleArr count]; i++) {
        
        UIView *lCellView = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, _mContactScrollView.frame.size.width, 40)];
        [lCellView.layer setBorderColor:[[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0] CGColor]];
        [lCellView.layer setBorderWidth:0.5];
        
        UILabel *lTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 150, 18)];
        lTitleLbl.textAlignment = NSTextAlignmentRight;
        [lTitleLbl setTextColor:[UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0]];
        [lTitleLbl setText:[lTitleArr objectAtIndex:i]];
        [lTitleLbl setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
        [lCellView addSubview:lTitleLbl];
        if (i==[lTitleArr count]-1) {
            CGFloat xCoord = lTitleLbl.frame.size.width + 38;
            for (int i=0; i<3; i++) {
                
                UIButton *lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                lBtn.frame = CGRectMake(xCoord, 10, 20, 20);
                [lBtn setTag:i];
                [lBtn setBackgroundImage:[UIImage imageNamed:@"TickMark_Unchecked.png"] forState:UIControlStateNormal];
                [lBtn setBackgroundImage:[UIImage imageNamed:@"TickMark.png"] forState:UIControlStateSelected];
                [lBtn addTarget:self action:@selector(ContactMethodBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                [lCellView addSubview:lBtn];
                UILabel *lUILabel = [[UILabel alloc] initWithFrame:CGRectMake(xCoord+lBtn.frame.size.width+10, 11, 60, 18)];
                [lUILabel setTextColor:[UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0]];
                if (i==0) {
                    [lUILabel setText:@"SMS"];
                }else if(i==1)
                    [lUILabel setText:@"Phone"];
                else {
                    [lUILabel setText:@"Email"];
                }
                [lUILabel setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
                [lCellView addSubview:lUILabel];
                xCoord += lUILabel.frame.size.width + 40;
            }
            
        }else {
            
            UITextField *lTextField = [[UITextField alloc] initWithFrame:CGRectMake(lTitleLbl.frame.size.width+35, 5, 400, 30)];
            lTextField.delegate = self;
            lTextField.tag = 100+i;
            [lTextField setTextColor:[UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0]];
            if (i==[lTitleArr count]-2) {
                lTextField.returnKeyType = UIReturnKeyDone;
            }else
                lTextField.returnKeyType = UIReturnKeyNext;
            switch (i) {
                case 2:
                case 3:
                case 4:
                case 11:lTextField.keyboardType = UIKeyboardTypeNumberPad;
                    break;
                case 5:lTextField.keyboardType = UIKeyboardTypeEmailAddress;
                    break;
                default:lTextField.keyboardType = UIKeyboardTypeDefault;
                    break;
            }
            lTextField.borderStyle = UITextBorderStyleNone;
            [lTextField setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
            lTextField.placeholder = [lTitleArr objectAtIndex:i];
            [lTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
            [lCellView addSubview:lTextField];
        }
        [_mContactScrollView addSubview:lCellView];
        yPos += lCellView.frame.size.height;
    }
}

- (void)setValuesForViews {
    
    for(UIView *lView in _mContactScrollView.subviews) {

        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if([pView isKindOfClass:[UITextField class]]) {
            UITextField *lTextField = (UITextField*)pView;

                switch (lTextField.tag) {
                    case 100:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_];
                        break;
                    case 101:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mLastName_];
                        break;
                    case 102:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mHomePhone_];
                        break;
                    case 103:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mWorkPhone_];
                        break;
                    case 104:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mMobilePhone_];
                        break;
                    case 105:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mEmail_];
                        break;
                    case 106:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mAddress1_];
                        break;
                    case 107:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mAddress2_];
                        break;
                    case 108:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mCountry_];
                        break;
                    case 109:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mState_];
                        break;
                    case 110:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mCity_];
                        break;
                    case 111:
                        [lTextField setText:mAppDelegate_.mModelForEditCustomerScreen_.mZipCode_];
                        break;
                }
                }
                if ([pView isKindOfClass:[UIButton class]]) {
                    switch (((UIButton*)pView).tag) {
                        case 0:
                            [((UIButton*)pView) setSelected:mAppDelegate_.mModelForEditCustomerScreen_.mSMS_];
                            break;
                        case 1:
                            [((UIButton*)pView) setSelected:mAppDelegate_.mModelForEditCustomerScreen_.mPhone_];
                            break;
                        case 2:
                            [((UIButton*)pView) setSelected:mAppDelegate_.mModelForEditCustomerScreen_.mContactEmail_];
                            break;
                        default:
                            break;
                    }
                }
            }
        }
            }
}

- (void)enableOrDisableTextFieldsForTechAndAdvisor {
    
    if ([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"]) {
        [mAppDelegate_.mEditCustomerViewController_.mSaveBtn_ setHidden:TRUE];
    }else
        [mAppDelegate_.mEditCustomerViewController_.mSaveBtn_ setHidden:FALSE];
    
    for(UIView *lView in mAppDelegate_.mEditCustomerViewController_.mContactScrollView.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if (([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Advisor"] || [mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"]) && mAppDelegate_.mMasterViewController_->mselectedSegment_ == 3) {
                    if([pView isKindOfClass:[UITextField class]]) {
                        if ([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Advisor"] && ((UITextField*)pView).tag == 105) {
                            [((UITextField*)pView) setEnabled:YES];
                        }else {
                            [((UITextField*)pView) setEnabled:NO];
                        }
                    }
                    if ([pView isKindOfClass:[UIButton class]]) {
                        [((UIButton*)pView) setEnabled:NO];
                    }
                }else {
                    if([pView isKindOfClass:[UITextField class]]) {
                        [((UITextField*)pView) setEnabled:YES];
                    }
                    if ([pView isKindOfClass:[UIButton class]]) {
                        [((UIButton*)pView) setEnabled:YES];
                    }
                }
            }
        }
    }
}

- (void)validationsForTextFields {
}

// *** Method get Data InTo Modal ***
- (void)getDataInToModal {
    
    for(UIView *lView in _mContactScrollView.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if([pView isKindOfClass:[UITextField class]]) {
                    UITextField *lTextField = (UITextField*)pView;
                    
                    switch (lTextField.tag) {
                        case 100:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMFirstName_:lTextField.text];
                            break;
                        case 101:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMLastName_:lTextField.text];
                            break;
                        case 102:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMHomePhone_:lTextField.text];
                            break;
                        case 103:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMWorkPhone_:lTextField.text];
                            break;
                        case 104:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMMobilePhone_:lTextField.text];
                            break;
                        case 105:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMEmail_:lTextField.text];
                            break;
                        case 106:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMAddress1_:lTextField.text];
                            break;
                        case 107:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMAddress2_:lTextField.text];
                            break;
                        case 108:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMCountry_:lTextField.text];
                            break;
                        case 109:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMState_:lTextField.text];
                            break;
                        case 110:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMCity_:lTextField.text];
                            break;
                        case 111:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMZipCode_:lTextField.text];
                            break;
                    }
                }
                if ([pView isKindOfClass:[UIButton class]]) {
                    switch (((UIButton*)pView).tag) {
                        case 0:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMSMS_:((UIButton*)pView).isSelected];
                            break;
                        case 1:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMPhone_:((UIButton*)pView).isSelected];
                            break;
                        case 2:
                            [mAppDelegate_.mModelForEditCustomerScreen_ setMContactEmail_:((UIButton*)pView).isSelected];
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
}

- (void)displayDatePicker {
    
    mAppDelegate_.mViewReference_ = self;
    DatePickerController *screen =[[DatePickerController alloc] initWithFrame:CGRectMake(0, 0, 600, 470)];
    NSString *tempString=mActiveTxtFld_.text;
    NSDate *getDate;
    //set the minimum date
    [[screen mDatePicker_] setMaximumDate:[NSDate date]];
    if ([tempString isEqualToString:@""]||tempString == nil)
    {
        getDate = [NSDate date];
        
    }else {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd-MM-yyyy"];
        getDate = [df dateFromString:tempString];
    }
    
    // Set the date current in the textField
    if (getDate)
    {
        [[screen mDatePicker_]setDate:getDate animated:YES];
    }
    // screen.mTextDisplayedlb.text=@"Select Date of Birth";
    
    [screen setMDatePickerDelegate_:self];
    [screen setMSelectedTextField_:mActiveTxtFld_];
    [self.view addSubview:screen];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mContactScrollView.contentInset = contentInsets;
    self.mContactScrollView.scrollIndicatorInsets = contentInsets;
}

- (void)requestToSaveCustomerDetails {

    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppDelegate_.mRequestMethods_ putRequestToUpdateCustomerDetails:mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ StoreID:mAppDelegate_.mModelForSplashScreen_.mStoreID_ CustomerNumber:mAppDelegate_.mModelForEditCustomerScreen_.mCustomerNumber_ FirstName:mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_ LastName:mAppDelegate_.mModelForEditCustomerScreen_.mLastName_ MiddleName:mAppDelegate_.mModelForEditCustomerScreen_.mMiddleName_ Email:mAppDelegate_.mModelForEditCustomerScreen_.mEmail_ HomePhone:mAppDelegate_.mModelForEditCustomerScreen_.mHomePhone_ WorkPhone:mAppDelegate_.mModelForEditCustomerScreen_.mWorkPhone_ MobilePhone:mAppDelegate_.mModelForEditCustomerScreen_.mMobilePhone_ Address1:mAppDelegate_.mModelForEditCustomerScreen_.mAddress1_ Address2:mAppDelegate_.mModelForEditCustomerScreen_.mAddress2_ Country:mAppDelegate_.mModelForEditCustomerScreen_.mCountry_ State:mAppDelegate_.mModelForEditCustomerScreen_.mState_ City:mAppDelegate_.mModelForEditCustomerScreen_.mCity_ Zipcode:mAppDelegate_.mModelForEditCustomerScreen_.mZipCode_ ContactEmail:mAppDelegate_.mModelForEditCustomerScreen_.mContactEmail_ ContactPhone:mAppDelegate_.mModelForEditCustomerScreen_.mPhone_ ContactSMS:mAppDelegate_.mModelForEditCustomerScreen_.mSMS_];
    } else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

- (void)requestToAddCustomerDetails {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]]|| [mAppDelegate_.mViewReference_ isKindOfClass:[EditCustomerViewController class]]) {
        }else
            [[SharedUtilities sharedUtilities] createLoadView];
        [mAppDelegate_.mRequestMethods_ postRequestToAddCustomerDetails:mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ StoreID:mAppDelegate_.mModelForSplashScreen_.mStoreID_ CustomerNumber:mAppDelegate_.mModelForEditCustomerScreen_.mCustomerNumber_ FirstName:mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_ LastName:mAppDelegate_.mModelForEditCustomerScreen_.mLastName_ MiddleName:mAppDelegate_.mModelForEditCustomerScreen_.mMiddleName_ Email:mAppDelegate_.mModelForEditCustomerScreen_.mEmail_ HomePhone:mAppDelegate_.mModelForEditCustomerScreen_.mHomePhone_ WorkPhone:mAppDelegate_.mModelForEditCustomerScreen_.mWorkPhone_ MobilePhone:mAppDelegate_.mModelForEditCustomerScreen_.mMobilePhone_ Address1:mAppDelegate_.mModelForEditCustomerScreen_.mAddress1_ Address2:mAppDelegate_.mModelForEditCustomerScreen_.mAddress2_ Country:mAppDelegate_.mModelForEditCustomerScreen_.mCountry_ State:mAppDelegate_.mModelForEditCustomerScreen_.mState_ City:mAppDelegate_.mModelForEditCustomerScreen_.mCity_ Zipcode:mAppDelegate_.mModelForEditCustomerScreen_.mZipCode_ ContactEmail:mAppDelegate_.mModelForEditCustomerScreen_.mContactEmail_ ContactPhone:mAppDelegate_.mModelForEditCustomerScreen_.mPhone_ ContactSMS:mAppDelegate_.mModelForEditCustomerScreen_.mSMS_];
    } else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

# pragma mark ===================== Custom Toolbar Methods =====================

// *** Method for Showing UIToolbar with Next,Previous and Done Buttons ***
- (void)inputviewForKeyboard {
    self.mToolBar_= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.superview.bounds.size.width, 44)];
    [self.mToolBar_ setBarStyle:UIBarStyleDefault];
    [self.mToolBar_ setTranslucent:YES];
    UIBarButtonItem *lflexibleButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace                                                                                     target:self action:nil];
    UIBarButtonItem *lClearBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(clear_Event:)];
    lClearBarButtonItem.tag=3;
    [self.mToolBar_ setItems:[NSArray arrayWithObjects:lflexibleButtonItem,lClearBarButtonItem,nil]];
    [_mContactScrollView.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
        if([object1 isKindOfClass:[UIView class]]) {
            [((UIView*)object1).subviews enumerateObjectsUsingBlock:^(id object2, NSUInteger index2, BOOL *stop2) {
                if ([object2 isKindOfClass:[UITextField class]]) {
                    UITextField *lTxtFld=(UITextField*)object2;
                    lTxtFld.inputAccessoryView=self.mToolBar_;
                }
            }];
        }
    }];
}

// *** Clear Button Action ***
- (void)clear_Event:(id)sender {
    
    [mActiveTxtFld_ setText:@""];
}

#pragma mark -  ***************** Button Actions ****************

- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtnAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self getDataInToModal];
    if ([mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]]) {
        [mAppDelegate_.mBeginVehicleCheckInView_ setActivityIndicatorToSearchView];
        NSMutableArray* lTempARray=[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_  valueForKey:@"Vehicles"];
        if (![lTempARray count] > 0) {
            mAppDelegate_.mViewReference_ = self;
        }
        [self requestToAddCustomerDetails];
    }else
        (mAppDelegate_.mSearchViewController_.mEditCustomerBtn_.selected || mAppDelegate_.mSearchCustomerInfoView_.mEditButton_.selected)?[self requestToAddCustomerDetails]:[self requestToSaveCustomerDetails];
}

- (IBAction)ContactMethodBtnAction:(id)sender {
    
    UIButton* lSelectButton=(UIButton*)sender;
    switch (lSelectButton.tag) {
        case 0: {
            if (!lSelectButton.selected) {
                [lSelectButton setSelected:YES];
            }else
                [lSelectButton setSelected:NO];
        }
            break;
        case 1: {
            if (!lSelectButton.selected) {
                [lSelectButton setSelected:YES];
            }else
                [lSelectButton setSelected:NO];
        }
            break;
        case 2: {
            if (!lSelectButton.selected) {
                [lSelectButton setSelected:YES];
            }else
                [lSelectButton setSelected:NO];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark -  ***************** TextField Delegate methods ****************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    UIScrollView *lScrollView = (UIScrollView*)textField.superview.superview;
    if(lScrollView.tag == 1) {
        int tag = textField.tag + 1;
        if (textField.tag <= 113) {
            [lScrollView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
                UIView *lTempTextField_ =  object;
                if ([lTempTextField_ isKindOfClass:[UIView class]]) {
                    [lTempTextField_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
                        UITextField *lTextField = object;
                        if ([lTextField isKindOfClass:[UITextField class]]) {
                            if (lTextField.tag == tag) {
                                [lTextField becomeFirstResponder];
                                *stop = YES;
                            }
                        }
                    }];
                }
            }];
        }else {
            UIEdgeInsets contentInsets = UIEdgeInsetsZero;
            lScrollView.contentInset = contentInsets;
            lScrollView.scrollIndicatorInsets = contentInsets;
        }
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    UIScrollView *lScrollView = (UIScrollView*)textField.superview.superview;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.0];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight+_mToolBar_.frame.size.height, 0.0);
    lScrollView.contentInset = contentInsets;
    lScrollView.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
    CGRect lFrame=[lScrollView convertRect:textField.bounds fromView:textField];
    [lScrollView scrollRectToVisible:lFrame animated:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
        [mActiveTxtFld_ resignFirstResponder];
        mActiveTxtFld_=textField;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.0];
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight+_mToolBar_.frame.size.height, 0.0);
        self.mContactScrollView.contentInset = contentInsets;
        self.mContactScrollView.scrollIndicatorInsets = contentInsets;
        [UIView commitAnimations];
        CGRect lFrame=[self.mContactScrollView convertRect:textField.bounds fromView:textField];
        [self.mContactScrollView scrollRectToVisible:lFrame animated:NO];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    UIScrollView *lScrollView = (UIScrollView*)textField.superview.superview;
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    lScrollView.contentInset = contentInsets;
    lScrollView.scrollIndicatorInsets = contentInsets;
    
}

# pragma mark ===================== Date picker controller delegate =====================
// ********** method for Date picker controller **********

- (void)datePickerController:(DatePickerController *)controller
                 didPickDate:(NSDate *)date
                      isDone:(BOOL)isDone {
    if(isDone)
    {
		NSDateFormatter *lDateFormat_ = [[NSDateFormatter alloc] init];
		[lDateFormat_ setDateFormat:@"dd/MM/yyyy"];
        NSTimeZone *gmtZone = [NSTimeZone systemTimeZone];
        [lDateFormat_ setTimeZone:gmtZone];
        NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
        lDateFormat_.locale = enLocale;
		mActiveTxtFld_.text = [NSString stringWithFormat:@"%@", [lDateFormat_ stringFromDate:date]];
		if([controller superview]){
			[controller removeFromSuperview];
		}
    }
    else
    {
        if([controller superview]){
            [controller removeFromSuperview];
        }
    }
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mContactScrollView.contentInset = contentInsets;
    self.mContactScrollView.scrollIndicatorInsets = contentInsets;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
