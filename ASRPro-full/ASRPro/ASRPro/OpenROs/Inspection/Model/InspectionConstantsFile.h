//
//  InspectionConstantsFile.h
//  ASRPro
//
//  Created by Kalyani on 13/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface InspectionConstantsFile : NSObject


typedef enum{
    BACKGROUNDTHREAD = 0,
    WALKAROUNDINSPECTION = 1,
    FINISHINSPECTION = 2,
    FINISHINSPECTIONVIEW = 3,
    ChECKINVIEWREFERENCE=4


}getformreference;

typedef enum{
    LANEINSPECTION = 0,
    MAININSPECTION = 1,
}gettformtype;



//Images

#define IMG_RED_ACTIVE_BUTTON [UIImage imageNamed:@"IMG_red-active-btn.png"]
#define IMG_GREEN_ACTIVE_BUTTON [UIImage imageNamed:@"IMG_green-active-btn.png"]
#define IMG_YELLOW_ACTIVE_BUTTON [UIImage imageNamed:@"IMG_yellow-active-btn.png"]
#define IMG_RED_INACTIVE_BUTTON [UIImage imageNamed:@"IMG_red-inactive-btn.png"]
#define IMG_GREEN_INACTIVE_BUTTON [UIImage imageNamed:@"IMG_green-inactive-btn.png"]
#define IMG_YELLOW_INACTIVE_BUTTON [UIImage imageNamed:@"IMG_yellow-inactive-btn.png"]
#define IMG_ADD_SERVICE_BUTTON [UIImage imageNamed:@"IMG_add-service-btn.png"]
#define IMG_MINUS_ICON [UIImage imageNamed:@"IMG_minus-icon.png"]
#define IMG_PLUS_ICON [UIImage imageNamed:@"IMG_plus-icon"]
#define IMG_SLIDER_HANDLE [UIImage imageNamed:@"IMG_slider-handler.png"]
#define IMG_SLIDER_SELECTED [UIImage imageNamed:@"IMG_tracker_selected.png"]
#define IMG_SLIDER_UNSELECTED [UIImage imageNamed:@"IMG_tracker_unselected.png"]
#define IMG_RADIO_SELECT [UIImage imageNamed:@"IMG_select-icon.png"]
#define IMG_RADIO_UNSELECT [UIImage imageNamed:@"IMG_unselect-icon.png"]
#define IMG_CHECK_SELECT [UIImage imageNamed:@"IMG_check-icon.png"]
#define IMG_CHECK_UNSELECT [UIImage imageNamed:@"IMG_uncheck-icon.png"]
#define IMG_MANDATORY_ICON [UIImage imageNamed:@"IMG_mandatory-icon.png"]

#define KINSPECTIONHEADINGS @"RO,Hat,VIN,Name,Year,Make,Model"


// Identifiers of components
#define MONTH ( 0 )
#define YEAR ( 1 )
@end
