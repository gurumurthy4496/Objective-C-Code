//
//  VehicleHistorySupportWebEngine.h
//  ASRPro
//
//  Created by GuruMurthy on 25/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleHistorySupportWebEngine : NSObject
+ (id)sharedInstance;
- (void)getRequestForVehicleHistory;
- (void)putRequestForAssigningROToTechnicianOrAdvisor;
- (void)methodToChangeModeFormDispatchModeToInspectionView;
- (void)threadRequestToGetRepairOrders;
@end
