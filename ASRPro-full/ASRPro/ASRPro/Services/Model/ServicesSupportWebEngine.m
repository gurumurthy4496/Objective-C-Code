//
//  ServicesSupportWebEngine.m
//  ASRPro
//
//  Created by Kalyani on 10/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ServicesSupportWebEngine.h"

@implementation ServicesSupportWebEngine

@synthesize mRequestData_;
@synthesize mImageAddArray_;
@synthesize mImagedeleteArray_;
@synthesize mImageData;

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    }
    
    return self;
    
}

// Request to get list of services
-(void)getRequestForServicesPackage:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kGET];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        NSError *jsonError;
        NSArray* lTempArray=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError];
        mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[lTempArray mutableCopy];
        [mAppDelegate_.mServiceDataGetter_ AlphabeticalStaffNames:mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ ];
        [[FileUtils fileUtils] saveArrayInToFile:mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ Path:kALLSERVICESPATH];
        [[SharedUtilities sharedUtilities] writeDateToUserDefaults:[NSDate date] forKey:kALLSERVICESDATE];
        [ mAppDelegate_.mServiceDataGetter_ filterServicepackages];
        
        
    }
    
    [self performSelectorOnMainThread:@selector(onSuccessForGetServicesPackage:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)getRequestForServices:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kGET];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        NSError *jsonError;
        NSArray* lTempArray=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError];
        mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[lTempArray mutableCopy];
        
        DLog(@"%@", mAppDelegate_.mServiceDataGetter_.mAllServicesArray_);
        [mAppDelegate_.mServiceDataGetter_ AlphabeticalStaffNames:  mAppDelegate_.mServiceDataGetter_.mAllServicesArray_];
        [[FileUtils fileUtils] saveArrayInToFile:mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ Path:kALLSERVICESPATH];
        [[SharedUtilities sharedUtilities] writeDateToUserDefaults:[NSDate date] forKey:kALLSERVICESDATE];
        [ mAppDelegate_.mServiceDataGetter_ filterServicepackages];
        
        
    }
    
    [self performSelectorOnMainThread:@selector(onSuccessForGetServices:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)getRequestForServicesForPullToRefresh:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kGET];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        NSError *jsonError;
        NSArray* lTempArray=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError];
        mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[lTempArray mutableCopy];
        
        DLog(@"%@", mAppDelegate_.mServiceDataGetter_.mAllServicesArray_);
        [mAppDelegate_.mServiceDataGetter_ AlphabeticalStaffNames:  mAppDelegate_.mServiceDataGetter_.mAllServicesArray_];
        [[FileUtils fileUtils] saveArrayInToFile:mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ Path:kALLSERVICESPATH];
        [[SharedUtilities sharedUtilities] writeDateToUserDefaults:[NSDate date] forKey:kALLSERVICESDATE];
        [ mAppDelegate_.mServiceDataGetter_ filterServicepackages];
        
    }
    [self performSelectorOnMainThread:@selector(onSuccessForGetServicesForPullToRefresh:) withObject:responseCodeStr waitUntilDone:NO];
}


// Request to get list of services for RO

-(void)getRequestForROLines:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kGET];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        NSError *jsonError;
        mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ = [[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                        options:kNilOptions error:&jsonError] mutableCopy];
        mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ =[[mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"RepairOrderLines"] mutableCopy];
        [mAppDelegate_.mServiceDataGetter_ filterLines:mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_];
    }
    
    [self performSelectorOnMainThread:@selector(onSuccessForGetROLines:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void) postRequestToAddLine:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kPOST];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    if([responseCodeStr intValue]==201){
        NSError *jsonError;
        NSMutableDictionary* ldict =[[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                     options:kNilOptions error:&jsonError] mutableCopy];
        mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_ =[NSString stringWithFormat:@"%@",[ldict objectForKey:@"ASRLID"]];
    }
    [self performSelectorOnMainThread:@selector(onSuccessForAddLine:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void) putRequestToUpdateLine:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kPUT];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForUpdateLine:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)deleteRequestForLine:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kDELETE];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForDeleteLine:) withObject:responseCodeStr waitUntilDone:NO];
}


-(void)putRequestForApprovedLine:(NSObject*)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONStringwithoutdata:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
	[Projrequest setHTTPMethod:kPUT];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForApprovedLine:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)putRequestForPartsNotNeededLine:(NSObject*)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONStringwithoutdata:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
	[Projrequest setHTTPMethod:kPUT];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForPartsNotNeededLine:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)getRequestForRODetails:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kGET];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        NSError *jsonError;
        mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                       options:kNilOptions error:&jsonError];
        DLog(@"mRepairOrderDetailsArray_:-%@",mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_);
        mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ =[[mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"RepairOrderLines"] mutableCopy];
        [mAppDelegate_.mServiceDataGetter_ filterLines:mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_];
    }
    
    [self performSelectorOnMainThread:@selector(onSuccessForGetRODetails:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)onSuccessForGetRODetails:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        [[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_->isROChanged_ = FALSE;
        
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_ setWalkAroundData:mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mOpenROInspectionDataGetter_.mInspectionFormID_=[mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"FormID"];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mOnSuccessDelegate_ OnsuccessResponseForServices];
        
        
    } else { // unable to get VehicleDiagramSets
        [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"Repair Order Request", nil) message:NSLocalizedString(@"lERROR_RESPONSE_FROM_SERVER_TEXT", nil)];
    }
    
}

- (void)onSuccessForPartsNotNeededLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    [mAppDelegate_.mModelForServiceRequestWebEngine_ setMGetServiceReference_:SERVICESVIEWCONTROLLER];
    [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForGetROLines:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
}

- (void)onSuccessForGetServicesPackage:(NSObject *) isSucces {
    [mAppDelegate_.mServicesViewController_.mServicesPackageTableViewController_ reloadServicesData];
    
}

- (void)onSuccessForGetServicesForPullToRefresh:(NSObject *) isSucces {
//    [[SharedUtilities sharedUtilities] removeLoadView];
    [mAppDelegate_.mServicesViewController_.mServicesPackageTableViewController_.tableView setHidden:YES];

    [mAppDelegate_.mServicesViewController_.mServicesPackageTableViewController_ reloadServicesData];


    mAppDelegate_.mServicesViewController_.mServicesPackageTableViewController_->isPulltorefresh=FALSE;
    [mAppDelegate_.mServicesViewController_.mServicesPackageTableViewController_.tableView setHidden:NO];



    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        [mAppDelegate_.mServicesViewController_.mServicesPackageTableViewController_ performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
    }else {
        [mAppDelegate_.mServicesViewController_.mServicesPackageTableViewController_ performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
    }
}


- (void)onSuccessForGetServices:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];

    if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==WALKAROUNDCONTROLLER){
        [[SharedUtilities sharedUtilities] createLoadView];
        [self performSelector:@selector(pushToServicesList) withObject:mAppDelegate_.mWalkAroundViewController_ afterDelay:0.5];
    }
    if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==MAINVIEWCONTROLLER){
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForGetROLines:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_ ];
    }
    if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==SERVICESVIEWCONTROLLER){
        [mAppDelegate_.mServicesViewController_  pushToServicesList];
    }
    if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==SERVICEPACKAGEVIEWCONTROLLER){
        [mAppDelegate_.mServicesViewController_.mServicesPackageTableViewController_ reloadServicesData];
    }
    if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==OPENROSERVICESVIEWCONTROLLER){
        [mAppDelegate_.mSearchViewController_.mOpenROServicesTableViewController_ pushToAddServicesViewModal];
    }
    
}
- (void)onSuccessForGetROLines:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==MAINVIEWCONTROLLER)
        [mAppDelegate_.mOnSuccessDelegate_ OnsuccessResponseForRequest];
    if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==SERVICESVIEWCONTROLLER){
        [mAppDelegate_.mServicesViewController_.mServicesScheduleTableViewController_.tableView reloadData];
        [mAppDelegate_.mServicesViewController_.mRecommendedServicesTableViewController_.tableView reloadData];
    }
    else if (mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==WALKAROUNDCONTROLLER){
        [mAppDelegate_.mServicesViewController_.mServicesScheduleTableViewController_.tableView reloadData];
        [mAppDelegate_.mServicesViewController_.mRecommendedServicesTableViewController_.tableView reloadData];
        
    }
    else if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==VEHICLEHISTORYSERVICES){
        [mAppDelegate_.mServicesViewController_.mServicesScheduleTableViewController_.tableView reloadData];
        [mAppDelegate_.mServicesViewController_.mRecommendedServicesTableViewController_.tableView reloadData];
        [mAppDelegate_.mMasterViewController_ setRequestforVehicleHistory];
    }
}
- (void)onSuccessForAddLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    
    [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForUpdateServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_ ServiceDict:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mServiceDetailsDict_];
    
}
- (void)onSuccessForUpdateLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if(mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_->isAdd_){
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForApproveServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_  ApproveDict:[[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID",@"true",@"Data", nil] mutableCopy]];

    
    }
    else{
    [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForRepairOrderServiceLines:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
    }
}


- (void)onSuccessForDeleteLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        [mAppDelegate_.mModelForServiceRequestWebEngine_  RequestForGetROLines:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
        
    }
    //  else{
    // [mAppDelegate_.mServicesViewController_.mServicesListTableViewController_.tableView reloadData];
    //    [mAppDelegate_.mServicesViewController_ onSucessResponse];
    
    //  }
}

- (void)onSuccessForApprovedLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    [mAppDelegate_.mModelForServiceRequestWebEngine_ setMGetServiceReference_:SERVICESVIEWCONTROLLER];
    [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForGetROLines:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
}

@end
