//
//  SearchDataGetter.h
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchDataGetter : NSObject {
    /**
     * Appdelegate parameter
     */
    AppDelegate *mAppDelegate_;
}

/*
 * mAppointmentListData_ is used to hold all the appoitmentlist Data (API)
 */
@property (retain, nonatomic) NSMutableArray *mAppointmentListData_;

/*
 * mRepairOrdersData_ is used to hold all the Repair Orders Data (API)
 */
@property (retain, nonatomic) NSMutableArray *mRepairOrdersData_;
/*
 * mInprocessListData_ is used to hold all the Inprocess List Data
 */
@property (retain, nonatomic) NSMutableArray *mInprocessListData_;
/*
 * mOpenROListData_ is used to hold all the Open RO List Data
 */
@property (retain, nonatomic) NSMutableArray *mOpenROListData_;
/*
 * mOpenROListData_ is used to hold all the Open RO List Data
 */
@property (retain, nonatomic) NSMutableArray *mOpenROListDisplayData_;
/*
 * mSearchedCustomerListData_ is used to hold all the Searched Customer List Data
 */
@property (retain, nonatomic) NSMutableDictionary *mSearchedCustomerListData_;
/*
 * mCustomerDetailsData_ is used to store customer details
 */
@property (retain, nonatomic) NSMutableArray *mCustomerDetailsData_;
/*
 * mCustomerDetailsByNumberData_ is used to store customer details by customer number
 */
@property (retain, nonatomic) NSMutableArray *mCustomerDetailsByNumberData_;
/*
 * mVehicleDetailsData_ is used to store vehicle details
 */
@property (retain, nonatomic) NSMutableArray *mVehicleDetailsData_;
/*
 * mSearchCustomerVehiclesData_ is used to store Walk-in Customer vehicles data
 */
@property (retain, nonatomic) NSMutableArray *mSearchCustomerVehiclesData_;
/*
 * mAddVehicleResponseData_ is used to add vehicles to Walk-in Customer response data
 */
@property (retain, nonatomic) NSMutableArray *mAddVehicleResponseData_;
/*
* mVehicleCheckInData_ is used to hold all the Vehicle Check In Data (API)
*/
@property (retain, nonatomic) NSMutableArray *mVehicleCheckInData_;
/*
 * mVINDecoderResponseData_ is used to hold the VINDecoder Response data (API)
 */
@property (retain, nonatomic) NSMutableArray *mVINDecoderResponseData_;
/*
 * mVehicleHistoryData_ is used to hold the Vehicle History Data (API)
 */
@property (retain, nonatomic) NSMutableArray *mVehicleHistoryData_;

@end
