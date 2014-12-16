//
//  SearchSupportWebEngine.h
//  ASRPro
//
//  Created by Santosh Kvss on 2/11/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppDelegate;
@interface SearchSupportWebEngine : NSObject {
    
    AppDelegate *mAppDelegate_;
}
+ (id)sharedInstance;
- (void)threadRequestToGetRepairOrders;
- (void)threadRequestForSearchCustomerInfo:(NSString*)searchValue;
/**
 * Method used to get request for VIN Decoder
 * @param aVIN for user VIN
 */
- (void)threadRequestForVINDecoder:(NSString *)aVIN;
/**
 * Method used to add Vehicle details
 */
- (void)threadRequestToAddVehicleDetails:(NSString*)aCustomerID;
/**
 * Method used to add Customer details
 */
- (void)threadRequestToAddCustomerDetails:(NSString*)aVehicleID;
/**
 * Method used to add new vehicle
 */
- (void)threadRequestToAddNewVehicle;
@end
