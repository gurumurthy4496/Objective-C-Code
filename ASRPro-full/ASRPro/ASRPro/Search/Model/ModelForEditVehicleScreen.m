//
//  ModelForEditVehicleScreen.m
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForEditVehicleScreen.h"

@implementation ModelForEditVehicleScreen

- (void)setValues:(NSMutableDictionary*)aVehicleDictionary {
    DLog(@"%@",aVehicleDictionary);
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    /**----------------------------- Vehicle Details ----------------------------------*/
    self.mVehicleID_=[aVehicleDictionary objectForKey:@"ID"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"ID"]]:@"";
    self.mVIN_=[aVehicleDictionary objectForKey:@"VIN"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"VIN"]]:@"";
    self.mYear_=[aVehicleDictionary objectForKey:@"Year"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"Year"]]:@"";
    self.mEngineNo_=[aVehicleDictionary objectForKey:@"EngineNo"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"EngineNo"]]:@"";
    
    self.mMileage_=[aVehicleDictionary objectForKey:@"Mileage"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"Mileage"]]:@"";
    self.mMake_=[aVehicleDictionary objectForKey:@"Make"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"Make"]]:@"";
    self.mMakeID_=[aVehicleDictionary objectForKey:@"MakeID"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"MakeID"]]:@"";
    self.mModel_=[aVehicleDictionary objectForKey:@"Model"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"Model"]]:@"";
    self.mRegistrationNo_=[aVehicleDictionary objectForKey:@"License"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"License"]]:@"";
    self.mColor_=[aVehicleDictionary objectForKey:@"Color"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"Color"]]:@"";
    NSDate* lDate  =[mAppDelegate_.mMasterViewController_ mfDateFromDotNetJSONString:[aVehicleDictionary objectForKey:@"PurchaseDate"]!=nil ?[NSString stringWithFormat:@"%@",[aVehicleDictionary objectForKey:@"PurchaseDate"]]:@""];
    
    NSDateFormatter *lDateFormat_ = [[NSDateFormatter alloc] init];
    
    [lDateFormat_ setDateFormat:@"dd/MM/yyyy"];
    
    self.mPurchaseDate_=(([lDateFormat_ stringFromDate:lDate]==nil)||([[lDateFormat_ stringFromDate:lDate] isEqualToString:@"01/01/1900"]))?@"":[lDateFormat_ stringFromDate:lDate];
}

- (void)resetallData {
    
    self.mVIN_ = @"";
    self.mYear_ = @"";
    self.mMake_ = @"";
    self.mMakeID_ = @"";
    self.mModel_ = @"";
    self.mEngineNo_ = @"";
    self.mMileage_ = @"";
    self.mPurchaseDate_ = @"";
    self.mFuel_ = @"";
    self.mRegistrationNo_ = @"";
    self.mAppointmentStatus_ = @"";
    self.mVehicleID_ = @"";
    self.mColor_ = @"";
}
@end
