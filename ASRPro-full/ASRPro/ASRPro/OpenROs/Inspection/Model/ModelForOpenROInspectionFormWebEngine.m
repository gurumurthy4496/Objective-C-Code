//
//  ModelForOpenROInspectionFormWebEngine.m
//  ASRPro
//
//  Created by Kalyani on 04/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForOpenROInspectionFormWebEngine.h"

@implementation ModelForOpenROInspectionFormWebEngine
@synthesize mOpenROInspectionWebEngine_;
@synthesize mFormReference;

#pragma mark -
#pragma mark Synchronous Requests Methods
- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        mOpenROInspectionWebEngine_=[[OpenROInspectionWebEngine alloc] init];
    }
    return self;
}


-(void)requestForLoadingInspectionFormList{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/InspectionForms",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForInspectionFormList:) toTarget:mOpenROInspectionWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}
-(void)requestForLoadingAllInspectionForms{
  //  mFormReference=BACKGROUNDTHREAD;

    if(mOpenROInspectionWebEngine_->mFormCount_>0){
     [self requestForLoadingInspectionForm:[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormsArray_ objectAtIndex:mOpenROInspectionWebEngine_->mFormCount_-1] objectForKey:@"ID"]];
        mOpenROInspectionWebEngine_->mFormCount_--;
    }
}

-(void)requestForLoadingInspectionForm:(NSString*)aFormID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/InspectionForms/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aFormID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForInspectionForm:) toTarget:mOpenROInspectionWebEngine_ withObject: [NSMutableArray arrayWithObjects:lRequestStr,aFormID, nil]];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}



-(void)requestForLoadingROInspectionForm:(NSString*)aFormID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];

        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/InspectionForms/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aFormID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForInspectionFormIndividual:) toTarget:mOpenROInspectionWebEngine_ withObject: [NSMutableArray arrayWithObjects:lRequestStr,aFormID, nil]];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)requestForFormID:(NSString*)aRONumber{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getInspectionFormID:) toTarget:mOpenROInspectionWebEngine_ withObject:lRequestStr ];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
}
-(void)requestForAddInspectionItem:(NSString*)aRONumber
                       requestDict:(NSMutableDictionary*)aRequestDict{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionItems",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mOpenROInspectionWebEngine_ setMRequestData:aRequestDict];
        [NSThread detachNewThreadSelector:@selector(postRequestForAddInspectionItem:) toTarget:mOpenROInspectionWebEngine_ withObject:lRequestStr ];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
    
}
-(void)requestForUpdateInspectionItem:(NSString*)aRONumber
                               itemID:(NSString*)anASRIID
                          requestDict:(NSMutableDictionary*)aRequestDict{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionItems/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber,anASRIID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mOpenROInspectionWebEngine_ setMRequestData:aRequestDict];
        [NSThread detachNewThreadSelector:@selector(putRequestForUpdateInspectionItem:) toTarget:mOpenROInspectionWebEngine_ withObject:lRequestStr ];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}
-(void)requestForDeleteInspectionItem{
    
}
-(void)requestForchangeInspectionForm:(NSString*)aRONumber
                          requestDict:(NSMutableDictionary*)aRequestDict{
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mOpenROInspectionWebEngine_ setMRequestData:aRequestDict];
        [NSThread detachNewThreadSelector:@selector(putRequestForChangeInspectionForm:) toTarget:mOpenROInspectionWebEngine_ withObject:lRequestStr ];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}


#pragma mark -
#pragma mark Asynchronous Requests Methods
-(void)requestForInspectionItems:(NSString*)aRONumber{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppDelegate_.mRequestMethods_ getListForInspectionItems:aRONumber];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}
-(void)requestForCompleteInspection:(NSString*)aRONumber{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppDelegate_.mRequestMethods_ putRequestCompleteInspection:aRONumber];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }

}
-(void)requestToChangeMode:(NSString*)aString{
    
   // mAppDelegate_.mServicesDataGetter_.mROMode_=[aString intValue];
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
       NSString* mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/ROMode/%@",WEBSERVICEURL,[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mStoreID_],[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_] mOpenROString_],aString];
       mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NSThread detachNewThreadSelector:@selector(PutRequestToChangeRoModeFromDispatchToInspection:) toTarget:mOpenROInspectionWebEngine_ withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
    }
    
}

@end
