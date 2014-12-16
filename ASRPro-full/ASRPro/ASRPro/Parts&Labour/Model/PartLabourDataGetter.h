//
//  PartLabourDataGetter.h
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelForCurrentPart.h"
#import "PartsLabourLookupViewController.h"
#import "PartsLabourMainViewController.h"
#import "PartsLaborMainSubview.h"


@interface PartLabourDataGetter : NSObject{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    BOOL isSucess;
    BOOL isAdd;
}

/**
 * string stores the RONumber for Parts Lookup
 */
@property (nonatomic,retain) NSString* mRONumber_;

/**
 * Array constists of the list of part items added to the line
 */
@property (nonatomic,retain) NSMutableArray* mAddedPartsArray_;

/**
 * Array constists of the list of Vehicles with part and labor items
 */
@property(nonatomic,retain) NSMutableArray* mPartsLookupDict_;

/**
 * Instance of model with details of selected part  item
 */
@property(nonatomic,retain) ModelForCurrentPart* mModelForCurrentPart_;

/**
 * Instance of PartsLabourLookupViewController
 */
@property(nonatomic,retain) PartsLabourLookupViewController* mPartsLabourLookupViewController_;

/**
 * Instance of PartsLabourMainViewController
 */
@property(nonatomic,retain) PartsLabourMainViewController* mPartsLabourMainViewController_;

/**
 * Instance of PartsLaborMainSubview
 */
@property(nonatomic,retain) PartsLaborMainSubview* mPartsLaborMainSubview;

@end
