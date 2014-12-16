//
//  ModelForCheckIn.h
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForCheckIn : NSObject

@property (nonatomic, retain) NSMutableArray *mStaticCustomerAndVehicleInfoArray_;
@property (nonatomic, retain) NSMutableArray *mCustomerAndVehicleInfoArray_;
@property (nonatomic, retain) NSMutableArray *mInspectionCautionedOrFailedItemsArray_;
@property (nonatomic, retain) NSMutableArray *mInspectionAllItemsArray_;

@property (nonatomic, retain) NSString *mTagNumber_;
@property (nonatomic, retain) NSString *mFormID_;
@property (nonatomic, retain) NSString *mVehicleDiagramSetID_;
@property (nonatomic, retain) NSString *mPartEmpID_;
@property (retain, nonatomic) NSString *mPromisedDate_;
@property (retain, nonatomic) NSString *mPromisedTime_;

-(void)filterInspectionItemsArray:(NSMutableArray*)aItemsArray;

- (void)setArrayForCustomerAndVehicleInfo;
- (void)setFormID :(NSString *)aFormID PartEmpID:(NSString *)aPartEmpID TagNumber:(NSString *)aTagNumber VehicleDiagramSetID:(NSString *)aVehicleDiagramSetID PromisedDate:(NSString *)aPromisedDate PromisedTime:(NSString *)aPromisedTime;
@end
