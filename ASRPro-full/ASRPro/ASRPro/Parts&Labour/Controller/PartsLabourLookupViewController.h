//
//  PartsLabourLookupViewController.h
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PartsLaborSubview.h"
#import "PartsLabourLookupSubview.h"

@interface PartsLabourLookupViewController : UIViewController<PartsLabourLookupSubviewClassDelegate>
{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    int selectedindex;
    int rowheight;
    
}

@property (strong, nonatomic) IBOutlet UILabel *mHeadingLabel_;
@property (strong, nonatomic) IBOutlet UIButton *mCancelButton_;
@property (strong, nonatomic) IBOutlet UIButton *mSaveButton_;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *mGrayActivityIndicator;
@property (strong, nonatomic) IBOutlet UIScrollView *mPartsScrollView;
@property (strong, nonatomic)  UIView *mTempView_;
@property (strong, nonatomic) IBOutlet UIView *mPartsLookupView_;

-(void)addNoPartsFound;
- (IBAction)SaveButtonAction:(id)sender;
- (IBAction)CancelButtonAction_:(id)sender;
-(void)resetAllFields;

@end