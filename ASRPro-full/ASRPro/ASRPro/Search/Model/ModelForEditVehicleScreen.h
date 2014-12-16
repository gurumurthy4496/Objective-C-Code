//
//  ModelForEditVehicleScreen.h
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForEditVehicleScreen : NSObject {
    
    AppDelegate *mAppDelegate_;
}

@property (strong, nonatomic) NSString *mVIN_;
@property (strong, nonatomic) NSString *mYear_;
@property (strong, nonatomic) NSString *mMakeID_;
@property (strong, nonatomic) NSString *mMake_;
@property (strong, nonatomic) NSString *mModel_;
@property (strong, nonatomic) NSString *mEngineNo_;
@property (strong, nonatomic) NSString *mMileage_;
@property (strong, nonatomic) NSString *mPurchaseDate_;
@property (strong, nonatomic) NSString *mFuel_;
@property (strong, nonatomic) NSString *mRegistrationNo_;
@property (strong, nonatomic) NSString *mAppointmentStatus_;
@property (strong, nonatomic) NSString *mColor_;
/*
 * mVehicleID_ is used to hold the vehicle Id
 */
@property (nonatomic,retain)NSString *mVehicleID_;

-(void)resetallData;
- (void)setValues:(NSMutableDictionary*)aVehicleDictionary;
@end
