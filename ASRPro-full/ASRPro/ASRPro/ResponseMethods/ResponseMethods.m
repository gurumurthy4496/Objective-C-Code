     //
//  ResponseMethods.m
//  ASRProAppDelegate
//
//  Created by Value Labs on 17/09/12.
//  Copyright (c) 2012 ValueLabs. All rights reserved.
//

#import "ResponseMethods.h"
#import "NetworkMonitor.h"
#import "VehicleHistorySupportWebEngine.h"
#import "WalkAroundSupportWebEngine.h"
#import "PrintEmailPopupViewViewController.h"

@class ChangePlanPhaseViewController;

@implementation ResponseMethods

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        //notifications
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(onResponseObserver:) 
                                                     name: @"onResponse" 
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(onNilResponseObserver:) 
                                                     name: @"onNilResponse" 
                                                   object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self 
                                                 selector: @selector(ResponseFailed:) 
                                                     name: @"ResponseFailed" 
                                                   object: nil];
    }
    return self;
}

#pragma mark onResponse methods
#pragma mark response observer

- (void)onResponseObserver:(NSNotification*)notification {
    DLog(@"response found server");
    [[SharedUtilities sharedUtilities] removeLoadView];
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kINSPECTIONITEMS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [mAppDelegate_.mParserMethods_ parseInspectionItems];
            [self successResponse];
            return;
        }
    

    }
    else if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kGETSERVICES]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [mAppDelegate_.mParserMethods_ parseGetServiceLines];
            [self successResponse];
            return;
        }
    }

    
    
  else if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kLOGIN]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        
        [mAppDelegate_.mParserMethods_ parseLogin];
        
        if (![[mAppDelegate_.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Message"] isEqualToString:@"success"]) {
            [mAppDelegate_.mSplashScreenViewController_.mErrorView_ setHidden:FALSE];
            [mAppDelegate_.mSplashScreenViewController_.view bringSubviewToFront:mAppDelegate_.mSplashScreenViewController_.mErrorView_];
            [mAppDelegate_.mSplashScreenViewController_.mLoginScrollView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
                UIView *lTempView_ = object;
                UITextField *lTempTextField_ = object;
                switch (lTempView_.tag) {
                    case 1: { // Welcome to ASR Pro Label;
                    }
                        break;
                    case 2: { // UserName Label;
                    }
                        break;
                    case 3: { // Password Label;
                    }
                        break;
                    case 4: { // StoreID Label;
                    }
                        break;
                    case 5: { //Username TextView;
                        [lTempTextField_.layer setBorderWidth:1];
                        lTempTextField_.font = [UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey];
                        [lTempTextField_ setTextColor:[UIColor redColor]];
                        [lTempTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
                    }
                        break;
                    case 6: { //Password TextView;
                        [lTempTextField_.layer setBorderWidth:1];
                        lTempTextField_.font = [UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey];
                        [lTempTextField_ setTextColor:[UIColor redColor]];
                        [lTempTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
                    }
                        break;
                    case 7: { //StoreID TextView;
                        [lTempTextField_.layer setBorderWidth:1];
                        lTempTextField_.font = [UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey];
                        [lTempTextField_ setTextColor:[UIColor redColor]];
                        [lTempTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
                    }
                        break;
                    case 8: { //Login Button;
                    }
                        break;
                    case 9: { //Login Button;
                    }
                        break;
                    default:
                        break;
                }
            }];
            [mAppDelegate_.mSplashScreenViewController_.mErrorMessageLabel_ setText:NSLocalizedString(@"lLOGIN_FAILURE_RESPONSE", nil)];
            return;
        }
        else if ([[mAppDelegate_.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Message"] isEqualToString:@"success"]) {
            [self successResponse];
            return;
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kAppointments]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [mAppDelegate_.mParserMethods_ parseAppointmentList];
            [self successResponse];
            return;
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kREPAIRORDER]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [mAppDelegate_.mParserMethods_ parseRepairOrders];
            [self successResponse];
            return;
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kSearch_Customer]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [mAppDelegate_.mParserMethods_ parseSearchCustomerData];
            [self successResponse];
            return;
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kEDIT_CUSTOMER_DETAILS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPUT]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [mAppDelegate_.mParserMethods_ parseCustomerDetails];
            [self successResponse];
            return;
        }else {
            NSString *response1 = [[NSString alloc] initWithBytes:[mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                           length:[mAppDelegate_.mWebEngine_->webData length]
                                                         encoding:NSUTF8StringEncoding];
            [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:[NSString stringWithFormat:@"Customer : Error response from server : %@",response1]];
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kEDIT_CUSTOMER_DETAILS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 201) {
            [mAppDelegate_.mParserMethods_ parseAddCustomerDetails];
            [self successResponse];
            return;
        }else {
            NSString *response1 = [[NSString alloc] initWithBytes:[mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                           length:[mAppDelegate_.mWebEngine_->webData length]
                                                         encoding:NSUTF8StringEncoding];
             [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:[NSString stringWithFormat:@"Customer : Error response from server : %@",response1]];
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kEDIT_VEHICLE_DETAILS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPUT]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [mAppDelegate_.mParserMethods_ parseVehicleDetails];
            [self successResponse];
            return;
        }else {
            NSString *response1 = [[NSString alloc] initWithBytes:[mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                           length:[mAppDelegate_.mWebEngine_->webData length]
                                                         encoding:NSUTF8StringEncoding];
            [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:[NSString stringWithFormat:@"Vehicle : Error response from server : %@",response1]];
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kEDIT_VEHICLE_DETAILS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 201) {
            [mAppDelegate_.mParserMethods_ parseAddVehicleDetails];
            [self successResponse];
            return;
        }else {
            NSString *response1 = [[NSString alloc] initWithBytes:[mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                           length:[mAppDelegate_.mWebEngine_->webData length]
                                                         encoding:NSUTF8StringEncoding];
            [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:[NSString stringWithFormat:@"Vehicle : Error response from server : %@",response1]];
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kVEHICLE_HISTORY_API]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [mAppDelegate_.mParserMethods_ parseAppointmentsVehicleHistory];
            if ([mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ count]>0) {
                [self successResponse];
            }else
                [mAppDelegate_.mSearchViewController_.mVehicleHistoryLbl_ setText:NSLocalizedString(@"NO_VEHICLE_HISTORY", nil)];
            return;
        }else if (mAppDelegate_.mWebEngine_.mResponseCode_ == 500) {
            if (mAppDelegate_.mModelForWalkAround_.mShowVehicleHistoryPopUp_ == ShowVehicleHistoryPopUpFromAppointments) {
                [mAppDelegate_.mSearchViewController_ reloadVehicleHistoryWhenFailed];
                mAppDelegate_.mWalkAroundLeftViewController_.mShowVehicleHistoryForOpenRO_ = 0;
            }
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kVehicle_Check_In]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 201) {
            [mAppDelegate_.mParserMethods_ parseVehicleCheckIn];
            [self successResponse];
            return;
        }else if (mAppDelegate_.mWebEngine_.mResponseCode_ == 500){
            NSString *json_string = [[NSString alloc]
                                     initWithData:mAppDelegate_.mWebEngine_->webData encoding:NSUTF8StringEncoding];
                [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:[NSString stringWithFormat:@"%@",json_string]];
            [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mIsBeginVehicle_ = FALSE;
            return;
            }
        }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kADDSERVICES]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 201) {
            [mAppDelegate_.mParserMethods_ parseAddService];
            [self successResponse];
            return;
        }
        else   if (mAppDelegate_.mWebEngine_.mResponseCode_ == 500){
            [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:[NSString stringWithFormat:@"Cannot Add Duplicate Service"]];

        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kUPDATESERVICE]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPUT]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [self successResponse];
            return;
        }
    }
        if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kOPENROGETSERVICES]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
            if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
                [mAppDelegate_.mParserMethods_ parseOpenROGetServiceLines];
                [self successResponse];
                return;
            }
        }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kCOMPLETE_INSPECTION]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPUT]) {
        if (mAppDelegate_.mWebEngine_.mResponseCode_ == 200) {
            [mAppDelegate_.mParserMethods_ parseCompleteInspectionDetails];
            [self successResponse];
            return;
        }
    }
}

#pragma mark nil response observer
- (void)onNilResponseObserver: (NSNotification*)notification {
    [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:NSLocalizedString(@"lNO_RESPONSE", nil)];
    [[SharedUtilities sharedUtilities] removeLoadView];
}
    
#pragma mark  response failed
- (void)ResponseFailed: (NSNotification*)notification {
	[[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:NSLocalizedString(@"lNO_RESPONSE", nil)];
     [[SharedUtilities sharedUtilities] removeLoadView];
}

- (void)successResponse {
    // on success of response
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kLOGIN]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
        return;
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kAppointments]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        [mAppDelegate_.mMasterViewController_ reloadAppointmentData];
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kREPAIRORDER]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        mAppDelegate_.mSearchViewController_.isFromInProcess = TRUE;
        [mAppDelegate_.mModelForSearchScreen_ getInprocessListFromRepairOrders];
        [mAppDelegate_.mMasterViewController_ reloadInProcessData];
        DLog(@"%@",mAppDelegate_.mMasterViewController_.mOpenROFilterButton_.titleLabel.text);
        [mAppDelegate_.mModelForSearchScreen_ getSelectedModeName:[NSString stringWithFormat:@"%@",mAppDelegate_.mMasterViewController_.mOpenROFilterButton_.titleLabel.text]];
        [mAppDelegate_.mMasterViewController_ reloadOpenROData];
        if (mAppDelegate_.mModelForSearchScreen_.mDoneCheckInTOOpenROView_ == DoneToOPenROMode) {
            mAppDelegate_.mModelForSearchScreen_.mDoneCheckInTOOpenROView_ = 0;
            [mAppDelegate_.mMasterViewController_ reloadOPenROTableViewAfterDoneCheckIn];
            
        }
        if (![mAppDelegate_.mModelForSplashScreen_.mEmployeeType_ isEqualToString:@"Technician"] && [mAppDelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"FULL"]) {
            if (mAppDelegate_.mCheckInViewController_.mISFronCheckInScreen_) {
                mAppDelegate_.mCheckInViewController_.mISFronCheckInScreen_ = 0;
            }else {
                [[SearchSupportWebEngine sharedInstance] threadRequestToGetAppointments];
            }
            
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kSearch_Customer]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        [mAppDelegate_.mMasterViewController_ reloadSearchData];
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kEDIT_CUSTOMER_DETAILS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPUT]) {
        if (mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_) {
            [mAppDelegate_.mModelForEditVehicleScreen_ setMMileage_:mAppDelegate_.mModelForSearchScreen_.mMileage];
            [mAppDelegate_.mEditCustomerViewController_ dismissViewControllerAnimated:YES completion:^ {
                [mAppDelegate_.mSearchViewController_ displayEditVehiclePopup];
            }];
            return;
        }
        [[SearchSupportWebEngine sharedInstance] getRequestForRODetailsOnSavingCustomerAndVehicle];
        [mAppDelegate_.mMasterViewController_ refreshAppointmentOrInprocessData];
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kEDIT_CUSTOMER_DETAILS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]] || [mAppDelegate_.mViewReference_ isKindOfClass:[EditCustomerViewController class]]) {
            if ([mAppDelegate_.mViewReference_ isKindOfClass:[EditCustomerViewController class]]) {
                [[SearchSupportWebEngine sharedInstance] threadRequestToAddNewVehicle];
            }else
                [[SearchSupportWebEngine sharedInstance] threadRequestToAddCustomerDetails:mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_];
        }else {
            if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"LITE"] && ![mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ isEqualToString:@"00000000000000000000000000000000"]) {
                [[SearchSupportWebEngine sharedInstance] threadRequestToUpdatingRepairOrders];
            }else {
            [[SearchSupportWebEngine sharedInstance] getRequestForRODetailsOnSavingCustomerAndVehicle];
            [mAppDelegate_.mMasterViewController_ refreshAppointmentOrInprocessData];
            }
        }
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kEDIT_VEHICLE_DETAILS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPUT]) {
        if (mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_) {
            [mAppDelegate_.mEditVehicleViewController_ dismissViewControllerAnimated:YES completion:^{
                [mAppDelegate_.mBeginVehicleCheckInView_ postRequestforCheckin];
            }];
            return;
        }
        [[SearchSupportWebEngine sharedInstance] getRequestForRODetailsOnSavingCustomerAndVehicle];
        [mAppDelegate_.mMasterViewController_ refreshAppointmentOrInprocessData];
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kEDIT_VEHICLE_DETAILS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        if (mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_) {
            [mAppDelegate_.mEditVehicleViewController_ dismissViewControllerAnimated:YES completion:^{
                [mAppDelegate_.mBeginVehicleCheckInView_ postRequestforCheckin];
            }];
            return;
        }
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[SearchVehicleInfoView class]]) {
            [[SearchSupportWebEngine sharedInstance] threadRequestToAddVehicleDetails:mAppDelegate_.mModelForSearchScreen_.mCustomerID_];
        }else
            [mAppDelegate_.mMasterViewController_ refreshAppointmentOrInprocessData];
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kVEHICLE_HISTORY_API]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        [mAppDelegate_.mSearchViewController_ reloadVehicleHistory];
        mAppDelegate_.mWalkAroundLeftViewController_.mShowVehicleHistoryForOpenRO_ = 0;
//        [mAppDelegate_.mWalkAroundLeftViewController_ initDataForCustomerROInformationTableView];
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kVehicle_Check_In]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        [mAppDelegate_.mBeginVehicleCheckInView_ dismissViewControllerAnimated:YES completion:nil];
        [mAppDelegate_.mSearchViewController_ onSuccesofCheckin];
        return;
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kGETSERVICES]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==MAINVIEWCONTROLLER)
            [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
        if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==SERVICESVIEWCONTROLLER){
            [mAppDelegate_.mServicesViewController_ calculateAllTotals];
            [mAppDelegate_.mServicesViewController_.mServicesScheduleTableViewController_.tableView reloadData];
           [mAppDelegate_.mServicesViewController_.mRecommendedServicesTableViewController_.tableView reloadData];
            [mAppDelegate_.mCheckInViewController_.mServicesBeingPerformedTodayView_ reloadData];
        }
        if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==VEHICLEHISTORYSERVICES){
            [mAppDelegate_.mServicesViewController_ calculateAllTotals];
            [mAppDelegate_.mServicesViewController_.mServicesScheduleTableViewController_.tableView reloadData];
            [mAppDelegate_.mServicesViewController_.mRecommendedServicesTableViewController_.tableView reloadData];

            [mAppDelegate_.mMasterViewController_ setRequestforVehicleHistory];
        }
        return;
    }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kOPENROGETSERVICES]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        [mAppDelegate_.mSearchViewController_.mOpenROServicesTableViewController_.tableView reloadData];
        if(mAppDelegate_.mModelforOpenROSupportEngine_.mGetServiceReference_==VEHICLEHISTORYSERVICES){
            [[VehicleHistorySupportWebEngine sharedInstance] getRequestForVehicleHistory];
        }
        if(mAppDelegate_.mModelforOpenROSupportEngine_.mGetServiceReference_==OPENROMAINVIEWCONTROLLER){
            [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForFormID:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
        }
        if(mAppDelegate_.mModelforOpenROSupportEngine_.mGetServiceReference_==FINISHINSPECTIONVIEWCONTROLLER){
            [mAppDelegate_.mSearchViewController_.mOpenROServicesTableViewController_.tableView reloadData];
        }
        }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kADDSERVICES]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForUpdateServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_ ServiceDict:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mServiceDetailsDict_];
    }
        if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kUPDATESERVICE]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPUT]) {
            mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=SERVICESVIEWCONTROLLER;
            [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForGetROLines:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
        }
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kINSPECTIONITEMS]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
        if(mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference==WALKAROUNDINSPECTION)  {
            [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
        }
        else  if(mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference==FINISHINSPECTION)  {
            [mAppDelegate_.mSearchViewController_ pushToFinishServicesViewController];
        }
        else if(mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference==FINISHINSPECTIONVIEW)  {
            [mAppDelegate_.mFinishInspectionViewController_ reloadInspectionItems];

        }
        return;
        }
    
    if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kCOMPLETE_INSPECTION]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPUT]) {
        [[VehicleHistorySupportWebEngine sharedInstance] threadRequestToGetRepairOrders];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchViewController_];
        mAppDelegate_.mSearchViewController_->isFinishInspectionCompleted=TRUE;

    }

}

@end
