//
//  MasterViewController.m
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "MasterViewController.h"
#import "SearchSupportWebEngine.h"
#import "CheckInSupportWebEngine.h"

#define DateFormatApp @"MM/dd/yyyy hh:mm a"
#define TimeFormatApp @"hh:mm a"
#define KROWHEIGHT 48

@interface MasterViewController ()

@end

@implementation MasterViewController
@synthesize mSearhBar_;
@synthesize mOpenRODropDownView_;

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
    mAppdelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self initData];
//    _mOpenROTableView_.mMasterViewController_ =self;
//    _mOpenROTableView_->mAppDelegate_= mAppdelegate_;
    [_mOpenROTableView_ setDelegatesForSearchListTableview_];
}

#pragma mark -  ***************** Button Actions ****************

- (IBAction)refreshBtnAction:(id)sender {
    [mAppdelegate_.mModelForEditCustomerScreen_ resetallData];
    [mAppdelegate_.mModelForEditVehicleScreen_ resetallData];
    [mAppdelegate_.mSearchViewController_.mVehicleHistory_ setHidden:TRUE];
    [mAppdelegate_.mSearchViewController_.mVehicleHistoryLbl_ setText:@""];
    [self updateDateAndTime];
    if(mselectedSegment_==1) {
        
        [self postRequestToGetAppointments];
    }else if(mselectedSegment_==2) {
        
        [self postRequestToGetRepairOrders];
    }else if(mselectedSegment_ == 3){
        [self postRequestToGetRepairOrders];
    }
}

- (IBAction)BeginVehicleCheckInBtnAction:(id)sender {
    if (mselectedSegment_ == 2) {
        mAppdelegate_.mModelForSearchScreen_.mMileage = @"";
        mAppdelegate_.mModelForSearchScreen_.mTag_ = @"";
        [self resetAllData];
        [self.mAppointmentAndInprocessTableView_ reloadData];
    }
    [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
    [mAppdelegate_.mSearchViewController_.mContinueBtn_ setHidden:TRUE];
    BeginVehicleCheckInViewViewController *lBeginVehicleCheckInView = [[BeginVehicleCheckInViewViewController alloc] initWithNibName:@"BeginVehicleCheckInViewViewController" bundle:nil];
    [mAppdelegate_ setMBeginVehicleCheckInView_:lBeginVehicleCheckInView];
    mAppdelegate_.mViewReference_ = self;
    [mAppdelegate_.mBeginVehicleCheckInView_ setMFirstName_:mAppdelegate_.mModelForEditCustomerScreen_.mFirstName_];
    [mAppdelegate_.mBeginVehicleCheckInView_ setMLastName_:mAppdelegate_.mModelForEditCustomerScreen_.mLastName_];

   
    if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        mAppdelegate_.mBeginVehicleCheckInView_.modalPresentationStyle=UIModalPresentationFormSheet;
        mAppdelegate_.mBeginVehicleCheckInView_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
        mAppdelegate_.mBeginVehicleCheckInView_.preferredContentSize = CGSizeMake(384, 225);
    }else {
        mAppdelegate_.mBeginVehicleCheckInView_.modalPresentationStyle=UIModalPresentationPageSheet;
        mAppdelegate_.mBeginVehicleCheckInView_.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    }
    [self presentViewController:mAppdelegate_.mBeginVehicleCheckInView_ animated:YES completion:nil];
}

- (IBAction)segmentBtnAction:(id)sender {
    [self.mOpenRODropDownView_ hideOpenRODropDown:self.mOpenROFilterButton_];
    [self opnORDropDownNil];
    [self.mSearhBar_ setText:@""];
    [self.mSearhBar_ endEditing:YES];
    [mAppdelegate_.mSearchViewController_.mVehicleHistory_ setHidden:TRUE];
    [mAppdelegate_.mSearchViewController_.mVehicleHistoryLbl_ setText:@""];
    isAnyAppointmentSelected = FALSE;
    [self resetAllData];
    UIButton *lBtn = (UIButton*)sender;
    self.mSearchedListTableView_.hidden = YES;
    if(lBtn.tag==1){// Appointments
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:0.0f];

        [self.mAppointmentAndInprocessTableView_ setScrollEnabled:YES];
        // @"***** Button Tag :- *****
        mselectedSegment_ = lBtn.tag;
        isAppointmentSelected = TRUE;
        [mAppdelegate_.mModelForSearchScreen_ setTopNavigationBarHiddenForOpenROScreen:mAppdelegate_.mSearchViewController_.view Hidden:NO Button:nil];
        self.mOpenROTableView_.hidden = YES;
        [self.mBeginVehicleCheckInBtn_ setEnabled:YES];
        [self.mBarCodeBtn_ setHidden:FALSE];
        self.mAppointmentAndInprocessTableView_.hidden = NO;
//        self.mAppointmentsData_ = nil;
        if (!_isBeforeActualTime) {
            [self postRequestToGetAppointments];
        }
        [self.mAppointmentAndInprocessTableView_ reloadData];
        //To set the top navigation bar
        [self setTopNavigationBar];
        [self.mOpenROFilterButton_ setHidden:YES];
        [mAppdelegate_.mSearchViewController_ showVehicleHistoryScreen];
        [mAppdelegate_.mSearchViewController_ setMSearchCategory_:SearchDMS];
        
    } else if (lBtn.tag==2) {//Inprocess
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:0.0f];

        [self.mAppointmentAndInprocessTableView_ setScrollEnabled:YES];
        // @"***** Button Tag :- *****
        mselectedSegment_ = lBtn.tag;
        isAppointmentSelected = FALSE;
        [mAppdelegate_.mModelForSearchScreen_ setTopNavigationBarHiddenForOpenROScreen:mAppdelegate_.mSearchViewController_.view Hidden:NO Button:nil];
        self.mOpenROTableView_.hidden = YES;
        [self.mBarCodeBtn_ setHidden:FALSE];
        [self.mBeginVehicleCheckInBtn_ setEnabled:YES];
        self.mAppointmentAndInprocessTableView_.hidden = NO;
//        mAppdelegate_.mSearchDataGetter_.mInprocessListData_ = nil; // COMMENTED ON 3RD SEP 2014 BECAUSE WE HAVE REMOVED REPAIRORDERS REQUEST HERE....
//         [self postRequestToGetRepairOrders];
        [self.mAppointmentAndInprocessTableView_ reloadData];
        //To set the top navigation bar
        [self setTopNavigationBar];
        [self.mOpenROFilterButton_ setHidden:YES];
        [mAppdelegate_.mSearchViewController_ showVehicleHistoryScreen];
        [mAppdelegate_.mSearchViewController_ setMSearchCategory_:SearchDMS];
        
    } else if (lBtn.tag==3) {//OpenRO
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:0.0f];
        mselectedSegment_ = lBtn.tag;
        self.mOpenROTableView_.hidden = NO;
        for (UIView *lview in self.view.subviews) {
            if([lview isKindOfClass:[UIButton class]]) {
                if(((UIButton *)lview).tag == 50){
                    [((UIButton *)lview) setEnabled:NO];
                }
            }
        }
        [mAppdelegate_.mSearchViewController_.mVehicleHistory_.superview setHidden:TRUE];
        self.mAppointmentAndInprocessTableView_.hidden = YES;
        [self reloadOpenROData];
        [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
        //To set the top navigation bar hidden
        [mAppdelegate_.mSearchViewController_ setMSearchCategory_:SearchOpenRO];
        [mAppdelegate_.mModelForSearchScreen_ setTopNavigationBarHiddenForOpenROScreen:mAppdelegate_.mSearchViewController_.view Hidden:YES Button:nil];
        [self.mBarCodeBtn_ setHidden:TRUE];
        [self.mOpenROFilterButton_ setHidden:NO];
        [self.mOpenROFilterButton_ setEnabled:YES];
        [self.view bringSubviewToFront:self.mOpenROFilterButton_];
        [self.mOpenROFilterButton_ setTitle:@"All" forState:UIControlStateNormal];
        [self.mOpenROFilterButton_ setTitle:@"All" forState:UIControlStateSelected];
        [self.mOpenROFilterButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
        [self.mOpenROFilterButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.mOpenROFilterButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

        [mAppdelegate_.mSearchViewController_ showServicesScreen];
    }
    
    for (UIView *lview in self.view.subviews) {
                if([lview isKindOfClass:[UIButton class]]) {
                    if((UIButton *)lview==(UIButton *)sender){
                        mselectedSegment_ = lview.tag;
                        [(UIButton *)lview setSelected:YES];
                        [(UIButton *)lview setBackgroundColor:[UIColor ASRProBlueColor]];
                    } else {
                        [(UIButton *)lview setSelected:NO];
                        [(UIButton *)lview setBackgroundColor:[UIColor whiteColor]];
                    }
                }
    }
}

//This method is called @Lines 93 & 109
- (void)setTopNavigationBar {
    //To set the top navigation bar
    [self.view.superview.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *view = (UIView *)object;
        if (view.tag == 1) {
            [view.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
                UIButton *button = (UIButton *)object1;
                if (button.tag == 101) {
                    [mAppdelegate_.mModelForSearchScreen_ setTopNavigationBarHiddenForOpenROScreen:self.view.superview Hidden:NO Button:button];
                    *stop1 = YES;
                    *stop = YES;
                    return;
                }
            }];
        }
    }];
}

#pragma mark -  ***************** Generic methods ****************

- (void)initData {
    UISearchBar *lSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 45, 302, 35)];
    CGRect frame = lSearchBar.frame;
    lSearchBar.tag = 1;
    [lSearchBar CustomSearchBar:frame];
    self.mSearhBar_ = lSearchBar;
    // Get the instance of the UITextField of the search bar
    UITextField *searchField = [self.mSearhBar_ valueForKey:@"_searchField"];
    // Change the search bar placeholder text color
    [searchField setValue:[UIColor ASRProBlueColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:self.mSearhBar_];
    UIImage *lImg = [UIImage imageNamed:@"Barcode.png"];
    UIButton *lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lBtn.frame = CGRectMake(260, 54, lImg.size.width, lImg.size.height);
    [self setMBarCodeBtn_:lBtn];
    [_mBarCodeBtn_ setImage:lImg forState:UIControlStateNormal];
    [_mBarCodeBtn_ addTarget:self action:@selector(barCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_mBarCodeBtn_];
    self.mAppointmentsData_ = [NSMutableArray new];
    [[SharedUtilities sharedUtilities] hideEmptySeparators:_mAppointmentAndInprocessTableView_];
    [self setBorderColor];
    [self updateDateAndTime];
    [self setFontsAndTextToSearchScreenView];
    
    for (UIView *lview in self.view.subviews) {
        if([lview isKindOfClass:[UIButton class]]) {
            if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]) {
                if (lview.tag == 3) {
                    mAppdelegate_.mSearchViewController_.isFromInProcess = TRUE;
                    self.isFromLogin = TRUE;
                    [(UIButton *)lview setSelected:YES];
                    [(UIButton *)lview setBackgroundColor:[UIColor ASRProBlueColor]];
                    [self segmentBtnAction:(UIButton *)lview];
                    [self.mBarCodeBtn_ setHidden:TRUE];
                    mselectedSegment_ = 3;
                }else {
                    [(UIButton *)lview setSelected:NO];
                    if (((UIButton *)lview).tag != 20) {
                        [(UIButton *)lview setEnabled:NO];                        
                    }
                    [(UIButton *)lview setBackgroundColor:[UIColor whiteColor]];
                }
            }else {
                if ([mAppdelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"FULL"]) {
                    if (lview.tag == 1) {
                        mAppdelegate_.mSearchViewController_.isFromInProcess = TRUE;
                        self.isFromLogin = TRUE;
                        [self.mOpenROFilterButton_ setHidden:YES];
                        [self.mBarCodeBtn_ setHidden:FALSE];
                        [(UIButton *)lview setSelected:YES];
                        [(UIButton *)lview setBackgroundColor:[UIColor ASRProBlueColor]];
                        mselectedSegment_ = 1;
                        isAppointmentSelected = TRUE;
                    }
                }else {
                if (lview.tag == 2) {
                    mAppdelegate_.mSearchViewController_.isFromInProcess = TRUE;
                    self.isFromLogin = TRUE;
                    [self.mOpenROFilterButton_ setHidden:YES];
                    [self.mBarCodeBtn_ setHidden:FALSE];
                    [(UIButton *)lview setSelected:YES];
                    [(UIButton *)lview setBackgroundColor:[UIColor ASRProBlueColor]];
                    mselectedSegment_ = 2;
                    isAppointmentSelected = FALSE;
                }
                    }
            }
        }
    }
    [self removeAppointmentsForLite];
    _mSearchedListTableView_.mMasterViewController_ = self;
    _mSearchedListTableView_->mAppDelegate_ = mAppdelegate_;
    [_mSearchedListTableView_ setDelegatesForSearchListTableview_];
}

- (void)setFontsAndTextToSearchScreenView {
    [self.mOpenROFilterButton_ setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [self.mOpenROFilterButton_ setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

- (void)removeAppointmentsForLite {
    if ([mAppdelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"FULL"]) {
        
        for(UIView *lView in self.view.subviews) {
            if ([lView isKindOfClass:[UIButton class]]) {
                if (((UIButton*)lView).tag == 1) {
                    [((UIButton*)lView) setHidden:FALSE];
                    [((UIButton*)lView) setFrame:CGRectMake(0, ((UIButton*)lView).frame.origin.y, 100, ((UIButton*)lView).frame.size.height)];
                }else if (((UIButton*)lView).tag == 3) {
                    [((UIButton*)lView) setFrame:CGRectMake(201, ((UIButton*)lView).frame.origin.y, 101, ((UIButton*)lView).frame.size.height)];
                }else if (((UIButton*)lView).tag == 2) {
                    [((UIButton*)lView) setFrame:CGRectMake(100, ((UIButton*)lView).frame.origin.y, 101, ((UIButton*)lView).frame.size.height)];
                }
            }
        }
    }else {
    for(UIView *lView in self.view.subviews) {
        if ([lView isKindOfClass:[UIButton class]]) {
            if (((UIButton*)lView).tag == 1) {
                [((UIButton*)lView) setHidden:TRUE];
            }else if (((UIButton*)lView).tag == 3) {
                [((UIButton*)lView) setFrame:CGRectMake(151, ((UIButton*)lView).frame.origin.y, 151, ((UIButton*)lView).frame.size.height)];
            }else if (((UIButton*)lView).tag == 2) {
                [((UIButton*)lView) setFrame:CGRectMake(0, ((UIButton*)lView).frame.origin.y, 151, ((UIButton*)lView).frame.size.height)];
            }
        }
    }
    }
}

- (void)setBorderColor {
    
    [self.view.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
    [self.view.layer setBorderWidth:2.0];
    for(UIView *lView in self.view.subviews) {
        if ([lView isKindOfClass:[UIButton class]]) {
            DLog(@"%i",lView.tag);
            if(lView.tag != 50) {
                [lView.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
                [lView.layer setBorderWidth:0.5];
            }
        }
        if ([lView isKindOfClass:[UITableView class]]) {
            UITableView *mTableView = (UITableView*)lView;
            if ([mTableView respondsToSelector:@selector(setSeparatorInset:)]) {
                [mTableView setSeparatorInset:UIEdgeInsetsZero];
            }
        }
    }
}

- (void)reloadAppointmentData {
    
    [self updateDateAndTime];
    [mAppdelegate_.mSearchViewController_.mContinueBtn_ setHidden:TRUE];
    self.mAppointmentsData_ = [mAppdelegate_.mSearchDataGetter_.mAppointmentListData_ mutableCopy];
    [self resetAllData];
    [self.mAppointmentAndInprocessTableView_ reloadData];
    _isBeforeActualTime = TRUE;
    NSTimer *aTimer = [NSTimer scheduledTimerWithTimeInterval:900 target:self selector:@selector(setTimerOff) userInfo:nil repeats:NO];
    DLog(@"Timer : %@", aTimer);
}

-(void)setTimerOff
{
    _isBeforeActualTime = FALSE;
}

- (void)onSelectionOfAppointment {
    
    [self pushDataintoModalCustomerAndVehicleForApp];
    [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
    [mAppdelegate_.mSearchViewController_ setCustomerInfomationLabelsTextFromModel];
    [mAppdelegate_.mSearchViewController_ setVehicleInfomationLabelsTextFromModel];
    (![mAppdelegate_.mModelForEditCustomerScreen_.mCustomerID_ isEqualToString:@"00000000000000000000000000000000"] && ![mAppdelegate_.mModelForEditVehicleScreen_.mVehicleID_ isEqualToString:@"00000000000000000000000000000000"])?[self setRequestforVehicleHistory]:[self errorResponseForVehicleHistory];
//    [[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_ setMFirstName_:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForEditCustomerScreen_] mFirstName_]];
//    [[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_ setMLastName_:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForEditCustomerScreen_] mLastName_]];
//    (mAppdelegate_.mSearchViewController_.mEditCustomerBtn_.selected || mAppdelegate_.mSearchViewController_.mEditVehicleBtn_.selected)?[mAppdelegate_.mSearchViewController_.mContinueBtn_ setHidden:YES]
//    :[mAppdelegate_.mSearchViewController_.mContinueBtn_ setHidden:NO];
}

- (void)errorResponseForVehicleHistory {
    [mAppdelegate_.mSearchViewController_.mVehicleHistoryLbl_ setText:NSLocalizedString(@"NO_VEHICLE_HISTORY", nil)];
        NSMutableDictionary *lTempDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"lNoVehicleHistoryFound", Nil),@"RONumber",@"",@"DMSClosedDate", nil];
        NSMutableArray *lTempArray = [[NSMutableArray alloc] initWithObjects:lTempDictionary, nil];
        mAppdelegate_.mSearchDataGetter_.mVehicleHistoryData_ = lTempArray;
        DLog(@"%@",mAppdelegate_.mSearchDataGetter_.mVehicleHistoryData_);
    if (![[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
        if (mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ == ShowVehicleHistoryPopUpFromAppointments) {
            [mAppDelegate_.mSearchViewController_ reloadVehicleHistoryWhenFailed];
            mAppDelegate_.mWalkAroundLeftViewController_.mShowVehicleHistoryForOpenRO_ = 0;
        }
    }else {
        mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_  = 0;
    }
}

- (void)onSelectionOfInProcess {
    [mAppdelegate_.mSearchViewController_.mContinueBtn_ setHidden:YES];
    [self pushDataintoModalCustomerAndVehicleForApp];
    [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
    [mAppdelegate_.mSearchViewController_ setCustomerInfomationLabelsTextFromModel];
    [mAppdelegate_.mSearchViewController_ setVehicleInfomationLabelsTextFromModel];
    (![mAppdelegate_.mModelForEditCustomerScreen_.mCustomerID_ isEqualToString:@"00000000000000000000000000000000"] && ![mAppdelegate_.mModelForEditVehicleScreen_.mVehicleID_ isEqualToString:@"00000000000000000000000000000000"])?[self setRequestforVehicleHistory]:[self errorResponseForVehicleHistory];
}

- (void)pushDataintoModalCustomerAndVehicleForApp {

    if (mselectedSegment_ == 1) {
        isAnyAppointmentSelected = TRUE;
        mAppdelegate_.mModelForSearchScreen_.mAppointmentID_ = [[mAppdelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:_mselectedApptmentindex_] objectForKey:@"ID"];
        mAppdelegate_.mModelForSearchScreen_.mAppointmentNumber_ = [[mAppdelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:_mselectedApptmentindex_] objectForKey:@"Number"];
        mAppdelegate_.mModelForSearchScreen_.mAdvisorID_ = [[mAppdelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:_mselectedApptmentindex_] objectForKey:@"AdvisorID"];
        mAppdelegate_.mModelForSearchScreen_.mMileage = [NSString stringWithFormat:@"%@",[[[mAppdelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:_mselectedApptmentindex_] objectForKey:@"Vehicle"] objectForKey:@"Mileage"]];
        [mAppdelegate_.mModelForEditCustomerScreen_ setValues:(NSMutableDictionary*)[[mAppdelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:_mselectedApptmentindex_] objectForKey:@"Customer"]];
        [mAppdelegate_.mModelForEditVehicleScreen_ setValues:(NSMutableDictionary*)[[mAppdelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:_mselectedApptmentindex_] objectForKey:@"Vehicle"]];
    }else if (mselectedSegment_ == 2) {
//        mAppdelegate_.mGetVehicleDamagepointOnImageView_ = nil;
        isAnyAppointmentSelected = FALSE;
        mAppdelegate_.mModelForEditCustomerScreen_.mRONumber_ = [[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:_mselectedInprocessindex_] objectForKey:@"RONumber"];
        [mAppdelegate_.mModelForWalkAround_ setMTempPRE_RONumber:[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:_mselectedInprocessindex_] objectForKey:@"RONumber"]];
        [mAppdelegate_.mModelForEditCustomerScreen_ setValues:(NSMutableDictionary*)[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:_mselectedInprocessindex_] objectForKey:@"Customer"]];
        [mAppdelegate_.mModelForEditVehicleScreen_ setValues:(NSMutableDictionary*)[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:_mselectedInprocessindex_] objectForKey:@"Vehicle"]];
    }
}

- (void)reloadInProcessData {
    
    [self updateDateAndTime];
    self.mAppointmentsData_ = [mAppdelegate_.mSearchDataGetter_.mAppointmentListData_ mutableCopy];
    [self resetAllData];
    [self.mAppointmentAndInprocessTableView_ reloadData];
    [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
}

- (void)reloadOpenROData {
    
    [mAppdelegate_.mModelForSplashScreen_ setMEmployeesDataArray_:[[SharedUtilities sharedUtilities] retrieveArrayFromFile:kEmployeesData]];
    [self updateDateAndTime];
    [self.mOpenROTableView_ reloadData];
}

- (void)reloadOPenROTableViewAfterDoneCheckIn {
    [self updateDateAndTime];
    [self.mOpenROTableView_ reloadData];
    NSIndexPath *lSelectedIndexPath;
    DLog(@"RO Number :-%@",[mAppdelegate_.mModelForCheckIn_.mCustomerAndVehicleInfoArray_ valueForKey:@"RONumber"]);
    for (int i=0; i<[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ count]; i++) {
        /*if ([[mAppdelegate_.mModelForCheckIn_.mCustomerAndVehicleInfoArray_ valueForKey:@"RONumber"]  isEqualToString:[[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:i] valueForKey:@"RONumber"]]) {
            lSelectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        }*/
        if ([[[CheckInSupportWebEngine checkInSharedInstance] mPRERONumber]  isEqualToString:[[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:i] valueForKey:@"RONumber"]]) {
            lSelectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        }
    }
    [mAppdelegate_.mMasterViewController_.mOpenROTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    [mAppdelegate_.mMasterViewController_.mOpenROTableView_ onSelectionOfOpenRO:lSelectedIndexPath.row];
//    mAppdelegate_.mModelforOpenROSupportEngine_.mGetServiceReference_= OPENROMAINVIEWCONTROLLER;
//    [mAppdelegate_.mModelforOpenROSupportEngine_  RequestForGetROLines:[NSString stringWithFormat:@"%@",[[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:lSelectedIndexPath.row] objectForKey:@"RONumber"]]];
    [mAppdelegate_.mModelForVehicleHistoryTableView_ setMOpenROString_:[NSString stringWithFormat:@"%@",[[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:lSelectedIndexPath.row] objectForKey:@"RONumber"]]];
//    [mAppdelegate_.mModelforOpenROSupportEngine_  RequestForRepairOrderServiceLines:[NSString stringWithFormat:@"%@",[[mAppdelegate_.mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:lSelectedIndexPath.row] objectForKey:@"RONumber"]]];
    // This method is called to open PreROEstimatePDF Popup
//    [mAppdelegate_.mSearchViewController_ pushToPreROEstimatePDFView];
    [[CheckInSupportWebEngine checkInSharedInstance] getRequestForPreROEstimatePDF];
}

- (void)reloadSearchData {
    
    self.mSearchedListTableView_.hidden=NO;
    [self updateDateAndTime];
    [self.mSearchedListTableView_ reloadData];
}

- (void)resetAllData {
    mAppdelegate_.mModelForSearchScreen_.mMileage = @"";
    mAppdelegate_.mModelForSearchScreen_.mTag_ = @"";
    mAppdelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ = @"";

    [mAppdelegate_.mModelForEditCustomerScreen_ resetallData];
    [mAppdelegate_.mModelForEditVehicleScreen_ resetallData];
    [mAppdelegate_.mSearchViewController_.mVehicleHistory_ setHidden:TRUE];
    [mAppdelegate_.mSearchViewController_.mVehicleHistoryLbl_ setHidden:TRUE];
    [mAppdelegate_.mSearchViewController_.mEditCustomerBtn_ setEnabled:FALSE];
    [mAppdelegate_.mSearchViewController_.mEditVehicleBtn_ setEnabled:FALSE];
    [mAppdelegate_.mSearchViewController_ setCustomerInfomationLabelsTextFromModel];
    [mAppdelegate_.mSearchViewController_ setVehicleInfomationLabelsTextFromModel];
    [mAppdelegate_.mSearchViewController_.view.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *view = (UIView *)object;
        if (view.tag == 1) {
            [view.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
                UILabel *RONumberlabel = (UILabel *)object1;
                 if(RONumberlabel.tag == 102) {
                    [RONumberlabel setHidden:YES];
                 }
            }];
        }
    }];

}

- (void)updateDateAndTime {
    
    self.mUpdatedDate_=[NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [self setMFormatter_:formatter];
    [_mFormatter_ setDateFormat:DateFormatApp];
    NSString *lDateStr=[_mFormatter_ stringFromDate:self.mUpdatedDate_];
    _mUpdateDateLbl_.text=(lDateStr)?[NSString stringWithFormat:@"Last updated  %@",lDateStr]:[NSString stringWithFormat:@"Last updated  %@",@""];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//            *** this method is used to return the string (includes Time,Salutation,FirstName,LastName & MiddleName) which is used to display in the cell to avoid crash  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(NSString *)returnString1:(NSString *)apppoinmenttime salutaion:(NSString *)salutation firstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName // For Appointments
{
    // *** convert json date to actual date
    apppoinmenttime = [apppoinmenttime stringByReplacingOccurrencesOfString:@"0530" withString:@"0000"];
    
    if(![apppoinmenttime isEqualToString:@""]&&apppoinmenttime!=nil) {
        NSDate* date=[self mfDateFromDotNetJSONString:apppoinmenttime];
        NSDateFormatter *mFormatter_ = [NSDateFormatter new];
        [mFormatter_ setDateFormat:TimeFormatApp];
        apppoinmenttime= [mFormatter_ stringFromDate:date];
    }
    firstName = (firstName!=nil)?firstName:@"";
    lastName = (lastName!=nil)?lastName:@"";
    salutation =  (salutation!=nil)?salutation:@"";
    middleName = (middleName!=nil)?middleName:@"";
    apppoinmenttime = (apppoinmenttime!=nil)?apppoinmenttime:@"";
    NSString *returnStr=@"";
    returnStr = [NSString stringWithFormat:@"%@ %@ %@ %@",salutation,firstName,middleName,lastName];
    returnStr = [returnStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return returnStr;
}

//--------------------------------------------------- ************** ------------------------------------------------------
//            *** this method is used to return the Appointment date string which is used to display in the cell to avoid crash  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(NSString *)returnApptDateString:(NSString *)apppoinmenttime // For Appointments
{
    // *** convert json date to actual date
    apppoinmenttime = [apppoinmenttime stringByReplacingOccurrencesOfString:@"0530" withString:@"0000"];
    
    if(![apppoinmenttime isEqualToString:@""]&&apppoinmenttime!=nil) {
        NSDate* date=[self mfDateFromDotNetJSONString:apppoinmenttime];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = DateFormatApp;
        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        [dateFormatter setTimeZone:gmt];
        NSString *timeStamp = [dateFormatter stringFromDate:date];
        DLog(@" ==== DATE :%@ ==== ",timeStamp);
        apppoinmenttime = timeStamp;
    }
    apppoinmenttime = (apppoinmenttime!=nil)?apppoinmenttime:@"";
    NSString *returnStr=@"";
    returnStr = [NSString stringWithFormat:@"%@",apppoinmenttime];
    returnStr = [returnStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return returnStr;
}


//--------------------------------------------------- ************** ------------------------------------------------------
//            *** this method is used to return the string which is used to display in the cell to avoid crash  ***
//--------------------------------------------------- ************** ------------------------------------------------------

-(NSString *)returnString2:(NSString *)vehicleYear make:(NSString *)make model:(NSString *)model
{
    vehicleYear = (vehicleYear!=nil&&[vehicleYear length]>0)?[NSString stringWithFormat:@"%@ ",vehicleYear]:@"";
    make = (make!=nil&&[make length]>0)?[NSString stringWithFormat:@"%@ ",make]:@"";
    model = (model!=nil&&[model length]>0)?[NSString stringWithFormat:@"%@ ",model]:@"";
    model = [model stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
    
    NSString *returnStr=@"";
        returnStr = [NSString stringWithFormat:@"%@%@%@",vehicleYear,make,model];
    return returnStr;
}

//--------------------------------------------------- ************** ------------------------------------------------------
//            *** this method is used to return the string(includes RONumber,Salutation,FirstName,LastName & MiddleName) which is used to display in the cell to avoid crash  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(NSString *)returnString3:(NSString *)RONumber salutaion:(NSString *)salutation firstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName // For In-process
{
        RONumber = (RONumber!=nil)?RONumber:@"";
    firstName = (firstName!=nil)?firstName:@"";
    lastName = (lastName!=nil)?lastName:@"";
    salutation =  (salutation!=nil)?salutation:@"";
    middleName = (middleName!=nil)?middleName:@"";
    NSString *returnStr=@"";
    returnStr = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",RONumber,salutation,firstName,middleName,lastName];

    return returnStr;
}

- (NSDate *)mfDateFromDotNetJSONString:(NSString *)string {
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

//--------------------------------------------------- ************** ------------------------------------------------------
//               *** This method is used to update the appointments list / in-proces list data/ customer search ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)refreshAppointmentOrInprocessData {
        
            if(mselectedSegment_==1) {// appointments
                mAppdelegate_.mSearchViewController_.isFromInProcess = FALSE;
                [[SearchSupportWebEngine sharedInstance] threadRequestToGetAppointments];
            } else if(mselectedSegment_==2) { // in-Process
                [[SearchSupportWebEngine sharedInstance] threadRequestToGetRepairOrders];
            }else if (mselectedSegment_ == 3) { // OpenRO's
                [[SearchSupportWebEngine sharedInstance] threadRequestToGetRepairOrders];
//            NSString* noWhiteSpace = [dirtyString stringByTrimmingLeadingAndTrailingWhitespaceAndNewlineCharacters];

            }else { // walk-in customer
             mAppdelegate_.mModelForSearchScreen_->isSearchForBeginCheckIn = FALSE;
             if ([mAppdelegate_.mViewReference_ isKindOfClass:[SearchedListTableView class]]) {
                NSString* noWhiteSpace = [mAppdelegate_.mModelForEditCustomerScreen_.mFirstName_ stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                 
                 [self.mSearhBar_ setText:(noWhiteSpace.length !=0)?mAppdelegate_.mModelForEditCustomerScreen_.mFirstName_:self.mSearhBar_.text];
                 [[SearchSupportWebEngine sharedInstance] threadRequestForSearchCustomerInfo:self.mSearhBar_.text];
             }else {
                 mAppdelegate_.mViewReference_ = self;
                 NSString* noWhiteSpace = [mAppdelegate_.mModelForEditCustomerScreen_.mFirstName_ stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                 [self.mSearhBar_ setText:noWhiteSpace.length !=0?mAppdelegate_.mModelForEditCustomerScreen_.mFirstName_:self.mSearhBar_.text];
                 [[SearchSupportWebEngine sharedInstance] threadRequestForSearchCustomerInfo:self.mSearhBar_.text];
             }
        }
}

//--------------------------------------------------- ************** ------------------------------------------------------
//   *** this methods make wheather to have customer search or not and for the appointment case the searched customer may be in the appointment, if there in the appointment then show from appointment list ***
//--------------------------------------------------- ************** ------------------------------------------------------
- (void)showSearchlistViewOrHide:(int)showOrhide searchText:(NSString *)searchText {
    mAppdelegate_.mModelForWalkAround_.mTempPRE_RONumber = nil;
    if(showOrhide==1){// '1' search list
        mselectedSegment_ = 0; // made 0...because this is useful while adding a new customer
        [self.mSearchedListTableView_ resetData];
        [self resetAllData];
        self.mAppointmentAndInprocessTableView_.hidden=YES;
        [self.mAppointmentAndInprocessTableView_ reloadData];
        [mAppdelegate_.mSearchViewController_.mCustomerInfoView_ setHidden:TRUE];
        [mAppdelegate_.mSearchViewController_.mVehicleInfoView_ setHidden:TRUE];
        [mAppdelegate_.mSearchViewController_.mVehicleHistoryView_ setHidden:TRUE];
        [self.mOpenROTableView_ setHidden:TRUE];
        [self.mOpenROFilterButton_ setHidden:TRUE];
        [mAppdelegate_.mSearchCustomerInfoView_.view setHidden:FALSE];
        [mAppdelegate_.mSearchVehicleInfoView_.view setHidden:FALSE];
        for (UIView *btnview in self.view.subviews)  {
            if([btnview isKindOfClass:[UIButton class]]) {
                [(UIButton *)btnview setSelected:NO];
                [(UIButton *)btnview setBackgroundColor:[UIColor clearColor]];
                [(UIButton *)btnview setEnabled:NO];
                if (((UIButton *)btnview).tag !=50) {
                    UIButton *lbtn = (UIButton *)btnview;
                    lbtn.titleLabel.textColor = [UIColor ASRProBlueColor];
                }else
                    [(UIButton *)btnview setEnabled:YES];
                [self.mRefreshBtn_ setEnabled:NO];
            }
        }
    }else {// '0' appointment list
        self.mSearchedListTableView_.hidden=YES;
        [self.mSearchedListTableView_ reloadData];
        [self resetAllData];
        self.mAppointmentAndInprocessTableView_.hidden=NO;
        [mAppdelegate_.mSearchViewController_.mCustomerInfoView_ setHidden:FALSE];
        [mAppdelegate_.mSearchViewController_.mVehicleInfoView_ setHidden:FALSE];
        [mAppdelegate_.mSearchViewController_.mVehicleHistoryView_ setHidden:FALSE];
        [mAppdelegate_.mSearchViewController_.mContinueBtn_ setHidden:TRUE];
        [mAppdelegate_.mSearchCustomerInfoView_.view setHidden:TRUE];
        [mAppdelegate_.mSearchVehicleInfoView_.view setHidden:TRUE];
        for (UIView *btnview in self.view.subviews)  {
            if([btnview isKindOfClass:[UIButton class]]) {
                if (searchText.length>0) {
                    [(UIButton *)btnview setEnabled:NO];
                    [self.mRefreshBtn_ setEnabled:NO];
                    if(btnview.tag==1){
                        UIButton *lBtn = (UIButton*)btnview;
                        [(UIButton *)btnview setSelected:YES];
                        [(UIButton *)btnview setBackgroundColor: [UIColor ASRProBlueColor]];
                        lBtn.titleLabel.textColor = [UIColor whiteColor];
                        mselectedSegment_ = 1;
                    }
                    else {
                        [(UIButton *)btnview setSelected:NO];
                        [(UIButton *)btnview setEnabled:YES];

                    }
                }else {
                    if (((UIButton *)btnview).tag !=50)
                        [(UIButton *)btnview setEnabled:YES];
                    [self.mRefreshBtn_ setEnabled:YES];
                    if(!isAppointmentSelected && ((UIButton *)btnview).tag == 2){
                        [(UIButton *)btnview setSelected:YES];
                        [(UIButton *)btnview setBackgroundColor: [UIColor ASRProBlueColor]];
                        mselectedSegment_ = 2;
                    }else if (isAppointmentSelected && ((UIButton *)btnview).tag==1) {
                        [(UIButton *)btnview setSelected:YES];
                        [(UIButton *)btnview setBackgroundColor: [UIColor ASRProBlueColor]];
                        mselectedSegment_ = 1;
                    }
                    else {
                        [(UIButton *)btnview setSelected:NO];
                        [(UIButton *)btnview setBackgroundColor: [UIColor whiteColor]];
                    }
                }
            }
        }
        if([searchText length]>0) { // show searched appoinments
            
        } else { // show all appointments
            [_mAppointmentsData_ removeAllObjects];
            [_mAppointmentsData_ addObjectsFromArray:mAppdelegate_.mSearchDataGetter_.mAppointmentListData_];
        }
    }
    [self appointmentORCustomerSearchScreen];
}

// to make the screen empty for cases search or when no row is selected
-(void)appointmentORCustomerSearchScreen {
    
    if(!self.mAppointmentAndInprocessTableView_.hidden){//appointment case
        [self.mAppointmentAndInprocessTableView_ reloadData];
        [mAppdelegate_.mSearchViewController_ enableOrdisableEditCustomerOrVehiclebtn];
        [mAppdelegate_.mSearchViewController_.mVehicleHistory_ setHidden:TRUE];
        [mAppdelegate_.mSearchViewController_.mVehicleHistoryLbl_ setHidden:TRUE];
    } else if (!self.mSearchedListTableView_.hidden){ // customer search case
        mAppdelegate_.mSearchDataGetter_.mSearchedCustomerListData_ = nil;
        [self.mSearchedListTableView_ reloadData];
    }
    
}

-(void)postRequestToGetAppointments  {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppdelegate_.mRequestMethods_ getAppointmentList];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

- (void)postRequestToGetRepairOrders {

    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppdelegate_.mRequestMethods_ getRepairOrders];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)requestForCustomerSearch:(NSString *)searchValue  {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppdelegate_.mRequestMethods_ searchCustomerInformation:searchValue];
        
    } else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
}

- (void)setRequestforVehicleHistory {
    
    [mAppdelegate_.mSearchViewController_.mVehicleHistoryLbl_ setText:NSLocalizedString(@"LOADING_VEHICLE_HISTORY", nil)];
    
//    [[SearchSupportWebEngine sharedInstance] threadRequestToGetRequestForVehicleHistory];
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppdelegate_.mRequestMethods_ getRequestForVehicleHistory:mAppdelegate_.mModelForSplashScreen_.mStoreID_ CustomerID:mAppdelegate_.mModelForEditCustomerScreen_.mCustomerID_ VehicleID:mAppdelegate_.mModelForEditVehicleScreen_.mVehicleID_];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}
/*
#pragma mark --
#pragma mark backGround Thread Request Methods
-(void)threadForGetRequestSearchCustomer: (NSObject *) myObject {
//    NSError *jsonError;
    
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kGET];
    NSString *data = [NSString stringWithFormat:@"{\"Data\":{\"CustomerNumber\":\"\",\"FirstName\":\"Powell\",\"LastName\":\"\",\"Email\":\"\",\"Phone\":\"\",\"VIN\":\"\"}}"];
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"VehicleDiagramSets Request:-%@",Projrequest);
    DLog(@"VehicleDiagramSets Response:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    mAppdelegate_.mModelForWalkAround_.mVehicleDiagramSetsArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                   options:kNilOptions error:&jsonError];
    DLog(@"mVehicleDiagramSetsArray_:-%@",mAppdelegate_.mModelForWalkAround_.mVehicleDiagramSetsArray_);
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForVehicleDiagramSets:) withObject:responseCodeStr waitUntilDone:NO];
}

#pragma mark --
#pragma mark backGround Thread Succes Methods

- (void)onSuccessForVehicleDiagramSets:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}*/

#pragma mark -  ***************** TableView Delegate methods ****************
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return KROWHEIGHT;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(mselectedSegment_==1)// for appoinments
     {
         return  [self.mAppointmentsData_ count];
     }else // for in-process
         return  [mAppdelegate_.mSearchDataGetter_.mInprocessListData_ count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        int tagCount = 1;
        for (; tagCount <= 3; tagCount++) {
            UILabel *lUILabel=[[UILabel alloc]init];
            [lUILabel setBackgroundColor:[UIColor clearColor]];
            [lUILabel setHighlightedTextColor:[UIColor whiteColor]];
            [lUILabel setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
            if (tagCount == 1 || tagCount == 3) {
                [lUILabel setFont:[UIFont systemFontOfSize:13.0]];
            }else
                [lUILabel setFont:[UIFont systemFontOfSize:12.0]];
            
            [lUILabel setTag:tagCount];
            [cell.contentView addSubview:lUILabel];
        }
        
        UIView *lSelectedView_ = [[UIView alloc] init];
        lSelectedView_.backgroundColor =[UIColor colorWithRed:229/255.0 green:125/255.0 blue:37/255.0 alpha:1.0f];
        cell.selectedBackgroundView = lSelectedView_;
        
    }
    [self resetTableViews:cell];
    [self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
    cell.accessoryType=UITableViewCellAccessoryNone;
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    tableView.separatorColor = [UIColor ASRProBlueColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    mAppdelegate_.mServiceDataGetter_->isROChanged_=TRUE;
    mAppdelegate_.mModelForWalkAround_.mPRE_RONumber = @"";
//    mAppdelegate_.mServicesViewController_ = nil;
//    mAppdelegate_.mWalkAroundViewController_ = nil;
//    mAppdelegate_.mCheckInViewController_ = nil;
    [mAppdelegate_.mSearchViewController_.mVehicleHistory_ setHidden:TRUE];
    if(mselectedSegment_==1) {
        self.mselectedApptmentindex_=indexPath.row;
        [self onSelectionOfAppointment];
    }
    if(mselectedSegment_==2) {
        self.mselectedInprocessindex_=indexPath.row;
        [mAppdelegate_.mModelForWalkAround_ setMTempPRE_RONumber:[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"]];
        mAppdelegate_.mModelForEditCustomerScreen_.mRONumber_ = [[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"];
        [self onSelectionOfInProcess];
    }
}

#pragma mark --
#pragma mark Table Sections Populate methods

- (void)resetTableViews:(UITableViewCell*)tableViewCell  {
    int tagCount = 1;
	// reset UILabels;
	for (; tagCount <= 3; tagCount ++) {
        UILabel *lUILabel = (UILabel*)[tableViewCell viewWithTag:tagCount];
        lUILabel.text = nil;
	}
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView  {
    
    //----- local coordinates for setting frames of the internal UI Elements -----
    
    CGFloat xCoord = 15, yCoord = 5;
    
    // ----------------------------;
    // To display time and customer name for labels;
    // ----------------------------;
    
//    UILabel *lTimeLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
//    [lTimeLabel setFrame:CGRectMake(xCoord, yCoord, 60, 18)];
//    [lTimeLabel setText:@"10:00am"];
//    xCoord += lTimeLabel.frame.size.width + 3;
    UILabel *lTimeAndCustomerNameLabel = (UILabel*)[tableViewCell.contentView viewWithTag:1];
    UILabel *lApptTimeLabel = (UILabel*)[tableViewCell.contentView viewWithTag:3];


    if (mselectedSegment_ == 1) {
        [lTimeAndCustomerNameLabel setFrame:CGRectMake(xCoord, yCoord, 130, 18)];
        [lApptTimeLabel setFrame:CGRectMake(lTimeAndCustomerNameLabel.frame.origin.x + lTimeAndCustomerNameLabel.frame.size.width + 5, yCoord, 130, 18)];
        [lTimeAndCustomerNameLabel setText:[NSString stringWithFormat:@"%@",[self returnString1:[[self.mAppointmentsData_ objectAtIndex:indexPath.row] objectForKey:@"Time"] salutaion:[[self.mAppointmentsData_ objectAtIndex:indexPath.row] objectForKey:@"Salutation"] firstName:[[[self.mAppointmentsData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"FirstName"] middleName:[[[self.mAppointmentsData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"MiddleName"] lastName:[[[self.mAppointmentsData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"LastName"]]]];
        [lApptTimeLabel setText:[NSString stringWithFormat:@"%@",[self returnApptDateString:[[self.mAppointmentsData_ objectAtIndex:indexPath.row] objectForKey:@"Time"]]]];
    }else{
        [lTimeAndCustomerNameLabel setFrame:CGRectMake(xCoord, yCoord, 220, 18)];
        [lApptTimeLabel setFrame:CGRectMake(lTimeAndCustomerNameLabel.frame.origin.x + lTimeAndCustomerNameLabel.frame.size.width, yCoord, 70, 18)];
        [lTimeAndCustomerNameLabel setText:[NSString stringWithFormat:@"%@",[self returnString3:[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"RONumber"] salutaion:[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Salutation"] firstName:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"FirstName"] middleName:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"MiddleName"] lastName:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Customer"] objectForKey:@"LastName"]]]];
        [lApptTimeLabel setText:[NSString stringWithFormat:@""]];
    }
    xCoord = 15.0;
    yCoord += lTimeAndCustomerNameLabel.frame.size.height + 1;
    // ----------------------------;
    // To display year,make and model for labels;
    // ----------------------------;
    
    UILabel *lYearMakeModelLabel = (UILabel*)[tableViewCell.contentView viewWithTag:2];
    [lYearMakeModelLabel setFrame:CGRectMake(xCoord, yCoord, 300, 18)];
    if (mselectedSegment_ == 1) {
        [lYearMakeModelLabel setText:[NSString stringWithFormat:@"%@",[self returnString2:[[[self.mAppointmentsData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Year"] make:[[[self.mAppointmentsData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Make"] model:[[[self.mAppointmentsData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Model"]]]];
    }else {
        [lYearMakeModelLabel setText:[NSString stringWithFormat:@"%@",[self returnString2:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Year"] make:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Make"] model:[[[mAppdelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:indexPath.row] objectForKey:@"Vehicle"] objectForKey:@"Model"]]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark OpenRO DropDown Methods
- (IBAction)OpenROFilterButtonAction:(id)sender {
    self.mOpenROFilterButton_.selected = !self.mOpenROFilterButton_.selected;

    NSMutableArray * openROModesArray = [[NSMutableArray alloc] initWithObjects:@"All",@"Dispatch",@"Inspection",@"Approval",@"Repair",@"Review", nil];
    if(self.mOpenRODropDownView_ == nil) {
        CGFloat heightForTableView = [openROModesArray count] * 26;
        self.mOpenRODropDownView_ = [[OpenRODropDownView alloc] showOpenRODropDown:sender Height:&heightForTableView Array:openROModesArray Direction:@"down"];
        self.mOpenRODropDownView_.delegate = self;
        [self.mOpenROTableView_ setUserInteractionEnabled:FALSE];
    }
    else {
        [self.mOpenRODropDownView_ hideOpenRODropDown:sender];
        [self opnORDropDownNil];
    }
}

- (void)OpenRODropDownDelegateMethod:(OpenRODropDownView *)sender{
    [self opnORDropDownNil];
}

-(void)opnORDropDownNil {
    self.mOpenRODropDownView_  = nil;
    [self.mOpenROTableView_ setUserInteractionEnabled:TRUE];
}

#pragma mark TouchEvent
- (void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
    
    if (self.mOpenROFilterButton_.selected) {
        self.mOpenROFilterButton_.selected =! self.mOpenROFilterButton_.selected;
    }
    // some custom code to process a specific touch
    [self.mOpenRODropDownView_ hideOpenRODropDown:self.mOpenROFilterButton_];
    [self opnORDropDownNil];
}

- (void)dealloc {
    [self.view removeObserver:self.mAppointmentAndInprocessTableView_ forKeyPath:@"contentSize"];
}

@end
