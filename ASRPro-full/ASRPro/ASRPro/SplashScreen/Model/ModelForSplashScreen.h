//
//  ModelForSplashScreen.h
//  ASRPro
//
//  Created by GuruMurthy on 23/09/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForSplashScreen : NSObject

@property (nonatomic, retain) NSString *mUserName_;
@property (nonatomic, retain) NSString *mPassword_;
@property (nonatomic, retain) NSString *mStoreID_;

@property (nonatomic, retain) NSString *mStoreIDWithContext_;

@property (nonatomic, retain) NSString *mEmployeeID_;
@property (nonatomic, retain) NSString *mEmployeeName_;
@property (nonatomic, retain) NSString *mEmployeeType_;

/**
 * NSString to store User role[Manager,Technician,Advisor...] ->mUserRole_.
 */
@property (nonatomic,retain) NSString *mUserRole_;

/**
 * NSMutableDictionary for storing LoinData.
 */
@property (nonatomic, retain) NSMutableDictionary *mLoginDataArray_;
/**
 * NSMutableDictionary for storing Employees Data.
 */
@property (nonatomic, retain) NSMutableArray *mEmployeesDataArray_;

@property (nonatomic, retain) NSDate *mPreviousDate_;

/**
 * Method to store EmployeeID,StoreID,EmployeeType;
 */
- (void)StoreUserDetailsEmployeeID:(NSString*)aEmpID
                           StoreID:(NSString*)aStoreID
                      EmployeeType:(NSString *)aEmpType;
/**
 * To find role[Manager,Technician,Advisor...] of the login user;
 */
- (void)toFindRoleOfLoginUser;
/**
 * Method to return App settings;
 * @param aIPADVwesion; 0 = Disabled, 1 = Full Version, 2 = Lite Version
 */
- (NSString *)returnAppSettingsISFullOrLiteVersion :(int)aIPADVwesion;
- (void)clearData;
- (void)changingProductionAPIForSpecificStore;

- (void)setPreviousDate;
- (void)checkWhetherDateIsChanged;
- (NSDate*) dateFormat : (NSString*)date currentFormat:(NSString*) currentFormat newFormat : (NSString*) newFormat;
@end
