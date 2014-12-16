//
//  ModelForCheckIn.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForCheckIn.h"

@implementation ModelForCheckIn
@synthesize mStaticCustomerAndVehicleInfoArray_;
@synthesize mCustomerAndVehicleInfoArray_;
@synthesize mInspectionAllItemsArray_;
@synthesize mInspectionCautionedOrFailedItemsArray_;

@synthesize mFormID_;
@synthesize mPartEmpID_;
@synthesize mTagNumber_;
@synthesize mVehicleDiagramSetID_;
@synthesize mPromisedDate_;
@synthesize mPromisedTime_;

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mInspectionAllItemsArray_=[NSMutableArray new];
        mInspectionCautionedOrFailedItemsArray_=[NSMutableArray new];

    }
    return self;
}

- (void)setFormID :(NSString *)aFormID PartEmpID:(NSString *)aPartEmpID TagNumber:(NSString *)aTagNumber VehicleDiagramSetID:(NSString *)aVehicleDiagramSetID PromisedDate:(NSString *)aPromisedDate PromisedTime:(NSString *)aPromisedTime {
    self.mVehicleDiagramSetID_ = aVehicleDiagramSetID;
    self.mFormID_ = aFormID;
    self.mPartEmpID_ = aPartEmpID;
    self.mTagNumber_ = aTagNumber;
    self.mPromisedDate_ = aPromisedDate;
    self.mPromisedTime_ = aPromisedTime;
}

- (void)setArrayForCustomerAndVehicleInfo {
    // ----------------------------;
    // Set static names for Customer&VehicleInfo;
    // ----------------------------;
    NSMutableArray *staticCustomerAndVehicleInfoArray = [[NSMutableArray alloc] initWithObjects:@"Name",@"Mobile",@"Email",@"Customer No",@"Year",@"Make",@"Model",@"Mileage",@"VIN",@"Promise Date",@"Promise Time",[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mUserRole_, nil];
    self.mStaticCustomerAndVehicleInfoArray_ = staticCustomerAndVehicleInfoArray;
    
    // ----------------------------;
    // Set data for Customer&VehicleInfo;
    // ----------------------------;
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    NSString *customerName = [NSString stringWithFormat:@"%@ %@",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"] valueForKey:@"FirstName"],[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"] valueForKey:@"LastName"]];
    [mutableDictionary setValue:customerName forKey:@"Name"];
    NSString *mobileNumber = ([[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"] valueForKey:@"CellPhone"] length] != 0)?[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"] valueForKey:@"CellPhone"]:([[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"] valueForKey:@"WorkPhone"] length] != 0)?[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"] valueForKey:@"WorkPhone"]:([[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"] valueForKey:@"HomePhone"] length] != 0)?[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"] valueForKey:@"HomePhone"]:@"";
    [mutableDictionary setValue:mobileNumber forKey:@"Mobile"];
    [mutableDictionary setValue:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"] valueForKey:@"Email"] forKey:@"Email"];
    [mutableDictionary setValue:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"]valueForKey:@"Number"] forKey:@"Customer No"];
    [mutableDictionary setValue:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"CustomerSignatureImageUrl"] forKey:@"CustomerSignatureImageUrl"];
    [mutableDictionary setValue:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Customer"]valueForKey:@"ID"] forKey:@"ID"];
    [mutableDictionary setValue:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Vehicle"] valueForKey:@"Year"] forKey:@"Year"];
    [mutableDictionary setValue:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Vehicle"] valueForKey:@"Make"] forKey:@"Make"];
    [mutableDictionary setValue:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Vehicle"] valueForKey:@"Model"] forKey:@"Model"];
    [mutableDictionary setValue:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Vehicle"] valueForKey:@"Mileage"] forKey:@"Mileage"];
    [mutableDictionary setValue:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_] valueForKey:@"Vehicle"] valueForKey:@"VIN"] forKey:@"VIN"];
    [mutableDictionary setValue:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"PromisedDate"] forKey:@"Promise Date"];
    [mutableDictionary setValue:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"PromisedTime"] forKey:@"Promise Time"];
    
    [mutableDictionary setValue:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeName_ forKey:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mUserRole_];
    self.mCustomerAndVehicleInfoArray_ = (NSMutableArray *)mutableDictionary;
    
    [self setFormID:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"FormID"] PartEmpID:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"PartsNumber"] TagNumber:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"TagNumber"] VehicleDiagramSetID:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"VehicleDiagramSetID"] PromisedDate:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"PromisedDate"] PromisedTime:[[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_] mRepairOrderDetailsArray_]  valueForKey:@"PromisedTime"]];
}


- (void)filterInspectionItemsArray:(NSMutableArray*)aItemsArray {
    NSMutableArray* lTempArray=[NSMutableArray new];
    for(int i = 0; i < [aItemsArray count]; i++){
        for(int j = 0; j < [mInspectionAllItemsArray_ count]; j++){
            if([[NSString stringWithFormat:@"%@",[[aItemsArray objectAtIndex:i] objectForKey:@"IIID"]] isEqualToString:[NSString stringWithFormat:@"%@",[[mInspectionAllItemsArray_ objectAtIndex:j] objectForKey:@"IIID"]]]){
                if(![[NSString stringWithFormat:@"%@",[[aItemsArray objectAtIndex:i] objectForKey:@"Color"]] isEqualToString:@"Green"]){
                NSMutableDictionary* lTempDict=[NSMutableDictionary new];
                [lTempDict setValue:[NSString stringWithFormat:@"%@",[[mInspectionAllItemsArray_ objectAtIndex:j] objectForKey:@"Name"]] forKey:@"ItemName"];
                [lTempDict setValue:[NSString stringWithFormat:@"%@",[[aItemsArray objectAtIndex                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       :i] objectForKey:@"Color"]] forKey:@"Color"];
                [lTempArray addObject:lTempDict];
            }
            }
        }
    }
    [self setMInspectionCautionedOrFailedItemsArray_:lTempArray];
}
@end
