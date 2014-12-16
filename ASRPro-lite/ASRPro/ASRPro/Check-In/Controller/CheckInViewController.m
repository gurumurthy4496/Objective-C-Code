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
- (void)initializationOfObjectsForSearchScreenView;
- (void)setFontsAndTextToSearchScreenView;

@end

@implementation CheckInViewController
@synthesize mCustomerAndVehicleInfoView_;
@synthesize mServicesBeingPerformedTodayView_;
@synthesize mCheckInRightView_;
@synthesize mDoneButton_;

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
    [self initializationOfObjectsForSearchScreenView];
    [self setFontsAndTextToSearchScreenView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.mCustomerAndVehicleInfoView_ setLabelsForCustomerAndVehicleInfoView];
    [self.mCheckInRightView_.mWalkAroundDetailsUITableView_ setDelegatesAndDataSourcesForWalkAroundTableView];
    [self.mCheckInRightView_.mInspectionCautionedOrFailedUITableView_ setDelegatesAndDataSourcesForInspectionCautionedOrFailedUITableView];
    
    //Services is not there in the Lite Version.
    [self.mServicesBeingPerformedTodayView_ setHidden:YES];
    /*float SubTotalOfServicesListedCost = [mAppDelegate_.mServiceDataGetter_.mServicesScheduledTotal floatValue] + [mAppDelegate_.mServiceDataGetter_.mRecommendedServicesTotal floatValue];
    float ShopChargesAndTaxesCost = [mAppDelegate_.mServiceDataGetter_.mShopCharges floatValue] + [mAppDelegate_.mServiceDataGetter_.mTax floatValue];
    float TotalCost = [mAppDelegate_.mServiceDataGetter_.mFinalServicesTotall floatValue];
    [self.mServicesBeingPerformedTodayView_.mServicesBeingPerformedTodayUITableView_ setDelegatesAndDataSourcesForServicesBeingPerformedTableView];
    [self.mServicesBeingPerformedTodayView_ setTextForSubTotalOfServicesListedCost:SubTotalOfServicesListedCost
                                                           ShopChargesAndTaxesCost:ShopChargesAndTaxesCost
                                                                         TotalCost:TotalCost];*/
    
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
- (void)initializationOfObjectsForSearchScreenView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self.navigationController setNavigationBarHidden:YES];
    [self.mCustomerAndVehicleInfoView_ setBorderForCustomerAndVehicleInfoView];
    //Services is not there in the Lite Version.
//    [self.mServicesBeingPerformedTodayView_ setBorderForServicesBeingPerformedTodayView];
    [mAppDelegate_.mModelForCheckIn_ setArrayForCustomerAndVehicleInfo];
    [self.mCustomerSignatureView_ setBorderForCustomerSignatureView];
    [self.mCheckInRightView_ setBorderForCheckInRightView];
    [self setDoneButton];
}

- (void)setFontsAndTextToSearchScreenView {
    
}   

- (void)setDoneButton {
    UIButton *doneButton = [[UIButton alloc] init];
    UIImage *image = [UIImage imageNamed:@"DoneButton"];
    [doneButton setFrame:CGRectMake(510, self.mCustomerSignatureView_.frame.origin.y + self.mCustomerSignatureView_.frame.size.height + 10, image.size.width, image.size.height)];
    [doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setBackgroundColor:[UIColor ASRProGreenColor]];
//    [doneButton setTitle:@"DONE Pint pre work order" forState:UIControlStateNormal];
    [doneButton setImage:image forState:UIControlStateNormal];
    [doneButton setImage:image forState:UIControlStateSelected];
    [self setMDoneButton_:doneButton];
    [self.view addSubview:self.mDoneButton_];
}

- (IBAction)doneButtonAction:(id)sender {
    mAppDelegate_.mOnSuccessDelegate_ = self;
    [[CheckInSupportWebEngine checkInSharedInstance] putRequestForROToBeMovedToDispatchMode];
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
    mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ = nil;
    [mAppDelegate_.mMasterViewController_.mOpenROTableView_ reloadData];
    [mAppDelegate_.mModelForSearchScreen_ setMDoneCheckInTOOpenROView_:DoneToOPenROMode];
    [mAppDelegate_.mMasterViewController_ postRequestToGetRepairOrders];
}

@end
