//
//  ModelForVehicleHistoryTableView.h
//  ASRPro
//
//  Created by GuruMurthy on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VehicleHistorySectionInfo.h"
#import "VehicleHistorySectionView.h"
#import "VehicleHistoryCategory.h"

@interface ModelForVehicleHistoryTableView : NSObject<UIAlertViewDelegate>

/**
 * Main Vehicle History list array(Array which is stable) -> mVehicleHistoryArray_.
 */
@property (nonatomic, retain) NSMutableArray *mVehicleHistoryArray_;

/**
 * Temp Vehicle History list array(Array which is used to display in tableview) -> mVehicleHistorySectionInfoArray_.
 */
@property (nonatomic, strong) NSMutableArray *mVehicleHistorySectionInfoArray_;

/**
 * Category Array object -> mVehicleHistoryCategoryList_.(Temparary data)
 */
@property (nonatomic, strong) NSArray *mVehicleHistoryCategoryList_;

/**
 * Default Open Section index -> mVehicleHistoryOpenSectionIndex_.
 */
@property (nonatomic, assign) NSInteger mVehicleHistoryOpenSectionIndex_;

/**
 * BOOL to show "Vehicle History Screen or not" -> mToshowVehicleHistoryViewOrNot_.
 */
@property (nonatomic, assign) BOOL mToshowVehicleHistoryViewOrNot_;

/**
 * Current mode to display RO List -> mCurrentMode_.
 */
@property (nonatomic, assign) NSInteger mCurrentMode_;

/**
 * Selected Open RO List -> mOpenROString_.
 */
@property (nonatomic, retain) NSString *mOpenROString_;

#pragma mark --
#pragma mark Public Methods
/**
 * Method to present "Vehicle History" veiew controller;.
 */
- (void)presentVehicleHistoryViewController :(UIViewController *)aViewController;
/**
 * Method to dismiss "Vehicle History" veiew controller;.
 */
- (void)dismissVehicleHistoryViewController :(UIViewController *)aViewController;

/**
 * Method to set Vehicle History Array[mVehicleHistoryCategoryList_].
 */
- (void)setVehicleHistoryCategoryArray;

/**
 * Method to set Vehicle History Array[mVehicleHistorySectionInfoArray_].
 */
- (void)setVehicleHistorysectionInfoArray;

- (void)methodToShowAlertOrVehicleHistory:(NSUInteger)aSection;
@end
