//
//  ModelForSearchScreen.h
//  ASRPro
//
//  Created by Santosh Kvss on 2/10/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    DoneToOPenROMode = 1,
    
} DoneCheckInTOOpenROView;

@interface ModelForSearchScreen : NSObject {
    
    @public
    BOOL isSearchForBeginCheckIn;
}

@property (nonatomic,assign) DoneCheckInTOOpenROView mDoneCheckInTOOpenROView_;
/*
 * mAdvisorID_ is used to hold the advisor Id which is used for check-in mainly
 */
@property (nonatomic,retain)NSString *mAdvisorID_;
/*
 * mAppointmentID_ is used to hold the appointment Id which is used for check-in mainly
 */
@property (nonatomic,retain)NSString *mAppointmentID_;
/*
 * mCustomerID_ is used to hold the customer Id
 */
@property (nonatomic,retain)NSString *mCustomerID_;
/*
 * mVehicleID_ is used to hold the vehicle Id
 */
@property (nonatomic,retain)NSString *mVehicleID_;
/*
 * mAppointmentNumber_ is used to hold the appointment Number which is used for check-in mainly
 */
@property (nonatomic,retain)NSString *mAppointmentNumber_;
/*
 * mTempCustomerID_ is used to hold the customer ID which is used for check-in mainly
 */
@property (nonatomic,retain)NSString *mTempCustomerID_;
/*
 * mTag_ is used to hold the vehicle Id which is used for check-in mainly
 */
@property (nonatomic,retain)NSString *mTag_;
/*
 * mMileage is used to hold the mileage which is used for check-in mainly
 */
@property (nonatomic,retain)NSString *mMileage;
/*
 * mVehicleMileage is used to hold the vehicle mileage
 */
@property (nonatomic,retain)NSString *mVehicleMileage;
/*
 * mVIN is used to hold the VIN which is used for check-in mainly
 */
@property (nonatomic,retain)NSString *mBeginVehicleCheckInVIN;
/*
 * mSelectApptArray_ is used to hold filtered appointment list based on VIN and Customer
 */
@property (nonatomic,retain)NSMutableArray *mSelectApptArray_;
/*
 * mErrorResponseStr_ is used to hold error response from server.
 */
@property (nonatomic,retain)NSString *mErrorResponseStr_;

- (void)getInprocessListFromRepairOrders;
- (NSString*)getAdvisorForOpenRO:(int)advisorID;
- (NSString*)getTechnicianForOpenRO:(int)technicianID;
- (void)setTopNavigationBarHiddenForOpenROScreen :(UIView *)aView Hidden:(BOOL)aHidden Button:(UIButton *)aButton;
- (void)getSelectedModeName:(NSString *)aModename;
- (void)threadRequestForVINDecoderForAddVehicle:(NSString *)aVIN;
- (void)threadRequestForAdvancedCustomerSearchInfo:(NSString*)searchString;
@end
