//
//  AddPartViewController.m
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "AddPartViewController.h"

@interface AddPartViewController ()

@end

@implementation AddPartViewController
@synthesize mAddButton_;
@synthesize mCancelButton_;
@synthesize mTitleLabel_;
@synthesize mPartsScrollView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initTheViews];
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.superview.bounds = CGRectMake(0, 0, 600,165);
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                      *** Method to set empty strings to modal  ***
//--------------------------------------------------- ************** ------------------------------------------------------

-(void)initTheViews{
    [mAddButton_ setTitle:@"Add" forState:UIControlStateNormal];
    [mCancelButton_ setTitle:@"Cancel" forState:UIControlStateNormal];
    [mTitleLabel_ setText:@"Add Part"];
    [self setLabelsAndTextFieldsForContact];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)setLabelsAndTextFieldsForContact {
    
  CGFloat xPos = 0.0, yPos = 0.0;
 NSString *lTitleStr = @"Quantity,Part Number,";
 NSArray *lTitleArr = [lTitleStr componentsSeparatedByString:@","];
   for (int i=0; i<[lTitleArr count]; i++) {
        
        UIView *lCellView = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos,600 , 40)];
        [lCellView.layer setBorderColor:[[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0] CGColor]];
        [lCellView.layer setBorderWidth:0.5];
       if(i<2){
        UILabel *lTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 150, 20)];
        lTitleLbl.textAlignment = NSTextAlignmentRight;
        [lTitleLbl setTextColor:[UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0]];
        [lTitleLbl setText:[lTitleArr objectAtIndex:i]];
        [lTitleLbl setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
        [lCellView addSubview:lTitleLbl];
       if(i==0){
            UITextField *lTextField = [[UITextField alloc] initWithFrame:CGRectMake(lTitleLbl.frame.size.width+35, 5, 400, 30)];
            lTextField.delegate = self;
            lTextField.tag = 100+i;
            [lTextField setTextColor:[UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0]];
           lTextField.returnKeyType = UIReturnKeyDone;
           [lTextField setKeyboardType:UIKeyboardTypeNumberPad];
            lTextField.borderStyle = UITextBorderStyleNone;
            [lTextField setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
            lTextField.placeholder = @"(Tap to input)";
            [lTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
            [lCellView addSubview:lTextField];
           [self.mPartsScrollView_ addSubview:lCellView];

       }
       else{
           [self.mPartsScrollView_ addSubview:lCellView];

           DropDownView* lDropdownView=[[DropDownView alloc] initWithFrame:CGRectMake(lTitleLbl.frame.size.width+30, lCellView.frame.origin.y+1, 400, 38)];
           [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMPartNumbersArray_:[mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ getPartArray:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mLineID_]];
           [lDropdownView setMTempArray_:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mPartNumbersArray_];
           [lDropdownView setMkeysArray_:[[NSArray arrayWithObjects:@"Number", @"Name",@"Price",@"Quantity",nil] mutableCopy]];
           //   [lDropdownView.mDropDownTable_ reloadData];
           lDropdownView.tag = 100+i;
           
           [lDropdownView initTheVIews:80];
           [lDropdownView.mDropDownButton_ setTitle:@""];
           [lDropdownView setDelegate:self];
           [self.mPartsScrollView_ addSubview:lDropdownView];
           
       }
       }
       else
           [self.mPartsScrollView_ addSubview:lCellView];

   yPos += lCellView.frame.size.height;
    }
}



- (IBAction)CancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    
}
- (IBAction)AddButtonAction:(id)sender {
    if([self validationsForTextFields]){
    [self dismissViewControllerAnimated:YES completion:nil];
    [self getDataInToModal];
    [mAppDelegate_.mModelForPartsSupportEngine_ requestToAddParts:mAppDelegate_.mPartLabourDataGetter_.mRONumber_ LineID:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mLineID_ RequestDict:[[NSDictionary dictionaryWithObjectsAndKeys:mAppDelegate_.mModelForSplashScreen_.mEmployeeID_,@"UserID",mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mPartNumber_,@"PartNumber",mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mQuantity_,@"Quantity",nil] mutableCopy]];
    }
}




#pragma mark -  ***************** TextField Delegate methods ****************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//    if (textField.tag==100) {
//    [self.mPartsScrollView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
//        UIView *lView= object;
//        if ([lView isKindOfClass:[UIView class]]) {
//            [lView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
//                        UITextField *lTextField = object;
//                        if ([lTextField isKindOfClass:[UITextField class]]) {
//                            if (lTextField.tag == 101) {
//                                [lTextField becomeFirstResponder];
//                                *stop = YES;
//                            }
//                        }
//                    }];
//        }
//    }];
//}
//    else{
//
        [textField resignFirstResponder];

//    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
//    UIScrollView *lScrollView = (UIScrollView*)textField.superview.superview;
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.0];
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight+_mToolBar_.frame.size.height, 0.0);
//    lScrollView.contentInset = contentInsets;
//    lScrollView.scrollIndicatorInsets = contentInsets;
//    [UIView commitAnimations];
//    CGRect lFrame=[lScrollView convertRect:textField.bounds fromView:textField];
//    [lScrollView scrollRectToVisible:lFrame animated:NO];
    for(UIView *lView in mPartsScrollView_.subviews) {
        
                if([lView isKindOfClass:[DropDownView class]]) {
                    DropDownView *lDropDownView = (DropDownView*)lView;
                    [lDropDownView hideDropDown];
                }
                
        }
    mActiveTextField_=textField;

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    //[textField resignFirstResponder];
   // mActiveTxtFld_=textField;
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.0];
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight, 0.0);
////    self.view.contentInset = contentInsets;
////    self.view.scrollIndicatorInsets = contentInsets;
//    [UIView commitAnimations];
//    CGRect lFrame=[self.mContactScrollView convertRect:textField.bounds fromView:textField];
  //  [self.mContactScrollView scrollRectToVisible:lFrame animated:NO];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
   //    UIScrollView *lScrollView = (UIScrollView*)textField.superview.superview;
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    lScrollView.contentInset = contentInsets;
//    lScrollView.scrollIndicatorInsets = contentInsets;
    
}

- (BOOL)validationsForTextFields {
    
    BOOL returnValue =FALSE;
    for(UIView *lView in self.mPartsScrollView_.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if([pView isKindOfClass:[UITextField class]]) {
                    UITextField *lTextField = (UITextField*)pView;
                    
                    switch (lTextField.tag) {
                        case 100:
                            if (lTextField.text !=nil && ![lTextField.text isEqualToString:@""]) {
                                returnValue = TRUE;
                            }else {
                                [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:@"Please Enter Quantity"];
                                returnValue = FALSE;
                                return NO;
                            }
                    }
                }
            }
        }
        if([lView isKindOfClass:[DropDownView class]]) {
            DropDownView *lTextField = (DropDownView*)lView;
            
            switch (lTextField.tag) {
                case 101:
                    if (lTextField.mDropDownButton_.mFormDict_!=nil ) {
                        returnValue = TRUE;
                    }else {
                        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:@"Please Select Part Number"];
                        returnValue = FALSE;
                        return NO;
                    }
            }
        }
        
    }

    return returnValue;
}


- (void)getDataInToModal {
    
    for(UIView *lView in self.mPartsScrollView_.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if([pView isKindOfClass:[UITextField class]]) {
                    UITextField *lTextField = (UITextField*)pView;
                    
                    switch (lTextField.tag) {
                        case 100:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMQuantity_:lTextField.text];
                            break;
                                           }
                }
            }
        }
                if([lView isKindOfClass:[DropDownView class]]) {
                    DropDownView *lTextField = (DropDownView*)lView;
                    
                    switch (lTextField.tag) {
                        case 101:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMPartNumber_:[lTextField.mDropDownButton_.mFormDict_ objectForKey:@"Number"]!=nil?[NSString stringWithFormat:@"%@",[lTextField.mDropDownButton_.mFormDict_ objectForKey:@"Number"]]:@""];
                            break;
                    }
                }

                    }
}

-(void)changeHeight:(int)height Tag:(int)aTag View:(id)aDropDownView{
    [mActiveTextField_ resignFirstResponder];
    mActiveTextField_=nil;
    DropDownView* lTempDropDown=aDropDownView;
    if(lTempDropDown.tag==101){
        if(height==38) {
            [self.mPartsScrollView_ setContentSize:CGSizeMake(600, 120)]  ;
            [self.mPartsScrollView_ setContentOffset:CGPointMake(0, 0)]  ;
        }
        else{
            [self.mPartsScrollView_ setContentSize:CGSizeMake(600, 160)]  ;
            [self.mPartsScrollView_ setContentOffset:CGPointMake(0, 40)]  ;
        }
    }
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

-(void)hideKeyboard:(UIGestureRecognizer*)tapGestureRecognizer
{
    for(UIView *lView in mPartsScrollView_.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
                if([lView isKindOfClass:[DropDownView class]]) {
                    DropDownView *lDropDownView = (DropDownView*)lView;
                    if (!CGRectContainsPoint([lDropDownView.mDropDownTable_ cellForRowAtIndexPath:[lDropDownView.mDropDownTable_ indexPathForSelectedRow]].frame, [tapGestureRecognizer locationInView:lDropDownView.mDropDownTable_]))
                    {
                        [lDropDownView hideDropDown];
                    }
                }
                
        }
    }
    
}



@end
