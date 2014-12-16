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
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.superview.bounds = CGRectMake(0, 0, 600,117);
}

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
    
  CGFloat xPos = 0.0, yPos = 37.0;
 NSString *lTitleStr = @"Quantity,Part Number";
 NSArray *lTitleArr = [lTitleStr componentsSeparatedByString:@","];
   for (int i=0; i<[lTitleArr count]; i++) {
        
        UIView *lCellView = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos,600 , 40)];
        [lCellView.layer setBorderColor:[[UIColor colorWithRed:186/255.0 green:186/255.0 blue:186/255.0 alpha:1.0] CGColor]];
        [lCellView.layer setBorderWidth:0.5];

        UILabel *lTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 150, 18)];
        lTitleLbl.textAlignment = NSTextAlignmentRight;
        [lTitleLbl setTextColor:[UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0]];
        [lTitleLbl setText:[lTitleArr objectAtIndex:i]];
        [lTitleLbl setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
        [lCellView addSubview:lTitleLbl];

            UITextField *lTextField = [[UITextField alloc] initWithFrame:CGRectMake(lTitleLbl.frame.size.width+35, 5, 400, 30)];
            lTextField.delegate = self;
            lTextField.tag = 100+i;
            [lTextField setTextColor:[UIColor colorWithRed:31/255.0 green:31/255.0 blue:31/255.0 alpha:1.0]];
            if (i==[lTitleArr count]-1) {
                lTextField.returnKeyType = UIReturnKeyDone;
            }else
                lTextField.returnKeyType = UIReturnKeyNext;
       [lTextField setKeyboardType:UIKeyboardTypeNumberPad];
            lTextField.borderStyle = UITextBorderStyleNone;
            [lTextField setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
            lTextField.placeholder = @"(Tap to input)";
            [lTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
            [lCellView addSubview:lTextField];
            [self.view addSubview:lCellView];
   yPos += lCellView.frame.size.height;
    }
}



- (IBAction)CancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    
}
- (IBAction)AddButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self getDataInToModal];
    [mAppDelegate_.mModelForPartsSupportEngine_ requestToAddParts:mAppDelegate_.mPartLabourDataGetter_.mRONumber_ LineID:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mLineID_ RequestDict:[[NSDictionary dictionaryWithObjectsAndKeys:mAppDelegate_.mModelForSplashScreen_.mEmployeeID_,@"UserID",mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mPartNumber_,@"PartNumber",mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mQuantity_,@"Quantity",nil] mutableCopy]];
}


#pragma mark -  ***************** TextField Delegate methods ****************

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag==100) {
    [self.view.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *lView= object;
        if ([lView isKindOfClass:[UIView class]]) {
            [lView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
                        UITextField *lTextField = object;
                        if ([lTextField isKindOfClass:[UITextField class]]) {
                            if (lTextField.tag == 101) {
                                [lTextField becomeFirstResponder];
                                *stop = YES;
                            }
                        }
                    }];
        }
    }];
}
    else{

        [textField resignFirstResponder];

    }
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
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
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

- (void)getDataInToModal {
    
    for(UIView *lView in self.view.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if([pView isKindOfClass:[UITextField class]]) {
                    UITextField *lTextField = (UITextField*)pView;
                    
                    switch (lTextField.tag) {
                        case 100:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMQuantity_:lTextField.text];
                            break;
                        case 101:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMPartNumber_:lTextField.text];
                            break;
                                           }
                }
                    }
        }
}
}


- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}


@end
