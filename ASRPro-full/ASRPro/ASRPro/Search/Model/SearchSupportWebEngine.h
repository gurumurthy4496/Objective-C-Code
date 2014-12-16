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

@property (nonatomic, retain) NSMutableArray *mCustomersArray;
@property (nonatomic, retain) NSString *errorResponseFromServer;

+ (id)sharedInstance;
- (void)getRequestForRODetailsOnSavingCustomerAndVehicle;
- (void)threadRequestToGetAppointments;
- (void)threadRequestToGetRepairOrders;
- (void)threadRequestForSearchCustomerInfo:(NSString*)searchValue;
- (void)threadRequestToUpdatingRepairOrders;
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
/**
 * Method used to get Appointments List For Pull To Refresh
 */
- (void)threadRequestToGetAppointmentsForPullToRefresh;

/**
 * Method used to get InProcess List Pull To Refresh
 */
- (void)threadRequestToGetRepairOrdersForPullToRefresh;
@end
