//
//  ModelForVehicleHistory.h
//  ASRPro
//
//  Created by GuruMurthy on 04/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForVehicleHistory : NSObject
/**
 * NSMutableDictionary for storing VehicleHistory.
 */
@property (nonatomic, retain) NSMutableArray *mVehicleHistoryArray_;

@property (nonatomic, retain) NSMutableArray *mCustomerRoInformationArray_;

@property (nonatomic, retain) NSMutableArray *mCustomerRoInformationLeftSideStaticNamesArray_;

@property (nonatomic, retain) NSMutableDictionary *mRODetailsArray_;

- (void)setRoAndCustomerInformation;

- (NSString *)methodToReturnTheUpdatedModeName :(int)mode;

@end
