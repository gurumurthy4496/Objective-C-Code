//
//  ModelForPartsSupportEngine.m
//  ASRPro
//
//  Created by Kalyani on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForPartsSupportEngine.h"

@implementation ModelForPartsSupportEngine

@synthesize mPartsSupportWebEngine_;

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
      mPartsSupportWebEngine_ =[[PartsSupportWebEngine alloc] init];
    }
    
    return self;
    
}


-(void)requestToGetParts:(NSString*)aRONumber{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Parts/%@/Lookup",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mPartsSupportWebEngine_ setMRequestData_:nil];
        [NSThread detachNewThreadSelector:@selector(getRequestForPartsLookup:) toTarget:mPartsSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }

}

-(void)requestToAddParts:(NSString*)aRONumber
                  LineID:(NSString*)aLineID
             RequestDict:(NSMutableDictionary*)aRequestDict{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Parts/%@/Lines/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber,aLineID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mPartsSupportWebEngine_ setMRequestData_:aRequestDict];
        [NSThread detachNewThreadSelector:@selector(postRequestForPartsLookup:) toTarget:mPartsSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }

}

-(void)requestToUpdateParts:(NSString*)aRONumber
RequestDict:(NSMutableDictionary*)aRequestDict{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Parts/%@/Lines",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mPartsSupportWebEngine_ setMRequestData_:aRequestDict];
        [NSThread detachNewThreadSelector:@selector(putRequestForPartsLookup:) toTarget:mPartsSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }

}

-(void)requestToDeleteParts:(NSString*)aRONumber
                     PartID:(NSString*)aPartID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Parts/%@/Parts/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber,aPartID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mPartsSupportWebEngine_ setMRequestData_:nil];
        [NSThread detachNewThreadSelector:@selector(deleteRequestForPartsLookup:) toTarget:mPartsSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }

}

-(void)requestToAddLookup:(NSString*)aRONumber
RequestDict:(NSMutableDictionary*)aRequestDict{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Parts/%@/Lines",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mPartsSupportWebEngine_ setMRequestData_:aRequestDict];
        [NSThread detachNewThreadSelector:@selector(postRequestForAddLookup:) toTarget:mPartsSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}


-(void)RequestFoGetPartsLines:(NSString*)aRepairOrderID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForAddParts:) toTarget:self.mPartsSupportWebEngine_  withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestFoGetLocations{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Parts/Locations",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForLocationID:) toTarget:self.mPartsSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }

}
@end
