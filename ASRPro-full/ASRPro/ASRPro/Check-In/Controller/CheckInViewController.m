//
//  CheckInViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 30/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "CheckInViewController.h"
#import "CheckInSupportWebEngine.h"


@interface CheckInViewController () {
    AppDelegate *mAppDelegate_;
}
- (void)initializationOfObjectsForCheckINScreenView;
- (void)setFontsAndTextToSearchScreenView;

@end

@implementation CheckInViewController
@synthesize mCustomerAndVehicleInfoView_;
@synthesize mServicesBeingPerformedTodayView_;
@synthesize mCheckInRightView_;
@synthesize mDoneButton_;
@synthesize mISFronCheckInScreen_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark --
#pragma mark View Lifecycle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view customHeaderViewFull:self SelectedButton:@"Check-In"];
    [self initializationOfObjectsForCheckINScreenView];
    [self setFontsAndTextToSearchScreenView];
}

- (void)viewWillAppear:(BOOL)animated {
    [mAppDelegate_.mModelForNotifications_ checkTheNotifiationBadgeCount:self.view];
    [mAppDelegate_.mModelForCheckIn_ setArrayForCustomerAndVehicleInfo];
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
    }else {
        [self.mServicesBeingPerformedTodayView_ setHidden:YES];
        CGRect frame = self.mCustomerAndVehicleInfoView_.frame;
        frame.size.width = 689;
        self.mCustomerAndVehicleInfoView_.frame = frame;
    }
    [self.mCustomerAndVehicleInfoView_ setBorderForCustomerAndVehicleInfoView];
    [self.mCustomerSignatureView_ codeToHideClearButton];
    
    [self.mCustomerSignatureView_.mCustomerSignatureUIImageView_ initializationForSignatureImageView];
    [self.mCustomerAndVehicleInfoView_ setLabelsForCustomerAndVehicleInfoView];
    [self.mCheckInRightView_.mWalkAroundDetailsUITableView_ setDelegatesAndDataSourcesForWalkAroundTableView];
    [self.mCheckInRightView_.mInspectionCautionedOrFailedUITableView_ setDelegatesAndDataSourcesForInspectionCautionedOrFailedUITableView];
    
    // ----------------------------;
    // ADD LeftView to ECS_Sliding -> WalkAroundLeftSlider;
    // ----------------------------;
    [self.view addGestureRecognizer:mAppDelegate_.mECSlidingViewController_.panGesture];
    [mAppDelegate_.mECSlidingViewController_ setAnchorRightRevealAmount:340.0f];
    if (mAppDelegate_.mWalkAroundLeftViewController_ == nil) {
        WalkAroundLeftViewController *lViewControler = [[WalkAroundLeftViewController alloc] init];
        [mAppDelegate_ setMWalkAroundLeftViewController_:lViewControler];
        [mAppDelegate_.mWalkAroundLeftViewController_.view setBackgroundColor:[UIColor ASRProRGBColor:66 Green:66 Blue:68]];
    }
    if (![mAppDelegate_.mECSlidingViewController_.underLeftViewController isKindOfClass:[WalkAroundLeftViewController class]]) {
        mAppDelegate_.mECSlidingViewController_.underLeftViewController  = mAppDelegate_.mWalkAroundLeftViewController_;
    }
    //Services is not there in the Lite Version.
    
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
        float SubTotalOfServicesListedCost = [mAppDelegate_.mServiceDataGetter_.mServicesScheduledTotal floatValue] + [mAppDelegate_.mServiceDataGetter_.mRecommendedServicesTotal floatValue];
        float ShopChargesAndTaxesCost = [mAppDelegate_.mServiceDataGetter_.mShopCharges floatValue] + [mAppDelegate_.mServiceDataGetter_.mTax floatValue];
        float TotalCost = [mAppDelegate_.mServiceDataGetter_.mFinalServicesTotall floatValue];
        [self.mServicesBeingPerformedTodayView_.mServicesBeingPerformedTodayUITableView_ setDelegatesAndDataSourcesForServicesBeingPerformedTableView];
        [self.mServicesBeingPerformedTodayView_ setTextForSubTotalOfServicesListedCost:SubTotalOfServicesListedCost
                                                               ShopChargesAndTaxesCost:ShopChargesAndTaxesCost
                                                                             TotalCost:TotalCost];
    }else {
        [self.mServicesBeingPerformedTodayView_ setHidden:YES];
        CGRect frame = self.mCustomerAndVehicleInfoView_.frame;
        frame.size.width = 689;
        self.mCustomerAndVehicleInfoView_.frame = frame;
    }
}

- (void)viewDidLayoutSubviews
{
    //Services is not there in the Lite Version.
    
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
        float SubTotalOfServicesListedCost = [mAppDelegate_.mServiceDataGetter_.mServicesScheduledTotal floatValue] + [mAppDelegate_.mServiceDataGetter_.mRecommendedServicesTotal floatValue];
        float ShopChargesAndTaxesCost = [mAppDelegate_.mServiceDataGetter_.mShopCharges floatValue] + [mAppDelegate_.mServiceDataGetter_.mTax floatValue];
        float TotalCost = [mAppDelegate_.mServiceDataGetter_.mFinalServicesTotall floatValue];
        [self.mServicesBeingPerformedTodayView_.mServicesBeingPerformedTodayUITableView_ setDelegatesAndDataSourcesForServicesBeingPerformedTableView];
        [self.mServicesBeingPerformedTodayView_ setTextForSubTotalOfServicesListedCost:SubTotalOfServicesListedCost
                                                               ShopChargesAndTaxesCost:ShopChargesAndTaxesCost
                                                                             TotalCost:TotalCost];
    }else {
        [self.mServicesBeingPerformedTodayView_ setHidden:YES];
        CGRect frame = self.mCustomerAndVehicleInfoView_.frame;
        frame.size.width = 689;
        self.mCustomerAndVehicleInfoView_.frame = frame;
    }
}

- (void)displayEditCustomerPopup {
    
    EditCustomerViewController *lEditCustomerViewController = [[EditCustomerViewController alloc] initWithNibName:@"EditCustomerViewController" bundle:nil];
    [mAppDelegate_ setMEditCustomerViewController_:lEditCustomerViewController];
    
    if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        mAppDelegate_.mEditCustomerViewController_.modalPresentationStyle=UIModalPresentationFormSheet;
        mAppDelegate_.mEditCustomerViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
        mAppDelegate_.mEditCustomerViewController_.preferredContentSize = CGSizeMake(597, 523);
    }else {
        mAppDelegate_.mEditCustomerViewController_.modalPresentationStyle=UIModalPresentationPageSheet;
        mAppDelegate_.mEditCustomerViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    }
    [self presentViewController:mAppDelegate_.mEditCustomerViewController_ animated:YES completion:nil];
}

- (void)displayEditVehiclePopup {
    
    EditVehicleViewController *lEditVehicleViewController = [[EditVehicleViewController alloc] initWithNibName:@"EditVehicleViewController" bundle:nil];
    [mAppDelegate_ setMEditVehicleViewController_:lEditVehicleViewController];
    
    if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        mAppDelegate_.mEditVehicleViewController_.modalPresentationStyle=UIModalPresentationFormSheet;
        mAppDelegate_.mEditVehicleViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
        mAppDelegate_.mEditVehicleViewController_.preferredContentSize = CGSizeMake(597, 523);
    }else {
        mAppDelegate_.mEditVehicleViewController_.modalPresentationStyle=UIModalPresentationPageSheet;
        mAppDelegate_.mEditVehicleViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    }
    [self presentViewController:mAppDelegate_.mEditVehicleViewController_ animated:YES completion:nil];

}

#pragma mark --
#pragma mark Memory Management Methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark Orientations Methods
- (BOOL)shouldAutorotate // iOS 6/7 autorotation fix
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6/7 autorotation fix
{
    //	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    return UIInterfaceOrientationMaskAll;
}

#pragma mark --
#pragma mark Private Methods
- (void)initializationOfObjectsForCheckINScreenView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self.navigationController setNavigationBarHidden:YES];
    //Services is not there in the Lite Version.
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
        [self.mServicesBeingPerformedTodayView_ setBorderForServicesBeingPerformedTodayView];
        
    }else {
        
    }
    [self.mCustomerSignatureView_ setBorderForCustomerSignatureView];
    [self.mCheckInRightView_ setBorderForCheckInRightView];
    [self setDoneButton];
    self.mEstimateVerbageView_ = [[EstimateVerbageView alloc] initWithFrame:CGRectMake(self.mCustomerAndVehicleInfoView_.frame.origin.x, self.mCustomerSignatureView_.frame.origin.y, self.mCustomerSignatureView_.frame.size.width, self.mCustomerSignatureView_.frame.size.height+50)];
    [self.mEstimateVerbageView_ setBackgroundColor:[UIColor whiteColor]];
    [self.mEstimateVerbageView_ setBorderForEstimateVerbage];
    [self.view addSubview:self.mEstimateVerbageView_];
}

- (void)setFontsAndTextToSearchScreenView {
    
}

- (void)setDoneButton {
    UIButton *doneButton = [[UIButton alloc] init];
    UIImage *image = [UIImage imageNamed:@"DoneButton"];
    [doneButton setFrame:CGRectMake(508, self.mCustomerSignatureView_.frame.origin.y + self.mCustomerSignatureView_.frame.size.height + 10, image.size.width, image.size.height)];
    [doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setBackgroundColor:[UIColor ASRProGreenColor]];
    //    [doneButton setTitle:@"DONE Pint pre work order" forState:UIControlStateNormal];
    [doneButton setImage:image forState:UIControlStateNormal];
    [doneButton setImage:image forState:UIControlStateSelected];
    [self setMDoneButton_:doneButton];
    [self.view addSubview:self.mDoneButton_];
}

- (IBAction)doneButtonAction:(id)sender {
    if (self.mCustomerSignatureView_.mCustomerSignatureUIImageView_.image != nil && ![self.mCustomerSignatureView_.mSaveButton_.titleLabel.text isEqualToString:@"Saved"]) {
        [[CheckInSupportWebEngine checkInSharedInstance] postRequestForSaveCustomerSignature];
    }else if(self.mCustomerSignatureView_.mCustomerSignatureUIImageView_.image == nil) {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:@"" message:@"Signature cannot be left blank."];
        return;
    }
    self.mISFronCheckInScreen_ = ClickedDone;
    mAppDelegate_.mOnSuccessDelegate_ = self;
    [[CheckInSupportWebEngine checkInSharedInstance] putRequestForROToBeMovedToDispatchMode];
    //    [self pushToPreROEstimatePDFView];
    //    [[CheckInSupportWebEngine checkInSharedInstance] getRequestForPreROEstimatePDF];
    
}

- (void)OnsuccessResponseForRequest {
    if (![mAppDelegate_.mECSlidingViewController_.topViewController isKindOfClass:[SearchViewController class]]) {
        [mAppDelegate_.mECSlidingViewController_ setTopViewController:mAppDelegate_.mSearchViewController_];
    }
    for (UIView *lview in mAppDelegate_.mMasterViewController_.view.subviews) {
        if([lview isKindOfClass:[UIButton class]]) {
            if (lview.tag == 3) {
                [mAppDelegate_.mMasterViewController_ segmentBtnAction:(UIButton *)lview];
                mAppDelegate_.mMasterViewController_->mselectedSegment_ = 3;
            }
        }
    }
    [mAppDelegate_.mModelForVehicleHistoryTableView_ setMCurrentMode_:2];
    mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ = nil;
    [mAppDelegate_.mMasterViewController_.mOpenROTableView_ reloadData];
    [mAppDelegate_.mModelForSearchScreen_ setMDoneCheckInTOOpenROView_:DoneToOPenROMode];
    [mAppDelegate_.mMasterViewController_ postRequestToGetRepairOrders];
}

- (void)pushToPreROEstimatePDFView {
    PreROEstimatePopupViewController *lPreROEstimatePopupViewController = [[PreROEstimatePopupViewController alloc] initWithNibName:@"PreROEstimatePopupViewController" bundle:nil];
    lPreROEstimatePopupViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    lPreROEstimatePopupViewController.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lPreROEstimatePopupViewController animated:YES completion:nil];
    [mAppDelegate_ setMPreROEstimatePopupViewController_:lPreROEstimatePopupViewController];
}

-(void)pushToPDFView{
    ServicesPdfView *lServicesPdfView = [[ServicesPdfView alloc] initWithNibName:@"ServicesPdfView" bundle:nil];
    [lServicesPdfView setMTitle:@"Customer Plan"];
    [lServicesPdfView setMWebURl:mAppDelegate_.mOpenRoServiceDataGetter_.mPdfURL];
    lServicesPdfView.modalPresentationStyle=UIModalPresentationFormSheet;
    lServicesPdfView.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lServicesPdfView animated:YES completion:nil];
    [[SharedUtilities sharedUtilities] removeLoadView];
}

@end
