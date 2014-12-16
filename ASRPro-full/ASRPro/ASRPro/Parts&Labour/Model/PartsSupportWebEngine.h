//
//  PartsSupportWebEngine.h
//  ASRPro
//
//  Created by Kalyani on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartsSupportWebEngine : NSObject{
/**
 * AppDelegate object creating
 */
AppDelegate *mAppDelegate_;
}

/**
 * dictionary to store request data
 */
@property(nonatomic,retain) NSMutableDictionary* mRequestData_;

/**
 * Method used to initialize class
 */
- (id)init;

/**
 * Get Request for Parts and Labor Items in Parts Lookup
 */
-(void)getRequestForPartsLookup:(NSObject *)anObject;

/**
 * Post Request to Add part item to a line
 */
-(void)postRequestForPartsLookup:(NSObject *)anObject;

/**
 * Put Request to update part item in a line
 */
-(void)putRequestForPartsLookup:(NSObject *)anObject;

/**
 * Delete Request to delete part item in a line
 */
-(void)deleteRequestForPartsLookup:(NSObject *)anObject;

/**
 * Post Request to add multiple part and labor items in a line
 */
-(void)postRequestForAddLookup:(NSObject *)anObject;

/**
 * Get Request for part items in a line
 */
-(void)getRequestForAddParts:(NSObject *)anObject;

/**
 * Get Request for Locations in a store
 */
-(void)getRequestForLocationID:(NSObject *)anObject;


@end
