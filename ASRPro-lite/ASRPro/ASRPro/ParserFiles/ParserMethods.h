//
//  ParserMethods.h
//  Medifast
//
//  Created by Value Labs on 14/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASRProAppDelegate;

@interface ParserMethods : NSObject{
    
    /**
     * MedifastAppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
}

/**
 * Method used to initialize class
 */
- (id)init;

/**
 * Method used to parse response of login
 */
- (void)parseLogin;
/**
 * Method used to parse response of Repair Orders
 */
- (void)parseRepairOrders;
/**
 * Method used to parse response of Search Customer
 */
- (void)parseSearchCustomerData;
/**
 * Method used to parse response of Updated Customer Details
 */
- (void)parseCustomerDetails;
/**
 * Method used to parse response of Add Customer Details
 */
- (void)parseAddCustomerDetails;
/**
 * Method used to parse response of Updated Vehicle Details
 */
- (void)parseVehicleDetails;
/**
 * Method used to parse response of Add Vehicle Details
 */
- (void)parseAddVehicleDetails;
/**
 * Method to parse response of Appointments Vehicle History
 */
- (void)parseAppointmentsVehicleHistory;
/**
 * Method used to parse response of Vehicle Check-In
 */
- (void)parseVehicleCheckIn;

/**
 * Method used to parse Service Lines.
 */
- (void)parseGetServiceLines;


-(void)parseInspectionItems;
-(void)parseAddService;
- (void)parseCompleteInspectionDetails;
- (void)parseOpenROGetServiceLines;

@end
