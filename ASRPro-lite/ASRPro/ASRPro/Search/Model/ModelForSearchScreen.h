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

@interface ModelForSearchScreen : NSObject

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
 * mTag_ is used to hold the vehicle Id which is used for check-in mainly
 */
@property (nonatomic,retain)NSString *mTag_;
/*
 * mMileage is used to hold the mileage which is used for check-in mainly
 */
@property (nonatomic,retain)NSString *mMileage;
/*
 * mSelectApptArray_ is used to hold filtered appointment list based on VIN and Customer
 */
@property (nonatomic,retain)NSMutableArray *mSelectApptArray_;

- (void)getInprocessListFromRepairOrders;
- (NSString*)getAdvisorForOpenRO:(int)advisorID;
- (NSString*)getTechnicianForOpenRO:(int)technicianID;
- (void)setTopNavigationBarHiddenForOpenROScreen :(UIView *)aView Hidden:(BOOL)aHidden Button:(UIButton *)aButton;
- (void)getSelectedModeName:(NSString *)aModename;
@end
