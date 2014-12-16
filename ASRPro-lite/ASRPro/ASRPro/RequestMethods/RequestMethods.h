//
//  RequestMethods.h
//  ASRPro
//
//  Created by Value Labs on 17/09/12.
//  Copyright (c) 2012 ValueLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestMethods : NSObject{
    
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    
}
@property(nonatomic,retain) id mViewRefrence;
/**
 * Method used to initialize class
 */
- (id)init;

//request methods

/**
 * Method used to post request for registering new user
 * @param mUserName for  username
 * @param mPassword for password
 * @param mStoreID for user StoreID
 */
- (void)postRequestForLogin:(NSString*)mUserName 
                   Password:(NSString*)mPassword 
                      StoreID:(NSString*)mStoreID;
/**
 * Method used to get RepairOrder list
 */
- (void)getRepairOrders;
/**
 * Method used to search the cutomer information
 */
- (void)searchCustomerInformation:(NSString *)searchValue;
/**
 * Method used to update Customer details
 */
- (void)putRequestToUpdateCustomerDetails:(NSString *)aCustomerID
                                  StoreID:(NSString *)aStoreID
                           CustomerNumber:(NSString *)aCustomerNumber
                                FirstName:(NSString *)aFirstName
                                 LastName:(NSString *)aLastName
                               MiddleName:(NSString *)aMiddleName
                                    Email:(NSString *)aEmail
                                HomePhone:(NSString *)aHomePhone
                                WorkPhone:(NSString *)aWorkPhone
                              MobilePhone:(NSString *)aMobilePhone
                                 Address1:(NSString *)aAddress1
                                 Address2:(NSString *)aAddress2
                                  Country:(NSString *)aCountry
                                    State:(NSString *)aState
                                     City:(NSString *)aCity
                                  Zipcode:(NSString *)aZipcode
                             ContactEmail:(BOOL)aContactEmail
                             ContactPhone:(BOOL)aContactPhone
                               ContactSMS:(BOOL)aContactSMS;
/**
 * Method used to Add Customer details
 */
- (void)postRequestToAddCustomerDetails:(NSString *)aCustomerID
                                  StoreID:(NSString *)aStoreID
                           CustomerNumber:(NSString *)aCustomerNumber
                                FirstName:(NSString *)aFirstName
                                 LastName:(NSString *)aLastName
                               MiddleName:(NSString *)aMiddleName
                                    Email:(NSString *)aEmail
                                HomePhone:(NSString *)aHomePhone
                                WorkPhone:(NSString *)aWorkPhone
                              MobilePhone:(NSString *)aMobilePhone
                                 Address1:(NSString *)aAddress1
                                 Address2:(NSString *)aAddress2
                                  Country:(NSString *)aCountry
                                    State:(NSString *)aState
                                     City:(NSString *)aCity
                                  Zipcode:(NSString *)aZipcode
                             ContactEmail:(BOOL)aContactEmail
                             ContactPhone:(BOOL)aContactPhone
                               ContactSMS:(BOOL)aContactSMS;
/**
 * Method used to update Vehicle details
 */
- (void)putRequestToUpdateVehicleDetails:(NSString*)aVehicleID
                                 StoreID:(NSString*)aStoreID
                                  MakeID:(NSString*)aMakeID
                                    Make:(NSString*)aMake
                                   Model:(NSString*)aModel
                                    Year:(NSString*)aYear
                                     VIN:(NSString*)aVIN
                                 Mileage:(NSString*)aMileage
                                 License:(NSString*)aLicense;
/**
 * Method used to add Vehicle details
 */
- (void)postRequestToAddVehicleDetails:(NSString*)aVehicleID
                                 StoreID:(NSString*)aStoreID
                                  MakeID:(NSString*)aMakeID
                                    Make:(NSString*)aMake
                                   Model:(NSString*)aModel
                                    Year:(NSString*)aYear
                                     VIN:(NSString*)aVIN
                                 Mileage:(NSString*)aMileage
                                 License:(NSString*)aLicense;
/**
 * Method used to check-in vehicle
 * @param userID for userID
 * @param aCustomerID for user CustomerID
 * @param aVehicleID for user VehicleID
 * @param mileage for mileage
 * @param AdvisorID for user AdvisorID
 * @param aFirstName for user FirstName
 * @param aLastName for user LastName
 */
- (void)postRequestForCheckin:(NSString *)userID
                    VehicleID:(NSString *)VehicleID
                      Mileage:(NSString *)mileage
                    AdvisorID:(NSString *)AdvisorID
                          VIN:(NSString *)VIN
                   CustomerID:(NSString *)aCustomerID
                    FirstName:(NSString *)aFirstName
                     LastName:(NSString *)aLastName;
/**
 * Method used to get request for Vehicle History
 * @param aStoreID for user StoreID
 * @param aCustomerID for user CustomerID
 * @param aVehicleID for user VehicleID
 */
- (void)getRequestForVehicleHistory:(NSString *)aStoreID
                        CustomerID:(NSString*)aCustomerID
                        VehicleID:(NSString*)aVehicleID;
/**
 * Method used to post request for Add New Service
 * @param aRONumber for RONumber
 * @param aRequestData for Request Data
 */
-(void)postRequestToAddNewService:(NSString *)aRONumber
                      RequestData:(NSMutableDictionary*)aRequestData;
/**
 * Method used to post request for update service
 * @param aRONumber for RONumber
 * @param aLine_ID for LineID
 * @param aRequestData for Request Data
 */
-(void)putRequestToUpdateServiceToARepairOrder:(NSString *)aRONumber
                                        LineID:(NSString *)aLine_ID
                                   RequestData:(NSMutableDictionary*)aRequestData;


-(void)getListofServices:(NSString*)aRONumber;
/**
 * Method used to get request for Inspection Items
 * @param aRONumber for  RONumber
 */
- (void)getListForInspectionItems:(NSString *)aRONumber;
-(void)getListofOpenROServices:(NSString*)aRONumber;
-(void)putRequestCompleteInspection:(NSString *)repairOrderID;
@end
