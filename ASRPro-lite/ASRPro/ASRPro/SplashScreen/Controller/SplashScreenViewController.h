//
//  SplashScreenViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 27/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashScreenViewController : UIViewController <UIGestureRecognizerDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *mSplashScreenImageView_;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *mSplashScreenActivityIndicator_;
@property (retain, nonatomic) IBOutlet UIScrollView *mLoginScrollView_;
@property (retain, nonatomic) IBOutlet UIButton *mLoginButton_;
@property (weak, nonatomic) IBOutlet UIView *mErrorView_;
@property (weak, nonatomic) IBOutlet UILabel *mErrorMessageLabel_;


#pragma mark -
#pragma mark ButtonActions
- (IBAction)loginButtonAction:(id)sender;
- (IBAction)forgotUserNamePasswordAction:(id)sender;
@end
