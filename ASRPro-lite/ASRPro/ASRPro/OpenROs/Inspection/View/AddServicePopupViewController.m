//
//  AddServicePopupViewController.m
//  ASRPro
//
//  Created by Santosh Kvss on 11/9/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "AddServicePopupViewController.h"

@interface AddServicePopupViewController ()

@end

@implementation AddServicePopupViewController
@synthesize mFormtype;
@synthesize mRONumber_;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddServicePopupButtonAction:(id)sender {
    
    if(mFormtype==LANEINSPECTION){
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] mWalkAroundLaneInspectionView] removeAddServicePopupView];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] mWalkAroundLaneInspectionView]loadServices];
    }
    else{
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_]  removeAddServicePopupView];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mFinishInspectionViewController_] loadServices];

    }
}
@end
