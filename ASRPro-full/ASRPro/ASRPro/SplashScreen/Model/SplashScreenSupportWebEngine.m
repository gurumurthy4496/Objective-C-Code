//
//  SplashScreenSupportWebEngine.m
//  ASRPro
//
//  Created by GuruMurthy on 08/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "SplashScreenSupportWebEngine.h"
#import "WalkAroundSupportWebEngine.h"

#define DeviceTypeID @"7" // 7 value for iPad & 5 Value for iPhone

static SplashScreenSupportWebEngine *sharedSplashScreenSupportWebEngine = nil;


@implementation SplashScreenSupportWebEngine
@synthesize mDeviceToken_;

+ (id)sharedInstance {
    @synchronized(self) {
        if(sharedSplashScreenSupportWebEngine == nil)
            sharedSplashScreenSupportWebEngine = [[super allocWithZone:NULL] init];
    }
    return sharedSplashScreenSupportWebEngine;
}

#pragma mark --
#pragma mark Singleton Methods


+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (id)init {
    if (self = [super init]) {
        //        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark --
#pragma mark BG Thread To Get Appointments
- (void)BGthreadRequestToGetAppointments {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Appointments",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(BGrequestToGetListOfAppointments:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

// ----------------------------;
// Method to get list of Appointments;
// ----------------------------;
- (void)BGrequestToGetListOfAppointments: (NSObject *) myObject {
    
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
    mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                             options:kNilOptions error:&jsonError];
    DLog(@"Appointments Data Array :-%@",mAppDelegate_.mSearchDataGetter_.mAppointmentListData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(BGonSuccessForAppointments:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)BGonSuccessForAppointments:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        [mAppDelegate_.mMasterViewController_ setMAppointmentsData_:[mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ mutableCopy]];
        [mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ reloadData];
    }
}

#pragma mark --
#pragma mark LOGIN_API_Authentication_POST
- (void)postRequestForLogin {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        mAppDelegate_.mOnSuccessDelegate_ = self;
        [[SharedUtilities sharedUtilities] createLoadView];
         mAppDelegate_.mModelForSplashScreen_.mStoreID_ = [NSString stringWithFormat:@"%@",[[SharedUtilities sharedUtilities] getIntFromString:mAppDelegate_.mModelForSplashScreen_.mStoreID_]];
        [mAppDelegate_.mModelForSplashScreen_ changingProductionAPIForSpecificStore];
        [mAppDelegate_.mRequestMethods_ postRequestForLogin:mAppDelegate_.mModelForSplashScreen_.mUserName_
                                                   Password:mAppDelegate_.mModelForSplashScreen_.mPassword_
                                                    StoreID:mAppDelegate_.mModelForSplashScreen_.mStoreIDWithContext_];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

#pragma mark --
#pragma mark POST_REQUEST_FOR_DEVICE_TOKEN
- (void)postRequestToAddDeviceToken {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Employees/%@/Devices",WEBSERVICEURL,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mStoreID_,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        DLog(@" PUSH REQUEST :-%@",mRequestStr);
//        [self setMDeviceToken_:aDeviceToken];
        [NSThread detachNewThreadSelector:@selector(threadForpostRequestToAddDeviceToken:) toTarget:[SplashScreenSupportWebEngine sharedInstance] withObject: mRequestStr];
        
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        // return;
    }
}

- (void)OnsuccessResponseForRequest {
    
    int AppSettings = [[[[mAppDelegate_.mModelForSplashScreen_.mLoginDataArray_ valueForKey:@"Store"] valueForKey:@"AppSettings"] valueForKey:@"IPadVersion"] integerValue];
    
    mAppDelegate_.isCustomHeaderViewFullOrLight = [[mAppDelegate_ mModelForSplashScreen_] returnAppSettingsISFullOrLiteVersion:AppSettings];
    DLog(@"%@",mAppDelegate_.isCustomHeaderViewFullOrLight);
    
    
    [self cacheRequestForASRProUSApplication];
    // ----------------------------;
    // Storing LogIn Response in to files and storing EmployeeID;
    // ----------------------------;
    
    [[SharedUtilities sharedUtilities] saveDictionaryInToFile:mAppDelegate_.mModelForSplashScreen_.mLoginDataArray_ :kStore_Username_Role_In_Files];
    
   [mAppDelegate_.mModelForSplashScreen_ StoreUserDetailsEmployeeID:[[mAppDelegate_.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"ID"] StoreID:[[mAppDelegate_.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"StoreID"] EmployeeType:[[[mAppDelegate_.mModelForSplashScreen_.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"EmployeeType"] valueForKey:@"Name"]];
    
    NSMutableArray *lUserNameAndStoreID = [[NSMutableArray alloc ] init];
    [lUserNameAndStoreID addObject:mAppDelegate_.mModelForSplashScreen_.mUserName_];
    [lUserNameAndStoreID addObject:mAppDelegate_.mModelForSplashScreen_.mStoreIDWithContext_];
    
    [[SharedUtilities sharedUtilities] writeObjectToUserDefaults:lUserNameAndStoreID forKey:kStore_Username_StoreID_In_Files];
    RELEASE_NIL(lUserNameAndStoreID);
    mAppDelegate_.mModelForSplashScreen_.mPassword_ = @"";
    
    // ----------------------------;
    // StoreID in to UserDefaults;
    // ----------------------------;
    NSArray *lTokenAndUserId = [NSArray arrayWithObjects:mAppDelegate_.mModelForSplashScreen_.mEmployeeID_,mAppDelegate_.mModelForSplashScreen_.mStoreID_,nil];
    [[SharedUtilities sharedUtilities] writeObjectToUserDefaults:lTokenAndUserId forKey:kUserDefaults_TokenAndUserID_Key];
    
    [mAppDelegate_.mSplashScreenViewController_.view removeFromSuperview];
    
    SplashScreenViewController *lSplashScreenViewController_ = [[SplashScreenViewController alloc]initWithNibName:@"SplashScreenViewController" bundle:nil];
    [mAppDelegate_ setMSplashScreenViewController_:lSplashScreenViewController_];
    lSplashScreenViewController_ = nil;
    mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=BACKGROUNDTHREADSERVICES;

    [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForAllServiceLines];
    [mAppDelegate_.mModelForPartsSupportEngine_ RequestFoGetLocations];
    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForGetPayTypes];

    [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForLoadingInspectionFormList];

    [mAppDelegate_ displaySearchScreen];
}

// ----------------------------;
// Method for sendong device token;
// ----------------------------;
- (void)threadForpostRequestToAddDeviceToken: (NSObject *) myObject {
    
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPOST];
    
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"Data\":{\"DeviceTypeID\":\"%@\",\"DeviceID\":\"%@\",\"EnableNotification\":\"true\",\"Active\":\"true\"}}",[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_ ]mEmployeeID_],DeviceTypeID,self.mDeviceToken_];
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"PUSH REQUEST :-%@",Projrequest);
    DLog(@"PUSH DATA :-%@",data);
    DLog(@"PUSH RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessFofDeviceToken:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)onSuccessFofDeviceToken:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        
    }
}

- (void)getRequestForListOfEmployees {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/Employees",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToGetListOfEmployees:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

// ----------------------------;
// Method to get list of Employees;
// ----------------------------;
- (void)requestToGetListOfEmployees: (NSObject *) myObject {
    
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
    DLog(@"Employees RESPONSE :-%@",response);
    DLog(@"Employees RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSMutableArray *lEmployeesArray = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                        options:kNilOptions error:&jsonError];
    DLog(@"Employees Data Array :-%@",lEmployeesArray);
    [[SharedUtilities sharedUtilities] saveArrayInToFile:lEmployeesArray :kEmployeesData];

    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForEmployees:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)onSuccessForEmployees:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        [mAppDelegate_.mModelForSplashScreen_ setMEmployeesDataArray_:[[SharedUtilities sharedUtilities] retrieveArrayFromFile:kEmployeesData]];
    }
}

#pragma mark --
#pragma mark Cache Request
- (void)cacheRequestForASRProUSApplication {
    [[WalkAroundSupportWebEngine walkAroundSharedInstance] getRequestForVehicleDiagramSets];
    [self getRequestForListOfEmployees];
}


@end
