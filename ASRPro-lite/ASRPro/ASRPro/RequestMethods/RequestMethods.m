//
//  RequestMethods.m
//  ASRPro
//
//  Created by Value Labs on 17/09/12.
//  Copyright (c) 2012 ValueLabs. All rights reserved.
//

#import "RequestMethods.h"

@implementation RequestMethods

@synthesize mViewRefrence;

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    }
    
    return self;
    
}

- (void)postRequestForLogin:(NSString*)mUserName 
                   Password:(NSString*)mPassword 
                    StoreID:(NSString*)mStoreID{
    
    mAppDelegate_.mWebEngine_.mWebMethodName_ = kLOGIN;
    mAppDelegate_.mWebEngine_.mWebMethodType_ = kPOST;
    
    NSString *mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/Employees/Authentication",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *data = [NSString stringWithFormat:@"{\"UserName\":\"%@\",\"Password\":\"%@\",\"Context\":\"%@\"}",mUserName,mPassword,mStoreID];
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];
}

- (void)getRepairOrders {
    mAppDelegate_.mWebEngine_.mWebMethodName_=kREPAIRORDER;
    mAppDelegate_.mWebEngine_.mWebMethodType_=kGET;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@%@%@/%@",WEBSERVICEURL,@"Stores/",mAppDelegate_.mModelForSplashScreen_.mStoreID_,mAppDelegate_.mWebEngine_.mWebMethodName_];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:nil];
}

- (void)searchCustomerInformation:(NSString *)searchValue {
    
    mAppDelegate_.mWebEngine_.mWebMethodName_=kSearch_Customer;
    mAppDelegate_.mWebEngine_.mWebMethodType_=kGET;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@%@%@/Search?Query=%@",WEBSERVICEURL,@"Stores/",mAppDelegate_.mModelForSplashScreen_.mStoreID_,searchValue];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:nil];
}

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
                                  ContactSMS:(BOOL)aContactSMS{

    mAppDelegate_.mWebEngine_.mWebMethodName_=kEDIT_CUSTOMER_DETAILS;
    mAppDelegate_.mWebEngine_.mWebMethodType_=kPUT;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Customers/%@/",WEBSERVICEURL,aStoreID,aCustomerID];

    NSString *data =[NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"StoreID\":\"%d\",\"Number\":\"%@\",\"FirstName\":\"%@\",\"LastName\":\"%@\",\"Email\":\"%@\",\"HomePhone\":\"%@\",\"WorkPhone\":\"%@\",\"CellPhone\":\"%@\",\"Address1\":\"%@\",\"Address2\":\"%@\",\"Country\":\"%@\",\"State\":\"%@\",\"City\":\"%@\",\"Zip\":\"%@\",\"CanContactEmail\":\"%@\",\"CanContactPhone\":\"%@\",\"CanContactSMS\":\"%@\"}}",[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue],[aStoreID intValue],aCustomerNumber,aFirstName,aLastName,aEmail,aHomePhone,aWorkPhone,aMobilePhone,aAddress1,aAddress2,aCountry,aState,aCity,aZipcode,[self convertBooltoString:aContactEmail],[self convertBooltoString:aContactPhone],[self convertBooltoString:aContactSMS]];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];
}

- (void)postRequestToAddCustomerDetails:(NSString *)aCustomerID StoreID:(NSString *)aStoreID CustomerNumber:(NSString *)aCustomerNumber FirstName:(NSString *)aFirstName LastName:(NSString *)aLastName MiddleName:(NSString *)aMiddleName Email:(NSString *)aEmail HomePhone:(NSString *)aHomePhone WorkPhone:(NSString *)aWorkPhone MobilePhone:(NSString *)aMobilePhone Address1:(NSString *)aAddress1 Address2:(NSString *)aAddress2 Country:(NSString *)aCountry State:(NSString *)aState City:(NSString *)aCity Zipcode:(NSString *)aZipcode ContactEmail:(BOOL)aContactEmail ContactPhone:(BOOL)aContactPhone ContactSMS:(BOOL)aContactSMS {
    
    mAppDelegate_.mWebEngine_.mWebMethodName_=kEDIT_CUSTOMER_DETAILS;
    mAppDelegate_.mWebEngine_.mWebMethodType_=kPOST;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Customers/",WEBSERVICEURL,aStoreID];
    
    NSString *data =[NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"StoreID\":\"%d\",\"Number\":\"%@\",\"FirstName\":\"%@\",\"LastName\":\"%@\",\"Email\":\"%@\",\"HomePhone\":\"%@\",\"WorkPhone\":\"%@\",\"CellPhone\":\"%@\",\"Address1\":\"%@\",\"Address2\":\"%@\",\"Country\":\"%@\",\"State\":\"%@\",\"City\":\"%@\",\"Zip\":\"%@\",\"CanContactEmail\":\"%@\",\"CanContactPhone\":\"%@\",\"CanContactSMS\":\"%@\"}}",[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue],[aStoreID intValue],aCustomerNumber,aFirstName,aLastName,aEmail,aHomePhone,aWorkPhone,aMobilePhone,aAddress1,aAddress2,aCountry,aState,aCity,aZipcode,[self convertBooltoString:aContactEmail],[self convertBooltoString:aContactPhone],[self convertBooltoString:aContactSMS]];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];
}

- (NSString *)convertBooltoString:(BOOL)aValue{
    return aValue?@"TRUE":@"FALSE";
}

- (void)putRequestToUpdateVehicleDetails:(NSString *)aVehicleID
                                 StoreID:(NSString *)aStoreID
                                  MakeID:(NSString *)aMakeID
                                    Make:(NSString *)aMake
                                   Model:(NSString *)aModel
                                    Year:(NSString *)aYear
                                     VIN:(NSString *)aVIN
                                 Mileage:(NSString *)aMileage
                                 License:(NSString *)aLicense {
    
    mAppDelegate_.mWebEngine_.mWebMethodName_=kEDIT_VEHICLE_DETAILS;
    mAppDelegate_.mWebEngine_.mWebMethodType_=kPUT;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Vehicles/%@/",WEBSERVICEURL,aStoreID,aVehicleID];
    
    NSString *data =[NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"StoreID\":\"%d\",\"MakeID\":\"%d\",\"Make\":\"%@\",\"Model\":\"%@\",\"Year\":\"%@\",\"VIN\":\"%@\",\"Mileage\":\"%d\",\"License\":\"%@\"}}",[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue],[aStoreID intValue],[aMake intValue],aMake,aModel,aYear,aVIN,[aMileage intValue],aLicense];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];
}

- (void)postRequestToAddVehicleDetails:(NSString *)aVehicleID
                                 StoreID:(NSString *)aStoreID
                                  MakeID:(NSString *)aMakeID
                                    Make:(NSString *)aMake
                                   Model:(NSString *)aModel
                                    Year:(NSString *)aYear
                                     VIN:(NSString *)aVIN
                                 Mileage:(NSString *)aMileage
                                 License:(NSString *)aLicense {
    
    mAppDelegate_.mWebEngine_.mWebMethodName_=kEDIT_VEHICLE_DETAILS;
    mAppDelegate_.mWebEngine_.mWebMethodType_=kPOST;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Vehicles/",WEBSERVICEURL,aStoreID];
    
    NSString *data =[NSString stringWithFormat:@"{\"UserID\":\"%d\",\"Data\":{\"StoreID\":\"%d\",\"MakeID\":\"%d\",\"Make\":\"%@\",\"Model\":\"%@\",\"Year\":\"%@\",\"VIN\":\"%@\",\"Mileage\":\"%d\",\"License\":\"%@\"}}",[mAppDelegate_.mModelForSplashScreen_.mEmployeeID_ intValue],[aStoreID intValue],[aMake intValue],aMake,aModel,aYear,aVIN,[aMileage intValue],aLicense];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];
}

- (void)postRequestForCheckin:(NSString *)userID
                    VehicleID:(NSString *)VehicleID
                      Mileage:(NSString *)mileage
                    AdvisorID:(NSString *)AdvisorID
                          VIN:(NSString *)VIN
                   CustomerID:(NSString *)aCustomerID
                    FirstName:(NSString *)aFirstName
                     LastName:(NSString *)aLastName {
    
    mAppDelegate_.mWebEngine_.mWebMethodName_=kVehicle_Check_In;
    mAppDelegate_.mWebEngine_.mWebMethodType_=kPOST;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/%@/",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,mAppDelegate_.mWebEngine_.mWebMethodName_];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"Number\":\"%d\",\"Data\":{\"AdvisorID\":\"%@\",\"Vehicle\":{\"ID\":\"%@\",\"VIN\":\"%@\",\"Mileage\":\"%@\"},\"Customer\":{\"ID\":\"%@\",\"FirstName\":\"%@\",\"LastName\":\"%@\"}}",userID,[mAppDelegate_.mModelForSearchScreen_.mAppointmentNumber_ intValue],AdvisorID,VehicleID,VIN,mileage,aCustomerID,aFirstName,aLastName];
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];

}

- (void)getRequestForVehicleHistory:(NSString *)aStoreID CustomerID:(NSString *)aCustomerID VehicleID:(NSString *)aVehicleID {
    
    mAppDelegate_.mWebEngine_.mWebMethodName_ = kVEHICLE_HISTORY_API;
    mAppDelegate_.mWebEngine_.mWebMethodType_ = kGET;
    NSString *mRequestStr = [NSString stringWithFormat:@"%@Stores/%d/Vehicles/%@/Customers/%@/History",WEBSERVICEURL,[aStoreID intValue],aVehicleID,aCustomerID];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *data = nil;
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];
}

-(void)postRequestToAddNewService:(NSString *)aRONumber
                        RequestData:(NSMutableDictionary*)aRequestData{
    mAppDelegate_.mWebEngine_.mWebMethodName_= kADDSERVICES;
    mAppDelegate_.mWebEngine_.mWebMethodType_= kPOST;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *data = [[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:aRequestData];
    [ mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];
}

-(void)putRequestToUpdateServiceToARepairOrder:(NSString *)aRONumber
                                        LineID:(NSString *)aLine_ID
                                   RequestData:(NSMutableDictionary*)aRequestData{
    mAppDelegate_.mWebEngine_.mWebMethodName_= kUPDATESERVICE;
    mAppDelegate_.mWebEngine_.mWebMethodType_= kPUT;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber,aLine_ID];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *data = [[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:aRequestData];
    [ mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];
}

-(void)getListofServices:(NSString*)aRONumber{
    mAppDelegate_.mWebEngine_.mWebMethodName_= kGETSERVICES;
    mAppDelegate_.mWebEngine_.mWebMethodType_= kGET;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:nil];
    DLog(@"SERVICELINES REQUEST :-%@",mRequestStr);
}

- (void)getListForInspectionItems:(NSString *)aRONumber {
    mAppDelegate_.mWebEngine_.mWebMethodName_=kINSPECTIONITEMS;
    mAppDelegate_.mWebEngine_.mWebMethodType_=kGET;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionItems/",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:nil];
}

-(void)putRequestCompleteInspection:(NSString *)repairOrderID{
    mAppDelegate_.mWebEngine_.mWebMethodName_=kCOMPLETE_INSPECTION;
    mAppDelegate_.mWebEngine_.mWebMethodType_=kPUT;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/InspectionForms/%@",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,repairOrderID,mAppDelegate_.mWebEngine_.mWebMethodName_];
    DLog(@"Request :%@",mRequestStr);
    NSString *data =[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:nil];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:data];
}

-(void)getListofOpenROServices:(NSString*)aRONumber{
    mAppDelegate_.mWebEngine_.mWebMethodName_= kOPENROGETSERVICES;
    mAppDelegate_.mWebEngine_.mWebMethodType_= kGET;
    NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/RepairOrders/%@/Lines",WEBSERVICEURL,mAppDelegate_.mModelForSplashScreen_.mStoreID_,aRONumber];
    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [mAppDelegate_.mWebEngine_ makeRequestWithUrl:mRequestStr requestData:nil];
    DLog(@"SERVICELINES REQUEST :-%@",mRequestStr);
}

@end
