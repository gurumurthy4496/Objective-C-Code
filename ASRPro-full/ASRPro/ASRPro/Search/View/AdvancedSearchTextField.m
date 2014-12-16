//
//  AdvancedSearchTextField.m
//  ASRPro
//
//  Created by Santosh Kvss on 4/4/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "AdvancedSearchTextField.h"
#define kKeyboardHeight_CustomerCheckin 100

@implementation AdvancedSearchTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setDelegate:self];
    }
    return self;
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
    lLbl.frame = CGRectMake(20, 5, 120, 14);
    lLbl.font = [UIFont systemFontOfSize:11.0];
    if (textField.tag == 0)
        lLbl.text = @"FirstName";
    else if (textField.tag == 1)
        lLbl.text = @"LastName";
    else if (textField.tag == 2)
        lLbl.text = @"Phone";
    else
        lLbl.text = @"Email";
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

#pragma mark -  ***************** TextField Delegate methods ****************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    int i=[[[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_].mAdvancedSearchTextFieldsArr_ count];
    int x=textField.tag+1;
    if (x==1) {
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_ setMFirstName_:textField.text];
        
    }else if (x==2)
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_ setMLastName_:textField.text];
    else if (x==3)
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_ setMMobilePhone_:textField.text];
    else
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_ setMEmail_:textField.text];
    if (x<i) {
        UITextField *nextTextField = (UITextField *)[[[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_].mAdvancedSearchTextFieldsArr_ objectAtIndex:x];
        [nextTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
  //  [[[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_] setContinueHiddenTRueorFalse];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.0];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight_CustomerCheckin, 0.0);
    [[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_].mAdvancedSearchScrollView_.contentInset = contentInsets;
    [[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_].mAdvancedSearchScrollView_.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
    CGRect lFrame=[[[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_].mAdvancedSearchScrollView_ convertRect:textField.bounds fromView:textField];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_].mAdvancedSearchScrollView_ scrollRectToVisible:lFrame animated:NO];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {  // return NO to not change text
    [textField.text stringByReplacingCharactersInRange:range withString:string];
//    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_] setContinueHiddenTRueorFalse];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([[textField text] length]>0) {
        [self showCheckInLabels:textField];
    }else
        [self removeCheckInLabels:textField];
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    [[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_].mAdvancedSearchScrollView_.contentInset = contentInsets;
    [[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_].mAdvancedSearchScrollView_.scrollIndicatorInsets = contentInsets;
    int x=textField.tag+1;
    if (x==1) {
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_ setMFirstName_:textField.text];
        
    }else if (x==2)
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_ setMLastName_:textField.text];
    else if (x==3)
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_ setMMobilePhone_:textField.text];
    else
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_ setMEmail_:textField.text];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_] setContinueHiddenTRueorFalse];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
