//
//  EditVehicleViewController.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/6/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "EditVehicleViewController.h"
#define kKeyboardHeight 260

@interface EditVehicleViewController ()

@property(nonatomic,retain) UIToolbar  *mToolBar_;

@end

@implementation EditVehicleViewController

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

#pragma mark -  ***************** Generic Methods ****************

- (void)initData {
    
    [self.mScrollView_ setContentSize:CGSizeMake(self.mScrollView_.frame.size.width, self.mScrollView_.frame.size.height+100)];
    [self setFontsAndTextToSearchScreenView];
    [self setLabelsAndTextFields];
    [self enableOrDisableTextFieldsForTechAndAdvisor];
    [self setValuesToViews];
    [self inputviewForKeyboard];
}

- (void)setFontsAndTextToSearchScreenView {
    
    [self.mTitleLbl_ setText:(mAppDelegate_.mSearchViewController_.mEditVehicleBtn_.selected || mAppDelegate_.mSearchVehicleInfoView_.mAddVehicleButton_.selected)?NSLocalizedString(@"Add_Vehicle_Title", nil):NSLocalizedString(@"Edit_Vehicle_Title", nil)];

    [self.mSaveBtn_ setTitle:NSLocalizedString(@"Save_Button_Title", nil) forState:UIControlStateNormal];
    [self.mCancelBtn_ setTitle:NSLocalizedString(@"Cancel_Button_Title", nil) forState:UIControlStateNormal];
}

- (void)setLabelsAndTextFields {
    
    CGFloat xPos = 0.0, yPos = 0.0;
    
    NSString *lTitleStr = @"VIN,Year,Make,Model,Mileage,License";
    NSArray *lTitleArr = [lTitleStr componentsSeparatedByString:@","];
    for (int i=0; i<[lTitleArr count]; i++) {
        
        UIView *lCellView = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, _mScrollView_.frame.size.width, 46)];
        [lCellView.layer setBorderColor:[[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0] CGColor]];
        [lCellView.layer setBorderWidth:0.5];
        UILabel *lTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 150, 18)];
        lTitleLbl.textAlignment = NSTextAlignmentRight;
        [lTitleLbl setTextColor:[UIColor colorWithRed:30/255.0 green:30/255.0 blue:30/255.0 alpha:1.0]];
        [lTitleLbl setText:[lTitleArr objectAtIndex:i]];
        [lTitleLbl setFont:[UIFont systemFontOfSize:14.0]];
        [lCellView addSubview:lTitleLbl];
        UITextField *lTextField = [[UITextField alloc] initWithFrame:CGRectMake(lTitleLbl.frame.size.width+35, 10, 400, 30)];
        lTextField.delegate = self;
        lTextField.tag = i;
        if (i==[lTitleArr count]-1) {
            lTextField.returnKeyType = UIReturnKeyDone;
        }else
            lTextField.returnKeyType = UIReturnKeyNext;
        lTextField.borderStyle = UITextBorderStyleNone;
        [lTextField setFont:[UIFont systemFontOfSize:15.0]];
        lTextField.placeholder = [lTitleArr objectAtIndex:i];
        switch (i) {
            case 0: {
             lTextField.keyboardType = UIKeyboardTypeDefault;
                lTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
            }
                break;
            case 1:
            case 4:lTextField.keyboardType = UIKeyboardTypeNumberPad;
                break;
            default:lTextField.keyboardType = UIKeyboardTypeDefault;
                break;
        }
        [lTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [lCellView addSubview:lTextField];
        [_mScrollView_ addSubview:lCellView];
        yPos += lCellView.frame.size.height;
    }
}

- (void)getDataIntoModel {

    for(UIView *lView in _mScrollView_.subviews) {
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if ([pView isKindOfClass:[UITextField class]]) {
                    switch (((UITextField*)pView).tag) {
                        case 0:
                            [mAppDelegate_.mModelForEditVehicleScreen_ setMVIN_:((UITextField*)pView).text];
                            break;
                        case 1:
                            [mAppDelegate_.mModelForEditVehicleScreen_ setMYear_:((UITextField*)pView).text];
                            break;
                        case 2:
                            [mAppDelegate_.mModelForEditVehicleScreen_ setMMake_:((UITextField*)pView).text];
                            break;
                        case 3:
                            [mAppDelegate_.mModelForEditVehicleScreen_ setMModel_:((UITextField*)pView).text];
                            break;
                        case 4:
                            [mAppDelegate_.mModelForEditVehicleScreen_ setMMileage_:((UITextField*)pView).text];
                            break;
                        case 5:
                            [mAppDelegate_.mModelForEditVehicleScreen_ setMRegistrationNo_:((UITextField*)pView).text];
                            break;
                            
                        default:
                            break;
                    }
                }
            }
        }
    }
}

- (void)setValuesToViews {
    
    for(UIView *lView in _mScrollView_.subviews) {
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if ([pView isKindOfClass:[UITextField class]]) {
                    switch (((UITextField*)pView).tag) {
                        case 0:
                            [((UITextField*)pView) setText:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_];
                            break;
                        case 1:
                            [((UITextField*)pView) setText:[NSString stringWithFormat:@"%d",[mAppDelegate_.mModelForEditVehicleScreen_.mYear_ intValue]]];
                            break;
                        case 2:
                            [((UITextField*)pView) setText:mAppDelegate_.mModelForEditVehicleScreen_.mMake_];
                            break;
                        case 3:
                            [((UITextField*)pView) setText:mAppDelegate_.mModelForEditVehicleScreen_.mModel_];
                            break;
                        case 4:
                            [((UITextField*)pView) setText:mAppDelegate_.mModelForEditVehicleScreen_.mMileage_];
                            break;
                        case 5:
                            [((UITextField*)pView) setText:mAppDelegate_.mModelForEditVehicleScreen_.mRegistrationNo_];
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
    
    for(UIView *lView in mAppDelegate_.mEditVehicleViewController_.mScrollView_.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if (([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Advisor"] || [mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"]) && mAppDelegate_.mMasterViewController_->mselectedSegment_ == 3) {
                    if([pView isKindOfClass:[UITextField class]]) {
                        if (((UITextField*)pView).tag == 4) {
                            [((UITextField*)pView) setEnabled:YES];
                        }else {
                            [((UITextField*)pView) setEnabled:NO];
                        }
                    }
                }else
                    [((UITextField*)pView) setEnabled:YES];
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
    self.mScrollView_.contentInset = contentInsets;
    self.mScrollView_.scrollIndicatorInsets = contentInsets;
}

- (void)requestToSaveVehicleDetails {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppDelegate_.mRequestMethods_ putRequestToUpdateVehicleDetails:mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_ StoreID:mAppDelegate_.mModelForSplashScreen_.mStoreID_ MakeID:mAppDelegate_.mModelForEditVehicleScreen_.mMakeID_ Make:mAppDelegate_.mModelForEditVehicleScreen_.mMake_ Model:mAppDelegate_.mModelForEditVehicleScreen_.mModel_ Year:mAppDelegate_.mModelForEditVehicleScreen_.mYear_ VIN:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_ Mileage:mAppDelegate_.mModelForEditVehicleScreen_.mMileage_ License:mAppDelegate_.mModelForEditVehicleScreen_.mRegistrationNo_];
    } else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

- (void)requestToAddVehicleDetails {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppDelegate_.mRequestMethods_ postRequestToAddVehicleDetails:mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_ StoreID:mAppDelegate_.mModelForSplashScreen_.mStoreID_ MakeID:mAppDelegate_.mModelForEditVehicleScreen_.mMakeID_ Make:mAppDelegate_.mModelForEditVehicleScreen_.mMake_ Model:mAppDelegate_.mModelForEditVehicleScreen_.mModel_ Year:mAppDelegate_.mModelForEditVehicleScreen_.mYear_ VIN:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_ Mileage:mAppDelegate_.mModelForEditVehicleScreen_.mMileage_ License:mAppDelegate_.mModelForEditVehicleScreen_.mRegistrationNo_];
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
    [self.mScrollView_.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
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
    [self getDataIntoModel];
    if ([mAppDelegate_.mViewReference_ isKindOfClass:[SearchViewController class]]) {
        (mAppDelegate_.mSearchViewController_.mEditVehicleBtn_.selected)?[self requestToAddVehicleDetails]:[self requestToSaveVehicleDetails];
    }
    if ([mAppDelegate_.mViewReference_ isKindOfClass:[SearchVehicleInfoView class]]) {
        (mAppDelegate_.mSearchVehicleInfoView_.mAddVehicleButton_.selected)?[self requestToAddVehicleDetails]:[self requestToSaveVehicleDetails];
    }
}

#pragma mark -  ***************** TextField Delegate methods ****************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    int tag = textField.tag + 1;
    if (textField.tag <= 6) {
        [self.mScrollView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
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
        self.mScrollView_.contentInset = contentInsets;
        self.mScrollView_.scrollIndicatorInsets = contentInsets;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.0];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight+_mToolBar_.frame.size.height, 0.0);
    self.mScrollView_.contentInset = contentInsets;
    self.mScrollView_.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
    CGRect lFrame=[self.mScrollView_ convertRect:textField.bounds fromView:textField];
    [self.mScrollView_ scrollRectToVisible:lFrame animated:NO];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

        [mActiveTxtFld_ resignFirstResponder];
        mActiveTxtFld_=textField;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.0];
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight+_mToolBar_.frame.size.height, 0.0);
        self.mScrollView_.contentInset = contentInsets;
        self.mScrollView_.scrollIndicatorInsets = contentInsets;
        [UIView commitAnimations];
        CGRect lFrame=[self.mScrollView_ convertRect:textField.bounds fromView:textField];
        [self.mScrollView_ scrollRectToVisible:lFrame animated:NO];
        return YES;
}

#define MaxLength 17
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string { // return NO to not change text
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mScrollView_.contentInset = contentInsets;
    self.mScrollView_.scrollIndicatorInsets = contentInsets;
    
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
    self.mScrollView_.contentInset = contentInsets;
    self.mScrollView_.scrollIndicatorInsets = contentInsets;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
