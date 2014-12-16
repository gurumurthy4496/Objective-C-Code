//
//  GlobalConstants.m
//  ASRPro
//
//  Created by GuruMurthy on 24/09/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "GlobalConstants.h"

@implementation GlobalConstants

/*#ifdef DEBUG
 NSString *const kAPIEndpointHost = @"http://example.dev";
 #else
 NSString *const kAPIEndpointHost = @"http://www.example.com";
 #endif*/

// ----------------------------;
// API Constants;
// ----------------------------;
//#define WEBSERVICEURL @"https://LaneApp:cjd# 9f0rm5) dd90DM@staging-api.asrpro.com/api/"

// NSString * WEBSERVICEURL = @"https://LaneApp:cjd# 9f0rm5) dd90DM@staging-api.asrpro.com/api/";//Staging
//NSString * WEBSERVICEURL = @"https://LaneApp:cjd# 9f0rm5) dd90DM@test10-api.asrpro.com/api/";
//NSString * WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@test10-api.asrpro.com/api/";
NSString * WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@api.asrpro.com/api/";

// ----------------------------;
// GET,POST,PUT,DELETE Global Constants;
// ----------------------------;

NSString *const kPUT = @"PUT";
NSString *const kPOST = @"POST";
NSString *const kGET = @"GET";
NSString *const kDELETE = @"DELETE";

// ----------------------------;
// Regular,Italic,Bold,BoldItalic Fonts Global Constants
// ----------------------------;

NSString *const kFontRegularKey = @"Regular";
NSString *const kFontItalicKey = @"Italic";
NSString *const kFontSemiBoldKey = @"Semibold";
NSString *const kFontBoldKey = @"Bold";
NSString *const kFontBoldItalicKey = @"BoldItalic";
// Key For HelveticaNeue
NSString *const kFontNameHelveticaNeueKey = @"HelveticaNeue";
// Key For OpenSansFont
NSString *const kFontNameOpenSansKey = @"OpenSans";


// ----------------------------;
// iPhone 5 Potrait Pixel Global Constants;
// ----------------------------;

NSString *const kiPhone5PotraitExcessPixel = @"([[UIScreen mainScreen]bounds].size.height==568?88:0)";

// ----------------------------;
// Documents Folder Path Global Constants;
// ----------------------------;
NSString *const kDocuments_Folder_Path = @"[NSHomeDirectory() stringByAppendingPathComponent:@\"Documents\"]";

// ----------------------------;
// KeyboardHeight Global Constants;
// ----------------------------;

float const kKeyboardHeight = 360;
float const kKeyboardHeightForiOS8 = 360 + 44;
// ----------------------------;
// Log-IN Global Constants;
// ----------------------------;

NSString *const kLOGIN = @"Authentication";
NSString *const kUserDefaults_TokenAndUserID_Key = @"UserDefaults_Storing_Token_UserID";
NSString *const kStore_Username_Role_In_Files = @"Store_Username_Role_In_Files";
NSString *const kStore_Username_StoreID_In_Files = @"Store_Username_StoreID_In_Files";
NSString *const kEmployeesData = @"EmployeesData";

// ----------------------------;
// Search Global Constants;
// ----------------------------;

NSString *const kAppointments = @"Appointments";
NSString *const kVehicle_Check_In = @"CheckInProcess";
NSString *const kEDIT_CUSTOMER_DETAILS = @"Customers";
NSString *const kEDIT_VEHICLE_DETAILS = @"Vehicles";
NSString *const kGet_Customer_ID = @"Customers/Number";
NSString *const kGet_Vehicle_ID = @"Vehicles/VIN";
NSString *const kSearch_Customer = @"SearchCustomer";

// ----------------------------;
// Repair Order Modes Global Constants;
// ----------------------------;

NSString *const kREPAIRORDER = @"RepairOrders";
float const kTableViewSectionHeight = 44.0f;

// ----------------------------;
// Customer and RO Information Global Constants;
// ----------------------------;

NSString *const kROInformation = @"RO Information";
NSString *const kCustomerInformation = @"Customer Information";
NSString *const kVehicleHistory = @"Vehicle History";

// ----------------------------;
// Notifications Global Constants;
// ----------------------------;

NSString *const kTechnicianNotificationArray_key = @"Technician Notification Array";
NSString *const kAdvisorNotificationArray_key = @"Advisor Notification Array";
NSString *const kAllNotificationsArray_Key = @"All Notifications Array";
// ----------------------------;
// Inspection Form Global Constants;
// ----------------------------;

NSString *const kINSPECTIONITEMS = @"InspectionItems";
NSString *const kCOMPLETE_INSPECTION = @"Completion";

// ----------------------------;
// Services Global Constants;
// ----------------------------;

NSString *const kADDSERVICES = @"AddServices";
NSString *const kUPDATESERVICE= @"UpdateService";

// ----------------------------;
// File and Folder Paths Global Constants;
// ----------------------------;
NSString *const kALLSERVICESPATH = @"ServicesData";
NSString *const kALLSERVICESPACKAGE = @"ServicesPackage";
NSString *const kGETSERVICES= @"GetServices";
NSString *const kOPENROGETSERVICES= @"OpenROGetServices";
NSString *const kALLSERVICESDATE = @"ServicesDataDate";
NSString *const kPARTSLOCATIONSPATH= @"LocationData";
NSString *const kPAYTYPESPATH= @"PaytypesData";
NSString *const kINSPECTIONFORMSLISTPATH = @"InspectionFormsList";
NSString *const kINSPECTIONFORMSFOLDERPATH = @"InspectionForms";
NSString *const kINPECTIONFORMNAMEPATH= @"InspectionForm";

NSString *const kIMAGEPATH=@"ImagesFolder";
NSString *const kCUSTOMERPLAN =@"CustomerPlan";
NSString *const kCUSTOMERPLANPDF= @"CustomerPlan.pdf";

// ----------------------------;
// Vehicle History Global Constants;
// ----------------------------;

NSString *const kVEHICLE_HISTORY_API = @"History";
NSString *const kVIN_DECODER_API = @"VinDecoder";

// ----------------------------;
// Walk-Around Global Constants;
// ----------------------------;
NSString *const kStore_VehicleDiagrams_sets_Array = @"Store_VehicleDiagrams_Sets_In_Files";
float const kVehicle_Image_X_Cord = 198.0f;
float const kVehicle_Image_Y_Cord = 90.0f;
float const kVehicle_Image_Width = 808.0f;
float const kVehicle_Image_Height = 360.0f;
float const kScreenWidth = 1024;
float const kScreenHeight = 768;
// ----------------------------;
// CheckIN Global Constants;
// ----------------------------;
NSString *const kSIGNATURE_DATA_PATH = @"/SignaturePointsDictionary";
@end
