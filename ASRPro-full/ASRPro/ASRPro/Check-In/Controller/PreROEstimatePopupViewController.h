//
//  PreROEstimatePopupViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 02/05/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreROEstimatePopupViewController : UIViewController<UIPrintInteractionControllerDelegate,OnsuccessProtocol>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel_;
@property (strong, nonatomic) IBOutlet UIButton *doneButton_;
- (IBAction)doneButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *printButton_;
- (IBAction)printButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIWebView *pdfWebView_;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView_;
@end
