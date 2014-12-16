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

@property (nonatomic,retain) NSString* mRONumber_;
@property (nonatomic,retain) NSMutableArray* mAddedPartsArray_;
@property(nonatomic,retain) NSMutableArray* mPartsLookupDict_;
@property(nonatomic,retain) ModelForCurrentPart* mModelForCurrentPart_;
@property(nonatomic,retain) PartsLabourLookupViewController* mPartsLabourLookupViewController_;
@property(nonatomic,retain) PartsLabourMainViewController* mPartsLabourMainViewController_;

@property(nonatomic,retain) PartsLaborMainSubview* mPartsLaborMainSubview;
@end
