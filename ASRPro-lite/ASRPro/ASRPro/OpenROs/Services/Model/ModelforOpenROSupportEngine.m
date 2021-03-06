//
//  ModelForServiceRequestWebEngine.m
//  ASRPro
//
//  Created by Kalyani on 10/21/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ModelforOpenROSupportEngine.h"



@interface ModelforOpenROSupportEngine(){
}
@property (nonatomic,retain) NSMutableArray* mSortArray;
@property (nonatomic,retain) NSMutableArray* mDoneArray;

@end

@implementation ModelforOpenROSupportEngine
@synthesize mOpenROSupportWebEngine_;
@synthesize mSortArray;
@synthesize mDoneArray;
@synthesize mGetServiceReference_;

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        mOpenROSupportWebEngine_=[[OpenROSupportWebEngine alloc]init];
        isLoadingRequired=FALSE;
        Loadingcount=0;
    }
    
    return self;
    
}

-(void)RequestForAllServiceLines{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Services",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForServices:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestForRepairOrderServiceLines:(NSString*)aRepairOrderID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForROLines:) toTarget:self.mOpenROSupportWebEngine_  withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

-(void)RequestForAddServiceLine:(NSString*)aRepairOrderID
                          SGCID:(NSString*)aSGCID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary* lRequestDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:aSGCID,@"SGCID", nil];
            [mOpenROSupportWebEngine_ setMRequestData_:lRequestDict];
        [NSThread detachNewThreadSelector:@selector(postRequestToAddLine:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
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
          [mOpenROSupportWebEngine_ setMRequestData_:aServiceDict];
        [NSThread detachNewThreadSelector:@selector(putRequestToUpdateLine:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
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
        [mOpenROSupportWebEngine_ setMRequestData_:nil];
        [NSThread detachNewThreadSelector:@selector(deleteRequestForLine:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}


-(void)RequestForChangeLineOrder:(NSString*)aRepairOrderID
                          LineID:(NSString*)aLineID
                  DisplayOrderID:(NSString*)aDisplayOrderID
                         GroupId:(NSString*)aGroupId{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines/%@/DisplayOrder",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID,aLineID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary* lRequestDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:aDisplayOrderID,@"NewDisplayOrder",aGroupId,@"NewGroupID",[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID", nil];
            [mOpenROSupportWebEngine_ setMRequestData_:lRequestDict];
              [NSThread detachNewThreadSelector:@selector(postRequestForDisplayOrder:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
    
}

-(void)RequestForCompleteServiceLine:(NSString*)aRepairOrderID
                              LineID:(NSString*)aLineID
                              isDone:(BOOL)isDone{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines/%@/Completed",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID,aLineID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary* lRequestDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:isDone?@"true":@"false",@"Data",[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_],@"UserID", nil];
            [mOpenROSupportWebEngine_ setMRequestData_:lRequestDict];
           [NSThread detachNewThreadSelector:@selector(putRequestForCompletedLine:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
    
}

-(void)RequestForCompleteAllServiceLines:(NSString*)aRepairOrderID {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines/Completed",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
           [mOpenROSupportWebEngine_ setMRequestData_:nil];
              [NSThread detachNewThreadSelector:@selector(postRequestForAllWorkDone:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
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
          [mOpenROSupportWebEngine_ setMRequestData_:anApproveDict];
           [NSThread detachNewThreadSelector:@selector(putRequestForApprovedLine:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
    
}

-(void)RequestToChangePartsStatus:(NSString*)aRepairOrderID
                     PartStatusID:(NSString*)aPartStatusID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/PartStatus/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRepairOrderID,aPartStatusID];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [mOpenROSupportWebEngine_ setMRequestData_:nil];
            [NSThread detachNewThreadSelector:@selector(putRequestFoPartStatus:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
    
}

-(void)RequestForGetROLines:(NSString*)aRepairOrderID{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        [mAppDelegate_.mRequestMethods_ getListofOpenROServices:aRepairOrderID];
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

-(void)RequestToAddImages:(NSString*)aRONumber
                   LineId:(NSString*)aLineID
               ImageArray:(NSMutableArray*)aImgArray
        DeleteImagesArray:(NSMutableArray*)aDeleteImgArray{
    
   [mOpenROSupportWebEngine_ setMImageAddArray_:aImgArray];
    [mOpenROSupportWebEngine_ setMImagedeleteArray_:aDeleteImgArray];

    [self requestToSendImageData];
}
-(void)requestToSendImageData  {
      if([mOpenROSupportWebEngine_.mImageAddArray_ count]>0){
     if ([[NetworkMonitor instance] isNetworkAvailable]) {
       [[SharedUtilities sharedUtilities] createLoadView];
   NSString *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines/%@/Images",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_,mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_];
          lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   mOpenROSupportWebEngine_.mImageData=[mOpenROSupportWebEngine_.mImageAddArray_ objectAtIndex:0];
     [NSThread detachNewThreadSelector:@selector(postRequestToAddImages:) toTarget:mOpenROSupportWebEngine_ withObject: lRequestStr];
       [mOpenROSupportWebEngine_.mImageAddArray_ removeObjectAtIndex:0];

    }else {
           [[NetworkMonitor instance]displayNetworkMonitorAlert];
     }
   }
    else{
        [self RequestDeleteImageData];
    }
   
    
}

-(void)RequestToDeleteImages:(NSString*)aRONumber
                      LineId:(NSString*)aLineID
                  ImageArray:(NSMutableArray*)anImageArray{
    [self RequestDeleteImageData];
    }

-(void)RequestDeleteImageData{
    if([mOpenROSupportWebEngine_.mImagedeleteArray_ count]>0){
        if ([[NetworkMonitor instance] isNetworkAvailable]) {
            [[SharedUtilities sharedUtilities] createLoadView];
            NSString *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines/%@/Images/%@?UserID=%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_,mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_,[[mOpenROSupportWebEngine_.mImagedeleteArray_ objectAtIndex:0] objectForKey:@"DisplayOrder"], mAppDelegate_.mModelForSplashScreen_.mEmployeeID_];
            [mOpenROSupportWebEngine_.mImagedeleteArray_ removeObjectAtIndex:0];
            lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [NSThread detachNewThreadSelector:@selector(postRequestToDeleteImages:) toTarget:mOpenROSupportWebEngine_ withObject: lRequestStr];
            
        }else {
            [[NetworkMonitor instance]displayNetworkMonitorAlert];
        }
    }
    else{
        [self RequestForGetROLines:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
    }
}

-(void)RequestForLoadingBooklet:(NSString*)aRONumber
                   DocumentType:(NSString*)aDocumentType
                       LineType:(NSString*)aLineType
                       Language:(NSString*)aLanguage
                      EmailType:(NSString*)aEmailType{
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
     //   [[SharedUtilities sharedUtilities] createLoadView];
        NSString  *lRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/PDFs/%@?LineType=%@&Language=%@&SendEmail=%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber,aDocumentType,aLineType,aLanguage,aEmailType];
        lRequestStr = [lRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(getRequestForPDF:) toTarget:self.mOpenROSupportWebEngine_ withObject: lRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }

    
}




@end
