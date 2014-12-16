//
//  AppDelegate.h
//  ASRPro
//
//  Created by GuruMurthy on 27/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ECSlidingViewController.h"

#import "SplashScreenSupportWebEngine.h"
#import "SearchSupportWebEngine.h"

#import "OnsuccessProtocol.h"
#import "ChangeUsernameAndAcronymTextColor.h"
#import "GetVehicleDamagepointOnImageView.h"

#import "RequestMethods.h"
#import "WebEngine.h"
#import "ResponseMethods.h"
#import "ParserMethods.h"

#import "ModelForSplashScreen.h"
#import "ModelForEditCustomerScreen.h"
#import "ModelForEditVehicleScreen.h"
#import "SearchDataGetter.h"
#import "ModelForSearchScreen.h"
#import "ModelForVehicleHistory.h"
#import "ModelForWalkAround.h"
#import "ModelForCheckIn.h"
#import "ModelForVehicleHistoryTableView.h"
#import "ModelForNotifications.h"

#import "CustomNavigationController.h"
#import "SplashScreenViewController.h"
#import "SearchViewController.h"
#import "WalkAroundViewController.h"
#import "ServicesViewController.h"
#import "CheckInViewController.h"
#import "LogoutViewController.h"
#import "MasterViewController.h"
#import "BeginVehicleCheckInViewViewController.h"
#import "EditCustomerViewController.h"
#import "EditVehicleViewController.h"
#import "SearchCustomerInfoView.h"
#import "SearchVehicleInfoView.h"
#import "VehicleHistoryViewController.h"
#import "NotificationsViewController.h"
#import "WalkAroundLeftViewController.h"
#import "PrintEmailPopupViewViewController.h"

#import "ModelForServiceRequestWebEngine.h"
#import "ServiceDataGetter.h"

#import "ModelForOpenROInspectionFormWebEngine.h"
#import "OpenROInspectionDataGetter.h"
#import "ModelforOpenROSupportEngine.h"
#import "OpenRoServiceDataGetter.h"
#import "ModelForPartsSupportEngine.h"
#import "FinishInspectionViewController.h"
#import "PartLabourDataGetter.h"

@class ECSlidingViewController;

@class SplashScreenSupportWebEngine;
@class SearchSupportWebEngine;

@class RequestMethods;
@class WebEngine;
@class ResponseMethods;
@class ParserMethods;

@class ModelForSplashScreen;
@class ModelForEditCustomerScreen;
@class ModelForEditVehicleScreen;
@class SearchDataGetter;
@class ModelForSearchScreen;
@class ModelForVehicleHistory;
@class ModelForWalkAround;
@class ModelForCheckIn;
@class ModelForVehicleHistoryTableView;
@class ModelForNotifications;

@class CustomNavigationController;
@class SplashScreenViewController;
@class SearchViewController;
@class WalkAroundViewController;
@class ServicesViewController;
@class CheckInViewController;
@class LogoutViewController;
@class MasterViewController;
@class BeginVehicleCheckInViewViewController;
@class EditCustomerViewController;
@class EditVehicleViewController;
@class SearchCustomerInfoView;
@class SearchVehicleInfoView;
@class BeginVehicleCheckInView;
@class VehicleHistoryViewController;
@class FinishInspectionViewController;
@class NotificationsViewController;
@class WalkAroundLeftViewController;
@class PrintEmailPopupViewViewController;

@class ModelForServiceRequestWebEngine;
@class ServiceDataGetter;
@class ModelForOpenROInspectionFormWebEngine;
@class OpenROInspectionDataGetter;
@class ModelforOpenROSupportEngine;
@class OpenRoServiceDataGetter;
@class ModelForPartsSupportEngine;
@class PartLabourDataGetter;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) ECSlidingViewController *mECSlidingViewController_;

@property (retain, nonatomic) CustomNavigationController *mRootNavigationController_;

@property (retain, nonatomic) id mViewReference_;

#pragma mark --
#pragma mark OnSuccess Delegate
@property (nonatomic,assign) id<OnsuccessProtocol> mOnSuccessDelegate_;
@property (nonatomic,assign) id<ChangeUsernameAndAcronymTextColor> mChangeUsernameAndAcronymTextColor_;
@property (nonatomic,assign) id<GetVehicleDamagepointOnImageView> mGetVehicleDamagepointOnImageView_;
#pragma mark --
#pragma mark Web Engine
@property (nonatomic,retain) WebEngine *mWebEngine_;
@property (nonatomic,retain) ParserMethods *mParserMethods_;
@property (nonatomic,retain) RequestMethods *mRequestMethods_;
@property (nonatomic,retain) ResponseMethods *mResponseMethods_;

#pragma mark --
#pragma mark Models
@property (retain, nonatomic) ModelForSplashScreen *mModelForSplashScreen_;
@property (retain, nonatomic) ModelForEditCustomerScreen *mModelForEditCustomerScreen_;
@property (retain, nonatomic) ModelForEditVehicleScreen *mModelForEditVehicleScreen_;
@property (retain, nonatomic) ModelForVehicleHistory *mModelForVehicleHistory_;
@property (retain, nonatomic) ModelForWalkAround *mModelForWalkAround_;
@property (retain, nonatomic) SearchDataGetter *mSearchDataGetter_;
@property (retain, nonatomic) ModelForSearchScreen *mModelForSearchScreen_;
@property(retain,nonatomic) ModelForServiceRequestWebEngine* mModelForServiceRequestWebEngine_;
@property(retain,nonatomic) ServiceDataGetter* mServiceDataGetter_;
@property(retain,nonatomic) ModelForOpenROInspectionFormWebEngine* mModelForOpenROInspectionFormWebEngine_;
@property(retain,nonatomic) OpenROInspectionDataGetter* mOpenROInspectionDataGetter_;
@property (retain, nonatomic) ModelForCheckIn *mModelForCheckIn_;
@property (retain,nonatomic) ModelforOpenROSupportEngine* mModelforOpenROSupportEngine_;
@property(retain,nonatomic) OpenRoServiceDataGetter*mOpenRoServiceDataGetter_;
@property (retain,nonatomic) ModelForVehicleHistoryTableView* mModelForVehicleHistoryTableView_;
@property(retain,nonatomic) ModelForPartsSupportEngine* mModelForPartsSupportEngine_;
@property(retain,nonatomic) ModelForNotifications *mModelForNotifications_;

#pragma mark --
#pragma mark ViewControllers
@property (strong, nonatomic) IBOutlet SplashScreenViewController *mSplashScreenViewController_;
@property (strong, nonatomic) SearchViewController *mSearchViewController_;
@property (strong, nonatomic) WalkAroundViewController *mWalkAroundViewController_;
@property (strong, nonatomic) ServicesViewController *mServicesViewController_;
@property (strong, nonatomic) CheckInViewController *mCheckInViewController_;
@property (strong, nonatomic) LogoutViewController *mLogoutViewController_;
@property (strong, nonatomic) MasterViewController *mMasterViewController_;
@property (strong, nonatomic) BeginVehicleCheckInViewViewController *mBeginVehicleCheckInView_;
@property (strong, nonatomic) EditCustomerViewController *mEditCustomerViewController_;
@property (strong, nonatomic) EditVehicleViewController *mEditVehicleViewController_;
@property (strong, nonatomic) SearchCustomerInfoView *mSearchCustomerInfoView_;
@property (strong, nonatomic) SearchVehicleInfoView *mSearchVehicleInfoView_;
@property (strong, nonatomic) VehicleHistoryViewController *mVehicleHistoryViewController_;
@property (strong, nonatomic) FinishInspectionViewController* mFinishInspectionViewController_;
@property (strong,nonatomic) NotificationsViewController *mNotificationsViewController_;
@property (strong, nonatomic) WalkAroundLeftViewController *mWalkAroundLeftViewController_;
@property (strong, nonatomic) PrintEmailPopupViewViewController *mPrintEmailPopupViewViewController_;
@property (strong, nonatomic) PartLabourDataGetter *mPartLabourDataGetter_;
#pragma mark --
#pragma mark PublicMethods
- (void)displaySearchScreen;
-(void)showLogin:(UIImageView *)splashimageView;

@end
