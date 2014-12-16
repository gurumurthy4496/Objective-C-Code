//
//  ModelForServiceRequestWebEngine.h
//  ASRPro
//
//  Created by Kalyani on 10/21/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServicesSupportWebEngine.h"
#import "ServicesConstants.h"

@interface ModelForServiceRequestWebEngine : NSObject{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    
    BOOL isLoadingRequired;
    int Loadingcount;
}

@property (nonatomic,retain) ServicesSupportWebEngine* mServicesSupportWebEngine_;
@property (nonatomic,assign) getservicereference mGetServiceReference_;
/**
 * Method used to initialize class
 */
- (id)init;
-(void)RequestForAllServiceLines;
-(void)RequestForRepairOrderServiceLines:(NSString*)aRepairOrderID;
-(void)RequestForAddServiceLine:(NSString*)aRepairOrderID
                          SGCID:(NSString*)aSGCID;
-(void)RequestForUpdateServiceLine:(NSString*)aRepairOrderID
                            LineID:(NSString*)aLineID
                       ServiceDict:(NSMutableDictionary*)aServiceDict;
-(void)RequestForDeleteServiceLine:(NSString*)aRepairOrderID
                            LineID:(NSString*)aLineID;
-(void)RequestForApproveServiceLine:(NSString*)aRepairOrderID
                             LineID:(NSString*)aLineID
                        ApproveDict:(NSMutableDictionary*)anApproveDict;
-(void)RequestForGetROLines:(NSString*)aRepairOrderID;
-(void)RequestToAddService:(NSString*)aRepairOrderID
               ServiceDict:(NSMutableDictionary*)aServiceDict;
-(void)RequestToUpdateService:(NSString*)aRepairOrderID
                       LineID:(NSString*)aLineID
                  ServiceDict:(NSMutableDictionary*)aServiceDict;
-(void)RequestForServiceLines;

@end
