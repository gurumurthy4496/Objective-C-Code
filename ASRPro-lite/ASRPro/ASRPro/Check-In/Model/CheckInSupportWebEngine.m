//
//  CheckInSupportWebEngine.m
//  ASRPro
//
//  Created by GuruMurthy on 21/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "CheckInSupportWebEngine.h"
static CheckInSupportWebEngine *sharedCheckInSupportWebEngine = nil;

@implementation CheckInSupportWebEngine

+ (id)checkInSharedInstance {
    @synchronized(self) {
        if(sharedCheckInSupportWebEngine == nil)
            sharedCheckInSupportWebEngine = [[super allocWithZone:NULL] init];
    }
    return sharedCheckInSupportWebEngine;
}

#pragma mark --
#pragma mark Singleton Methods


+ (id)allocWithZone:(NSZone *)zone {
    return [self checkInSharedInstance];
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
#pragma mark CheckIN_InspectionCautionedOrFailed_API_GET
- (void)getRequestForInspectionCautionedOrFailed {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionItems",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,mAppDelegate_.mModelForWalkAround_.mTempPRE_RONumber];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForInspectionCautionedOrFailed:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

#pragma mark --
#pragma mark CheckIN_ROToBeMovedToDispatchMode_API_PUT
- (void)putRequestForROToBeMovedToDispatchMode {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/CheckInProcess/%@/Completion",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,mAppDelegate_.mModelForWalkAround_.mTempPRE_RONumber];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForROToBeMovedToDispatchMode:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

#pragma mark --
#pragma mark CheckIN_TOChangePromiseDateAndTime_API_PUT
- (void)putRequestForChangingPromiseDateAndTime {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,mAppDelegate_.mModelForWalkAround_.mTempPRE_RONumber];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForChangingPromiseDateAndTime:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

#pragma mark --
#pragma mark CheckIN_API_RODetails_GET
- (void)getRequestForRODetails {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForGetRequestRepairOrdersDetails:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

#pragma mark --
#pragma mark CheckIN_API_RODetails_POST
- (void)postRequestForSaveCustomerSignature {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr = @"";
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/CustomerSignature",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[mAppDelegate_ mModelForWalkAround_].mTempPRE_RONumber];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(postRequestForSaveCustomerSignature:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}


#pragma mark --
#pragma mark backGround Thread Request Methods

-(void)threadForInspectionCautionedOrFailed: (NSObject *) myObject {
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
    DLog(@"InspectionCautionedOrFailedItems Request:-%@",Projrequest);
    DLog(@"InspectionCautionedOrFailedItems Response:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                   options:kNilOptions error:&jsonError];
    DLog(@"mInspectionCautionedOrFailedItemsArray_:-%@",mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_);
    [mAppDelegate_.mModelForCheckIn_ filterInspectionItemsArray:mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessInspectionCautionedOrFailed:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForROToBeMovedToDispatchMode: (NSObject *) myObject {
    
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
    
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\"}",[[mAppDelegate_ mModelForSplashScreen_ ]mEmployeeID_]];
    
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@" Request:-%@",Projrequest);
    DLog(@" Response:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForROToBeMovedToDispatchMode:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)threadForChangingPromiseDateAndTime: (NSObject *) myObject {
    
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
    
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"Data\":{\"TagNumber\":\"%@\",\"FormID\":\"%@\",\"VehicleDiagramSetID\":\"%@\",\"PartEmpID\":\"%@\",\"PromisedDate\":\"%@\",\"PromisedTime\":\"%@\"}}",[[mAppDelegate_ mModelForSplashScreen_ ]mEmployeeID_],mAppDelegate_.mModelForCheckIn_.mTagNumber_,mAppDelegate_.mModelForCheckIn_.mFormID_,mAppDelegate_.mModelForCheckIn_.mVehicleDiagramSetID_,mAppDelegate_.mModelForCheckIn_.mPartEmpID_,mAppDelegate_.mModelForCheckIn_.mPromisedDate_,mAppDelegate_.mModelForCheckIn_.mPromisedTime_];
    
        
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@" Request:-%@",Projrequest);
    DLog(@" Data:-%@",data);
    DLog(@" Response:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForChangingPromiseDateAndTime:) withObject:responseCodeStr waitUntilDone:NO];
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

- (void)postRequestForSaveCustomerSignature: (NSObject *) myObject {
    
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
    [theBodyData appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"Image.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[NSData dataWithData:[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCustomerSignatureView_.mCustomerSignatureUIImageView_.mSignatureData_]];
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
    DLog(@"CustomerSignature Request:-%@",Projrequest);
    DLog(@"CustomerSignature for images uplaoding %@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessOfSaveCustomerSignature:) withObject:responseCodeStr waitUntilDone:NO];
}

#pragma mark --
#pragma mark backGround Thread Succes Methods

- (void)onSuccessInspectionCautionedOrFailed:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        //Storing VehicleDiagramSets into the files
        [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"GET Inspection Cautioned Or Failed", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessForROToBeMovedToDispatchMode:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        //Storing VehicleDiagramSets into the files
        [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"PUT Request For RO To Be Moved To Dispatch Mode", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessForChangingPromiseDateAndTime:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        [self getRequestForRODetails];
    } else { // unable to get
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"PUT Request For Changing RepairOrders", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessForSelectedRepairOrdersDetails:(NSObject *) isSucces {
    
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        
    } else {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Repair Order Request", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessOfSaveCustomerSignature:(NSObject *) isSucces {
    
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode || [(NSString *)isSucces intValue]==ASRProCreatedStatusCode) {
        
    } else {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Customer Signature Request", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

@end
