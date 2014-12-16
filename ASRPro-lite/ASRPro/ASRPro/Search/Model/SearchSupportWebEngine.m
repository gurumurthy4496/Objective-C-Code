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
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)threadRequestToGetRepairOrders {

    if ([[NetworkMonitor instance] isNetworkAvailable]) {
//        if (!mAppDelegate_.mSearchViewController_.isCheckIn) {
            [[SharedUtilities sharedUtilities] createLoadView];
//        }
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToGetListOfRepairOrders:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
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
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
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

- (void)onSuccessForRepairOrders:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[PrintEmailPopupViewViewController class]] || mAppDelegate_.mMasterViewController_->mselectedSegment_ == 3) {
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
            mAppDelegate_.mMasterViewController_.mselectedInprocessindex_ = [mAppDelegate_.mSearchDataGetter_.mInprocessListData_ count] - 1;
            mAppDelegate_.mMasterViewController_.mSearhBar_.text = @"";
            [mAppDelegate_.mMasterViewController_ showSearchlistViewOrHide:0 searchText:@""];
        }
        NSIndexPath *lSelectedIndexPath = [NSIndexPath indexPathForRow:mAppDelegate_.mMasterViewController_.mselectedInprocessindex_ inSection:0];
        [mAppDelegate_.mMasterViewController_.mAppointmentAndInprocessTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        [mAppDelegate_.mMasterViewController_ onSelectionOfInProcess];
        }
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
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kGET];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"Search Customer RESPONSE :-%@",response);
    DLog(@"Search Customer RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                             options:kNilOptions error:&jsonError];
    DLog(@"Search Customer Data Array :-%@",mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForSearchCustomer:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)onSuccessForSearchCustomer:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        NSIndexPath *lSelectedIndexPath;
        if ([mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]] || [mAppDelegate_.mViewReference_ isKindOfClass:[EditCustomerViewController class]]) {
            [mAppDelegate_.mBeginVehicleCheckInView_ reloadSearchTableData];
        }else {
            [mAppDelegate_.mMasterViewController_.mSearchedListTableView_ reloadData];
            if ([mAppDelegate_.mViewReference_ isKindOfClass:[SearchedListTableView class]]) {
                NSMutableArray*lTempArray=[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"];
                for (int i=0; i<[lTempArray count]; i++) {
                    if ([[mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ stringByReplacingOccurrencesOfString:@"-" withString:@""] isEqualToString:[[[mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ valueForKey:@"Customers"]objectAtIndex:i] objectForKey:@"ID"]]) {
                        mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_ = i;
                        lSelectedIndexPath = [NSIndexPath indexPathForRow:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_ inSection:0];
                    }
                }
            }else
                lSelectedIndexPath = [NSIndexPath indexPathForRow:mAppDelegate_.mMasterViewController_.mSearchedListTableView_.mselectedCustomerindex_ inSection:0];
            [mAppDelegate_.mMasterViewController_.mSearchedListTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [mAppDelegate_.mMasterViewController_.mSearchedListTableView_ onSelectionOfCustomer];
        }
    }
}

// ----------------------------;
// thread request for VINDecoder;
// ----------------------------;

- (void)threadRequestForVINDecoder:(NSString *)aVIN {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        if (![mAppDelegate_.mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]]) {
            [[SharedUtilities sharedUtilities] createLoadView];
        }        NSString *mRequestStr=[NSString stringWithFormat:@"%@/VinDecoder/%@",WEBSERVICEURL,aVIN];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestForVINDecoder:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
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
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kGET];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"Search Customer RESPONSE :-%@",response);
    DLog(@"Search Customer RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    if (responseCode == 404) {
//        [[SharedUtilities sharedUtilities] showAlertWithTitle:@"Error" message:@"Invalid VIN..! Please enter the correct VIN"];
        [[SharedUtilities sharedUtilities] showAlertWithTitle:@"Error" message:json_string];
        [mAppDelegate_.mBeginVehicleCheckInView_ errorResponseForVINDecoder];
    }
    mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                  options:kNilOptions error:&jsonError];
    DLog(@"Search Customer Data Array :-%@",mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForVINDecoder:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)onSuccessForVINDecoder:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        
        [self threadRequestForSearchCustomerInfo:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMMake_:[mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_ valueForKey:@"MAKE"]];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMModel_:[mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_ valueForKey:@"MODEL"]];
        [mAppDelegate_.mModelForEditVehicleScreen_ setMYear_:[mAppDelegate_.mSearchDataGetter_.mVINDecoderResponseData_ valueForKey:@"YEAR"]];
        [mAppDelegate_.mEditVehicleViewController_ setValuesToViews];
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
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPUT];
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"ID\":\"%@\",\"Vehicles\":{\"ID\":\"%@\",\"MakeID\":\"%d\",\"Make\":\"%@\",\"Model\":\"%@\",\"Year\":\"%@\",\"VIN\":\"%@\",\"Mileage\":\"%d\",\"License\":\"%@\"}}}",[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_ ]mEmployeeID_] intValue],mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_,mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_,[mAppDelegate_.mModelForEditVehicleScreen_.mMakeID_ intValue],mAppDelegate_.mModelForEditVehicleScreen_.mMake_,mAppDelegate_.mModelForEditVehicleScreen_.mModel_,mAppDelegate_.mModelForEditVehicleScreen_.mYear_,mAppDelegate_.mModelForEditVehicleScreen_.mVIN_,[mAppDelegate_.mModelForEditVehicleScreen_.mMileage_ intValue],mAppDelegate_.mModelForEditVehicleScreen_.mRegistrationNo_];
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

- (void)onSuccessForAddNewVehicleToCustomer:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        [mAppDelegate_.mMasterViewController_ refreshAppointmentOrInprocessData];
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
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
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

- (void)onSuccessForAddNewCustomer:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        [self threadRequestForSearchCustomerInfo:mAppDelegate_.mModelForEditVehicleScreen_.mVIN_];
    }
}

- (void)threadRequestToAddNewVehicle {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr=[NSString stringWithFormat:@"%@%@%@/Vehicles/",WEBSERVICEURL,@"Stores/",mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToAddNewVehicle:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
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
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPOST];
    NSString *data =[NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"StoreID\":\"%d\",\"MakeID\":\"%d\",\"Make\":\"%@\",\"Model\":\"%@\",\"Year\":\"%@\",\"VIN\":\"%@\",\"Mileage\":\"%d\",\"License\":\"%@\"}}",[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue],[mAppDelegate_.mModelForSplashScreen_.mStoreID_ intValue],[mAppDelegate_.mModelForEditVehicleScreen_.mMakeID_ intValue],mAppDelegate_.mModelForEditVehicleScreen_.mMake_,mAppDelegate_.mModelForEditVehicleScreen_.mModel_,mAppDelegate_.mModelForEditVehicleScreen_.mYear_,mAppDelegate_.mModelForEditVehicleScreen_.mVIN_,[mAppDelegate_.mModelForSearchScreen_.mMileage intValue],mAppDelegate_.mModelForEditVehicleScreen_.mRegistrationNo_];
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

- (void)onSuccessForAddNewVehicle:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue] == ASRProCreatedStatusCode){
        [self threadRequestToAddCustomerDetails:mAppDelegate_.mModelForEditVehicleScreen_.mVehicleID_];
    }
}

@end
