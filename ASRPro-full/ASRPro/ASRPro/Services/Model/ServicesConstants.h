//
//  ServicesConstants.h
//  ASRPro
//
//  Created by Kalyani on 13/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTABLEBACKGROUNDCOLOR_ONE [UIColor whiteColor]
#define kTABLEBACKGROUNDCOLOR_TWO [UIColor colorWithRed:(236.0/255.0) green:(240.0/255.0) blue:(241.0/255.0) alpha:1.0]

// Service images

#define  kDELETE_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_delete_button.png"]
#define  kEDIT_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_edit_button.png"]
#define  kNPL_ACTIVE_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_NPL-active.png"]
#define  kNPL_INACTIVE_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_NPL-inactive.png"]
#define  kAPPROVE_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_green_thumbsup_icon.png"]
#define  kUNAPPROVE_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_green_thumbsDown_icon.png"]
#define  kUNDECIDED_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_grey_hand_icon.png"]
#define  kAPPROVE_IMAGE [UIImage imageNamed:@"IMG_approve_selected.png"]
#define  kUNAPPROVE_IMAGE [UIImage imageNamed:@"IMG_approve_unselected.png"]
#define  kDECLINE_IMAGE [UIImage imageNamed:@"IMG_decline_selected.png"]
#define  kUNDECLINE_IMAGE [UIImage imageNamed:@"IMG_decline_unselected.png"]
#define  kDONE_IMAGE [UIImage imageNamed:@"IMG_done_button.png"]
#define  kUNDONE_IMAGE [UIImage imageNamed:@"IMG_undone_button.png"]
#define  kUNSELECT_RED_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_unselect-icon-red.png"]
#define  kSELECT_RED_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_select-icon-red.png"]
#define  kUNSELECT_YELLOW_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_unselect-icon-yellow.png"]
#define  kSELECT_YELLOW_IMAGE_RECOMMENDED [UIImage imageNamed:@"IMG_select-icon-yellow.png"]
#define  kSELECT_HEADER_ICON_SERVICEPACKAGE [UIImage imageNamed:@"iPad_carat-open.png"]
#define  kUNSELECT_HEADER_ICON_SERVICEPACKAGE [UIImage imageNamed:@"iPad_carat.png"]
#define  kFAST_MOVER_ICON_SERVICEPACKAGE [UIImage imageNamed:@"IMG_quick-access.png"]
#define kADDSERVICE_IMAGE [UIImage imageNamed:@"iPad_icon_add.png"]

#define KSERVICESHEADINGARRAY @"Service,Details,Notes,,PayType,Hours,Labor,Parts,Price,Complaint,Cause,Correction"
#define KPAYTYPECODE @"PayTypeCode"
#define KID @"ID"
#define KPAYCODE @"Code"
#define KSGID @"SGID"
#define KISPRIMARY @"IsPrimary"
#define KSGCID @"SGCID"
#define KSERVICEGUIDESPECIALITEMNAME @"ServiceGuideSpecialItemName"
#define KSERVICENAME @"ServiceName"
#define KCOLOR @"Color"
#define KHOURS @"Hours"
#define KPRICE @"Price"
#define KPRICELABOR @"PriceLabor"
#define KPRICEPARTS @"PriceParts"
#define KADVISORNOTE @"AdvisorNote"
#define KPARTSNOTE @"PartsNote"
#define KMANAGERNOTE @"ManagerNote"
#define KTECHNICIANNOTE @"TechnicianNote"
#define KCOMPLAINT @"Complaint"
#define KCAUSE @"Cause"
#define KCORRECTION @"Correction"
#define KDESCRIPTION @"ServiceDescription"
#define KGROUPID @"GroupID"
#define KCUSTOMHOURS @"CustomHours"
#define KCUSTOMPRICE @"CustomPrice"
#define KCUSTOMPRICELABOR @"CustomPriceLabor"
#define KCUSTOMPRICEPARTS @"CustomPriceParts"
#define KPARTSNOTNEEDED @"PartsNotNeeded"
#define KAPPROVED @"Approved"
#define KPRICE @"Price"
// OpenROServicesConstants

#define APPROVE_BUTTON_TAG_OPENRO 1
#define DECLINE_BUTTON_TAG_OPENRO 2
#define SERVICE_LABEL_TAG_OPENRO 3
#define PAY_TYPE_LABEL_TAG_OPENRO 4
#define HOURS_LABEL_TAG_OPENRO 5
#define LABOR_LABEL_TAG_OPENRO 6
#define PARTS_LABEL_TAG_OPENRO 7
#define PRICE_LABEL_TAG_OPENRO 8
#define EDIT_BUTTON_TAG_OPENRO 9
#define DONE_BUTTON_TAG_OPENRO  10
#define DELETE_BUTTON_TAG_OPENRO 11

#define APPROVE_BUTTON_WIDTH_OPENRO 27
#define DECLINE_BUTTON_WIDTH_OPENRO 27
#define SERVICE_LABEL_WIDTH_OPENRO 200
#define PAY_TYPE_LABEL_WIDTH_OPENRO 75
#define HOURS_LABEL_WIDTH_OPENRO 75
#define LABOR_LABEL_WIDTH_OPENRO 75
#define PARTS_LABEL_WIDTH_OPENRO 75
#define PRICE_LABEL_WIDTH_OPENRO 75
#define EDIT_BUTTON_WIDTH_OPENRO 24
#define SEPERATION_GAP_OPENRO 1


// RecommendedServicesConstants

#define EDIT_BUTTON_TAG_RECOMMENDED 1
#define SERVICE_LABEL_TAG_RECOMMENDED 2
#define PAY_TYPE_LABEL_TAG_RECOMMENDED 3
#define HOURS_LABEL_TAG_RECOMMENDED 4
#define LABOR_LABEL_TAG_RECOMMENDED 5
#define PARTS_LABEL_TAG_RECOMMENDED 6
#define PRICE_LABEL_TAG_RECOMMENDED 7
#define APPROVE_BUTTON_TAG_RECOMMENDED 8
#define DELETE_BUTTON_TAG_RECOMMENDED 9
#define NPL_BUTTON_TAG_RECOMMENDED 10

#define APPROVE_BUTTON_WIDTH_RECOMMENDED 27
#define SERVICE_LABEL_WIDTH_RECOMMENDED 250
#define PAY_TYPE_LABEL_WIDTH_RECOMMENDED 70
#define HOURS_LABEL_WIDTH_RECOMMENDED 70
#define LABOR_LABEL_WIDTH_RECOMMENDED 70
#define PARTS_LABEL_WIDTH_RECOMMENDED 70
#define PRICE_LABEL_WIDTH_RECOMMENDED 70
#define EDIT_BUTTON_WIDTH_RECOMMENDED 24
#define SEPERATION_GAP_RECOMMENDED 1

#define KPRIMARYSERVICESLABEL @"Current Services,Pay Type,Hrs,Labor,Parts,Price"
#define KRECOMMENDEDSERVICESLABEL @"Recommended Services,Pay Type,Hrs,Labor,Parts,Price"
#define KRECOMMENDEDSERVICESTOTALLABEL @"Sub - Total of recommended services"
#define KRECOMMENDEDSERVICESTOTALAPPOINMENTLABEL @"Sub - Total of appointment services"
#define KTOTALSERVICESLABEL @"Total of all Services"
#define KSHOPCHARGESLABEL @"Shop Charges"
#define KTAXLABEL @"Tax"
#define KREQUIREATTENTION @"Requires Immediate Attention"
#define KMAYREQUIREATTENTION @"May Require Future Attention"
#define kNOSERVICESLABEL @"No Services have been added"
#define kPRIMARYSGID @"3"

//ScheduleServicesConstants

#define APPROVE_BUTTON_TAG_SCHEDULED 1
#define SERVICE_LABEL_TAG_SCHEDULED 2

#define SERVICE_LABEL_WIDTH_SCHEDULED 650
#define APPROVE_BUTTON_WIDTH_SCHEDULED 27
#define SEPERATION_GAP_SCHEDULED 1



#define KSERVICEPOPUP_SERVICE 0
#define KSERVICEPOPUP_DETAILS 1
#define KSERVICEPOPUP_NOTES 2
#define KSERVICEPOPUP_COLOR 3
#define KSERVICEPOPUP_PAYTYPE 4
#define KSERVICEPOPUP_HOURS 5
#define KSERVICEPOPUP_LABOR 6
#define KSERVICEPOPUP_PARTS 7
#define KSERVICEPOPUP_PRICE 8
#define KSERVICEPOPUP_COMPLAINT 9
#define KSERVICEPOPUP_CAUSE 10
#define KSERVICEPOPUP_CORRECTION 11
#define KSERVICEPOPUP_IMAGEVIEW 12




#define KSERVICEPOPUP_SERVICE_HEIGHT 40
#define KSERVICEPOPUP_DETAILS_HEIGHT 40
#define KSERVICEPOPUP_NOTES_HEIGHT 40
#define KSERVICEPOPUP_COLOR_HEIGHT 80
#define KSERVICEPOPUP_PAYTYPE_HEIGHT 200
#define KSERVICEPOPUP_HOURS_HEIGHT 200
#define KSERVICEPOPUP_LABOR_HEIGHT 40
#define KSERVICEPOPUP_PARTS_HEIGHT 40
#define KSERVICEPOPUP_PRICE_HEIGHT 40
#define KSERVICEPOPUP_COMPLAINT_HEIGHT 40
#define KSERVICEPOPUP_CAUSE_HEIGHT 40
#define KSERVICEPOPUP_CORRECTION_HEIGHT 40
typedef enum{
    MAINVIEWCONTROLLER = 0,
    WALKAROUNDCONTROLLER = 1,
    SERVICESVIEWCONTROLLER = 2,
    FINISHINSPECTIONVIEWCONTROLLER = 3,
    OPENROSERVICESVIEWCONTROLLER = 4,
    BACKGROUNDTHREADSERVICES = 5,
    VEHICLEHISTORYSERVICES = 6,
    OPENROMAINVIEWCONTROLLER = 7,
    SERVICEPACKAGEVIEWCONTROLLER = 8
}getservicereference;

typedef enum{
    APPROVESTATE = 0,
    DECLINESTATE = 1,
    UNDECIDEDSTATE = 2,
}gettbuttonstate;
