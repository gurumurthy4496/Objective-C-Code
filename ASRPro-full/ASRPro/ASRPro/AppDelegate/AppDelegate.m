//
//  AppDelegate.m
//  ASRPro
//
//  Created by GuruMurthy on 27/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize mECSlidingViewController_;

@synthesize mRootNavigationController_;

@synthesize mWebEngine_;
@synthesize mRequestMethods_;
@synthesize mResponseMethods_;
@synthesize mParserMethods_;

@synthesize mModelForSplashScreen_;
@synthesize mServiceDataGetter_;
@synthesize mPartLabourDataGetter_;

@synthesize mModelForVehicleHistory_;
@synthesize mModelForWalkAround_;
@synthesize mModelForEditCustomerScreen_;
@synthesize mModelForEditVehicleScreen_;
@synthesize mMasterViewController_;
@synthesize mModelForCheckIn_;
@synthesize mModelForVehicleHistoryTableView_;
@synthesize mModelForNotifications_;

@synthesize mSplashScreenViewController_;
@synthesize mSearchViewController_;
@synthesize mWalkAroundViewController_;
@synthesize mServicesViewController_;
@synthesize mCheckInViewController_;
@synthesize mLogoutViewController_;
@synthesize mVehicleHistoryViewController_;
@synthesize mFinishInspectionViewController_;
@synthesize mNotificationsViewController_;
@synthesize mWalkAroundLeftViewController_;
@synthesize buildInspectionDetailsViewController;

@synthesize mModelForServiceRequestWebEngine_;
@synthesize mModelForOpenROInspectionFormWebEngine_;
@synthesize mOpenROInspectionDataGetter_;
@synthesize mModelforOpenROSupportEngine_;
@synthesize mOpenRoServiceDataGetter_;
@synthesize mModelForPartsSupportEngine_;


@synthesize mModelForSearchScreen_;
@synthesize mBeginVehicleCheckInView_;
@synthesize mChangeUsernameAndAcronymTextColor_;
@synthesize mEditCustomerViewController_;
@synthesize mEditVehicleViewController_;
@synthesize mGetVehicleDamagepointOnImageView_;
@synthesize mOnSuccessDelegate_;
@synthesize mSearchCustomerInfoView_;
@synthesize mSearchDataGetter_;
@synthesize mSearchVehicleInfoView_;
@synthesize mViewReference_;

@synthesize isCustomHeaderViewFullOrLight;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    // ----------------------------;
    // Initialize NetworkMonitor;
    // ----------------------------;
    [self initializeNetworkMonitor];
    
    // ----------------------------;
    // Initialize WebEngine,Model,ViewControllers;
    // ----------------------------;
    [self initializeViewControllers];
    [self initializeModel];
    [self initializeWebEngine];
    
    // ----------------------------;
    // Calling method displaySplashScreen;
    // ----------------------------;
    [self displaySplashScreen];
    
    // ----------------------------;
    // Initialization for BarcodeScanner;
    // ----------------------------;
//    if (self.mSearchViewController_ != nil) {
//        [self.modelForBarCode applicationDidBecomeActive:application viewController:self.mSearchViewController_];
//    }
    
    // ----------------------------;
    // Add registration for remote notifications;
    // ----------------------------;
    [self registerForRemoteNotification:application launchingWithOptions:launchOptions];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark --
#pragma mark Private Methods
- (void)initializeNetworkMonitor {
    [[NSNotificationCenter defaultCenter] addObserver: [NetworkMonitor instance] selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    [[NetworkMonitor instance]initNetworkInstance];
}

- (void)initializeViewControllers {
    
}

- (void)initializeModel {
    self.mModelForSplashScreen_ = [[ModelForSplashScreen alloc] init];
    self.mSearchDataGetter_ = [[SearchDataGetter alloc] init];
    [self.mSearchDataGetter_ initData];
    self.mModelForServiceRequestWebEngine_=[ModelForServiceRequestWebEngine new];
    self.mModelForSearchScreen_ = [ModelForSearchScreen new];
    self.mModelForVehicleHistory_ = [[ModelForVehicleHistory alloc] init];
    self.mModelForWalkAround_ = [[ModelForWalkAround alloc] init];
    self.mModelForEditVehicleScreen_ = [ModelForEditVehicleScreen new];
    self.mModelForEditCustomerScreen_ = [ModelForEditCustomerScreen new];
    self.mModelForOpenROInspectionFormWebEngine_=[ModelForOpenROInspectionFormWebEngine new];
    self.mOpenROInspectionDataGetter_=[OpenROInspectionDataGetter new];
    self.mServiceDataGetter_ = [[ServiceDataGetter alloc] init];
    self.mModelForCheckIn_ = [[ModelForCheckIn alloc] init];
    self.mModelforOpenROSupportEngine_ = [[ModelforOpenROSupportEngine alloc] init];
    self.mOpenRoServiceDataGetter_ = [[OpenRoServiceDataGetter alloc] init];
    self.mModelForVehicleHistoryTableView_ = [[ModelForVehicleHistoryTableView alloc] init];
    self.mModelForPartsSupportEngine_ = [[ModelForPartsSupportEngine alloc] init];
    self.mModelForNotifications_ = [[ModelForNotifications alloc] init];
    [self.mModelForNotifications_ initTheDataForNotifications];
    self.mPartLabourDataGetter_ = [[PartLabourDataGetter alloc] init];
//    self.modelForBarCode = [[ModelForBarCode alloc] init];
//    [self.modelForBarCode initWithData];
    //    [self.mModelForSplashScreen_ setPreviousDate];
}

- (void)initializeWebEngine {
    mWebEngine_ = [[WebEngine alloc]init];
    mParserMethods_=[[ParserMethods alloc]init];
    mRequestMethods_=[[RequestMethods alloc]init];
    mResponseMethods_=[[ResponseMethods alloc]init];
}

- (void)registerForRemoteNotification :(UIApplication *)aUIApplication launchingWithOptions:(NSDictionary *)alaunchOptions{
    // Add registration for remote notifications
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    
    // Clear application badge when app launches
    aUIApplication.applicationIconBadgeNumber = 0;
    
    self.mModelForNotifications_.mIsNotificationButtonClicked_ = TRUE;
    self.mModelForNotifications_.mHasNotificationsForAdvisor_ = FALSE;
    self.mModelForNotifications_.mHasNotificationsForTechnician_ = FALSE;
    self.mModelForNotifications_.mHasNotificationsForManager_ = FALSE;
    
    // ----------------------------;
    // See if we were launched due to a push notification;
    // ----------------------------;
    NSDictionary *userInfo = [alaunchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        if ([self respondsToSelector:@selector(handlePushNotification:)]) {
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber: -1];
            [self performSelector:@selector(handlePushNotification:) withObject:userInfo afterDelay:2];
        }
    }
}

// ----------------------------;
// Handle an incoming push
// ----------------------------;
- (void)handlePushNotification:(NSDictionary *)userInfo {
    
    if (self.mModelForSplashScreen_.mLoginDataArray_ == nil) {
        
        self.mModelForSplashScreen_.mLoginDataArray_ = [[SharedUtilities sharedUtilities] retrieveDictionaryFromFile:kStore_Username_Role_In_Files];
        
        [self.mModelForSplashScreen_ StoreUserDetailsEmployeeID:[[self.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"ID"] StoreID:[[self.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"StoreID"] EmployeeType:[[[self.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"EmployeeType"] valueForKey:@"Name"]];
    }
    
    DLog(@"PUSH NOTIFICATION DICT:-%@",userInfo);
    
    DLog(@"MEMOEY FOR NOTIFICATION ARRAY :-%@",[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_]mAllDataForNotificationsArray_]);
    
    //    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_]mAllDataForNotificationsArray_] addObject:userInfo];
    
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_]mAllDataForNotificationsArray_] insertObject:userInfo atIndex:0];
    
    if (([[userInfo objectForKey:@"RecipientID"] integerValue] == [[[self mModelForSplashScreen_] mEmployeeID_] integerValue]) && ([[self mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"])) {
        self.mModelForNotifications_.mHasNotificationsForTechnician_ = TRUE;
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:FALSE];
        // ----------------------------;
        // Removing the object under 25(row) and adding the new notification under 25(row) the notification count should not exceed 25;
        // ----------------------------;
        if ([[self mModelForNotifications_].mNotificationsArray_ count] >= 25) {
            [[self mModelForNotifications_].mNotificationsArray_ removeObjectAtIndex:24];
        }
        
        [[self mModelForNotifications_].mNotificationsArray_ insertObject:userInfo atIndex:0];
        
        // ----------------------------;
        // Set the count for Notification badge;
        // ----------------------------;
        [[self mModelForNotifications_] methodToSetNewNotificationCount:[[[self mModelForNotifications_] mNotificationsArray_] count]];
        [[self mNotificationsViewController_] reloadNotificationDataInTableView];
        DLog(@"TECHNICIAN NOTIFICATIONS ARRAY:-%@",[self mModelForNotifications_].mNotificationsArray_);
        
    }else if ([[userInfo  objectForKey:@"RecipientID"] integerValue] == [[[self mModelForSplashScreen_] mEmployeeID_] integerValue]&& ([[self mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])) {
        self.mModelForNotifications_.mHasNotificationsForAdvisor_ = TRUE;
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:FALSE];
        // ----------------------------;
        // Removing the object under 25(row) and adding the new notification under 25(row) the notification count should not exceed 25;
        // ----------------------------;
        
        if ([[self mModelForNotifications_].mNotificationsArray_ count] >= 25) {
            [[self mModelForNotifications_].mNotificationsArray_ removeObjectAtIndex:24];
        }
        
        [[self mModelForNotifications_].mNotificationsArray_ insertObject:userInfo atIndex:0];
        
        // ----------------------------;
        // Set the count for Notification badge;
        // ----------------------------;
        [[self mModelForNotifications_] methodToSetNewNotificationCount:[[[self mModelForNotifications_] mNotificationsArray_] count]];
        [[self mNotificationsViewController_] reloadNotificationDataInTableView];
        DLog(@"ADVISOR NOTIFICATIONS ARRAY:-%@",[self mModelForNotifications_].mNotificationsArray_);
        
    }else {
        self.mModelForNotifications_.mHasNotificationsForManager_ = TRUE;
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:FALSE];
        // ----------------------------;
        // Removing the object under 25(row) and adding the new notification under 25(row) the notification count should not exceed 25;
        // ----------------------------;
        
        if ([[self mModelForNotifications_].mNotificationsArray_ count] >= 25) {
            [[self mModelForNotifications_].mNotificationsArray_ removeObjectAtIndex:24];
        }
        
        [[self mModelForNotifications_].mNotificationsArray_ insertObject:userInfo atIndex:0];
        
        // ----------------------------;
        // Set the count for Notification badge;
        // ----------------------------;
        [[self mModelForNotifications_] methodToSetNewNotificationCount:[[[self mModelForNotifications_] mNotificationsArray_] count]];
        [[self mNotificationsViewController_] reloadNotificationDataInTableView];
        DLog(@"Manager NOTIFICATIONS ARRAY:-%@",[self mModelForNotifications_].mNotificationsArray_);
    }
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    NSString *alert;
    //    NSString *badge;
    if (aps == nil) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Problem" message:@"No Message Avilable" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"View", nil];
        [alertView show];
        RELEASE_NIL(alertView);
    } else {
        alert = [aps objectForKey:@"alert"];
        //        badge = [aps objectForKey:@"badge"];
        
        if (alert == nil) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Problem" message:@"alert did not exist" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"View", nil];
            [alertView show];
            RELEASE_NIL(alertView);
        } else {
            /*if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {*/
            // app was already in the foreground
            if ([[userInfo  objectForKey:@"RecipientID"] integerValue] == [[[self mModelForSplashScreen_] mEmployeeID_] integerValue]) {
                UIAlertView *pushNotificationAlertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@", [((NSDictionary *)[userInfo objectForKey:@"aps"]) objectForKey:@"alert"]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [pushNotificationAlertView show];
                RELEASE_NIL(pushNotificationAlertView);
            }
            /* } else {*/
            
            //              [UIApplication sharedApplication].applicationIconBadgeNumber = [badge integerValue];
            
            /* }*/
        }
    }
}

- (void)failIfSimulator {
    if ([[[UIDevice currentDevice] model] compare:@"iPhone Simulator"] == NSOrderedSame) {
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                            message:@"You will not be able to recieve push notifications in the simulator."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [someError show];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];// to register notification
    }
}

#pragma mark --
#pragma mark Public Methods

// ----------------------------;
// Add SplashScreenViewController to Window;
// ----------------------------;
- (void)displaySplashScreen {
    [self.window setRootViewController:self.mSplashScreenViewController_];
    [self.mSplashScreenViewController_.mSplashScreenActivityIndicator_ startAnimating];
    [self.mSplashScreenViewController_.view.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *lView = object;
        if (lView.tag != 1 && lView.tag != 2) {
            lView.hidden = TRUE;
        }else {
            lView.hidden = FALSE;
            if ([lView isKindOfClass:[UIImageView class]]) {
                [(UIImageView *)lView setImage:[UIImage imageNamed:@"Splash-Landscape"]];
            }
        }
    }];
    
    [self performSelector:@selector(showLogin:) withObject:self.mSplashScreenViewController_.mSplashScreenImageView_ afterDelay:2.0];
}

-(void)showLogin:(UIImageView *)splashimageView {
    // ----------------------------;
    // If Logout show the SplashScreenViewController(login) or show RO Modes screen and add it to Window ;
    // ----------------------------;
    [splashimageView removeFromSuperview];
    
    [self.mSplashScreenViewController_.mSplashScreenActivityIndicator_ stopAnimating];
    
    self.mSplashScreenViewController_.view.frame = [[UIScreen mainScreen] bounds];
    
    NSArray *lEmpID_StoreID = [[SharedUtilities sharedUtilities] readObjectFromUserDefaultsforKey:kUserDefaults_TokenAndUserID_Key];
    
    DLog(@"Employee_ID & StoreID ->%@",lEmpID_StoreID);
    
    // ----------------------------;
    // If Condition to show RO Modes screen and add it to Window; else condition to show Login screen;
    // ----------------------------;
    
    if (lEmpID_StoreID != nil) {
        self.mModelForSplashScreen_.mLoginDataArray_ = [[SharedUtilities sharedUtilities] retrieveDictionaryFromFile:kStore_Username_Role_In_Files];
        [[self mModelForSplashScreen_] changingProductionAPIForSpecificStore];
        self.mModelForWalkAround_.mVehicleDiagramSetsArray_ = (NSMutableArray *)[[SharedUtilities sharedUtilities] retrieveArrayFromFile:kStore_VehicleDiagrams_sets_Array];
        [self.mModelForSplashScreen_ StoreUserDetailsEmployeeID:[[self.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"ID"] StoreID:[[self.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"StoreID"] EmployeeType:[[[self.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"EmployeeType"] valueForKey:@"Name"]];
        
        
        int AppSettings = [[[[self.mModelForSplashScreen_.mLoginDataArray_ valueForKey:@"Store"] valueForKey:@"AppSettings"] valueForKey:@"IPadVersion"] integerValue];
        
        self.isCustomHeaderViewFullOrLight = [[self mModelForSplashScreen_] returnAppSettingsISFullOrLiteVersion:AppSettings];
        DLog(@"%@",self.isCustomHeaderViewFullOrLight);
        
        [self displaySearchScreen];
        
        
    }else {
        
        [self.mSplashScreenViewController_.view.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            UIView *lView = object;
            if (lView.tag == 1 && lView.tag == 2) {
                lView.hidden = TRUE;
            }else {
                lView.hidden = FALSE;
            }
        }];
        
        NSArray *lUserNameStoreID = [[SharedUtilities sharedUtilities] readObjectFromUserDefaultsforKey:kStore_Username_StoreID_In_Files];
        
        [self.mSplashScreenViewController_.mLoginScrollView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            UITextField *lTextFiled_ = object;
            switch (lTextFiled_.tag) {
                case 5: // Username TextField;
                    [lTextFiled_ setText:[lUserNameStoreID objectAtIndex:0]];
                    break;
                case 7: // StoreID TextField;
                    [lTextFiled_ setText:[lUserNameStoreID objectAtIndex:1]];
                    break;
                default:
                    break;
            }
        }];
    }
}

- (void)displaySearchScreen {
    [self failIfSimulator];
    [[SplashScreenSupportWebEngine sharedInstance] postRequestToAddDeviceToken];
    // ----------------------------;
    // Method to find Role for Login User;
    // ----------------------------;
    [self.mModelForSplashScreen_ toFindRoleOfLoginUser];
    
    // ----------------------------;
    // Get saved data for Notifications;
    // ----------------------------;
    [self getSavedDataForNotifications];
    
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"]) {
        self.mModelForNotifications_.mNotificationsCount_ = self.mModelForNotifications_.mAdvisorNotificationCount_;
        DLog(@"%d",self.mModelForNotifications_.mAdvisorNotificationCount_);
    }else if([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]) {
        self.mModelForNotifications_.mNotificationsCount_ = self.mModelForNotifications_.mTechnicianNotificationCount_;
        DLog(@"%d",self.mModelForNotifications_.mTechnicianNotificationCount_);
    }else {
        self.mModelForNotifications_.mNotificationsCount_ = self.mModelForNotifications_.mManagerNotificationCount_;
        DLog(@"%d",self.mModelForNotifications_.mManagerNotificationCount_);
    }
    
    // ----------------------------;
    // SearchViewController object -> mSearchViewController_;
    // ----------------------------;
    
    SearchViewController *lSearchViewController_ = [[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
    [self setMSearchViewController_:lSearchViewController_];
    lSearchViewController_ = nil;
    
    // ----------------------------;
    // ECSlidingViewController object -> mECSlidingViewController_;
    // ----------------------------;
    
    ECSlidingViewController *lSlidingViewController =[[ECSlidingViewController alloc] init];
    self.mECSlidingViewController_ = lSlidingViewController;
    lSlidingViewController = nil;
    
    // ----------------------------;
    // RootNavigationController_.view removeFromSuperview;
    // ----------------------------;
    
    if([mRootNavigationController_.view superview]){
        [mRootNavigationController_.view removeFromSuperview];
    }
    
    // ----------------------------;
    // RootNavigationController object -> mRootNavigationController_;
    // ----------------------------;
    
    mRootNavigationController_ = [[CustomNavigationController alloc] initWithRootViewController:self.mECSlidingViewController_];// iOS 6 autorotation fix
    
    // ----------------------------;
    // ECSlidingViewController set TopView as RepairOrderModesViewController;
    // ----------------------------;
    
    self.mECSlidingViewController_.topViewController = mSearchViewController_;
    
    // ----------------------------;
    // ADD LeftView to ECS_Sliding -> WalkAroundLeftSlider;
    // ----------------------------;
    WalkAroundLeftViewController *lViewControler = [[WalkAroundLeftViewController alloc] init];
    [self setMWalkAroundLeftViewController_:lViewControler];
    
    [self.mWalkAroundLeftViewController_.view setBackgroundColor:[UIColor ASRProRGBColor:66 Green:66 Blue:68]];
    if (![self.mECSlidingViewController_.underLeftViewController isKindOfClass:[WalkAroundLeftViewController class]]) {
        self.mECSlidingViewController_.underLeftViewController  = self.mWalkAroundLeftViewController_;
    }
    
    [self.window setRootViewController:mRootNavigationController_];// iOS 6 autorotation fix
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [self.mRequestMethods_ getRepairOrders];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}



- (void)getSavedDataForNotifications {
    
    NSMutableArray *lTempMutableArray_ = [[NSMutableArray alloc]initWithArray:[[SharedUtilities sharedUtilities] readObjectFromUserDefaultsforKey:kAllNotificationsArray_Key]];
    
    
    [self mModelForNotifications_].mAllDataForNotificationsArray_ = lTempMutableArray_;
    
    RELEASE_NIL(lTempMutableArray_);
    
    DLog(@"SAVED NOTIFICATIOND ARRAY :-%@",[self mModelForNotifications_].mAllDataForNotificationsArray_);
    
    if ([[self mModelForNotifications_].mAllDataForNotificationsArray_ count] > 0) {
        
        DLog(@"EMP ID :-%@",[[self mModelForSplashScreen_] mEmployeeID_]);
        
        NSPredicate *lCurrentModePredicate = [NSPredicate predicateWithFormat:@"RecipientID = %d",[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeeID_] integerValue]];
        
        NSMutableArray *lDummyArray = [[self mModelForNotifications_].mAllDataForNotificationsArray_ mutableCopy];
        
        NSArray *lTempArray = [lDummyArray  filteredArrayUsingPredicate:lCurrentModePredicate];
        RELEASE_NIL(lDummyArray);
        NSMutableArray *lTempMutableArray = [[NSMutableArray alloc] initWithArray:lTempArray];
        
        if ([[self mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]) {
            
            // ----------------------------;
            // Removing the object under 25(row) and adding the new notification under 25(row) the notification count should not exceed 25;
            // ----------------------------;
            for (int i = 0; i < [lTempMutableArray count]; i++) {
                if ([lTempMutableArray count] > 25) {
                    
                    [lTempMutableArray removeObjectAtIndex:24];
                }
            }
            
            [self mModelForNotifications_].mNotificationsArray_ = lTempMutableArray;
            
            // ----------------------------;
            // Set the count for Notification badge;
            // ----------------------------;
            [[self mModelForNotifications_] methodToSetNewNotificationCount:0];
            
            DLog(@"TECHNICIAN MAIN NOTIFICATIONS ARRAY:-%@",[self mModelForNotifications_].mNotificationsArray_);
            
        }else if ([[self mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"]) {
            
            // ----------------------------;
            // Removing the object under 25(row) and adding the new notification under 25(row) the notification count should not exceed 25;
            // ----------------------------;
            for (int i = 0; i < [lTempMutableArray count]; i++) {
                if ([lTempMutableArray count] > 25) {
                    [lTempMutableArray removeObjectAtIndex:24];
                }
            }
            [self mModelForNotifications_].mNotificationsArray_ = lTempMutableArray;
            
            // ----------------------------;
            // Set the count for Notification badge;
            // ----------------------------;
            [[self mModelForNotifications_] methodToSetNewNotificationCount:0];
            
            DLog(@"ADVISOR MAIN NOTIFICATIONS ARRAY:-%@",[self mModelForNotifications_].mNotificationsArray_);
        }else if ([[self mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Manager"]) {
            
            // ----------------------------;
            // Removing the object under 25(row) and adding the new notification under 25(row) the notification count should not exceed 25;
            // ----------------------------;
            for (int i = 0; i < [lTempMutableArray count]; i++) {
                if ([lTempMutableArray count] > 25) {
                    [lTempMutableArray removeObjectAtIndex:24];
                }
            }
            [self mModelForNotifications_].mNotificationsArray_ = lTempMutableArray;
            
            // ----------------------------;
            // Set the count for Notification badge;
            // ----------------------------;
            [[self mModelForNotifications_] methodToSetNewNotificationCount:0];
            
            DLog(@"MANAGER MAIN NOTIFICATIONS ARRAY:-%@",[self mModelForNotifications_].mNotificationsArray_);
        }else {
            [self mModelForNotifications_].mNotificationsArray_ = lTempMutableArray;
            
            // ----------------------------;
            // Set the count for Notification badge;
            // ----------------------------;
            [[self mModelForNotifications_] methodToSetNewNotificationCount:0];
            
            DLog(@"MAIN NOTIFICATIONS ARRAY:-%@",[self mModelForNotifications_].mNotificationsArray_);
        }
        RELEASE_NIL(lTempMutableArray);
    }
}

#pragma mark --
#pragma mark Push Notification Delegates

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    // Prepare the Device Token for Registration (remove spaces and < >)
    NSString *  _pToken=[[NSString alloc] initWithString:[[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<"withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString: @" " withString: @""]];
    [[SplashScreenSupportWebEngine sharedInstance] setMDeviceToken_:_pToken];
    DLog(@" DEVICE TOKEN :%@",_pToken);
//    [[SharedUtilities sharedUtilities] showAlertWithTitle:@"DeviceToken" message:_pToken];
//    [[SplashScreenSupportWebEngine sharedInstance] postRequestToAddDeviceToken];
    _pToken = nil;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (UIApplicationStateBackground) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: -1];
        DLog(@"===========================");
        DLog(@"App was in BACKGROUND...");
        if ([self respondsToSelector:@selector(handlePushNotification:)]) {
            [self performSelector:@selector(handlePushNotification:) withObject:userInfo];
        }
    }
    else if (UIApplicationStateActive == TRUE) {
        DLog(@"===========================");
        DLog(@"App was ACTIVE");
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: -1];
        if ([self respondsToSelector:@selector(handlePushNotification:)]) {
            [self performSelector:@selector(handlePushNotification:) withObject:userInfo];
        }
    }
    else {
        DLog(@"===========================");
        DLog(@"App was NOT ACTIVE");
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: -1];
        /*UIAlertView *BOOM = [[UIAlertView alloc] initWithTitle:@"BOOM"
         message:@"app was INACTIVE"
         delegate:self
         cancelButtonTitle:@"a-ha!"
         otherButtonTitles:nil];
         [BOOM show];*/
        DLog(@"App was NOT ACTIVE");
    }
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    DLog(@"Failed to get token, error: %@", error);
    UIAlertView *notificationAlertView = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"%@", error] delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"View", nil];
    [notificationAlertView show];
    notificationAlertView = nil;
}

#pragma mark --
#pragma mark OrientationMethods
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window  // iOS 6 autorotation fix
{
    return UIInterfaceOrientationMaskAll;
    //    return UIInterfaceOrientationMaskAll;
}

#pragma mark --
#pragma mark application Status
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self.mModelForNotifications_ saveDataForNotifications];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //    [self.mModelForSplashScreen_ checkWhetherDateIsChanged];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
