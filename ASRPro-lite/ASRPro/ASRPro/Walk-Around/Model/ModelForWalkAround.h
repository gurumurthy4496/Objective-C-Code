//
//  ModelForWalkAround.h
//  ASRPro
//
//  Created by GuruMurthy on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

/** @constant ECResetStrategy top view behavior while anchored. */
/*typedef enum {

    VehicleDiagramViewAngleIDTop = 1,

    VehicleDiagramViewAngleIDLeft,

    VehicleDiagramViewAngleIDRight,
    
    VehicleDiagramViewAngleIDFront,
    
    VehicleDiagramViewAngleIDRear
    
} VehicleDiagramViewAngle;*/


typedef enum {
 
 ShowVehicleHistoryPopUpFromAppointments = 1,
  
} ShowVehicleHistoryPopUp;

@interface ModelForWalkAround : NSObject{
    @public
    BOOL isROChanged;
}

@property (nonatomic, assign) ShowVehicleHistoryPopUp mShowVehicleHistoryPopUp_;

/**
 * Vehicle ID.
 */
@property (nonatomic, assign) NSUInteger mButtonID_;

/**
 * Selected Vehicle name.
 */
@property (nonatomic, assign) NSString *mVehicleName_;

/**
 * Selected mPRE_RONumber.
 */
@property (nonatomic, assign) NSString *mPRE_RONumber;

/**
 * Selected mTempPRE_RONumber.
 */
@property (nonatomic, assign) NSString *mTempPRE_RONumber;

/**
 * Vehicle diagram sets array.
 */
@property (nonatomic, retain) NSMutableArray *mVehicleDiagramSetsArray_;
@property (nonatomic, retain) NSMutableArray *mCategoryListArray_;
/**
 * Selected Vehicle diagram array.
 */
@property (nonatomic, retain) NSMutableDictionary *mSelectedVehicleDiagramDictionary_;

/**
 * Selected RepairOrder Details Array.
 */
@property (nonatomic, retain) NSMutableArray *mRepairOrderDetailsArray_;

/**
 * Selected Damage details array.
 */
@property (nonatomic, retain) NSMutableArray *mDamageDetailsArray_;

@property (nonatomic, assign) int mTempmVehicleDiagramForDamagesSetID_;
@property (nonatomic, assign) int mTempmVehicleAngleForDamagesSetID_;


/**
 * Store text for mNotesString.
 */
@property (nonatomic, retain) NSString *mNotesString_;
@property (nonatomic, assign) NSString *mDamageTypeString_;
@property (nonatomic, assign) NSString *mSeverityString_;
@property (nonatomic, assign) int mDamageTypeIndex_;
@property (nonatomic, assign) int mSeverityTypeIndex_;
@property (nonatomic, assign) int mVehicleDiagramSetID_;
@property (nonatomic, assign) int mVehicleDiagramForDamagesSetID_;
@property (nonatomic, assign) int mVehicleDiagramViewAngleID_;
@property (nonatomic, assign) float mXCoord_;
@property (nonatomic, assign) float mYCoord_;

@property (nonatomic, retain) NSData *mImageData_;

/**
 * enum for Vehicle diagram.
 */
//@property (nonatomic, assign) VehicleDiagramViewAngle mVehicleDiagramViewAngle_;

/**
 * Set Selected Vehicle Array For Category.
 */
- (void)setWalkAroundData :(NSMutableArray *)aRODetailsArray;
- (void)setDataForSelectedVehicleTypes;
- (void)setTempararyPRERONumber :(NSString *)aTempPRERONumber;
- (void)setPRERONumber :(NSString *)aPRERONumber;
- (void)setXCoordAndYCoord :(CGPoint)aCGPoint;

#pragma mark --
#pragma mark Class Public Methods

-(void)tableViewSelectedAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)getTextFromVehicleDiagramViewAngleID :(NSMutableDictionary *)aMutableDictionary;
@end
