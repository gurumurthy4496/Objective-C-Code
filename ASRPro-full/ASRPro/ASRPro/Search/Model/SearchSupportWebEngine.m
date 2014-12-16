//
//  SearchSupportWebEngine.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/11/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "SearchSupportWebEngine.h"

static SearchSupportWebEngine *sharedSearchSupportWebEngine = nil;

@implementation SearchSupportWebEngine

+ (id)sharedInstance {
    @synchronized(self) {
        if(sharedSearchSupportWebEngine == nil)
            sharedSearchSupportWebEngine = [[super allocWithZone:NULL] init];
    }
    return sharedSearchSupportWebEngine;
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
        _mCustomersArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark --
#pragma mark Public Methods

/**
 * Method to get request for RODetails.
 */
#pragma mark --
#pragma mark WalkAround_API_RODetails_GET_OnSavingCustomer&Vehicle
- (void)getRequestForRODetailsOnSavingCustomerAndVehicle {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr = @"";
        if (mAppDelegate_.mWalkAroundLeftViewController_.mShowVehicleHistoryForOpenRO_ == ShowVehicleHistoryForOpenROSection) {
            mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForVehicleHistoryTableView_].mOpenROString_];
        }else {
            mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber];
        }
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForGetRequestRepairOrdersDetailsOnSavingCustomerAndVehicle:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

- (void)threadRequestToGetAppointments {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        if (!mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_) {
            [[SharedUtilities sharedUtilities] createLoadView];
        }
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Appointments",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToGetListOfAppointments:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

- (void)threadRequestToGetRepairOrders {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        //        if (!mAppDelegate_.mSearchViewController_.isCheckIn) {
        [[SharedUtilities sharedUtilities] createLoadView];
        //        }
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders?UserID=%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,mAppDelegate_.mModelForSplashScreen_.mEmployeeID_];
        
        //        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToGetListOfRepairOrders:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}
- (void)threadRequestForSearchCustomerInfo:(NSString*)searchValue {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]] || [mAppDelegate_.mViewReference_ isKindOfClass:[EditCustomerViewController class]]) {
        }else
            [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr=[NSString stringWithFormat:@"%@%@%@/Search?Query=%@",WEBSERVICEURL,@"Stores/",mAppDelegate_.mModelForSplashScreen_.mStoreID_,searchValue];
        
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestForSearchCustomerInfo:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}
// ----------------------------;
// thread request for VINDecoder;
// ----------------------------;

- (void)threadRequestForVINDecoder:(NSString *)aVIN {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr=[NSString stringWithFormat:@"%@/VinDecoder/%@",WEBSERVICEURL,aVIN];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestForVINDecoder:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}
- (void)threadRequestToAddVehicleDetails:(NSString*)aCustomerID {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr=[NSString stringWithFormat:@"%@%@%@/Customers/%@/Vehicles",WEBSERVICEURL,@"Stores/",mAppDelegate_.mModelForSplashScreen_.mStoreID_,aCustomerID];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToAddVehicleToCustomer:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}
- (void)threadRequestToAddCustomerDetails:(NSString*)aVehicleID {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]] || [mAppDelegate_.mViewReference_ isKindOfClass:[EditCustomerViewController class]]) {
        }else
            [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr=[NSString stringWithFormat:@"%@%@%@/Vehicles/%@/Customers",WEBSERVICEURL,@"Stores/",mAppDelegate_.mModelForSplashScreen_.mStoreID_,aVehicleID];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToAddCustomerToVehicle:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}
- (void)threadRequestToAddNewVehicle {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr=[NSString stringWithFormat:@"%@%@%@/Vehicles",WEBSERVICEURL,@"Stores/",mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToAddNewVehicle:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}


- (void)threadRequestToGetAppointmentsForPullToRefresh {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Appointments",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToGetListOfAppointmentsForPullToRefresh:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

- (void)threadRequestToGetRepairOrdersForPullToRefresh {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders?UserID=%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,mAppDelegate_.mModelForSplashScreen_.mEmployeeID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToGetListOfRepairOrdersForPullToRefresh:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

- (void)threadRequestToUpdatingRepairOrders {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToUpdatingRepairOrders:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

#pragma mark --
#pragma mark backGround Thread Request Methods

-(void)threadForGetRequestRepairOrdersDetailsOnSavingCustomerAndVehicle: (NSObject *) myObject {
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
    DLog(@"RepairOrder Request:-%@",Projrequest);
    DLog(@"RepairOrder Response:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    if (mAppDelegate_.mWalkAroundLeftViewController_.mShowVehicleHistoryForOpenRO_ == ShowVehicleHistoryForOpenROSection) {
        [mAppDelegate_ mModelForVehicleHistory_].mRODetailsArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                    options:kNilOptions error:&jsonError];
        DLog(@"mRepairOrderDetailsArray_:-%@",[mAppDelegate_ mModelForVehicleHistory_].mRODetailsArray_);
        
    }else {
        mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                       options:kNilOptions error:&jsonError];
        DLog(@"mRepairOrderDetailsArray_:-%@",mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_);
    }
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForSelectedRepairOrdersDetailsOnSavingCustomerAndVehicle:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to get list of Appointments;
// ----------------------------;
- (void)requestToGetListOfAppointments: (NSObject *) myObject {
    
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
    [self performSelectorOnMainThread:@selector(onSuccessForAppointments:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to get list of Appointments;
// ----------------------------;
- (void)requestToGetListOfAppointmentsForPullToRefresh: (NSObject *) myObject {
    
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
    [self performSelectorOnMainThread:@selector(onSuccessForAppointmentsForPullToRefresh:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to get list of RepairOrders;
// ----------------------------;
- (void)requestToGetListOfRepairOrders: (NSObject *) myObject {
    
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
    DLog(@"RepairOrders RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    mAppDelegate_.mSearchDataGetter_.mRepairOrdersData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                          options:kNilOptions error:&jsonError];
    DLog(@"RepairOrders Data Array :-%@",mAppDelegate_.mSearchDataGetter_.mRepairOrdersData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForRepairOrders:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to get list of RepairOrders for Pull to refresh;
// ----------------------------;
- (void)requestToGetListOfRepairOrdersForPullToRefresh: (NSObject *) myObject {
    
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
    DLog(@"RepairOrders RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    mAppDelegate_.mSearchDataGetter_.mRepairOrdersData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                          options:kNilOptions error:&jsonError];
    self.errorResponseFromServer = json_string;
    DLog(@"RepairOrders Data Array :-%@",mAppDelegate_.mSearchDataGetter_.mRepairOrdersData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForRepairOrdersForPullToRefresh:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to get search customer info;
// ----------------------------;
- (void)requestForSearchCustomerInfo: (NSObject *) myObject {
    
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
    DLog(@"Search Customer RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    if (mAppDelegate_.mModelForSearchScreen_->isSearchForBeginCheckIn) {
        mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&jsonError];
        DLog(@"Search Customer Data Array :-%@",mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_);
    }else {
        mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                      options:kNilOptions error:&jsonError];
        DLog(@"Search Customer Data Array :-%@",mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_);
    }
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForSearchCustomer:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to get make, model and year based on VIN;
// ----------------------------;
- (void)requestForVINDecoder:(NSObject *)myObject {
    
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
    DLog(@"VIN Decoder RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    if (responseCode == ASRProNotFoundStatusCode) {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:@"Error" message:json_string];
        [mAppDelegate_.mBeginVehicleCheckInView_ errorResponseForVINDecoder];
    }
    mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                options:kNilOptions error:&jsonError];
    DLog(@"VIN Decoder Data Array :-%@",mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForVINDecoder:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to add vehicle to particular customer;
// ----------------------------;
- (void)requestToAddVehicleToCustomer: (NSObject *) myObject {
    
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
    [Projrequest setHTTPMethod:kPUT];
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"ID\":\"%@\",\"Vehicles\":{\"ID\":\"%@\",\"MakeID\":\"%d\",\"Make\":\"%@\",\"Model\":\"%@\",\"Year\":\"%@\",\"VIN\":\"%@\",\"Mileage\":\"%d\",\"License\":\"%@\",\"Color\":\"%@\"}}}",[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_ ]mEmployeeID_] intValue],mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_,mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_,[mAppDelegate_.mModelForEditVehicleScreen_.mMakeID_ intValue],mAppDelegate_.mModelForEditVehicleScreen_.mMake_,mAppDelegate_.mModelForEditVehicleScreen_.mModel_,mAppDelegate_.mModelForEditVehicleScreen_.mYear_,mAppDelegate_.mModelForEditVehicleScreen_.mVIN_,[mAppDelegate_.mModelForEditVehicleScreen_.mMileage_ intValue],mAppDelegate_.mModelForEditVehicleScreen_.mRegistrationNo_,mAppDelegate_.mModelForEditVehicleScreen_.mColor_];
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"PUSH DATA :-%@",data);
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"Vehicle RESPONSE :-%@",response);
    DLog(@"Vehicle RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    mAppDelegate_.mSearchDataGetter_.mAddVehicleResponseData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                options:kNilOptions error:&jsonError];
    DLog(@"Vehicle Array :-%@",mAppDelegate_.mSearchDataGetter_.mAddVehicleResponseData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForAddNewVehicleToCustomer:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to add Customer to particular vehicle;
// ----------------------------;
- (void)requestToAddCustomerToVehicle: (NSObject *) myObject {
    
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
    [Projrequest setHTTPMethod:kPUT];
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"ID\":\"%@\",\"Customers\":{\"ID\":\"%@\",\"FirstName\":\"%@\",\"MiddleName\":\"%@\",\"LastName\":\"%@\",\"Email\":\"%@\",\"HomePhone\":\"%@\",\"WorkPhone\":\"%@\",\"CellPhone\":\"%@\",\"Address1\":\"%@\",\"Address2\":\"%@\",\"Country\":\"%@\",\"State\":\"%@\",\"City\":\"%@\",\"Zip\":\"%@\",\"ContactEmail\":\"%@\",\"ContactPhone\":\"%@\",\"ContactSMS\":\"%@\"}}}",[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_ ]mEmployeeID_] intValue],mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_,mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_,mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_,mAppDelegate_.mModelForEditCustomerScreen_.mMiddleName_,mAppDelegate_.mModelForEditCustomerScreen_.mLastName_,mAppDelegate_.mModelForEditCustomerScreen_.mEmail_,mAppDelegate_.mModelForEditCustomerScreen_.mHomePhone_,mAppDelegate_.mModelForEditCustomerScreen_.mWorkPhone_,mAppDelegate_.mModelForEditCustomerScreen_.mMobilePhone_,mAppDelegate_.mModelForEditCustomerScreen_.mAddress1_,mAppDelegate_.mModelForEditCustomerScreen_.mAddress2_,mAppDelegate_.mModelForEditCustomerScreen_.mCountry_,mAppDelegate_.mModelForEditCustomerScreen_.mState_,mAppDelegate_.mModelForEditCustomerScreen_.mCity_,mAppDelegate_.mModelForEditCustomerScreen_.mZipCode_,mAppDelegate_.mModelForEditCustomerScreen_.mContactEmail_?@"TRUE":@"FALSE",mAppDelegate_.mModelForEditCustomerScreen_.mPhone_?@"TRUE":@"FALSE",mAppDelegate_.mModelForEditCustomerScreen_.mSMS_?@"TRUE":@"FALSE"];
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"PUSH DATA :-%@",data);
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"Vehicle RESPONSE :-%@",response);
    DLog(@"Vehicle RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    mAppDelegate_.mSearchDataGetter_.mCustomerDetailsData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                             options:kNilOptions error:&jsonError];
    DLog(@"Vehicle Array :-%@",mAppDelegate_.mSearchDataGetter_.mCustomerDetailsData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForAddNewCustomer:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to add vehicle to particular customer;
// ----------------------------;
- (void)requestToAddNewVehicle: (NSObject *) myObject {
    
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
    [Projrequest setHTTPMethod:kPOST];
    NSString *data =[NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"StoreID\":\"%d\",\"MakeID\":\"%d\",\"Make\":\"%@\",\"Model\":\"%@\",\"Year\":\"%@\",\"VIN\":\"%@\",\"Mileage\":\"%d\",\"License\":\"%@\",\"Color\":\"%@\"}}",[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue],[mAppDelegate_.mModelForSplashScreen_.mStoreID_ intValue],[mAppDelegate_.mModelForEditVehicleScreen_.mMakeID_ intValue],mAppDelegate_.mModelForEditVehicleScreen_.mMake_,mAppDelegate_.mModelForEditVehicleScreen_.mModel_,mAppDelegate_.mModelForEditVehicleScreen_.mYear_,mAppDelegate_.mModelForEditVehicleScreen_.mVIN_,[mAppDelegate_.mModelForSearchScreen_.mMileage intValue],mAppDelegate_.mModelForEditVehicleScreen_.mRegistrationNo_,mAppDelegate_.mModelForEditVehicleScreen_.mColor_];
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"DATA :-%@",data);
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"Vehicle RESPONSE :-%@",response);
    DLog(@"Vehicle RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    mAppDelegate_.mSearchDataGetter_.mVehicleDetailsData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                            options:kNilOptions error:&jsonError];
    DLog(@"Vehicle Array :-%@",mAppDelegate_.mSearchDataGetter_.mVehicleDetailsData_);
    [mAppDelegate_.mModelForEditVehicleScreen_ setMVehicleID_:[mAppDelegate_.mSearchDataGetter_.mVehicleDetailsData_ valueForKey:@"VehicleID"]];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForAddNewVehicle:) withObject:responseCodeStr waitUntilDone:NO];
}

- (NSString *)convertBooltoString:(BOOL)aValue{
    return aValue?@"TRUE":@"FALSE";
}

- (void)requestToUpdatingRepairOrders: (NSObject *) myObject {
    
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
    [Projrequest setHTTPMethod:kPUT];
    NSString *data =[NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"Customer\":{\"ID\":\"%@\",\"FirstName\":\"%@\",\"LastName\":\"%@\",\"Email\":\"%@\",\"HomePhone\":\"%@\",\"WorkPhone\":\"%@\",\"CellPhone\":\"%@\",\"Address1\":\"%@\",\"Address2\":\"%@\",\"Country\":\"%@\",\"State\":\"%@\",\"City\":\"%@\",\"Zip\":\"%@\",\"CanContactEmail\":\"%@\",\"CanContactPhone\":\"%@\",\"CanContactSMS\":\"%@\"}}}",[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue],mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ ,mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_,mAppDelegate_.mModelForEditCustomerScreen_.mLastName_,mAppDelegate_.mModelForEditCustomerScreen_.mEmail_,mAppDelegate_.mModelForEditCustomerScreen_.mHomePhone_,mAppDelegate_.mModelForEditCustomerScreen_.mWorkPhone_,mAppDelegate_.mModelForEditCustomerScreen_.mMobilePhone_,mAppDelegate_.mModelForEditCustomerScreen_.mAddress1_,mAppDelegate_.mModelForEditCustomerScreen_.mAddress2_, mAppDelegate_.mModelForEditCustomerScreen_.mCountry_, mAppDelegate_.mModelForEditCustomerScreen_.mState_, mAppDelegate_.mModelForEditCustomerScreen_.mCity_, mAppDelegate_.mModelForEditCustomerScreen_.mZipCode_, [self convertBooltoString:mAppDelegate_.mModelForEditCustomerScreen_.mContactEmail_], [self convertBooltoString:mAppDelegate_.mModelForEditCustomerScreen_.mPhone_], [self convertBooltoString:mAppDelegate_.mModelForEditCustomerScreen_.mSMS_]];
    
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"DATA :-%@",data);
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"Update Customer RESPONSE :-%@",response);
    DLog(@"Update Customer RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForToUpdatingRepairOrders:) withObject:responseCodeStr waitUntilDone:NO];
}

#pragma mark --
#pragma mark backGround Thread Succes Methods

- (void)onSuccessForSelectedRepairOrdersDetailsOnSavingCustomerAndVehicle:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
    
    
}

- (void)onSuccessForAppointments:(NSObject *) isSucces {
    if (!mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_) {
        [[SharedUtilities sharedUtilities] removeLoadView];
    }
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        if (!mAppDelegate_.mSearchViewController_.isFromInProcess) {
            [mAppDelegate_.mMasterViewController_ reloadAppointmentData];
            NSIndexPath *lSelectedIndexPath = [NSIndexPath indexPathForRow:mAppDelegate_.mMasterViewController_.mselectedApptmentindex_ inSection:0];
            [mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [mAppDelegate_.mMasterViewController_ onSelectionOfAppointment];
        }else {
            [mAppDelegate_.mMasterViewController_ setMAppointmentsData_:[mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ mutableCopy]];
            if (mAppDelegate_.mMasterViewController_->mselectedSegment_ !=2) {
                [mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ reloadData];
            }
        }
    }
}

- (void)onSuccessForAppointmentsForPullToRefresh:(NSObject *) isSucces {
    
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode) {
        [mAppDelegate_.mMasterViewController_ reloadAppointmentData];
        [mAppDelegate_.mMasterViewController_ performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
    }else {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
        [mAppDelegate_.mMasterViewController_ performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
    }
}

- (void)onSuccessForRepairOrdersForPullToRefresh:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        [mAppDelegate_.mModelForSearchScreen_ getInprocessListFromRepairOrders];
        
        if (mAppDelegate_.mMasterViewController_->mselectedSegment_ == 2) {
            [mAppDelegate_.mMasterViewController_ reloadInProcessData];
            NSIndexPath *selectedIndexPath = [mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ indexPathForSelectedRow];
            
            if (selectedIndexPath == nil) {
                mAppDelegate_.mModelForWalkAround_.mTempPRE_RONumber = nil;
            }
            [mAppDelegate_.mMasterViewController_ performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
        }else {
            DLog(@"%@",mAppDelegate_.mMasterViewController_.mOpenROFilterButton_.titleLabel.text);
            [mAppDelegate_.mModelForSearchScreen_ getSelectedModeName:[NSString stringWithFormat:@"%@",mAppDelegate_.mMasterViewController_.mOpenROFilterButton_.titleLabel.text]];
            [mAppDelegate_.mMasterViewController_ reloadOpenROData];
            [mAppDelegate_.mSearchViewController_ hideallview:TRUE];
            [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:0.0f];
            
            [mAppDelegate_.mMasterViewController_.mOpenROTableView_ performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
        }
    }else {
        if (mAppDelegate_.mMasterViewController_->mselectedSegment_ == 2) {
            [mAppDelegate_.mMasterViewController_ performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
        }else {
            [mAppDelegate_.mSearchViewController_ hideallview:TRUE];
            [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:0.0f];
            
            [mAppDelegate_.mMasterViewController_.mOpenROTableView_ performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
        }
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Error", nil) message:self.errorResponseFromServer];
    }
}

- (void)onSuccessForRepairOrders:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[PrintEmailPopupViewViewController class]] || mAppDelegate_.mMasterViewController_->mselectedSegment_ == 3) {
            [[SharedUtilities sharedUtilities] removeLoadView];
            
            [mAppDelegate_.mModelForSearchScreen_ getInprocessListFromRepairOrders];
            [mAppDelegate_.mMasterViewController_.mOpenROTableView_ reloadData];
            DLog(@"Customer ID : %@", mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_);
            NSIndexPath *lSelectedIndexPath = [NSIndexPath indexPathForRow:mAppDelegate_.mMasterViewController_.mOpenROTableView_.mselectedCustomerindex_ inSection:0];
            [mAppDelegate_.mMasterViewController_.mOpenROTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
            [mAppDelegate_.mMasterViewController_.mOpenROTableView_ onSelectionOfOpenRO:mAppDelegate_.mMasterViewController_.mOpenROTableView_.mselectedCustomerindex_];
            if([mAppDelegate_.mViewReference_ isKindOfClass:[PrintEmailPopupViewViewController class]])
                [mAppDelegate_.mPrintEmailPopupViewViewController_ requestForEmail];
        }else {
            [mAppDelegate_.mModelForSearchScreen_ getInprocessListFromRepairOrders];
            [mAppDelegate_.mMasterViewController_ reloadInProcessData];
            if (mAppDelegate_.mSearchViewController_.isCheckIn) {
                mAppDelegate_.mSearchViewController_.isCheckIn = NO;
                for (int i=0; i<[mAppDelegate_.mSearchDataGetter_.mInprocessListData_ count]; i++) {
                    if ([mAppDelegate_.mModelForWalkAround_.mTempPRE_RONumber isEqualToString:[[mAppDelegate_.mSearchDataGetter_.mInprocessListData_ objectAtIndex:i] objectForKey:@"RONumber"]]) {
                        mAppDelegate_.mMasterViewController_.mselectedInprocessindex_ = i;
                    }
                    
                }
                mAppDelegate_.mMasterViewController_.mSearhBar_.text = @"";
                mAppDelegate_.mMasterViewController_->isAppointmentSelected = FALSE;
                [mAppDelegate_.mMasterViewController_ showSearchlistViewOrHide:0 searchText:@""];
            }
            
            NSIndexPath *lSelectedIndexPath = [NSIndexPath indexPathForRow:mAppDelegate_.mMasterViewController_.mselectedInprocessindex_ inSection:0];
            [mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            [[SharedUtilities sharedUtilities] removeLoadView];
            [mAppDelegate_.mMasterViewController_ onSelectionOfInProcess];
            /**
             * This is to reload the Check-In customer & Vehicle Information
             */
            [mAppDelegate_.mModelForCheckIn_ setArrayForCustomerAndVehicleInfo];
            if (mAppDelegate_.mCheckInViewController_!= nil) {
                [mAppDelegate_.mCheckInViewController_.mCustomerAndVehicleInfoView_ setBorderForCustomerAndVehicleInfoView];
            }
        }
    }
}

- (void)onSuccessForSearchCustomer:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        NSIndexPath *lSelectedIndexPath;
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]] || [mAppDelegate_.mViewReference_ isKindOfClass:[EditCustomerViewController class]]) {
            if (mAppDelegate_.mMasterViewController_->isAnyAppointmentSelected) {
                [self isFromAppointmentOrSearch];
            }else {
                NSIndexPath *path = [mAppDelegate_.mMasterViewController_.mSearchedListTableView_ indexPathForSelectedRow];
                if (path){
                    [self isFromAppointmentOrSearch];
                }
                else{
                    // No cell selected
                    [mAppDelegate_.mBeginVehicleCheckInView_ reloadSearchTableData];
                    if ([[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] count] != 0) {
                        for (int i=0; i<[[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] count]; i++) {
                            if ([mAppDelegate_.mBeginVehicleCheckInView_.mFirstName_ isEqualToString:[[[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:i] objectForKey:@"FirstName"]] && [mAppDelegate_.mBeginVehicleCheckInView_.mLastName_ isEqualToString:[[[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:i] objectForKey:@"LastName"]]) {
                                [mAppDelegate_.mBeginVehicleCheckInView_.mCheckInSearchTableView_  selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
                                mAppDelegate_.mBeginVehicleCheckInView_.mCheckInSearchTableView_.mselectedCustomerindex_ = i;
                                [mAppDelegate_.mBeginVehicleCheckInView_.mCheckInSearchTableView_ onSelectionOfCustomer];
                            }
                        }
                    }
                    return;
                }
            }
        }else {
            [mAppDelegate_.mMasterViewController_.mSearchedListTableView_ reloadData];
            if ([mAppDelegate_.mViewReference_ isKindOfClass:[SearchedListTableView class]]) {
                NSMutableArray*lTempArray=[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"];
                for (int i=0; i<[lTempArray count]; i++) {
                    if ([[mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ stringByReplacingOccurrencesOfString:@"-" withString:@""] isEqualToString:[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"]objectAtIndex:i] objectForKey:@"ID"]]) {
                        mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_ = i;
                        lSelectedIndexPath = [NSIndexPath indexPathForRow:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_ inSection:0];
                        [mAppDelegate_.mMasterViewController_.mSearchedListTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                        [mAppDelegate_.mMasterViewController_.mSearchedListTableView_ onSelectionOfCustomer];
                    }
                }
            }else {
                if ([[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"] count] !=0 || [[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Vehicles"] count] !=0) {
                    for (int i=0; i<[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"] count]; i++) {
                        
                        if ([[mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ stringByReplacingOccurrencesOfString:@"-" withString:@""] isEqualToString:[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"]objectAtIndex:i] objectForKey:@"ID"]]) {
                            mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_ = i;
                            lSelectedIndexPath = [NSIndexPath indexPathForRow:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_ inSection:0];
                            [mAppDelegate_.mMasterViewController_.mSearchedListTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                            [mAppDelegate_.mMasterViewController_.mSearchedListTableView_ onSelectionOfCustomer];
                        }
                    }
                    
                }else {
                    [mAppDelegate_.mMasterViewController_ resetAllData];
                    [mAppDelegate_.mSearchViewController_ setCustomerInfomationLabelsTextFromModel];
                    [mAppDelegate_.mSearchViewController_ setVehicleInfomationLabelsTextFromModel];
                }
            }
            
        }
    }else
        [mAppDelegate_.mBeginVehicleCheckInView_ errorResponseForCustomerSearch];
}

- (BOOL)isSelectedAppointmentInTheSearchList {
    
    __block BOOL isCustomerIntheList = FALSE;
    [[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
        if ([[object objectForKey:@"Number"] isEqualToString:mAppDelegate_.mModelForEditCustomerScreen_.mCustomerNumber_]) {
            isCustomerIntheList = TRUE;
            if ([[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] count] > 1) {
                [self settingTheCustomerAttheTopPosition:mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ IndexValue:index];
            }
            [mAppDelegate_.mBeginVehicleCheckInView_ reloadSearchTableData];
            
            [mAppDelegate_.mBeginVehicleCheckInView_.mCheckInSearchTableView_  selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
            mAppDelegate_.mBeginVehicleCheckInView_.mCheckInSearchTableView_.mselectedCustomerindex_ = 0;
            [mAppDelegate_.mBeginVehicleCheckInView_.mCheckInSearchTableView_ onSelectionOfCustomer];
        }else {
            [_mCustomersArray addObject:object];
        }
    }];
    return isCustomerIntheList;
    
}

- (void)settingTheCustomerAttheTopPosition:(NSMutableDictionary*)lBeginCheckInArray IndexValue:(int)indexValue {
    
    if ([[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] count] >0) {
        __block NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:[NSArray arrayWithObject:[NSNull null]] forKey:@"Customers"];
        NSMutableDictionary *dicttemp;
        [_mCustomersArray insertObject:[[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] objectAtIndex:indexValue] atIndex:0];
        
        dict = [[NSMutableDictionary alloc] init];
        [dict setValue:[NSArray arrayWithObject:[NSNull null]] forKey:@"Customers"];
        dicttemp = [NSMutableDictionary dictionaryWithObject:_mCustomersArray forKey:@"Customers"];
        [[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ objectForKey:@"Vehicles"] objectAtIndex:0] enumerateKeysAndObjectsUsingBlock:^(id key, id object1, BOOL *stop){
            if ([key isEqualToString:@"Customers"]) {
            }else {
                DLog(@"dict : %@",dicttemp);
                [dicttemp setObject:object1 forKey:key];
            }
        }];
        [dict setValue:[NSArray arrayWithObject:dicttemp] forKey:@"Vehicles"];
        
        [mAppDelegate_.mSearchDataGetter_ setMBeginCheckInSearchData_:dict];
    }
    
}

- (void)isFromAppointmentOrSearch {
    
    if ([[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] count] >0) {
        if ([self isSelectedAppointmentInTheSearchList]) {
            return;
        }else {
            if ([[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] valueForKey:@"Customers"] count] == 0) {
                __block NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setValue:[NSArray arrayWithObject:[NSNull null]] forKey:@"Customers"];
                NSMutableDictionary *dicttemp;
                if (mAppDelegate_.mMasterViewController_->isAnyAppointmentSelected) { // From Appointments
                    mAppDelegate_.mMasterViewController_->isAnyAppointmentSelected = FALSE;
                    dicttemp = [NSMutableDictionary dictionaryWithObject:[NSMutableArray arrayWithObjects:[[mAppDelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:mAppDelegate_.mMasterViewController_.mselectedApptmentindex_] objectForKey:@"Customer"], nil] forKey:@"Customers"];
                    [[[mAppDelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:mAppDelegate_.mMasterViewController_.mselectedApptmentindex_] objectForKey:@"Vehicle"] enumerateKeysAndObjectsUsingBlock:^(id key, id object1, BOOL *stop){
                        if ([key isEqualToString:@"Customers"]) {
                        }else {
                            DLog(@"dict : %@",dicttemp);
                            [dicttemp setObject:object1 forKey:key];
                        }
                    }];
                }else {
                    dicttemp = [NSMutableDictionary dictionaryWithObject:[NSMutableArray arrayWithObjects:[mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mSearchListArray objectAtIndex:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_], nil] forKey:@"Customers"];
                    [[[mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mSearchListArray objectAtIndex:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_] objectForKey:@"Vehicles"] enumerateObjectsUsingBlock:^(id object, NSUInteger index,BOOL *stop) {
                        if ([[object objectForKey:@"VIN"] isEqualToString:mAppDelegate_.mModelForSearchScreen_.mBeginVehicleCheckInVIN]) {
                            [object enumerateKeysAndObjectsUsingBlock:^(id key, id object1, BOOL *stop){
                                if ([key isEqualToString:@"Customers"]) {
                                }else {
                                    DLog(@"dict : %@",dicttemp);
                                    [dicttemp setObject:object1 forKey:key];
                                }
                            }];
                        }
                    }];
                }
                [dict setValue:[NSArray arrayWithObject:dicttemp] forKey:@"Vehicles"];
                [mAppDelegate_.mSearchDataGetter_ setMBeginCheckInSearchData_:dict];
                DLog(@"%@",mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_);
                
            }else {
                __block NSMutableArray *lCustomerArray = [[NSMutableArray alloc] init];
                NSMutableDictionary *dicttemp;
                __block NSMutableDictionary *dict;
                if (mAppDelegate_.mMasterViewController_->isAnyAppointmentSelected) {
                    mAppDelegate_.mMasterViewController_->isAnyAppointmentSelected = FALSE;
                    [lCustomerArray addObject:[[mAppDelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:mAppDelegate_.mMasterViewController_.mselectedApptmentindex_] objectForKey:@"Customer"]];
                    [[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] enumerateObjectsUsingBlock:^(id object, NSUInteger index,BOOL *stop) {
                        [lCustomerArray addObject:object];
                    }];
                    dict = [[NSMutableDictionary alloc] init];
                    [dict setValue:[NSArray arrayWithObject:[NSNull null]] forKey:@"Customers"];
                    dicttemp = [NSMutableDictionary dictionaryWithObject:lCustomerArray forKey:@"Customers"];
                    [[[mAppDelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:mAppDelegate_.mMasterViewController_.mselectedApptmentindex_] objectForKey:@"Vehicle"] enumerateKeysAndObjectsUsingBlock:^(id key, id object1, BOOL *stop){
                        if ([key isEqualToString:@"Customers"]) {
                        }else {
                            DLog(@"dict : %@",dicttemp);
                            [dicttemp setObject:object1 forKey:key];
                        }
                    }];
                }else {
                    [lCustomerArray addObject:[mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mSearchListArray objectAtIndex:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_]];
                    [[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] objectForKey:@"Customers"] enumerateObjectsUsingBlock:^(id object, NSUInteger index,BOOL *stop) {
                        [lCustomerArray addObject:object];
                    }];
                    dict = [[NSMutableDictionary alloc] init];
                    [dict setValue:[NSArray arrayWithObject:[NSNull null]] forKey:@"Customers"];
                    dicttemp = [NSMutableDictionary dictionaryWithObject:lCustomerArray forKey:@"Customers"];
                    [[[mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mSearchListArray objectAtIndex:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_] objectForKey:@"Vehicles"] enumerateObjectsUsingBlock:^(id object, NSUInteger index,BOOL *stop) {
                        if ([[object objectForKey:@"VIN"] isEqualToString:mAppDelegate_.mModelForSearchScreen_.mBeginVehicleCheckInVIN]) {
                            [object enumerateKeysAndObjectsUsingBlock:^(id key, id object1, BOOL *stop){
                                if ([key isEqualToString:@"Customers"]) {
                                }else {
                                    DLog(@"dict : %@",dicttemp);
                                    [dicttemp setObject:object1 forKey:key];
                                }
                            }];
                        }
                    }];
                }
                [dict setValue:[NSArray arrayWithObject:dicttemp] forKey:@"Vehicles"];
                [mAppDelegate_.mSearchDataGetter_ setMBeginCheckInSearchData_:dict];
                DLog(@"%@",mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_);
                DLog(@"count : %d", [[[[mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_ valueForKey:@"Vehicles"] objectAtIndex:0] valueForKey:@"Customers"] count]);
            }
        }
    }else {
        __block NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:[NSArray arrayWithObject:[NSNull null]] forKey:@"Customers"];
        NSMutableDictionary *dicttemp;
        if (mAppDelegate_.mMasterViewController_->isAnyAppointmentSelected) {
            mAppDelegate_.mMasterViewController_->isAnyAppointmentSelected = FALSE;
            dicttemp = [NSMutableDictionary dictionaryWithObject:[NSMutableArray arrayWithObjects:[[mAppDelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:mAppDelegate_.mMasterViewController_.mselectedApptmentindex_] objectForKey:@"Customer"], nil] forKey:@"Customers"];
            [[[mAppDelegate_.mMasterViewController_.mAppointmentsData_ objectAtIndex:mAppDelegate_.mMasterViewController_.mselectedApptmentindex_] objectForKey:@"Vehicle"] enumerateKeysAndObjectsUsingBlock:^(id key, id object1, BOOL *stop){
                if ([key isEqualToString:@"Customers"]) {
                }else {
                    DLog(@"dict : %@",dicttemp);
                    [dicttemp setObject:object1 forKey:key];
                }
            }];
        }else {
            dicttemp = [NSMutableDictionary dictionaryWithObject:[NSMutableArray arrayWithObjects:[mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mSearchListArray objectAtIndex:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_], nil] forKey:@"Customers"];
            [[[mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mSearchListArray objectAtIndex:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_] objectForKey:@"Vehicles"] enumerateObjectsUsingBlock:^(id object, NSUInteger index,BOOL *stop) {
                if ([[object objectForKey:@"VIN"] isEqualToString:mAppDelegate_.mModelForSearchScreen_.mBeginVehicleCheckInVIN]) {
                    [object enumerateKeysAndObjectsUsingBlock:^(id key, id object1, BOOL *stop){
                        if ([key isEqualToString:@"Customers"]) {
                        }else {
                            DLog(@"dict : %@",dicttemp);
                            [dicttemp setObject:object1 forKey:key];
                        }
                    }];
                }
            }];
            
        }
        [dict setValue:[NSArray arrayWithObject:dicttemp] forKey:@"Vehicles"];
        [mAppDelegate_.mSearchDataGetter_ setMBeginCheckInSearchData_:dict];
        DLog(@"Customer Object Data : %@",mAppDelegate_.mSearchDataGetter_.mBeginCheckInSearchData_);
    }
    [mAppDelegate_.mBeginVehicleCheckInView_ reloadSearchTableData];
    [mAppDelegate_.mBeginVehicleCheckInView_.mCheckInSearchTableView_  selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    mAppDelegate_.mBeginVehicleCheckInView_.mCheckInSearchTableView_.mselectedCustomerindex_ = 0;
    [mAppDelegate_.mBeginVehicleCheckInView_.mCheckInSearchTableView_ onSelectionOfCustomer];
    
}

- (void)onSuccessForVINDecoder:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        
        [mAppDelegate_.mModelForEditVehicleScreen_ setMMake_:[mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_ valueForKey:@"MAKE"]];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMModel_:[mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_ valueForKey:@"MODEL"]];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMYear_:[NSString stringWithFormat:@"%@",[mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_ valueForKey:@"YEAR"]]];
        mAppDelegate_.mModelForSearchScreen_->isSearchForBeginCheckIn = TRUE;
        [self threadRequestForSearchCustomerInfo:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_];
        [mAppDelegate_.mEditVehicleViewController_ setValuesToViews];
    }
}

- (void)onSuccessForAddNewVehicleToCustomer:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        [mAppDelegate_.mMasterViewController_ refreshAppointmentOrInprocessData];
    }else
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Add Vehicle", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
}

- (void)onSuccessForAddNewCustomer:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        mAppDelegate_.mModelForSearchScreen_->isSearchForBeginCheckIn = TRUE;
        //        [self threadRequestForSearchCustomerInfo:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_];
        [mAppDelegate_.mBeginVehicleCheckInView_ setMFirstName_:mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_];
        [mAppDelegate_.mBeginVehicleCheckInView_ setMLastName_:mAppDelegate_.mModelForEditCustomerScreen_.mLastName_];
        if ([mAppDelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"FULL"]) {
            [mAppDelegate_.mBeginVehicleCheckInView_ showApptView];
        }else {
            mAppDelegate_.mModelForEditCustomerScreen_.mIsBeginVehicle_ = TRUE;
            [mAppDelegate_.mSearchViewController_ displayEditVehiclePopup];
        }
    }else {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Add Customer", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
        [mAppDelegate_.mBeginVehicleCheckInView_ reloadSearchTableData];
    }
}

- (void)onSuccessForAddNewVehicle:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue] == ASRProCreatedStatusCode){
        [self threadRequestToAddCustomerDetails:mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_];
    }else {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Add Vehicle", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
        [mAppDelegate_.mBeginVehicleCheckInView_ reloadSearchTableData];
    }
}

- (void)onSuccessForToUpdatingRepairOrders:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        
        [[SearchSupportWebEngine sharedInstance] getRequestForRODetailsOnSavingCustomerAndVehicle];
        [mAppDelegate_.mMasterViewController_ refreshAppointmentOrInprocessData];
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
    
    
}

@end
