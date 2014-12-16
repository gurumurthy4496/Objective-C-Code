//
//  SplashScreenViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 27/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "SplashScreenViewController.h"

@interface SplashScreenViewController () {
    AppDelegate *mAppDelegate_;
}

- (void)initializationOfObjectsForSplashScreenView;
- (void)setFontsAndTextToSplashScreenView;
- (BOOL)loginValidations;

@end

@implementation SplashScreenViewController

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
    
    // ----------------------------;
    // Initialization of objects;
    // ----------------------------;
    [self initializationOfObjectsForSplashScreenView];
    
    // ----------------------------;
    // Set Fonts and Text to splash screen sub-views;
    // ----------------------------;
    [self setFontsAndTextToSplashScreenView];
    
}

- (void)viewWillAppear:(BOOL)animated {
}

#pragma mark -
#pragma mark Private Methods

- (void)initializationOfObjectsForSplashScreenView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    
    [self.mLoginScrollView_ setContentSize:CGSizeMake(1024,674)];
    
    // ----------------------------;
    // Set the tap guesture for UIView and resign the keyboard when tap on view;
    // ----------------------------;
    
    UITapGestureRecognizer *lTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    lTapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:lTapGestureRecognizer];
}

- (void)setFontsAndTextToSplashScreenView {
    // ----------------------------;
    // Get the subview's from the UIScrollView -> mLoginScrollView_;
    // ----------------------------;
    
    [self.mLoginScrollView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        
        UIView *lTempView_ = object;
        UITextField *lTempTextField_ = object;
        UIButton *lTempButton_ = object;
        UILabel *lTempLabel_ = object;
        if ([lTempTextField_ isKindOfClass:[UITextField class]]) {
            UIView *lLeftViewForTextField = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, lTempTextField_.frame.size.height)];
            [lTempTextField_ setLeftView:lLeftViewForTextField];
            lTempTextField_.leftViewMode = UITextFieldViewModeAlways;
            lLeftViewForTextField.userInteractionEnabled = NO;
            lLeftViewForTextField = nil;
        }
        self.mSplashScreenImageView_.image = [UIImage imageNamed:@"Splash-Landscape"];
        
        switch (lTempView_.tag) {
            case 1: { // Welcome to ASR Pro Label;
                [lTempLabel_ setText:NSLocalizedString(@"lWelcomeToASRProLabel", nil)];
                [lTempLabel_ setTextColor:[UIColor whiteColor]];
                [lTempLabel_ setFont:[UIFont regularFontOfSize:25.0 fontKey:kFontNameHelveticaNeueKey]];
            }
                break;
            case 2: { // UserName Label;
                [lTempLabel_ setText:NSLocalizedString(@"lUsernameLabel", nil)];
                [lTempLabel_ setTextColor:[UIColor whiteColor]];
                [lTempLabel_ setFont:[UIFont regularFontOfSize:17.0 fontKey:kFontNameHelveticaNeueKey]];
            }
                break;
                
            case 3: { // Password Label;
                [lTempLabel_ setText:NSLocalizedString(@"lPasswordLabel", nil)];
                [lTempLabel_ setTextColor:[UIColor whiteColor]];
                [lTempLabel_ setFont:[UIFont regularFontOfSize:17.0 fontKey:kFontNameHelveticaNeueKey]];
            }
                break;
                
            case 4: { // StoreID Label;
                [lTempLabel_ setText:NSLocalizedString(@"lStoreIDLabel", nil)];
                [lTempLabel_ setTextColor:[UIColor whiteColor]];
                [lTempLabel_ setFont:[UIFont regularFontOfSize:17.0 fontKey:kFontNameHelveticaNeueKey]];
            }
                break;
                
            case 5: { //Username TextView;
                [lTempTextField_.layer setBorderWidth:1];
                lTempTextField_.font = [UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey];
                [lTempTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
            }
                break;
                
            case 6: { //Password TextView;
                [lTempTextField_.layer setBorderWidth:1];
                lTempTextField_.font = [UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey];
                [lTempTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
            }
                break;
                
            case 7: { //StoreID TextView;
                [lTempTextField_.layer setBorderWidth:1];
                lTempTextField_.font = [UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey];
                [lTempTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
            }
                break;
                
            case 8: { //Login Button;
                [lTempButton_ setTitle:NSLocalizedString(@"lForgotUsernameOrPassword?", nil) forState:UIControlStateNormal];
                [lTempButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [lTempLabel_ setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
            }
                break;
                
            case 9: { //Login Button;
                [lTempButton_ setBackgroundColor:[UIColor ASRProLoginButtonBackGroundColor]];
                [lTempButton_ setTitle:NSLocalizedString(@"lLogin", @"lLogin") forState:UIControlStateNormal];
                [lTempButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [lTempLabel_ setFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey]];
            }
                break;
            default:
                break;
        }
    }];
    
    [self.view.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *lTempView = object;
        if (lTempView.tag == 3) {
            [lTempView setBackgroundColor:[UIColor ASRProLoginBackgroundColor]];
        }else if (lTempView.tag == 4) {
            [lTempView setBackgroundColor:[UIColor ASRProLoginErrorViewBackgroundColor]];
            [lTempView setHidden:YES];
        }
    }];
    [self.mErrorMessageLabel_ setTextColor:[UIColor whiteColor]];
}

- (void)resignKeyboard {
    [[self view] endEditing:TRUE];
}

- (BOOL)loginValidations {
    
    [self resignKeyboard];
    
    __block BOOL lReturnValue = TRUE;
    
    [self.mLoginScrollView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UITextField *lTempTextFiled_ = object;
        switch (lTempTextFiled_.tag) {
            case 5: { // UserName TextFiled;
                if(![lTempTextFiled_.text isEqualToString:@""] && lTempTextFiled_.text != nil){
                    mAppDelegate_.mModelForSplashScreen_.mUserName_ = lTempTextFiled_.text;
                    [self.mErrorView_ setHidden:TRUE];
                }else{
                    [self.mErrorView_ setHidden:FALSE];
                    [self.mErrorMessageLabel_ setText:NSLocalizedString(@"lUsername", nil)];
                    lReturnValue = FALSE;
                    *stop = YES;
                }
            }
                break;
            case 6: { // Password TextFiled;
                if(![lTempTextFiled_.text isEqualToString:@""] && lTempTextFiled_.text != nil) {
                    mAppDelegate_.mModelForSplashScreen_.mPassword_ = lTempTextFiled_.text;
                    [self.mErrorView_ setHidden:TRUE];
                }else{
                    [self.mErrorView_ setHidden:FALSE];
                    [self.mErrorMessageLabel_ setText:NSLocalizedString(@"lPassword", nil)];
                    lReturnValue = FALSE;
                    *stop = YES;
                }
            }
                break;
            case 7: { // StoreID TextFiled;
                if (![lTempTextFiled_.text isEqualToString:@""] && lTempTextFiled_.text != nil) {
                    mAppDelegate_.mModelForSplashScreen_.mStoreID_ = lTempTextFiled_.text;
                    mAppDelegate_.mModelForSplashScreen_.mStoreIDWithContext_ = lTempTextFiled_.text;
                    [self.mErrorView_ setHidden:TRUE];
                }else {
                    [self.mErrorView_ setHidden:FALSE];
                    [self.mErrorMessageLabel_ setText:NSLocalizedString(@"lStoreID", nil)];
                    lReturnValue = FALSE;
                    *stop = YES;
                }
            }
                break;
            default:
                break;
        }
    }];
    [self.view bringSubviewToFront:self.mErrorView_];
    return lReturnValue;
}

#pragma mark -
#pragma mark TextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.0];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0,[[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0?kKeyboardHeightForiOS8:kKeyboardHeight, 0.0);
    self.mLoginScrollView_.contentInset = contentInsets;
    self.mLoginScrollView_.scrollIndicatorInsets = contentInsets;
    
    [UIView commitAnimations];
    
    CGRect lFrame=[self.mLoginScrollView_ convertRect:textField.bounds fromView:textField];
    [self.mLoginScrollView_ scrollRectToVisible:lFrame animated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    int tag = textField.tag + 1;
    if (textField.returnKeyType == UIReturnKeyGo) {
        if ([self loginValidations]) {
            [[SplashScreenSupportWebEngine sharedInstance] postRequestForLogin];
        }
    }
    if (textField.tag >= 5 && textField.tag <= 7) {
        [self.mLoginScrollView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            UITextField *lTempTextField_ =  object;
            if ([lTempTextField_ isKindOfClass:[UITextField class]]) {
                if (lTempTextField_.tag == tag) {
                    [lTempTextField_ becomeFirstResponder];
                    *stop = YES;
                }
            }
        }];
    }else {
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.mLoginScrollView_.contentInset = contentInsets;
        self.mLoginScrollView_.scrollIndicatorInsets = contentInsets;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mLoginScrollView_.contentInset = contentInsets;
    self.mLoginScrollView_.scrollIndicatorInsets = contentInsets;
}

#pragma mark -
#pragma mark Public Methods

#pragma mark -
#pragma mark Button Actions
- (IBAction)loginButtonAction:(id)sender {
    if ([self loginValidations]) {
        [[SplashScreenSupportWebEngine sharedInstance] postRequestForLogin];
    }
}

- (IBAction)forgotUserNamePasswordAction:(id)sender {
openURLInBrowser:{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.asrpro.com/Home/Contact"]];
    if (![[UIApplication sharedApplication] openURL:url])
        DLog(@"%@%@",@"Failed to open url:",[url description]);
}
}

#pragma mark -
#pragma mark Memory Management Methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Orientations Methods
- (BOOL)shouldAutorotate // iOS 6/7 autorotation fix
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6/7 autorotation fix
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

@end
