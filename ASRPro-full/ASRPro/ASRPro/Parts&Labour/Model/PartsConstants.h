//
//  PartsConstants.h
//  ASRPro
//
//  Created by Kalyani on 13/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartsConstants : NSObject

#define KLOCATIONVALUES @",In Stock,Later Today,Tomorrow,2 Days,3 Days,4 Days +,Out of Stock"
#define KQUALITYVALUES @"Good,Better,Best"
#define KPARTSHEADINGLABEL @"Quality,Quantity,Part Number,Description,Location,Price"

#define kPART_NUMBER @"PartNumber"
#define kPART_NUMBER_DICT @"Number"
#define kPART_QUALITY_ID @"QualityID"
#define kPART_QUALITY @"Quality"
#define kPART_LOCATION_ID @"LocationID"
#define kPART_LOCATION @"Location"
#define kPART_DESCRIPTION @"Description"
#define kPART_QUANTITY @"Quantity"
#define kPART_PRICE @"Price"
#define kPART_ID @"ID"
#define kPART_LINE_ID @"LineID"
#define kPART_NAME @"Name"
#define kPART_ASRLID @"ASRLID"

#define kCONTENT_TYPE @"Content-Type"
#define kACCEPT @"Accept"
#define kAUTHORISATION @"Authorization"
#define kFORMAT @"Format"

#define kCONTENT_TYPE_VALUE @"application/json; charset=UTF-8"
#define kACCEPT_VALUE @"application/json"
#define kAUTHORISATION_VALUE @"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc="
#define kFORMAT_VALUE @"JSON"

#define KAPPROVED @"Approved"
#define KDECLINED @"Declined"
#define KPARTS @"Parts"

#define kAPPROVECOLOR [UIColor colorWithRed:(41.0/255.0) green:(174.0/255.0) blue:(97.0/255.0) alpha:1.0]
#define kDECLINECOLOR [UIColor colorWithRed:(251.0/255.0) green:(62.0/255.0) blue:(56.0/255.0) alpha:1.0]
#define kUNDECIDEDCOLOR [UIColor colorWithRed:(19.0/255.0) green:(124.0/255.0) blue:(252.0/255.0) alpha:1.0]

#define kUNDECIDEDTHUMBIMAGE [UIImage imageNamed:@"IMG_thumb_default.png"]
#define kADD_IMAGE_PARTS  [UIImage imageNamed:@"IMG_add.png"]
#define kPLUS_IMAGE_PARTS [UIImage imageNamed:@"IMG_plus.png"]
#define kMINUS_IMAGE_PARTS [UIImage imageNamed:@"IMG_minus.png"]

#define kADD_TITLE_PARTS  @"Add"

#define kTEXTCOLORPARTS [UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]
#define kNOPARTSTEXT @"Parts information for this service is unavailable"

typedef enum {
    INPROCESSOPARTSVIEWCONTROLLER = 0,
    OPENROPARTSVIEWCONTROLLER = 1,
} getPartsReference;

@end
