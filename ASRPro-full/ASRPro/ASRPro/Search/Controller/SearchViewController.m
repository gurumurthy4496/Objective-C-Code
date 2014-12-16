//
//  SearchViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 28/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "SearchViewController.h"
#import "PrintEmailPopupViewViewController.h"
#import "ServicesPdfView.h"
#import "VehicleHistorySupportWebEngine.h"

@interface SearchViewController () {
    AppDelegate *mAppDelegate_;
}

- (void)initializationOfObjectsForSearchScreenView;
- (void)setFontsAndTextToSearchScreenView;

@end

@implementation SearchViewController
@synthesize mOpenROServicesTableViewController_;
@synthesize mSearchCategory_;
@synthesize mAllWorkDone_;
@synthesize mContinueBtn_;
@synthesize mCustomerInfoTitleLbl_;
@synthesize mCustomerInfoView_;
@synthesize mEditCustomerBtn_;
@synthesize mEditVehicleBtn_;
@synthesize mGetPartsandLabour_;
@synthesize mGoToInspectionFormButton_;
@synthesize mPrintEmail_;
@synthesize mVehicleHistoryLbl_;
@synthesize mVehicleInfoView_;
@synthesize mVehicleInfoTitleLbl_;
@synthesize mSendToNextMode_;
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
    [self.view customHeaderViewFull:self SelectedButton:@"Search"];
    [self initializationOfObjectsForSearchScreenView];
    [self setFontsAndTextToSearchScreenView];
}

- (void)viewWillAppear:(BOOL)animated {
    [mAppDelegate_.mModelForNotifications_ checkTheNotifiationBadgeCount:self.view];
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
//	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    return UIInterfaceOrientationMaskAll;
}

#pragma mark --
#pragma mark Private Methods
- (void)initializationOfObjectsForSearchScreenView {
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    _mVehicleHistory_.mSearchViewController_ = self;
    _mVehicleHistory_->mAppDelegate_= mAppDelegate_;
    [_mVehicleHistory_ initData];
    [_mVehicleHistory_ setDelegatesVehicleHistoryTableview_];
    [self.navigationController setNavigationBarHidden:YES];
    [self setBorderColor];
    [self setMasterViewToHomeScreen];
    [self setLabelsForCustomerInfoView];
    [self setLabelsForVehicleInfoView];
    [self setSearchCustomerInfoView];
    [self setSearchVehicleInfoView];
    [self initOpenROservicesView];
}

- (void)setFontsAndTextToSearchScreenView {
    
    [self.mCustomerInfoTitleLbl_ setText:NSLocalizedString(@"Customer_Information", nil)];
    [self.mCustomerInfoTitleLbl_ setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [self.mVehicleInfoTitleLbl_ setText:NSLocalizedString(@"Vehicle_Information", nil)];
    [self.mVehicleInfoTitleLbl_ setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [self.ROHistoryTitleLbl_ setText:NSLocalizedString(@"Vehicle_History", nil)];
    [self.ROHistoryTitleLbl_ setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    
    
    
}

- (void)setBorderColor {
    
    for(UIView *lView in self.view.subviews) {
        
        if ([lView isKindOfClass:[UIView class]]) {
            if (lView.tag == 100 || lView.tag == 200 || lView.tag == 300) {
                [lView.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
                [lView.layer setBorderWidth:2.0];
            }
            for(UIView *pView in lView.subviews) {
                if (pView.tag == 20 || pView.tag == 30 || pView.tag == 40) {
                    [pView setBackgroundColor:[UIColor ASRProBlueColor]];
                }
            }
        }
    }
}
- (void)setMasterViewToHomeScreen {
    
    MasterViewController *lMasterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    [mAppDelegate_ setMMasterViewController_:lMasterViewController];
    [mAppDelegate_.mMasterViewController_.view setFrame:CGRectMake(0, 83, 302, 684)];
//    [mAppDelegate_.mMasterViewController_.mOpenROFilterButton_ setHidden:YES];
    [self.view addSubview:mAppDelegate_.mMasterViewController_.view];
}

- (void)setLabelsForCustomerInfoView {
    CGFloat xPos = 15.0, yPos = 65; int lblTag = 50;
    CGFloat XPos = 130.0, YPos = 90;
    NSArray *lCustomerInfoArray = [[NSArray alloc] initWithObjects:@"Home",@"Work",@"Mobile",@"Email",@"Customer No",@"Address", nil];
    for (int i=0; i<7; i++) {
        
        UILabel *lCustomerInfoLbl = [[UILabel alloc] init];
        lCustomerInfoLbl.tag = i+1;
        lCustomerInfoLbl.font = [UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey];
        [lCustomerInfoLbl setTextColor:[UIColor colorWithRed:26/255.0 green:24/255.0 blue:24/255.0 alpha:1.0]];
        if (i==0) {
            lCustomerInfoLbl.frame = CGRectMake(xPos, yPos-10, 300, 18);
            lCustomerInfoLbl.text = @"";
        }else {
            lCustomerInfoLbl.frame = CGRectMake(xPos, yPos, 110, 18);
            lCustomerInfoLbl.text = [lCustomerInfoArray objectAtIndex:i-1];
        }
        yPos += 24;
        [self.mCustomerInfoView_ addSubview:lCustomerInfoLbl];
        UILabel *lCustomerDetailLbl = [[UILabel alloc] init];
        lCustomerDetailLbl.frame = CGRectMake(XPos, YPos, 200, 18);
        lCustomerDetailLbl.font = [UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey];
        [lCustomerDetailLbl setTextColor:[UIColor colorWithRed:26/255.0 green:24/255.0 blue:24/255.0 alpha:1.0]];
        lCustomerDetailLbl.text = @"";
        lCustomerDetailLbl.tag = lblTag + i;
        [self.mCustomerInfoView_ addSubview:lCustomerDetailLbl];
        YPos += 24;
        
    }
}

- (void)setLabelsForVehicleInfoView {
    
    CGFloat xPos = 13.0, yPos = 68; int lblTag = 50;
    CGFloat XPos = 165.0, YPos = 68;
    NSArray *lCustomerInfoArray = [[NSArray alloc] initWithObjects:@"VIN",@"Year",@"Make",@"Model",@"License",@"Mileage",@"Color", nil];
    for (int i=0; i<[lCustomerInfoArray count]; i++) {
        
        UILabel *lCustomerInfoLbl = [[UILabel alloc] init];
        lCustomerInfoLbl.tag = i+1;
        lCustomerInfoLbl.font = [UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey];
        [lCustomerInfoLbl setTextColor:[UIColor colorWithRed:26/255.0 green:24/255.0 blue:24/255.0 alpha:1.0]];
        lCustomerInfoLbl.frame = CGRectMake(xPos, yPos, 160, 18);
        lCustomerInfoLbl.text = [lCustomerInfoArray objectAtIndex:i];
        yPos += 24;
        [self.mVehicleInfoView_ addSubview:lCustomerInfoLbl];
        UILabel *lCustomerDetailLbl = [[UILabel alloc] init];
        lCustomerDetailLbl.frame = CGRectMake(XPos, YPos, 170, 18);
        lCustomerDetailLbl.font = [UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey];
        [lCustomerDetailLbl setTextColor:[UIColor colorWithRed:26/255.0 green:24/255.0 blue:24/255.0 alpha:1.0]];
        lCustomerDetailLbl.text = @"";
        lCustomerDetailLbl.tag = lblTag + i;
        [self.mVehicleInfoView_ addSubview:lCustomerDetailLbl];
        YPos += 24;
        
    }
}

- (void)reloadVehicleHistory {
    [self.mVehicleHistory_ setHidden:FALSE];
    [self.mVehicleHistory_ reloadData];
    if (mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ == ShowVehicleHistoryPopUpFromAppointments) {
        DLog(@"%@",mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_);
        mAppDelegate_.mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ = [mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ mutableCopy];
        id object = [mAppDelegate_.mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ valueForKey:@"Status"];
        
        if (![object isKindOfClass:[NSArray class]]) {
            
            [self errorResponseForVehicleHistory];
            
        }else {
            
            [[mAppDelegate_ mVehicleHistoryViewController_] initDataInTableView];
        }
        if ([mAppDelegate_.mECSlidingViewController_.topViewController isKindOfClass:[SearchViewController class]]) {
            [[mAppDelegate_ mModelForWalkAround_] setTempararyPRERONumber:[[mAppDelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:mAppDelegate_.mMasterViewController_.mselectedInprocessindex_] objectForKey:@"RONumber"]];
            [self.view getRODetails];
        }
        
    }
}

- (void)reloadVehicleHistoryWhenFailed {
    if (mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ == ShowVehicleHistoryPopUpFromAppointments) {
        DLog(@"%@",mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_);
        mAppDelegate_.mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ = [mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ mutableCopy];
        id object = [mAppDelegate_.mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ valueForKey:@"Status"];
        
        if (![object isKindOfClass:[NSArray class]]) {
            
            [self errorResponseForVehicleHistory];
            
        }else {
            
            [[mAppDelegate_ mVehicleHistoryViewController_] initDataInTableView];
        }
        if ([mAppDelegate_.mECSlidingViewController_.topViewController isKindOfClass:[SearchViewController class]]) {
            [[mAppDelegate_ mModelForWalkAround_] setTempararyPRERONumber:[[mAppDelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:mAppDelegate_.mMasterViewController_.mselectedInprocessindex_] objectForKey:@"RONumber"]];
            [self.view getRODetails];
        }
        
    }

}

#pragma mark --
#pragma mark Private Methods

// ----------------------------;
// Below method is called when we get error response from server for Vehicle History -> Fill the mVehicleHistoryArray_ array with dummy data;
// ----------------------------;
- (void)errorResponseForVehicleHistory {
    
    NSMutableDictionary *lTempDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"lNoVehicleHistoryFound", Nil),@"RONumber",@"",@"DMSClosedDate", nil];
    
    NSMutableArray *lTempArray = [[NSMutableArray alloc] initWithObjects:lTempDictionary, nil];
    
    mAppDelegate_.mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ = lTempArray;
    
    RELEASE_NIL(lTempArray);
    
    [[mAppDelegate_ mVehicleHistoryViewController_] initDataInTableView];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                 *** This method is used enable the vehicle edit only when any vehicle is selected ***..
//--------------------------------------------------- ************** ------------------------------------------------------
- (void)enableOrdisableEditCustomerOrVehiclebtn {
    mAppDelegate_.mViewReference_ = self;
    if(!mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_.hidden) {
        
//            [self.mEditCustomerBtn_ setSelected:((mAppDelegate_.mMasterViewController_->mselectedSegment_==1)&&[mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ isEqualToString:@"00000000000000000000000000000000"])?YES:NO];
//            [self.mEditVehicleBtn_ setSelected:((mAppDelegate_.mMasterViewController_->mselectedSegment_==1)&&[mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_ isEqualToString:@"00000000000000000000000000000000"])?YES:NO];
        [self.mEditCustomerBtn_ setSelected:NO];
        [self.mEditVehicleBtn_ setSelected:NO];
        if (mAppDelegate_.mMasterViewController_->mselectedSegment_ == 1) {
            self.mEditCustomerBtn_.enabled=NO;
            self.mEditVehicleBtn_.enabled=([mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ indexPathForSelectedRow] && ![mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_ isEqualToString:@"00000000000000000000000000000000"])?YES:NO;
        }else {
            self.mEditCustomerBtn_.enabled=([mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ indexPathForSelectedRow])?YES:NO;
            self.mEditVehicleBtn_.enabled=([mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ indexPathForSelectedRow])?YES:NO;
        }
    }else {
        self.mEditCustomerBtn_.enabled=([mAppDelegate_.mMasterViewController_.mOpenROTableView_ indexPathForSelectedRow])?YES:NO;
        if ([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"]) {
            if ([mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ count]>0) {
                
            if(!([[[mAppDelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:mAppDelegate_.mMasterViewController_.mOpenROTableView_.mselectedCustomerindex_] objectForKey:@"CurrentMode"] intValue] == 2))
                self.mEditVehicleBtn_.enabled=([mAppDelegate_.mMasterViewController_.mOpenROTableView_ indexPathForSelectedRow])?YES:NO;
            else
                self.mEditVehicleBtn_.enabled = NO;
            }
        }else
            self.mEditVehicleBtn_.enabled=([mAppDelegate_.mMasterViewController_.mOpenROTableView_ indexPathForSelectedRow])?YES:NO;
        [self.mEditCustomerBtn_ setSelected:NO];
        [self.mEditVehicleBtn_ setSelected:NO];
    }
}

- (void)setCustomerInfomationLabelsTextFromModel {
    DLog(@" subview count %d",[self.mCustomerInfoView_.subviews count]);
    [self.mCustomerInfoView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UILabel *lView = (UILabel *)object;
        if ([lView isKindOfClass:[UILabel class]]) {
            if(lView.tag==1) {
                [((UILabel*)lView) setText:[mAppDelegate_.mMasterViewController_ returnString1:nil salutaion:mAppDelegate_.mModelForEditCustomerScreen_.mSalutation_ firstName:mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_ middleName:mAppDelegate_.mModelForEditCustomerScreen_.mMiddleName_ lastName:mAppDelegate_.mModelForEditCustomerScreen_.mLastName_] ];
            }
            else if(lView.tag==50) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditCustomerScreen_.mHomePhone_] ];
            }
            else if(lView.tag==51) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditCustomerScreen_.mWorkPhone_]];
            }
            else if(lView.tag==52) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditCustomerScreen_.mMobilePhone_] ];
            }
            else if(lView.tag==53) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditCustomerScreen_.mEmail_] ];
            }
            else if(lView.tag==54) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditCustomerScreen_.mCustomerNumber_] ];
            }
            else if(lView.tag==55) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditCustomerScreen_.mAddress1_] ];
            }
            else if(lView.tag==56) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditCustomerScreen_.mAddress2_] ];
            }
            
        }
    }];
}

-(void)setVehicleInfomationLabelsTextFromModel{

    for (UIView *lView in self.mVehicleInfoView_.subviews) {
        if ([lView isKindOfClass:[UILabel class]]) {
            if(lView.tag==50){
                [ ((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditVehicleScreen_.mVIN_]]; }
            if(lView.tag==51){
                [ ((UILabel*)lView) setText: [NSString stringWithFormat:@" %@",mAppDelegate_.mModelForEditVehicleScreen_.mYear_] ]; }
            if(lView.tag==52){
                [ ((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditVehicleScreen_.mMake_ ]]; }
            if(lView.tag==53){
                [ ((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", mAppDelegate_.mModelForEditVehicleScreen_.mModel_ ]]; }
            if(lView.tag==54){
                [ ((UILabel*)lView) setText: [NSString stringWithFormat:@" %@",mAppDelegate_.mModelForEditVehicleScreen_.mRegistrationNo_ ]]; }
            if(lView.tag==55){
                [ ((UILabel*)lView) setText: [NSString stringWithFormat:@" %@",mAppDelegate_.mModelForEditVehicleScreen_.mMileage_ ]]; }
            if(lView.tag==56){
                [ ((UILabel*)lView) setText: [NSString stringWithFormat:@" %@",mAppDelegate_.mModelForEditVehicleScreen_.mColor_!=nil?mAppDelegate_.mModelForEditVehicleScreen_.mColor_:@""]]; }
        }
    }
}

- (void)setSearchCustomerInfoView {

    SearchCustomerInfoView *lSearchCustomerInfoView = [[SearchCustomerInfoView alloc] initWithNibName:@"SearchCustomerInfoView" bundle:nil];
    [mAppDelegate_ setMSearchCustomerInfoView_:lSearchCustomerInfoView];
    [mAppDelegate_.mSearchCustomerInfoView_.view setFrame:CGRectMake(314, 83, mAppDelegate_.mSearchCustomerInfoView_.view.frame.size.width, mAppDelegate_.mSearchCustomerInfoView_.view.frame.size.height)];
    [self.view addSubview:mAppDelegate_.mSearchCustomerInfoView_.view];
}

- (void)setSearchVehicleInfoView {
    
    SearchVehicleInfoView *lSearchVehicleInfoView = [[SearchVehicleInfoView alloc] initWithNibName:@"SearchVehicleInfoView" bundle:nil];
    [mAppDelegate_ setMSearchVehicleInfoView_:lSearchVehicleInfoView];
    [mAppDelegate_.mSearchVehicleInfoView_.view setFrame:CGRectMake(314, mAppDelegate_.mSearchCustomerInfoView_.view.frame.size.height+100, mAppDelegate_.mSearchVehicleInfoView_.view.frame.size.width, mAppDelegate_.mSearchVehicleInfoView_.view.frame.size.height)];
    [self.view addSubview:mAppDelegate_.mSearchVehicleInfoView_.view];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                          *** this method is called on the succes of the checkin customer for appointment***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)onSuccesofCheckin {
    
        // particular appointment moves to inprocess
        for (UIView *btnview in mAppDelegate_.mMasterViewController_.view.subviews)  {
            if([btnview isKindOfClass:[UIButton class]]) {
                if(btnview.tag==2){
                    [(UIButton *)btnview setSelected:YES];
                    [(UIButton *)btnview setBackgroundColor:[UIColor ASRProBlueColor]];
                    ((UIButton *)btnview).titleLabel.textColor = [UIColor whiteColor];
                    mAppDelegate_.mMasterViewController_->mselectedSegment_ = 2;
                    [mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ reloadData];
                }
                else {
                    [(UIButton *)btnview setSelected:NO];
                    [(UIButton *)btnview setBackgroundColor:[UIColor whiteColor]];
                }
            }
        }
    mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ = ShowVehicleHistoryPopUpFromAppointments;
        self.mContinueBtn_.hidden=YES;
    [mAppDelegate_.mMasterViewController_.mBeginVehicleCheckInBtn_ setEnabled:YES];
  [mAppDelegate_.mMasterViewController_.mBarCodeBtn_ setHidden:FALSE];
        self.isCheckIn = YES;
        mAppDelegate_.mBeginVehicleCheckInView_.isAnyCustomerSelected = FALSE;
    mAppDelegate_.mBeginVehicleCheckInView_.isAnyApponimentSelected = FALSE;
    mAppDelegate_.mMasterViewController_->isAppointmentSelected = FALSE;
    mAppDelegate_.mModelForSearchScreen_.mMileage = @"";
    mAppDelegate_.mModelForSearchScreen_.mTag_ = @"";
    if ([[[SearchSupportWebEngine sharedInstance] mCustomersArray] count] !=0) {
        [[[SearchSupportWebEngine sharedInstance] mCustomersArray] removeAllObjects];
    }
    mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = FALSE;
        mAppDelegate_.mWalkAroundViewController_ = nil;
        [[SearchSupportWebEngine sharedInstance] threadRequestToGetRepairOrders];
    mAppDelegate_.mSearchViewController_.isFromInProcess = TRUE;
    
    if ([mAppDelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"FULL"]) {
        [[SearchSupportWebEngine sharedInstance] threadRequestToGetAppointmentsForPullToRefresh];
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
        if (mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_) {
            [mAppDelegate_.mBeginVehicleCheckInView_ presentViewController:mAppDelegate_.mEditCustomerViewController_ animated:YES completion:nil];
        }else {
            [self presentViewController:mAppDelegate_.mEditCustomerViewController_ animated:YES completion:nil];
        }
    }else {
        mAppDelegate_.mEditCustomerViewController_.modalPresentationStyle=UIModalPresentationPageSheet;
        mAppDelegate_.mEditCustomerViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
        [self presentViewController:mAppDelegate_.mEditCustomerViewController_ animated:YES completion:nil];
    }
}

- (void)displayEditVehiclePopup {
    
    EditVehicleViewController *lEditVehicleViewController = [[EditVehicleViewController alloc] initWithNibName:@"EditVehicleViewController" bundle:nil];
    [mAppDelegate_ setMEditVehicleViewController_:lEditVehicleViewController];
   
    if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        mAppDelegate_.mEditVehicleViewController_.modalPresentationStyle=UIModalPresentationFormSheet;
        mAppDelegate_.mEditVehicleViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
        mAppDelegate_.mEditVehicleViewController_.preferredContentSize = CGSizeMake(597, 523);
        if (mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_) {
            [mAppDelegate_.mBeginVehicleCheckInView_ presentViewController:mAppDelegate_.mEditVehicleViewController_ animated:YES completion:nil];
        }else {
            [self presentViewController:mAppDelegate_.mEditVehicleViewController_ animated:YES completion:nil];
        }
    }else {
        mAppDelegate_.mEditVehicleViewController_.modalPresentationStyle=UIModalPresentationPageSheet;
        mAppDelegate_.mEditVehicleViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
        [self presentViewController:mAppDelegate_.mEditVehicleViewController_ animated:YES completion:nil];
    }
}

-(void)initOpenROservicesView{
    OpenROServicesTableViewController* lOpenROServicesTableViewController_=[[OpenROServicesTableViewController alloc] initWithNibName:@"OpenROServicesTableViewController" bundle:nil];
    [lOpenROServicesTableViewController_.view setFrame:CGRectMake(314, 378, 691, 300)];
    [self setMOpenROServicesTableViewController_:lOpenROServicesTableViewController_];
    [self.view addSubview:self.mOpenROServicesTableViewController_.view];
    [self.mOpenROServicesTableViewController_.view setHidden:TRUE];
    [[GenericFiles genericFiles] createUIButtonInstance:self.mAllWorkDone_ buttonTitle:@"All Work Done" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(6.0/255.0) green:(160.0/255.0) blue:(74.0/255.0) alpha:1.0]]];
    [[GenericFiles genericFiles] createUIButtonInstance:self.mSendToNextMode_ buttonTitle:@"Send to Next Mode" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(231.0/255.0) green:(126.0/255.0) blue:(34.0/255.0) alpha:1.0]]];

    [self.mSendToNextMode_.titleLabel setNumberOfLines:0];
    [self.mSendToNextMode_.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.mGoToInspectionFormButton_.titleLabel setNumberOfLines:0];
    [self.mGoToInspectionFormButton_.titleLabel setTextAlignment:NSTextAlignmentCenter];
    isFinishInspectionCompleted=FALSE;
    if(mAppDelegate_.mMasterViewController_->mselectedSegment_==3)
        [self showServicesScreen];
}
#pragma mark --
#pragma mark Button Actions

- (IBAction)customerEditBtnAction:(id)sender {
    mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = FALSE;
    [self displayEditCustomerPopup];
}

- (IBAction)vehicleEditBtnAction:(id)sender {
    mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = FALSE;
    mAppDelegate_.mViewReference_ = self;
    [self displayEditVehiclePopup];
}

- (IBAction)continueBtnAction:(id)sender {
  /*  BeginVehicleCheckInViewViewController *lBeginVehicleCheckInView = [[BeginVehicleCheckInViewViewController alloc] initWithNibName:@"BeginVehicleCheckInViewViewController" bundle:nil];
    [mAppDelegate_ setMBeginVehicleCheckInView_:lBeginVehicleCheckInView];
    mAppDelegate_.mBeginVehicleCheckInView_.modalPresentationStyle=UIModalPresentationPageSheet;
    mAppDelegate_.mBeginVehicleCheckInView_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:mAppDelegate_.mBeginVehicleCheckInView_ animated:YES completion:nil];*/
}


- (IBAction)PrintEmailBtnAction:(id)sender {
    PrintEmailPopupViewViewController *lPrintEmailPopupViewViewController = [[PrintEmailPopupViewViewController alloc] initWithNibName:@"PrintEmailPopupViewViewController" bundle:nil];
    [mAppDelegate_ setMPrintEmailPopupViewViewController_:lPrintEmailPopupViewViewController];
    mAppDelegate_.mPrintEmailPopupViewViewController_.modalPresentationStyle=UIModalPresentationFormSheet;
    mAppDelegate_.mPrintEmailPopupViewViewController_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:mAppDelegate_.mPrintEmailPopupViewViewController_ animated:YES completion:nil];

}

- (IBAction)GetPartsLaborBtnAction:(id)sender {
    mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mLocationArray_=[[FileUtils fileUtils] loadArrayFromFile:kPARTSLOCATIONSPATH];
    if(mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mLocationArray_==nil){
        [mAppDelegate_.mModelForPartsSupportEngine_ RequestFoGetLocations];
    }

    if(mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_!=nil){
    [mAppDelegate_.mModelForPartsSupportEngine_ setMGetPartsReference_:OPENROPARTSVIEWCONTROLLER];
    [mAppDelegate_.mModelForPartsSupportEngine_ requestToGetParts:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
    }
  }

- (IBAction)goToInspectionFormBtnAction:(id)sender {
    if(mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ !=nil){
        mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_=[[FileUtils fileUtils] loadDictionaryFromFileFolder:kINSPECTIONFORMSFOLDERPATH Path:[NSString stringWithFormat:@"%@-%@",kINPECTIONFORMNAMEPATH,mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormID_]];
        if( mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_==nil){
            mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference=FINISHINSPECTION;
            [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForLoadingROInspectionForm:mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormID_];
        }
        else{
            mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference=FINISHINSPECTION;
            [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForInspectionItems:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
        }
    }
}

- (IBAction)sendToNextModeBtnAction:(id)sender {
    if(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_== 4)
       {
           if(([self isAllServicesDeclined]&&[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ count]>0&&[self areAllCurrentServicesDone])||([self isAllServicesApproved]&&[self areAllRecommendedServicesDone]&&[self areAllCurrentServicesDone])){
               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Do you want to send RO# %@ to Review ",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
               alertView.tag=7;
               //  alert.delegate = self;
               [alertView show];
          }  else{
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Do you want to send RO# %@ to Repair ",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
              alertView.tag=6;
              //  alert.delegate = self;
              [alertView show];
           }

      }
    else if([self isAllServicesApproved]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Do you want to send RO# %@ to Review ",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alertView.tag=7;
        //  alert.delegate = self;
        [alertView show];

    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Do you want to send RO# %@ to Approval ",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alertView.tag=4;
        //  alert.delegate = self;
        [alertView show];

    }

}



- (IBAction)allWorkDoneBtnAction:(id)sender {
    [self showAlertView];
}

- (void)showAlertView {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"Is All Work Completed for RO# %@ ",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_] delegate:self cancelButtonTitle:@"Not Yet" otherButtonTitles:@"Yes", nil];
    alertView.tag=1;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if(alertView.tag==1)
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForCompleteAllServiceLines:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
        else
            [self sendROToRepairorReview:alertView.tag];
    }else {
    }
}



-(void)pushToPartsLabour{
    PartsLabourMainViewController *lPartsLabourMainViewController = [[PartsLabourMainViewController alloc] initWithNibName:@"PartsLabourMainViewController" bundle:nil];
    [mAppDelegate_.mPartLabourDataGetter_ setMRONumber_:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
    [mAppDelegate_.mPartLabourDataGetter_ setMPartsLabourMainViewController_:lPartsLabourMainViewController];
    [mAppDelegate_.mPartLabourDataGetter_ setMAddedPartsArray_:[mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_  mutableCopy]];
    [self.view addSubview:mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_.view];
  [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_ initTheViews];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0];
    [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_.view setFrame:CGRectMake(0, -768, 1024, 768)];
    [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_.view setFrame:CGRectMake(0, 0, 1024, 768)];
    [UIView commitAnimations];
}


-(void)pushToFinishServicesViewController{
    FinishInspectionViewController *lViewController = [[FinishInspectionViewController alloc] initWithNibName:@"FinishInspectionViewController" bundle:nil];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mFinishInspectionViewController_ = lViewController;
    [mAppDelegate_.mECSlidingViewController_ setTopViewController:mAppDelegate_.mFinishInspectionViewController_];
}

-(void)showServicesScreen{
  [self.mOpenROServicesTableViewController_.view setHidden:FALSE];
    [self.mVehicleHistoryView_ setHidden:TRUE];
  [self.mPrintEmail_ setHidden:FALSE];
   [self.mGetPartsandLabour_ setHidden:FALSE];
[self.mGoToInspectionFormButton_ setHidden:FALSE];
[self.mAllWorkDone_ setHidden:FALSE];
   // [self.mSendToNextMode_ setHidden:FALSE];

    [self hideallview:TRUE];
    //[self setButtonState];
}

-(void)pushToPDFView{
    ServicesPdfView *lServicesPdfView = [[ServicesPdfView alloc] initWithNibName:@"ServicesPdfView" bundle:nil];
    [lServicesPdfView setMTitle:mAppDelegate_.mOpenRoServiceDataGetter_.mPdfTitle];
    [lServicesPdfView setMWebURl:mAppDelegate_.mOpenRoServiceDataGetter_.mPdfURL];
    lServicesPdfView.modalPresentationStyle=UIModalPresentationFormSheet;
    lServicesPdfView.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lServicesPdfView animated:YES completion:nil];
//    [[SharedUtilities sharedUtilities] removeLoadView];
}
-(void)hideallview:(BOOL)isValue{
//    [mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_ removeAllObjects];
//    [mAppDelegate_.mOpenRoServiceDataGetter_ filterLines:mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_];
 [self.mOpenROServicesTableViewController_.view setHidden:isValue];
    [self.mPrintEmail_ setHidden:isValue];
    [self.mGetPartsandLabour_ setHidden:isValue];
    [self.mGoToInspectionFormButton_ setHidden:isValue];
    [self.mAllWorkDone_ setHidden:isValue];
   [self.mSendToNextMode_ setHidden:isValue];
 
}

-(void)setcurrentRO:(BOOL)isDispatch{
    [self hideallview:isDispatch];
    if(isDispatch)
        [[VehicleHistorySupportWebEngine sharedInstance] getRequestForVehicleHistory];

    else {
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] enableOrdisableEditCustomerOrVehiclebtn];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] setVehicleInfomationLabelsTextFromModel];
    }
}

-(void)showVehicleHistoryScreen{
    [self.mOpenROServicesTableViewController_.view setHidden:TRUE];
    [self.mVehicleHistoryView_ setHidden:FALSE];
    [self.mPrintEmail_ setHidden:TRUE];
    [self.mGetPartsandLabour_ setHidden:TRUE];
    [self.mGoToInspectionFormButton_ setHidden:TRUE];
  [self.mAllWorkDone_ setHidden:TRUE];
 //   [self.mSendToNextMode_ setHidden:TRUE];

    [mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ removeAllObjects];
    [mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_ removeAllObjects];
 
    [mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ removeAllObjects];
    [self.mOpenROServicesTableViewController_.tableView reloadData];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    int height=self.mOpenROServicesTableViewController_.tableView.contentSize.height;
    CGRect frame = self.mOpenROServicesTableViewController_.tableView.frame;
    frame.size.height = (height>300)?300:height;
    
    self.mOpenROServicesTableViewController_.tableView.frame = frame;
    [self  setButtonState];
    [self showAlertViewForInspection];
    if(([mAppDelegate_.mOpenRoServiceDataGetter_.mPartStatusID_ intValue]==4)&&(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==4)&&(([[NSString stringWithFormat:@"%@",[[mAppDelegate_ mModelForVehicleHistory_].mRODetailsArray_ objectForKey:@"AdvisorID"]] integerValue]==[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue])||([[NSString stringWithFormat:@"%@",[[mAppDelegate_ mModelForVehicleHistory_].mRODetailsArray_ objectForKey:@"TechnicianID"]] integerValue]==[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue]))){
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestToChangePartsStatus:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ PartStatusID:@"5"];
    }
    
    if((mAppDelegate_.mMasterViewController_->mselectedSegment_==3)&&[mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"]&&mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_!=nil&&![mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ isEqualToString:@""]){
    [self setcurrentRO:NO];
        [self setButtonState];

    }
    else     if((mAppDelegate_.mMasterViewController_->mselectedSegment_==3)&&[mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Advisor"]&&(mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_!=nil)){
        [self hideallview:FALSE];
        [self setButtonState];
    }
}


-(void)setButtonState{
    [mAllWorkDone_ setEnabled:((([mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ count]>0)||[self isSingleServiceApproved])&&(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_!=2)&&(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_!=7))?TRUE:FALSE];
    [self.mSendToNextMode_ setHidden:((([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_  isEqualToString:@"Advisor"]&&(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_<4))|| (mAppDelegate_.mMasterViewController_->mselectedSegment_!=3))||([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_  isEqualToString:@"Technician"]&&(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_<5)))?TRUE:FALSE];
 
[mSendToNextMode_ setEnabled:(([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_  isEqualToString:@"Advisor"] && (((mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==4) && [self isSingleServiceApproved]) || ((mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==6) && [self isAllWorkDone])) ) || ([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_  isEqualToString:@"Technician"] && ((mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==6) && ([self isAllWorkDone]||(![self isAllServicesApproved])))) || ([mAppDelegate_.mModelForSplashScreen_.mEmployeeType_  isEqualToString:@"Manager"] && (((mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==4) && [self isSingleServiceApproved]) || ((mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==6) && [self isAllWorkDone])) )) ?TRUE:FALSE];
    
    }

-(BOOL)isSingleServiceApproved{
    for(int i=0;i<[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ count];i++){
        if(([[[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:i] objectForKey:@"Approved"] boolValue]==TRUE)||([[[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:i] objectForKey:@"Declined"] boolValue]==TRUE))
            return TRUE;
    }
    return FALSE;
    
}

-(BOOL)isAllServicesDeclined{
    for(int i=0;i<[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ count];i++){
        if([[[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:i] objectForKey:@"Declined"] boolValue]==FALSE)
            return FALSE;
    }
    return TRUE;
    
}
-(BOOL)isAllServicesApproved{
    for(int i=0;i<[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ count];i++){
        if(([[[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:i] objectForKey:@"Approved"] boolValue]==FALSE)&&([[[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:i] objectForKey:@"Declined"] boolValue]==FALSE))
            return FALSE;
    }
    return TRUE;
}

-(BOOL)areAllCurrentServicesDone{
    for(int i=0;i<[mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ count];i++){
        if([[[mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ objectAtIndex:i] objectForKey:@"Completed"] boolValue]==FALSE)
            return FALSE;
    }
    return TRUE;
}

-(BOOL)areAllRecommendedServicesDone{
    for(int i=0;i<[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ count];i++){
        if(([[[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:i] objectForKey:@"Completed"] boolValue]==FALSE)&&([[[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:i] objectForKey:@"Declined"] boolValue]==FALSE))
            return FALSE;
    }
    return TRUE;
}

-(void)sendROToRepairorReview:(int)tag{
    if(tag==7){
        [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestToChangeMode:@"7"];
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:[NSString stringWithFormat:@"RO# %@ has been sent for Review",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_]];
    }
    else if(tag==4){
        [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestToChangeMode:@"4"];
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:[NSString stringWithFormat:@"RO# %@ has been sent for Approval",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_]];
    }else if(tag==6){
        [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestToChangeMode:@"6"];
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:[NSString stringWithFormat:@"RO# %@ has been sent for Repair",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_]];
    }
}

-(void)showAlertViewForInspection{
    if(isFinishInspectionCompleted){
if([[mAppDelegate_.mOpenROInspectionDataGetter_.mCompleteInspectionDetailsDict_ objectForKey:@"CurrentMode"] intValue] == 4){
    [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message: [NSString stringWithFormat:@"RO# %@ has been sent for Approval",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_]];
    
}
else  if([[mAppDelegate_.mOpenROInspectionDataGetter_.mCompleteInspectionDetailsDict_ objectForKey:@"CurrentMode"] intValue] == 6){
    [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:[NSString stringWithFormat:@"RO# %@ has been sent for Repair",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_]];
}
else{
    if([[mAppDelegate_.mOpenROInspectionDataGetter_.mCompleteInspectionDetailsDict_ objectForKey:@"CurrentMode"] intValue] == 7) {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:[NSString stringWithFormat:@"RO# %@ has been sent for Review",mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_]];
    }
}
        isFinishInspectionCompleted=FALSE;
}
}

-(BOOL)isAllWorkDone{
    for(int i=0;i<[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ count];i++){
        if(([[[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:i] objectForKey:@"Completed"] boolValue]==FALSE)&&([[[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:i] objectForKey:KDECLINED] boolValue]==FALSE))
            return FALSE;
    }
    for(int i=0;i<[mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ count];i++){
        if([[[mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ objectAtIndex:i] objectForKey:@"Completed"] boolValue]==FALSE)
            return FALSE;
    }

    return TRUE;
}

#pragma mark --
#pragma mark pushToPreROEstimatePDFView

- (void)pushToPreROEstimatePDFView {
    PreROEstimatePopupViewController *lPreROEstimatePopupViewController = [[PreROEstimatePopupViewController alloc] initWithNibName:@"PreROEstimatePopupViewController" bundle:nil];
    lPreROEstimatePopupViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    lPreROEstimatePopupViewController.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lPreROEstimatePopupViewController animated:YES completion:nil];
    [mAppDelegate_ setMPreROEstimatePopupViewController_:lPreROEstimatePopupViewController];
}


@end
