//
//  EditPartViewController.m
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "EditPartViewController.h"

@interface EditPartViewController ()

@end

@implementation EditPartViewController
@synthesize mCancelButton_;
@synthesize mDeleteLabel_;
@synthesize mDeleteView_;
@synthesize mEditScrollView_;
@synthesize mHeadingLabel_;
@synthesize mNoDeleteLabel_;
@synthesize mSaveButton_;
@synthesize mYesDeleteLabel_;

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

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.superview.bounds = CGRectMake(0, 0, 600,317);
}

-(void)initTheViews{
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];

    [mSaveButton_ setTitle:@"Save" forState:UIControlStateNormal];
    [mCancelButton_ setTitle:@"Cancel" forState:UIControlStateNormal];
    [mHeadingLabel_ setText:@"Edit Part"];
    [[GenericFiles genericFiles] createUILabelWithInstance:mDeleteLabel_ labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:@"Want to delete this part ?" labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    
    [[GenericFiles genericFiles] createUIButtonInstance:mYesDeleteLabel_ buttonTitle:@"Yes,delete" buttonTitleColor:[UIColor colorWithRed:(251.0/255.0) green:(62.0/255.0) blue:(58.0/255.0) alpha:1.0] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
    [mYesDeleteLabel_.layer setBorderColor:[UIColor colorWithRed:(251.0/255.0) green:(62.0/255.0) blue:(58.0/255.0) alpha:1.0].CGColor];
    [mYesDeleteLabel_.layer setBorderWidth:1.0];
    
    [[GenericFiles genericFiles] createUIButtonInstance:mNoDeleteLabel_ buttonTitle:@"No,Cancel" buttonTitleColor:[UIColor colorWithRed:(251.0/255.0) green:(62.0/255.0) blue:(58.0/255.0) alpha:1.0] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [mNoDeleteLabel_.layer setBorderColor:[UIColor colorWithRed:(251.0/255.0) green:(62.0/255.0) blue:(58.0/255.0) alpha:1.0].CGColor];
    [mNoDeleteLabel_.layer setBorderWidth:1.0];

    [self setLabelsAndTextFieldsForContact];
    [self setValueToViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLabelsAndTextFieldsForContact {
    
    CGFloat xPos = 0.0, yPos = 0.0;
    NSString *lTitleStr = @"Quality,Quantity,Part Number,Description,Location,Price";
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
        lTextField.borderStyle = UITextBorderStyleNone;
        [lTextField setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
        lTextField.placeholder = @"(Tap to input)";
        [lTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [lCellView addSubview:lTextField];
        [mEditScrollView_ addSubview:lCellView];
        yPos += lCellView.frame.size.height;
    }
    UIButton* mDeleteButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 240, 600, 40)];
    [[GenericFiles genericFiles] createUIButtonInstance:mDeleteButton buttonTitle:@"Delete Part" buttonTitleColor:[UIColor colorWithRed:(251.0/255.0) green:(62.0/255.0) blue:(58.0/255.0) alpha:1.0] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [mDeleteButton.layer setBorderColor:[UIColor colorWithRed:(251.0/255.0) green:(62.0/255.0) blue:(58.0/255.0) alpha:1.0].CGColor];
    [mDeleteButton.layer setBorderWidth:1.0];
    [mDeleteButton addTarget:self action:@selector(DeletePartAction:) forControlEvents:UIControlEventTouchUpInside];
    [mEditScrollView_ addSubview:mDeleteButton];
    
    

}

-(void)setValueToViews{
    
    for(UIView *lView in mEditScrollView_.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if([pView isKindOfClass:[UITextField class]]) {
                    UITextField *lTextField = (UITextField*)pView;
                    
                    switch (lTextField.tag) {
                            case 100:{
                                [lTextField setText:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mQuality_];
                                [lTextField setKeyboardType:UIKeyboardTypeDefault];
                                [lTextField setEnabled:FALSE];
                                break;
                            }
                            case 101:{
                                [lTextField setText:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mQuantity_];
                                [lTextField setKeyboardType:UIKeyboardTypeNumberPad];
                                break;
                            }
                            case 102:{
                                [lTextField setText:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mPartNumber_];
                                [lTextField setKeyboardType:UIKeyboardTypeNumberPad];
                            break;
                            }
                            case 103:{
                                [lTextField setText:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mDescription_];
                                [lTextField setKeyboardType:UIKeyboardTypeDefault];
                            break;
                            }
                            case 104:{
                                [lTextField setText:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mLocation_];
                                [lTextField setKeyboardType:UIKeyboardTypeDefault];
                                [lTextField setEnabled:FALSE];

                            break;
                            }
                            case 105:{
                                [lTextField setText:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mPrice_];
                                [lTextField setKeyboardType:UIKeyboardTypeNumberPad];
                            break;
                            }
                        }
                }
    }
        }
}
}
- (IBAction)CancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)SaveAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self getDataInToModal];
    [mAppDelegate_.mModelForPartsSupportEngine_ requestToUpdateParts:mAppDelegate_.mPartLabourDataGetter_.mRONumber_ RequestDict:[mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ convertModelToDict]];

}

- (IBAction)DeleteAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [mAppDelegate_.mModelForPartsSupportEngine_ requestToDeleteParts:mAppDelegate_.mPartLabourDataGetter_.mRONumber_ PartID:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mPartID_];

}



- (IBAction)CancelDeleteAction:(id)sender {
    [mDeleteView_ setHidden:TRUE];
}


-(void)DeletePartAction:(UIButton*)sender{
    [mDeleteView_ setHidden:FALSE];
    [self.view bringSubviewToFront:mDeleteView_];

}

- (void)getDataInToModal {
    
    for(UIView *lView in mEditScrollView_.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
            for(UIView *pView in lView.subviews) {
                if([pView isKindOfClass:[UITextField class]]) {
                    UITextField *lTextField = (UITextField*)pView;
                    
                    switch (lTextField.tag) {
                        case 100:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMQuality_:lTextField.text];
                            break;
                        case 101:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMQuantity_:lTextField.text];
                            break;
                        case 102:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMPartNumber_:lTextField.text];
                            break;
                        case 103:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMDescription_:lTextField.text];
                            break;
                        case 104:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMLocation_:lTextField.text];
                            break;
                        case 105:
                            [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMPrice_:lTextField.text];
                            break;
                                   }
                }
            }
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    UIScrollView *lScrollView = (UIScrollView*)textField.superview.superview;
        int tag = textField.tag + 1;
        if (textField.tag <= 104) {
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
        }else  if (textField.tag == 105) {
            UIEdgeInsets contentInsets = UIEdgeInsetsZero;
            lScrollView.contentInset = contentInsets;
            lScrollView.scrollIndicatorInsets = contentInsets;
            [textField resignFirstResponder];

        }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    UIScrollView *lScrollView = (UIScrollView*)textField.superview.superview;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.0];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight, 0.0);
    lScrollView.contentInset = contentInsets;
    lScrollView.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
    CGRect lFrame=[lScrollView convertRect:textField.bounds fromView:textField];
    [lScrollView scrollRectToVisible:lFrame animated:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.0];
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kKeyboardHeight, 0.0);
    self.mEditScrollView_.contentInset = contentInsets;
    self.mEditScrollView_.scrollIndicatorInsets = contentInsets;
    [UIView commitAnimations];
    CGRect lFrame=[self.mEditScrollView_ convertRect:textField.bounds fromView:textField];
    [self.mEditScrollView_ scrollRectToVisible:lFrame animated:NO];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    UIScrollView *lScrollView = (UIScrollView*)textField.superview.superview;
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    lScrollView.contentInset = contentInsets;
    lScrollView.scrollIndicatorInsets = contentInsets;
    
}
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}


@end
