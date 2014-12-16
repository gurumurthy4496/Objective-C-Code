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
    
}

/**
 * instance for OpenROSupportWebEngine
 */
@property (nonatomic,retain) OpenROSupportWebEngine* mOpenROSupportWebEngine_;

/**
 * instance for getservicereference
 */
@property (nonatomic,assign) getservicereference mGetServiceReference_;

/**
 * Method used to initialize class
 */
- (id)init;

/**
 * Method for getting all services in store
 */
-(void)RequestForAllServiceLines;

/**
 * Method for getting lines added to RO
 * @param aRepairOrderID returns RONumber
 */
-(void)RequestForRepairOrderServiceLines:(NSString*)aRepairOrderID;

/**
 * Method for adding service line to RO
 * @param aRepairOrderID returns RONumber
 * @param aSGCID returns SGCID
 */
-(void)RequestForAddServiceLine:(NSString*)aRepairOrderID
                          SGCID:(NSString*)aSGCID;

/**
 * Method for updating service line to RO
 * @param aRepairOrderID returns RONumber
 * @param aLineID returns LineID
 * @param aServiceDict returns service details dictionary
 */
-(void)RequestForUpdateServiceLine:(NSString*)aRepairOrderID
                            LineID:(NSString*)aLineID
                       ServiceDict:(NSMutableDictionary*)aServiceDict;

/**
 * Method action for deleting service line
 * @param aRepairOrderID returns RONumber
 * @param aLineID returns LineID
 */
-(void)RequestForDeleteServiceLine:(NSString*)aRepairOrderID
                            LineID:(NSString*)aLineID;

/**
 * Method for marking complete for service line to RO
  * @param aRepairOrderID returns RONumber
 * @param aLineID returns LineID
 * @param isDone returns Completed state
 */
-(void)RequestForCompleteServiceLine:(NSString*)aRepairOrderID
                              LineID:(NSString*)aLineID
                              isDone:(BOOL)isDone;

/**
* Method for marking complete all service lines to RO
 * @param aRepairOrderID returns RONumber
*/
-(void)RequestForCompleteAllServiceLines:(NSString*)aRepairOrderID;

/**
 * Method for marking approve for service line to RO
 * @param aRepairOrderID returns RONumber
 * @param aLineID returns LineID
 * @param ApproveDict returns Approve Dict
 */
-(void)RequestForApproveServiceLine:(NSString*)aRepairOrderID
                                                    LineID:(NSString*)aLineID
                                            ApproveDict:(NSMutableDictionary*)anApproveDict;
/**
 * Method action when cell swiped left
 * @param aRepairOrderID returns RONumber
 * @param aPartStatusID returns PartStatusID
 */
-(void)RequestToChangePartsStatus:(NSString*)aRepairOrderID
                     PartStatusID:(NSString*)aPartStatusID;

/**
 * Method for marking approve for service line to RO
 * @param aRepairOrderID returns RONumber
 * @param aDocumentType returns DocumentType
 * @param aLineType returns LineType
 * @param aLanguage returns Language
 * @param aEmailType returns Customer Email
*/
-(void)RequestForLoadingBooklet:(NSString*)aRONumber
                   DocumentType:(NSString*)aDocumentType
                       LineType:(NSString*)aLineType
                       Language:(NSString*)aLanguage
                      EmailType:(NSString*)aEmailType;

/**
 * Method for customer planPDF
 * @param aRepairOrderID returns RONumber
 */
-(void)RequestForCustomerPlanPDF:(NSString*)aRONumber;

/**
 * Method action to get Pay Types
 */
-(void)RequestForGetPayTypes;

/**
 * Method to update PartsNotNeeded flag
 * @param aRepairOrderID returns RONumber
 * @param aLineID returns LineID
 * @param aNPLDict returns PartsNotNeeded Dict
 */
-(void)RequestForPartsNotNeeded:(NSString*)aRepairOrderID
                         LineID:(NSString*)aLineID
                        NPLDict:(NSMutableDictionary*)aNPLDict;

/**
 * Method for deleting images in service line to RO
 * @param aRepairOrderID returns RONumber
 * @param aLineID returns LineID
 * @param anImageArray returns images array
*/
-(void)RequestToDeleteImages:(NSString*)aRONumber
                      LineId:(NSString*)aLineID
                  ImageArray:(NSMutableArray*)anImageArray;

/**
 * Method for adding an deleting images in service line to RO
 * @param aRepairOrderID returns RONumber
* @param aLineID returns LineID
 * @param anImageArray returns images array
 * @param anImageArray returns deleting images array
 */
-(void)RequestToAddImages:(NSString*)aRONumber
                   LineId:(NSString*)aLineID
               ImageArray:(NSMutableArray*)aImgArray
DeleteImagesArray:(NSMutableArray*)aDeleteImgArray;

/**
 * Method to add images to line
 */
-(void)requestToSendImageData;

/**
 * Method to delete images from line
 */
-(void)RequestDeleteImageData;

/**
 * Method for getting lines added to RO
 * @param aRepairOrderID returns RONumber
 */
-(void)RequestForGetROLines:(NSString*)aRepairOrderID;

/**
 * Method for adding service line to RO
 * @param aRepairOrderID returns RONumber
 * @param aServiceDict returns Add Service Dictionary
 */
-(void)RequestToAddService:(NSString*)aRepairOrderID
               ServiceDict:(NSMutableDictionary*)aServiceDict;

/**
 * Method for updating service line to RO
 * @param aRepairOrderID returns RONumber
 * @param aLineID returns LineID
 * @param aServiceDict returns service details dictionary
 */
-(void)RequestToUpdateService:(NSString*)aRepairOrderID
                       LineID:(NSString*)aLineID
                  ServiceDict:(NSMutableDictionary*)aServiceDict;

@end