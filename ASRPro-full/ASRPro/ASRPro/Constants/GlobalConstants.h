//
//  GlobalConstants.h
//  ASRPro
//
//  Created by GuruMurthy on 24/09/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalConstants : NSObject

typedef enum {
    ASRProOKStatusCode = 200,
    ASRProCreatedStatusCode = 201,
    ASRProNoContentStatusCode = 204,
    ASRProListingStatusCode = 207,
    ASRProUnauthorized = 401,
    ASRProPaymentRequired = 402,
    ASRProForbiddenStatusCode = 403,
    ASRProNotFoundStatusCode = 404,
    ASRProMethodNotAllowedStatusCode = 405,
    ASRProConflictStatusCode = 409,
    HTTPNotImplementedErrorCode = 501,
    ASRProHTTPInternalErrorCode = 500,
}ResponseCodeNumber;


/**
 * API
 */
//#define WEBSERVICEURL @"https://LaneApp:cjd# 9f0rm5) dd90DM@staging-api.asrpro.com/api/"
extern NSString * WEBSERVICEURL;


/**
 * GET,POST,PUT,DELETE Global Constants
 */

extern NSString *const kPUT;
extern NSString *const kPOST;
extern NSString *const kGET;
extern NSString *const kDELETE;

/**
 * Regular,Italic,Bold,BoldItalic Fonts Global Constants
 */

extern NSString *const kFontRegularKey;
extern NSString *const kFontItalicKey;
extern NSString *const kFontBoldKey;
extern NSString *const kFontSemiBoldKey;
extern NSString *const kFontBoldItalicKey;

extern NSString *const kFontNameHelveticaNeueKey;
extern NSString *const kFontNameOpenSansKey;

/**
 * iPhone5 pixel Global Constants
 */

extern NSString *const kiPhone5PotraitExcessPixel;
extern float const kScreenWidth;
extern float const kScreenHeight;
/**
 * Documents Folder Path Global Constants
 */

extern NSString *const kDocuments_Folder_Path;

/**
 * KeyboardHeight Global Constants
 */

extern float const kKeyboardHeight;
extern float const kKeyboardHeightForiOS8;
/**
 * Log-IN Global Constants
 */

extern NSString *const kLOGIN;
extern NSString *const kUserDefaults_TokenAndUserID_Key;
extern NSString *const kStore_Username_Role_In_Files;
extern NSString *const kStore_Username_StoreID_In_Files;
extern NSString *const kEmployeesData;

/**
 * Search Global Constants
 */

extern NSString *const kAppointments;
extern NSString *const kVehicle_Check_In;
extern NSString *const kEDIT_CUSTOMER_DETAILS;
extern NSString *const kEDIT_VEHICLE_DETAILS;
extern NSString *const kGet_Customer_ID;
extern NSString *const kGet_Vehicle_ID;
extern NSString *const kSearch_Customer;
/**
 * Repair Order Modes Global Constants
 */

extern NSString *const kREPAIRORDER;
extern float const kTableViewSectionHeight;

/**
 * Customer and RO Information Global Constants
 */

extern NSString *const kROInformation;
extern NSString *const kCustomerInformation;
extern NSString *const kVehicleHistory;

/**
 * Notifications Global Constants
 */
extern NSString *const kTechnicianNotificationArray_key;
extern NSString *const kAdvisorNotificationArray_key;
extern NSString *const kAllNotificationsArray_Key;
/**
 * Inspection Form Global Constants
 */

extern NSString *const kINSPECTIONITEMS;
extern NSString *const kCOMPLETE_INSPECTION;

/**
 * Services Global Constants
 */

extern NSString *const kADDSERVICES;
extern NSString *const kGETSERVICES;
extern NSString *const kOPENROGETSERVICES;
extern NSString *const kUPDATESERVICE;

/**
 *File and Folder Paths Global Constants
 */
extern NSString *const kALLSERVICESPATH;
extern NSString *const kALLSERVICESPACKAGE;
extern NSString *const kALLSERVICESDATE;
extern NSString *const kPARTSLOCATIONSPATH;
extern NSString *const kPAYTYPESPATH;
extern NSString *const kINSPECTIONFORMSLISTPATH;
extern NSString *const kINSPECTIONFORMSFOLDERPATH;
extern NSString *const kINPECTIONFORMNAMEPATH;
extern NSString *const kIMAGEPATH;
extern NSString *const kCUSTOMERPLAN ;
extern NSString *const kCUSTOMERPLANPDF ;
/**
 * Vehicle History Global Constants
 */
extern NSString *const kVEHICLE_HISTORY_API;
extern NSString *const kVIN_DECODER_API;

/**
 * Walk-Around Global Constants
 */
extern NSString *const kStore_VehicleDiagrams_sets_Array;
extern float const kVehicle_Image_X_Cord;
extern float const kVehicle_Image_Y_Cord;
extern float const kVehicle_Image_Width;
extern float const kVehicle_Image_Height;

/**
 * CheckIN Global Constants
 */

extern NSString *const kSIGNATURE_DATA_PATH;

@end
