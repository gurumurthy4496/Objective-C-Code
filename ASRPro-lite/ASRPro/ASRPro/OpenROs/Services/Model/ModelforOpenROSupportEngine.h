//
//  ModelforOpenROSupportEngine.h
//  ASRPro
//
//  Created by Kalyani on 14/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"OpenROSupportWebEngine.h"

@interface ModelforOpenROSupportEngine : NSObject{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    
    BOOL isLoadingRequired;
    int Loadingcount;
}

@property (nonatomic,retain) OpenROSupportWebEngine* mOpenROSupportWebEngine_;
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
-(void)RequestForCompleteServiceLine:(NSString*)aRepairOrderID
                              LineID:(NSString*)aLineID
                              isDone:(BOOL)isDone;
-(void)RequestForCompleteAllServiceLines:(NSString*)aRepairOrderID;
-(void)RequestForApproveServiceLine:(NSString*)aRepairOrderID
                             LineID:(NSString*)aLineID
                        ApproveDict:(NSMutableDictionary*)anApproveDict;
-(void)RequestForGetROLines:(NSString*)aRepairOrderID;
-(void)RequestToAddService:(NSString*)aRepairOrderID
               ServiceDict:(NSMutableDictionary*)aServiceDict;
-(void)RequestToUpdateService:(NSString*)aRepairOrderID
                       LineID:(NSString*)aLineID
                  ServiceDict:(NSMutableDictionary*)aServiceDict;

-(void)RequestToDeleteImages:(NSString*)aRONumber
                      LineId:(NSString*)aLineID
                  ImageArray:(NSMutableArray*)anImageArray;

-(void)RequestToAddImages:(NSString*)aRONumber
                   LineId:(NSString*)aLineID
               ImageArray:(NSMutableArray*)aImgArray
DeleteImagesArray:(NSMutableArray*)aDeleteImgArray;

-(void)RequestForChangeLineOrder:(NSString*)aRepairOrderID
                          LineID:(NSString*)aLineID
                  DisplayOrderID:(NSString*)aDisplayOrderID
                         GroupId:(NSString*)aGroupId;
-(void)requestToSendImageData;
-(void)RequestDeleteImageData;
-(void)RequestToChangePartsStatus:(NSString*)aRepairOrderID
                     PartStatusID:(NSString*)aPartStatusID;
-(void)RequestForLoadingBooklet:(NSString*)aRONumber
                   DocumentType:(NSString*)aDocumentType
                       LineType:(NSString*)aLineType
                       Language:(NSString*)aLanguage
                      EmailType:(NSString*)aEmailType;

@end