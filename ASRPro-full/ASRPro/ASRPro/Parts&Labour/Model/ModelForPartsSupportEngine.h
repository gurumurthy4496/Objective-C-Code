//
//  ModelForPartsSupportEngine.h
//  ASRPro
//
//  Created by Kalyani on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartsSupportWebEngine.h"
#import "PartsConstants.h"


@interface ModelForPartsSupportEngine : NSObject{
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
}

/**
 * Instance of PartsSupportWebEngine
 */
@property(nonatomic,retain)PartsSupportWebEngine* mPartsSupportWebEngine_;

/**
 * Variable to store reference value
 */
@property (nonatomic,assign) getPartsReference mGetPartsReference_;

/**
 * Get Request for Parts and Labor Items in Parts Lookup
 */
-(void)requestToGetParts:(NSString*)aRONumber;

/**
 * post Request to add part to Line
 */
-(void)requestToAddParts:(NSString*)aRONumber
                  LineID:(NSString*)aLineID
             RequestDict:(NSMutableDictionary*)aRequestDict;

/**
 *  put Request to update part in Line
 */
-(void)requestToUpdateParts:(NSString*)aRONumber
                RequestDict:(NSMutableDictionary*)aRequestDict;

/**
 *  delete Request to delte part in Line
 */
-(void)requestToDeleteParts:(NSString*)aRONumber
                     PartID:(NSString*)aPartID;

/**
 * post Request for add Parts and Labor Items in Parts Lookup
 */
-(void)requestToAddLookup:(NSString*)aRONumber
              RequestDict:(NSMutableDictionary*)aRequestDict;

/**
 * Get Request for Parts added to lines
 */
-(void)RequestFoGetPartsLines:(NSString*)aRepairOrderID;

/**
 * Get Request for Locations
 */
-(void)RequestFoGetLocations;

@end
