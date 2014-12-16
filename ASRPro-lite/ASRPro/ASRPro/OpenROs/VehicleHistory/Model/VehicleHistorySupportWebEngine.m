//
//  VehicleHistorySupportWebEngine.m
//  ASRPro
//
//  Created by GuruMurthy on 25/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "VehicleHistorySupportWebEngine.h"
#import "UIView+CustomAnimation.h"

static VehicleHistorySupportWebEngine *sharedVehicleHistorySupportWebEngine = nil;

@implementation VehicleHistorySupportWebEngine

+ (id)sharedInstance {
    @synchronized(self) {
        if(sharedVehicleHistorySupportWebEngine == nil)
            sharedVehicleHistorySupportWebEngine = [[super allocWithZone:NULL] init];
    }
    return sharedVehicleHistorySupportWebEngine;
}

#pragma mark --
#pragma mark Singleton Methods


+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (id)init {
    if (self = [super init]) {
        //        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}



#pragma mark --
#pragma mark Public Methods

- (void)getRequestForVehicleHistory {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/History?UserID=%@",WEBSERVICEURL,[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mStoreID_,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_/*@"PRE-1402130434"*/,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeID_];
        DLog(@"VEHICLE HISTORY REQUEST :-%@",mRequestStr);
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(threadForGetRequestROHistory:) toTarget:self withObject: mRequestStr];
        
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

- (void)putRequestForAssigningROToTechnicianOrAdvisor {
    NSString *mRequestStr = @"";
    if([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mUserRole_ isEqualToString:@"Technician"])
    {
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Technician",WEBSERVICEURL,[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mStoreID_,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    }
    if([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mUserRole_ isEqualToString:@"Advisor"])
    {
        mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Advisor",WEBSERVICEURL,[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mStoreID_,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    }
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        DLog(@"REQUEST TO ASSIGN AN RO# TO ADVISOR OR TECHNICIAN :-:%@",mRequestStr);
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(PutRequestToAssignAdvisorOrTechnicianToAnRO:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}


- (void)methodToChangeModeFormDispatchModeToInspectionView {
    NSString *mRequestStr=@"";
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/ROMode/%@",WEBSERVICEURL,[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mStoreID_],[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_]  mOpenROString_],@"3"];
        DLog(@"REQUEST FOR MODE CHANGE FROM 2 TO 3 :%@",mRequestStr);
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(PutRequestToChangeRoModeFromDispatchToInspection:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
}

- (void)threadRequestToGetRepairOrders {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders",WEBSERVICEURL,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mStoreID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestToGetListOfRepairOrders:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

#pragma mark --
#pragma mark backGround Thread Request Methods

-(void)threadForGetRequestROHistory: (NSObject *) myObject {
    NSError *jsonError;
    ;
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
     DLog(@"VEHICLE HISTORY RESPONSE:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                                                             options:kNilOptions error:&jsonError];
    
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForGetROHistory:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void) PutRequestToAssignAdvisorOrTechnicianToAnRO: (NSObject *) myObject {
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
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"EmployeeID\" : \"%@\"}",[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeID_,[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeID_];
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"RESPONSE :- %@", json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessToAssignAdvisorOrTechnicianToAnRO:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void) PutRequestToChangeRoModeFromDispatchToInspection: (NSObject *) myObject {
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
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"ClosedReason\":\"%@\"}",[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeID_,@"1"];
    /*we are setting default value "1" for ClosedReason`(Note: Need to make dynamic) (int; required when closing a repair order.)
     * 1    Default
     * 2    Manual: An advisor closes it as part of the normal work process.
     * 3    Manual: An advisor batch-closes all ROs in Review mode.
     * 4    Manual: A manager closes it.
     * 11   Manual: A Super Admin closes it.*/
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"ChangeRoMode RESPONSE:-%@",Projrequest);
    DLog(@"ChangeRoMode RESPONSE:-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessOfChangeROMode:) withObject:responseCodeStr waitUntilDone:NO];
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
    DLog(@"Appointments RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mRepairOrdersData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                          options:kNilOptions error:&jsonError];
    DLog(@"Appointments Data Array :-%@",[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mRepairOrdersData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForRepairOrders:) withObject:responseCodeStr waitUntilDone:NO];
}

#pragma mark --
#pragma mark backGround Thread Succes Methods
- (void)onSuccessForGetROHistory:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if ([[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_.mGetServiceReference_==VEHICLEHISTORYSERVICES) {
        id object = [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ valueForKey:@"Status"];
        
        if (![object isKindOfClass:[NSArray class]]) {
            
            [self errorResponseForVehicleHistory];
            
        }else {
            
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mVehicleHistoryViewController_] initDataInTableView];
        }
        return;
    }
    LogBool([[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_].mToshowVehicleHistoryViewOrNot_);
    
    if ([[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_].mToshowVehicleHistoryViewOrNot_) {//This block is to show Vehicle History View.
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_ presentVehicleHistoryViewController:nil];
        if([(NSString *)isSucces intValue] == ASRProOKStatusCode) {
            
            id object = [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ valueForKey:@"Status"];
            
            if (![object isKindOfClass:[NSArray class]]) {
                
                [self errorResponseForVehicleHistory];
                
            }else {
                
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mVehicleHistoryViewController_] initDataInTableView];
            }
        }else {
            
            [self errorResponseForVehicleHistory];
        }
        
    }else {//This block is to show Services View.
        if([(NSString *)isSucces intValue] == ASRProOKStatusCode) {
            
            id object = [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistory_.mVehicleHistoryArray_ valueForKey:@"Status"];
            
            if (![object isKindOfClass:[NSArray class]]) {
                
                NSMutableDictionary *lTempDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"lNoVehicleHistoryFound", Nil),@"RONumber",@"",@"DMSClosedDate", nil];
                
                NSMutableArray *lTempArray = [[NSMutableArray alloc] initWithObjects:lTempDictionary, nil];
                
                [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistory_.mVehicleHistoryArray_ = lTempArray;
                
                RELEASE_NIL(lTempArray);
                
            }else {
                
            }
        }else {
            
            NSMutableDictionary *lTempDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"lNoVehicleHistoryFound", Nil),@"RONumber",@"",@"DMSClosedDate", nil];
            
            NSMutableArray *lTempArray = [[NSMutableArray alloc] initWithObjects:lTempDictionary, nil];
            
            [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistory_.mVehicleHistoryArray_ = lTempArray;
            
            [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ = lTempArray;
            
            RELEASE_NIL(lTempArray);
            
        }
        // Set the Category array;
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_ setVehicleHistoryCategoryArray];
        
        // Set the Section Array;
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_ setVehicleHistorysectionInfoArray];
    }
}

- (void)onSuccessToAssignAdvisorOrTechnicianToAnRO:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode){
        
    }
}

- (void)onSuccessOfChangeROMode:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode){
        [self threadRequestToGetRepairOrders];
    }
}

- (void)onSuccessForRepairOrders:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSearchScreen_ getInprocessListFromRepairOrders];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] reloadOpenROData];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            if ([[object valueForKey:@"RONumber"] isEqualToString:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_].mOpenROString_]) {
                [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.mOpenROTableView_.mselectedCustomerindex_ = index;
                [[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.mOpenROTableView_ selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
                [[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_].mCurrentMode_ = [[[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:index] valueForKey:@"CurrentMode"] integerValue];

            }
        }];

        
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ setMGetServiceReference_:OPENROMAINVIEWCONTROLLER];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_  RequestForGetROLines:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    }
}

#pragma mark --
#pragma mark Private Methods

// ----------------------------;
// Below method is called when we get error response from server for Vehicle History -> Fill the mVehicleHistoryArray_ array with dummy data;
// ----------------------------;
- (void)errorResponseForVehicleHistory {
    
    NSMutableDictionary *lTempDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"lNoVehicleHistoryFound", Nil),@"RONumber",@"",@"DMSClosedDate", nil];
    
    NSMutableArray *lTempArray = [[NSMutableArray alloc] initWithObjects:lTempDictionary, nil];
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mVehicleHistoryArray_ = lTempArray;
    
    RELEASE_NIL(lTempArray);
    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mVehicleHistoryViewController_] initDataInTableView];
}

@end
