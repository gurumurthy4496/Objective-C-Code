//
//  ModelForNotifications.m
//  ASRPro
//
//  Created by GuruMurthy on 05/11/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ModelForNotifications.h"

@implementation ModelForNotifications
@synthesize mAllDataForNotificationsArray_;
@synthesize mNotificationsCount_;

@synthesize mNotificationsArray_;
@synthesize mNotificationButton_;


@synthesize mIsNotificationButtonClicked_;

@synthesize mHasNotificationsForManager_;
@synthesize mHasNotificationsForTechnician_;
@synthesize mHasNotificationsForAdvisor_;

@synthesize mManagerNotificationCount_;
@synthesize mAdvisorNotificationCount_;
@synthesize mTechnicianNotificationCount_;

@synthesize mNotificationsRONumber_;

- (void)initTheDataForNotifications {
    mAllDataForNotificationsArray_ = [[NSMutableArray alloc] init];
    mNotificationsArray_ = [[NSMutableArray alloc] init];
    mNotificationsCount_ = 0;
}

- (void)methodToSetNewNotificationCount :(int)aNotificationCount {
    LogBool([self mHasNotificationsForAdvisor_]);
    LogBool([self mIsNotificationButtonClicked_]);
    if (aNotificationCount) {
        self.mNotificationsCount_++;
        [self.mNewNotificationCountButton_ setHidden:FALSE];
    }else {
        [self.mNewNotificationCountButton_ setHidden:TRUE];
    }
    [self.mNewNotificationCountButton_ setTitle:[NSString stringWithFormat:@"%d",self.mNotificationsCount_] forState:UIControlStateNormal];
}


- (void)saveDataForNotifications {
    [[SharedUtilities sharedUtilities] writeObjectToUserDefaults:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mAllDataForNotificationsArray_] forKey:kAllNotificationsArray_Key];
}

#pragma mark --
#pragma mark PublicMethods
- (void)methodToShowNotificationNumber {
    LogBool([self mHasNotificationsForAdvisor_]);
    LogBool([self mIsNotificationButtonClicked_]);
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"]) {
        if ([self mIsNotificationButtonClicked_] && ![self mHasNotificationsForAdvisor_]) {
            [[self mNewNotificationCountButton_] setHidden:YES];
        }else {
            [[self mNewNotificationCountButton_] setHidden:NO];
            [self.mNewNotificationCountButton_ setTitle:[NSString stringWithFormat:@"%d",self.mNotificationsCount_] forState:UIControlStateNormal];
        }
    }else if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]){
        if ([self mIsNotificationButtonClicked_] && ![self mHasNotificationsForTechnician_]) {
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:YES];
        }else {
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:NO];
            [self.mNewNotificationCountButton_ setTitle:[NSString stringWithFormat:@"%d",self.mNotificationsCount_] forState:UIControlStateNormal];
        }
    }else {
        if ([self mIsNotificationButtonClicked_] && ![self mHasNotificationsForManager_]) {
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:YES];
        }else {
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:NO];
            [self.mNewNotificationCountButton_ setTitle:[NSString stringWithFormat:@"%d",self.mNotificationsCount_] forState:UIControlStateNormal];
        }
    }
    
}

// ----------------------------;
// Method to Present & Dismiss "Notifications" veiew controller;
// ----------------------------;
- (void)presentNotificationsViewController {
    if ([[SharedUtilities sharedUtilities] appDelegateInstance].mNotificationsViewController_ == nil) {
        //Initializing the Notifications ViewController.
        NotificationsViewController *lNotificationsViewController = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
        [[[SharedUtilities sharedUtilities] appDelegateInstance] setMNotificationsViewController_:lNotificationsViewController];
    }
   
    [[SharedUtilities sharedUtilities] appDelegateInstance].mNotificationsViewController_.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController presentViewController:[[[SharedUtilities sharedUtilities] appDelegateInstance] mNotificationsViewController_] animated:YES completion:nil];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:TRUE];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] setMIsNotificationButtonClicked_:TRUE];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] setMNotificationsCount_:0];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mNotificationsViewController_] reloadNotificationDataInTableView];
}

- (void)dismissNotificationsViewController {
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logoutButtonAction:(id)sender {
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mChangeUsernameAndAcronymTextColor_ = self;
    [self changeTheTextForUsernameAndAcronymLabel:sender];
    [self showLogoutView];
}

#pragma mark --
#pragma mark Private Methods
/**
 * Change the text color for the username and acronym lables.
 */
-(void)changeTheTextForUsernameAndAcronymLabel:(id)aButton {
    UIButton *logoutbutton = aButton;
    UIView *lView = logoutbutton.superview;
    __block UIButton *lButton;
    __block UILabel *lUsername;
    __block UILabel *lAcronym;
    [lView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
        UIView *lTempView = object;
        if (lTempView.tag == 5) {
            lButton = (UIButton *)lTempView;
            lButton.selected = !lButton.selected;
        }else if (lTempView.tag == 6) {
            lUsername = (UILabel *)lTempView;
        }else if (lTempView.tag == 7) {
            lAcronym = (UILabel *)lTempView;
        }
    }];
    if (lButton.selected) {
        lUsername.textColor = [UIColor whiteColor];
        lAcronym.textColor = [UIColor whiteColor];
    }else {
        lUsername.textColor = [UIColor ASRProBlueColor];
        lAcronym.textColor = [UIColor ASRProBlueColor];
    }
}

/**
 * Show the Logout button.
 */
- (void)showLogoutView {
    if([[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view superview]){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view removeFromSuperview];
    }
    
    if ([[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_ == nil) {
        LogoutViewController *lViewController = [[LogoutViewController alloc]initWithNibName:@"LogoutViewController" bundle:nil];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_ =lViewController;
    }
    //If LogoutViewController is not a superview then add to Subview.
    
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view setBackgroundColor:[UIColor clearColor]];
    
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mNotificationsViewController_.view addSubview:[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mNotificationsViewController_.view bringSubviewToFront:[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view];
}


- (void)threadRequestToGetRepairOrdersInNotifications {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
//        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders",WEBSERVICEURL,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mStoreID_];
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders?UserID=%@",WEBSERVICEURL,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mStoreID_,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeID_];

        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToGetListOfRepairOrdersInNotifications:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

// ----------------------------;
// Method to get list of RepairOrders;
// ----------------------------;
- (void)requestToGetListOfRepairOrdersInNotifications: (NSObject *) myObject {
    
    NSError *jsonError;
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
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"Appointments RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mRepairOrdersData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                                                    options:kNilOptions error:&jsonError];
    DLog(@"Appointments Data Array :-%@",[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mRepairOrdersData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForRepairOrdersInNotifications:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)onSuccessForRepairOrdersInNotifications:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode) {
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSearchScreen_ getInprocessListFromRepairOrders];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mOnSuccessDelegate_ OnsuccessResponseForRequest];

    }
}

- (void)checkTheNotifiationBadgeCount:(UIView *)aView {
    [aView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *view = (UIView *)object;
        if (view.tag == 1) {
            [view.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
                UIButton *button = (UIButton *)object1;
                DLog(@"%@",button);
                if (button.tag == 1001) {
                    self.mNewNotificationCountButton_ = button;
                    [self methodToShowNotificationNumber];
                }
            }];
        }
    }];
}

@end
