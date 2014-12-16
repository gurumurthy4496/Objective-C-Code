//
//  WalkAroundSupportWebEngine.m
//  ASRPro
//
//  Created by GuruMurthy on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "WalkAroundSupportWebEngine.h"

static WalkAroundSupportWebEngine *sharedWalkAroundSupportWebEngine = nil;


@implementation WalkAroundSupportWebEngine
@synthesize mVehicleDiagramRequest_;
@synthesize mResponseString_;

+ (id)walkAroundSharedInstance {
    @synchronized(self) {
        if(sharedWalkAroundSupportWebEngine == nil)
            sharedWalkAroundSupportWebEngine = [[super allocWithZone:NULL] init];
    }
    return sharedWalkAroundSupportWebEngine;
}

#pragma mark --
#pragma mark Singleton Methods


+ (id)allocWithZone:(NSZone *)zone {
    return [self walkAroundSharedInstance];
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

/**
 * Method to get Vehicle Diagram Sets.
 */
#pragma mark --
#pragma mark VehicleDiagramSets_Cache
- (void)getRequestForVehicleDiagramSets {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/VehicleDiagramSets",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForGetRequestVehicleDiagramSets:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

/**
 * Method to get Selected Vehicle Diagram.
 */
#pragma mark --
#pragma mark SelectedVehicleDiagram
- (void)getRequestForSelectedVehicleDiagram {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/VehicleDiagramSets/%d",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mVehicleDiagramSetID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForGetRequestSelectedVehicleDiagram:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

/**
 * Method to get request for RODetails.
 */
#pragma mark --
#pragma mark WalkAround_API_RODetails_GET_1
- (void)getRequestForRODetails {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForGetRequestRepairOrdersDetails:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

/**
 * Method to get request for Damage Details.
 */
#pragma mark --
#pragma mark WalkAround_API_DamageDetails_GET_2
- (void)getRequestForDamageDetails {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];

        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionForms/DamageDetails",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForGetRequestDamageDetails:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

/**
 * Method to POST request for Damage Details.
 */
#pragma mark --
#pragma mark WalkAround_API_DamageDetails_POST_2
- (void)postRequestForDamageDetails {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionForms/DamageDetails",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForPostRequestDamageDetails:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

/**
 * Method to PUT request for Damage Details.
 */
#pragma mark --
#pragma mark WalkAround_API_DamageDetails_PUT_3
- (void)putRequestForDamageDetails {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionForms/DamageDetails/%@",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber,mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForPutRequestDamageDetails:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

/**
 * Method to PUT request for Damage Details.
 */
#pragma mark --
#pragma mark WalkAround_API_DamageDetails_DELETE_4
- (void)deleteRequestForDamageDetails {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionForms/DamageDetails/%@",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber,mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForDeleteRequestDamageDetails:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance] displayNetworkMonitorAlert];
    }
}

/**
 * Method to POST request for Damage Details Image.
 */
#pragma mark --
#pragma mark WalkAround_API_DamageDetailsImage_POST_5
- (void)postRequestForDamageDetailsImage {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        if (self.mVehicleDiagramRequest_ == VehicleDiagramPOSTRequest) {
            mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionForms/DamageDetails/%@/Images",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber,self.mResponseString_];
        }else {
            mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionForms/DamageDetails/%@/Images",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber,mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mID_];
        }
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForPostRequestDamageDetailsImage:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

/**
 * Method to PUT request for Damage Details Image.
 */
#pragma mark --
#pragma mark WalkAround_API_DamageDetailsImage_PUT_6
- (void)putRequestForDamageDetailsImage {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionForms/DamageDetails/%@/Images/1",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber,mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForPutRequestDamageDetailsImage:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

/**
 * Method to DELETE request for Damage Details Image.
 */
#pragma mark --
#pragma mark WalkAround_API_DamageDetailsImage_DELETE_7
- (void)deleteRequestForDamageDetailsImage {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionForms/DamageDetails/%@/Images/1?UserID=%@",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber,mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mID_,mAppDelegate_.mModelForSplashScreen_.mEmployeeID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForDeleteRequestDamageDetailsImage:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

#pragma mark --
#pragma mark backGround Thread Request Methods

-(void)threadForGetRequestVehicleDiagramSets: (NSObject *) myObject {
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
    DLog(@"VehicleDiagramSets Request:-%@",Projrequest);
    DLog(@"VehicleDiagramSets Response:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetsArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                                                             options:kNilOptions error:&jsonError];
    DLog(@"mVehicleDiagramSetsDictionary_:-%@",mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetsArray_);
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForVehicleDiagramSets:) withObject:responseCodeStr waitUntilDone:NO];
}

#pragma mark --
#pragma mark backGround Thread Succes Methods

- (void)onSuccessForVehicleDiagramSets:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        //Storing VehicleDiagramSets into the files
        [[SharedUtilities sharedUtilities] saveArrayInToFile:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramSetsArray_ :kStore_VehicleDiagrams_sets_Array];
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"VehicleDiagramsSets", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

#pragma mark --
#pragma mark Fore Thread Request Methods

-(void)threadForGetRequestSelectedVehicleDiagram: (NSObject *) myObject {
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
    DLog(@"SelectedVehicleDiagram Request:-%@",Projrequest);
    DLog(@"SelectedVehicleDiagram Response:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    mAppDelegate_.mModelForWalkAround_.mSelectedVehicleDiagramDictionary_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                   options:kNilOptions error:&jsonError];
    DLog(@"mSelectedVehicleDiagramDictionary_:-%@",mAppDelegate_.mModelForWalkAround_.mSelectedVehicleDiagramDictionary_);
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForSelectedVehicleDiagram:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForGetRequestRepairOrdersDetails: (NSObject *) myObject {
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
    DLog(@"RepairOrder Request:-%@",Projrequest);
    DLog(@"RepairOrder Response:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                            options:kNilOptions error:&jsonError];
    DLog(@"mRepairOrderDetailsArray_:-%@",mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_);
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForSelectedRepairOrdersDetails:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForGetRequestDamageDetails: (NSObject *) myObject {
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
    DLog(@"DamageDetails Request:-%@",Projrequest);
    DLog(@"DamageDetails Response:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    mAppDelegate_.mModelForWalkAround_.mDamageDetailsArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                   options:kNilOptions error:&jsonError];
    DLog(@"mDamageDetailsArray_:-%@",mAppDelegate_.mModelForWalkAround_.mDamageDetailsArray_);
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForDamageDetails:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForPostRequestDamageDetails: (NSObject *) myObject {
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
    
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"Data\":{\"X\":\"%f\",\"Y\":\"%f\",\"Notes\":\"%@\",\"VehicleDamageDetailTypeID\":\"%d\",\"VehicleDamageSeverityID\":\"%d\",\"VehicleDiagram\":{\"VehicleDiagramSetID\":\"%d\",\"VehicleDiagramViewAngleID\":\"%d\"}}}",[[mAppDelegate_ mModelForSplashScreen_ ]mEmployeeID_],mAppDelegate_.mModelForWalkAround_.mXCoord_,mAppDelegate_.mModelForWalkAround_.mYCoord_,([mAppDelegate_.mModelForWalkAround_.mNotesString_ isEqualToString:NSLocalizedString(@"VEHICLE_TAP_TO_INPUT_DETAILS", nil)]?@"":mAppDelegate_.mModelForWalkAround_.mNotesString_),mAppDelegate_.mModelForWalkAround_.mDamageTypeIndex_,mAppDelegate_.mModelForWalkAround_.mSeverityTypeIndex_,mAppDelegate_.mModelForWalkAround_.mVehicleDiagramForDamagesSetID_,mAppDelegate_.mModelForWalkAround_.mVehicleDiagramViewAngleID_];

    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"DamageDetails Request:-%@",Projrequest);
    DLog(@"DamageDetails data:-%@",data);
    DLog(@"DamageDetails Response :-%@",json_string);
    mAppDelegate_.mModelForWalkAround_.mButtonID_ = [[NSString stringWithFormat:@"%@",json_string] intValue];
    NSDictionary *lTempDict = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                              options:kNilOptions error:&jsonError];
    self.mResponseString_ = [lTempDict objectForKey:@"ID"];

    DLog(@"DamageDetails Response :-%@",self.mResponseString_);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForPostDamageDetails:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForPutRequestDamageDetails: (NSObject *) myObject {
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
    
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"Data\":{\"ID\":\"%@\",\"X\":\"%f\",\"Y\":\"%f\",\"Notes\":\"%@\",\"VehicleDamageDetailTypeID\":\"%d\",\"VehicleDamageSeverityID\":\"%d\",\"VehicleDiagram\":{\"VehicleDiagramSetID\":\"%d\",\"VehicleDiagramViewAngleID\":\"%d\"}}}",[[mAppDelegate_ mModelForSplashScreen_ ]mEmployeeID_],mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_.mOnTapPointButton_.mID_,mAppDelegate_.mModelForWalkAround_.mXCoord_,mAppDelegate_.mModelForWalkAround_.mYCoord_,([mAppDelegate_.mModelForWalkAround_.mNotesString_ isEqualToString:NSLocalizedString(@"VEHICLE_TAP_TO_INPUT_DETAILS", nil)]?@"":mAppDelegate_.mModelForWalkAround_.mNotesString_),mAppDelegate_.mModelForWalkAround_.mDamageTypeIndex_,mAppDelegate_.mModelForWalkAround_.mSeverityTypeIndex_,mAppDelegate_.mModelForWalkAround_.mVehicleDiagramForDamagesSetID_,mAppDelegate_.mModelForWalkAround_.mVehicleDiagramViewAngleID_];
    
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"DamageDetails Request:-%@",Projrequest);
    DLog(@"DamageDetails data:-%@",data);
    DLog(@"DamageDetails Response :-%@",json_string);
    mAppDelegate_.mModelForWalkAround_.mButtonID_ = [[NSString stringWithFormat:@"%@",json_string] intValue];
    DLog(@"DamageDetails Response :-%d",mAppDelegate_.mModelForWalkAround_.mButtonID_);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForPutDamageDetails:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForDeleteRequestDamageDetails: (NSObject *) myObject {
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kDELETE];
    
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\"}",[[mAppDelegate_ mModelForSplashScreen_ ]mEmployeeID_]];
    
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"DamageDetails Request:-%@",Projrequest);
    DLog(@"DamageDetails data:-%@",data);
    DLog(@"DamageDetails Response :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForDeleteDamageDetails:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForPostRequestDamageDetailsImage: (NSObject *) myObject {
    
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
    [Projrequest setHTTPMethod:kPOST];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [Projrequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    
    NSMutableData *theBodyData = [NSMutableData data];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"Image.jpeg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[NSData dataWithData:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mImageData_]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"UserID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [Projrequest setHTTPBody:theBodyData];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"DamageDetails Request:-%@",Projrequest);
    DLog(@"response for images uplaoding %@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessOfPostRequestDamageDetailsImage:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForPutRequestDamageDetailsImage: (NSObject *) myObject {
    
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
    [Projrequest setHTTPMethod:kPUT];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [Projrequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    
    NSMutableData *theBodyData = [NSMutableData data];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"Image.jpeg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[NSData dataWithData:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mImageData_]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"UserID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"NewDisplayOrder\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"%@",@"1"] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [Projrequest setHTTPBody:theBodyData];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"DamageDetails Request:-%@",Projrequest);
    DLog(@"response for images uplaoding %@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessOfPutRequestDamageDetailsImage:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForDeleteRequestDamageDetailsImage: (NSObject *) myObject {
    
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
    [Projrequest setHTTPMethod:kDELETE];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [Projrequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    
    NSMutableData *theBodyData = [NSMutableData data];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"Image.jpeg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[NSData dataWithData:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mImageData_]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"UserID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [Projrequest setHTTPBody:theBodyData];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"DamageDetails Request:-%@",Projrequest);
    DLog(@"response for images uplaoding %@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessOfDeleteRequestDamageDetailsImage:) withObject:responseCodeStr waitUntilDone:NO];
}

#pragma mark --
#pragma mark backGround Thread Succes Methods

- (void)onSuccessForSelectedVehicleDiagram:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
  
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
//        [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
        [self getRequestForDamageDetails];
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Selected Vehicle Diagram", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }

}

- (void)onSuccessForSelectedRepairOrdersDetails:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];

    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_ setWalkAroundData:mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mOpenROInspectionDataGetter_.mInspectionFormID_=[mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"FormID"];
        [self getRequestForSelectedVehicleDiagram];
    //    [mAppDelegate_.mOpenROInspectionDataGetter_ loadWalkaroundInspectionForm];

    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Repair Order Request", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }

    
}

- (void)onSuccessForDamageDetails:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];

    if([(NSString *)isSucces intValue] == ASRProOKStatusCode) {
       switch (self.mVehicleDiagramRequest_) {
            case 1: // VehicleDiagramPOSTRequest
                [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
                break;
            case 2: // VehicleDiagramPUTRequest
                [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
                break;
            case 3: // VehicleDiagramDELETERequest
                [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
                break;
            case 4: // DeleteRequestForDamageDetailsImage
                [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
                break;
            default: // GetRequestForDamageDetails
               [mAppDelegate_.mOpenROInspectionDataGetter_ loadWalkaroundInspectionForm];
                break;
        }
        

    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"GET Damage Details", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessForPostDamageDetails:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode || [(NSString *)isSucces intValue] == ASRProCreatedStatusCode) {
        if (mAppDelegate_.mModelForWalkAround_.mImageData_ != nil) {
            [[WalkAroundSupportWebEngine walkAroundSharedInstance] postRequestForDamageDetailsImage];
        }else {
            [self getRequestForDamageDetails];
        }
        
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"POST Damage Details", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessForPutDamageDetails:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode || [(NSString *)isSucces intValue] == ASRProCreatedStatusCode) {
        if (mAppDelegate_.mModelForWalkAround_.mImageData_ != nil) {
            [[WalkAroundSupportWebEngine walkAroundSharedInstance] postRequestForDamageDetailsImage];
        }else {
            [self getRequestForDamageDetails];
        }
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"PUT Damage Details", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessForDeleteDamageDetails:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode || [(NSString *)isSucces intValue] == ASRProCreatedStatusCode) {
        [self getRequestForDamageDetails];
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"DELETE Damage Details", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessOfPostRequestDamageDetailsImage:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode || [(NSString *)isSucces intValue] == ASRProCreatedStatusCode) {
        [self getRequestForDamageDetails];
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"POST Damage Details Image", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessOfPutRequestDamageDetailsImage:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode || [(NSString *)isSucces intValue] == ASRProCreatedStatusCode) {
        [self getRequestForDamageDetails];
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"PUT Damage Details Image", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessOfDeleteRequestDamageDetailsImage:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode || [(NSString *)isSucces intValue] == ASRProCreatedStatusCode) {
        mAppDelegate_.mModelForWalkAround_.mImageData_ = nil;
        [self getRequestForDamageDetails];
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"DELETE Damage Details Image", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

@end
