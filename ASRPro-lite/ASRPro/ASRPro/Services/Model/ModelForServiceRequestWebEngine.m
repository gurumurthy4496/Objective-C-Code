//
//  ModelForServiceRequestWebEngine.m
//  ASRPro
//
//  Created by Kalyani on 10/21/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ModelForServiceRequestWebEngine.h"



@interface ModelForServiceRequestWebEngine(){
}
@property (nonatomic,retain) NSMutableArray* mSortArray;
@property (nonatomic,retain) NSMutableArray* mDoneArray;

@end

@implementation ModelForServiceRequestWebEngine
@synthesize mServicesSupportWebEngine_;
@synthesize mSortArray;
@synthesize mDoneArray;
@synthesize mGetServiceReference_;

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
   mServicesSupportWebEngine_=[[ServicesSupportWebEngine alloc]init];
        isLoadingRequired=FALSE;
        Loadingcount=0;
    }
    
    return self;
    
}

-(void)RequestForAllServiceLines{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Services",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
       [NSThread detachNewThreadSelector:@selector(getRequestForServicesPackage:) toTarget:self.mServicesSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestForServiceLines{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];

        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Services",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForServices:) toTarget:self.mServicesSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }

}

-(void)RequestForRepairOrderServiceLines:(NSString*)aRepairOrderID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];

        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      [NSThread detachNewThreadSelector:@selector(getRequestForROLines:) toTarget:self.mServicesSupportWebEngine_  withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestForAddServiceLine:(NSString*)aRepairOrderID
                          SGCID:(NSString*)aSGCID{

    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        if(mGetServiceReference_!=WALKAROUNDCONTROLLER)
            [[SharedUtilities sharedUtilities] createLoadView];

        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary* lRequestDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:aSGCID,@"SGCID", nil];
    [mServicesSupportWebEngine_ setMRequestData_:lRequestDict];
     [NSThread detachNewThreadSelector:@selector(postRequestToAddLine:) toTarget:mServicesSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestForUpdateServiceLine:(NSString*)aRepairOrderID
                            LineID:(NSString*)aLineID
                       ServiceDict:(NSMutableDictionary*)aServiceDict{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID,aLineID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     [mServicesSupportWebEngine_ setMRequestData_:aServiceDict];
      [NSThread detachNewThreadSelector:@selector(putRequestToUpdateLine:) toTarget:mServicesSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestForDeleteServiceLine:(NSString*)aRepairOrderID
                            LineID:(NSString*)aLineID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID,aLineID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mServicesSupportWebEngine_ setMRequestData_:nil];
    [NSThread detachNewThreadSelector:@selector(deleteRequestForLine:) toTarget:mServicesSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestForApproveServiceLine:(NSString*)aRepairOrderID
                             LineID:(NSString*)aLineID
                        ApproveDict:(NSMutableDictionary*)anApproveDict{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines/%@/Approved",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID,aLineID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     [mServicesSupportWebEngine_ setMRequestData_:anApproveDict];
     [NSThread detachNewThreadSelector:@selector(putRequestForApprovedLine:) toTarget:mServicesSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestForGetROLines:(NSString*)aRepairOrderID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
 
        [mAppDelegate_.mRequestMethods_ getListofServices:aRepairOrderID];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
}

-(void)RequestToAddService:(NSString*)aRepairOrderID
               ServiceDict:(NSMutableDictionary*)aServiceDict{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
 [[SharedUtilities sharedUtilities] createLoadView];
    [mAppDelegate_.mRequestMethods_ postRequestToAddNewService:aRepairOrderID RequestData:aServiceDict];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestToUpdateService:(NSString*)aRepairOrderID
                       LineID:(NSString*)aLineID
                  ServiceDict:(NSMutableDictionary*)aServiceDict{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
     [[SharedUtilities sharedUtilities] createLoadView];
        [mAppDelegate_.mRequestMethods_ putRequestToUpdateServiceToARepairOrder:aRepairOrderID LineID:aLineID RequestData:aServiceDict];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }

}

@end
