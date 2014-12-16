//
//  PartsLabourMainViewController.h
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartsLaborMainSubview.h"


@interface PartsLabourMainViewController : UIViewController{
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
}

@property (strong, nonatomic) IBOutlet UIButton *mDoneButton_;
@property (strong, nonatomic) IBOutlet UIButton *mLookUpButton_;
@property (strong, nonatomic) IBOutlet UIScrollView *mPartsScrollView_;

-(void)initTheViews;
-(void)ShowAddPartsPopUp;
-(void)ShowEditPartsPopUp;
- (IBAction)DoneButtonAction:(id)sender;
- (IBAction)PartsLookupAction:(id)sender;
-(void)reloadPartsView;
-(void)resizeTheViews;

@end
