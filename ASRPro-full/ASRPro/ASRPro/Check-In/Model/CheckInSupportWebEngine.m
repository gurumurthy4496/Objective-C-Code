
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
@synthesize mResponseString_;

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

- (void)getRequestForPreROEstimatePDF {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr = @"";
        
        
        if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
            mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/PDFs/PreROEstimate",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[NSString stringWithFormat:@"%@",self.mPRERONumber]];
        }else {
            mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/PDFs/CustomerPlan",WEBSERVICEURL,[mAppDelegate_ mModelForSplashScreen_].mStoreID_,[NSString stringWithFormat:@"%@",self.mPRERONumber]];

        }
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForPreROEstimatePDF:) toTarget:self withObject: mRequestStr];
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
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
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
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
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
    self.mPRERONumber = [json_string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    [mAppDelegate_.mModelForVehicleHistoryTableView_ setMOpenROString_:[NSString stringWithFormat:@"%@",self.mPRERONumber]];
    
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
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPUT];
    
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"Data\":{\"TagNumber\":\"%@\",\"FormID\":\"%@\",\"VehicleDiagramSetID\":\"%@\",\"PartEmpID\":\"%@\",\"PromisedDate\":\"%@\",\"PromisedTime\":\"%@\",\"IsWaiter\":\"%@\"}}",[[mAppDelegate_ mModelForSplashScreen_ ]mEmployeeID_],mAppDelegate_.mModelForCheckIn_.mTagNumber_,mAppDelegate_.mModelForCheckIn_.mFormID_,mAppDelegate_.mModelForCheckIn_.mVehicleDiagramSetID_,mAppDelegate_.mModelForCheckIn_.mPartEmpID_,mAppDelegate_.mModelForCheckIn_.mPromisedDate_,mAppDelegate_.mModelForCheckIn_.mPromisedTime_,[self convertBooltoString:mAppDelegate_.mModelForCheckIn_.waiter]];
    
    
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

- (NSString *)convertBooltoString:(BOOL)aValue{
    return aValue?@"TRUE":@"FALSE";
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
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
    
    NSMutableData *theBodyData = [NSMutableData data];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"Image.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"Customer Signature Data :-%@",[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCustomerSignatureView_.mCustomerSignatureUIImageView_.mSignatureData_);
    [theBodyData appendData:[NSData dataWithData:[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCustomerSignatureView_.mCustomerSignatureUIImageView_.mSignatureData_]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"%@",[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCustomerSignatureView_.mCustomerSignatureUIImageView_.mSignatureData_);
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
    self.mResponseString_ = json_string;
    DLog(@"CustomerSignature Request:-%@",Projrequest);
    DLog(@"CustomerSignature for images uplaoding %@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessOfSaveCustomerSignature:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)getRequestForPreROEstimatePDF: (NSObject *) myObject {
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
    DLog(@"PDF Request:-%@",Projrequest);
    DLog(@"PDF Response:-%@",json_string);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:kNilOptions error:&jsonError];
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForCheckIn_.urlString = [dict objectForKey:@"URL"];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForPreROEstimatePDF:) withObject:responseCodeStr waitUntilDone:NO];
}

#pragma mark --
#pragma mark backGround Thread Succes Methods

- (void)onSuccessInspectionCautionedOrFailed:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        //Storing VehicleDiagramSets into the files
        //        [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
        mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_=[[FileUtils fileUtils] loadDictionaryFromFileFolder:kINSPECTIONFORMSFOLDERPATH Path:[NSString stringWithFormat:@"%@-%@",kINPECTIONFORMNAMEPATH,mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormID_]];
        if( mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_==nil){
            mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference=ChECKINVIEWREFERENCE;
            [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForLoadingROInspectionForm:mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormID_];
        }else {
            [mAppDelegate_.mModelForCheckIn_ filterInspectionItemsArray:mAppDelegate_.mModelForCheckIn_.mInspectionCautionedOrFailedItemsArray_];
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mCheckInRightView_.mInspectionCautionedOrFailedUITableView_ setDelegatesAndDataSourcesForInspectionCautionedOrFailedUITableView];
            
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_];
            
        }
        
        
        
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Inspection Cautioned Or Failed", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)onSuccessForROToBeMovedToDispatchMode:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        //Storing VehicleDiagramSets into the files
        DLog(@"Instance :-%@",mAppDelegate_.mOnSuccessDelegate_);
        [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
    } else { // unable to To Be Moved To Dispatch Mode
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lERROR", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
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
        [self showSignatureSavedAlert];
        if ([[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_.mISFronCheckInScreen_ == ClickedDone) {
            return;
        }
        [self getRequestForRODetails];
    } else {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Customer Signature", nil) message:self.mResponseString_];
    }
}

- (void)onSuccessForPreROEstimatePDF:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode || [(NSString *)isSucces intValue]==ASRProCreatedStatusCode) {
        [mAppDelegate_.mSearchViewController_ pushToPreROEstimatePDFView];
        mAppDelegate_.mModelforOpenROSupportEngine_.mGetServiceReference_= OPENROMAINVIEWCONTROLLER;
        [mAppDelegate_.mModelforOpenROSupportEngine_  RequestForRepairOrderServiceLines:[NSString stringWithFormat:@"%@",[mAppDelegate_ mModelForVehicleHistoryTableView_].mOpenROString_]];
    } else {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Pre RO Estimate", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
}

- (void)showSignatureSavedAlert {
    UIImage *signatureSavedImage = [UIImage imageNamed:@"Signature-saved"];

    CGRect frame = [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_] frame];
    frame.origin.x = (frame.size.width - signatureSavedImage.size.width)/2;
    frame.origin.y = (frame.size.height - signatureSavedImage.size.height)/2;
    frame.size.width = signatureSavedImage.size.width;
    frame.size.height = signatureSavedImage.size.height;
    UIImageView *signatureSavedImageView = [[UIImageView alloc] init];
    [signatureSavedImageView setImage:signatureSavedImage];
    [signatureSavedImageView setFrame:frame];
    [signatureSavedImageView setHidden:YES];
    UILabel *label = [[UILabel alloc] init];
    [label setText:@"Signature Saved"];
    [label setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFrame:CGRectMake(0, 0, signatureSavedImage.size.width, signatureSavedImage.size.height)];
    [signatureSavedImageView addSubview:label];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_] addSubview:signatureSavedImageView];

    [self codeToHideClearButton];
    
    if(signatureSavedImageView.hidden == true)
    {
        signatureSavedImageView.hidden = false;

        [UIView animateWithDuration:9.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^ {
                             [UIView beginAnimations:@"." context:nil];
                             [UIView setAnimationDelegate:self];
                             [UIView setAnimationDuration:.9];
                             signatureSavedImageView.alpha = 1;
                             [UIView commitAnimations];
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:1.0
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^ {
                                              }
                                              completion:^(BOOL finished) {
                                                  [self performSelector:@selector(hideImageView:) withObject:signatureSavedImageView afterDelay:3];
                                              }];
                         }];
    }
    else
    {
        [UIView animateWithDuration:1.0
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^ {
                         }
                         completion:^(BOOL finished) {
                             signatureSavedImageView.hidden = true;
                         }];
    }
}

- (void)hideImageView:(UIImageView *)aImageView {
    [UIView beginAnimations:@"." context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:.9];
	aImageView.alpha = 0;
	[UIView commitAnimations];
}

- (void)codeToHideClearButton {
    
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_].mSaveButton_ setFrame:CGRectMake([[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_].mClearButton_.frame.origin.x + [[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_].mClearButton_.frame.size.width - 20, 0, 80, 35)];
    
    [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_].mSaveButton_ titleLabel] setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_].mSaveButton_ setTitle:@"Saved" forState:UIControlStateNormal];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_].mSaveButton_ setTitle:@"Saved" forState:UIControlStateSelected];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_].mClearButton_ setHidden:TRUE];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_].mSaveButton_ setUserInteractionEnabled:FALSE];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mCheckInViewController_] mCustomerSignatureView_].mCustomerSignatureUIImageView_ setUserInteractionEnabled:FALSE];
    
}

@end
