//
//  WalkAroundSupportWebEngine.h
//  ASRPro
//
//  Created by GuruMurthy on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
 
 VehicleDiagramPOSTRequest = 1,
 
 VehicleDiagramPUTRequest,

 VehicleDiagramDELETERequest,
    
 VehicleDiagramDELETEImageRequest,
 
 } VehicleDiagramRequest;

@interface WalkAroundSupportWebEngine : NSObject {
    AppDelegate *mAppDelegate_;
}

@property (nonatomic, assign) VehicleDiagramRequest mVehicleDiagramRequest_;

@property (nonatomic, retain) NSString *mResponseString_;


/**
 * Shared instance method.
 */
+ (id)walkAroundSharedInstance;

/**
 * Method to get request for VehicleDiagramSets for particular store(cache data).
 */
- (void)getRequestForVehicleDiagramSets;

/**
 * Method to get request for selected vehicle diagram.
 */
- (void)getRequestForSelectedVehicleDiagram;

/**
 * Method to get request for RODetails.
 */
- (void)getRequestForRODetails;

/**
 * Method to get request for Damage Details.
 */
- (void)getRequestForDamageDetails;

/**
 * Method to POST request for Damage Details.
 */
- (void)postRequestForDamageDetails;

/**
 * Method to PUT request for Damage Details.
 */
- (void)putRequestForDamageDetails;

/**
 * Method to DELETE request for Damage Details.
 */
- (void)deleteRequestForDamageDetails;

/**
 * Method to POST request for Damage Details Image.
 */
- (void)postRequestForDamageDetailsImage;

/**
 * Method to PUT request for Damage Details Image.
 */
- (void)putRequestForDamageDetailsImage;

/**
 * Method to DELETE request for Damage Details Image.
 */
- (void)deleteRequestForDamageDetailsImage;

@end
