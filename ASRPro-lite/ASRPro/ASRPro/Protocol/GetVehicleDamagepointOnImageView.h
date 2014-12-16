//
//  GetVehicleDamagepointOnImageView.h
//  ASRPro
//
//  Created by GuruMurthy on 13/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GetVehicleDamagepointOnImageView <NSObject>
@optional
- (void)getVehicleDamagePointsOnTheImageViewIndex:(int)aVehicleDiagramViewAngleID VehicleDiagramSetID:(int)aVehicleDiagramSetID;
@end
