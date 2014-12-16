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

- (void)clearData;
@end
