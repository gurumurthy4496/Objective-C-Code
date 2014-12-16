//
//  PartLabourDataGetter.m
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PartLabourDataGetter.h"

@implementation PartLabourDataGetter
@synthesize mAddedPartsArray_;
@synthesize mModelForCurrentPart_;
@synthesize mPartsLookupDict_;
//@synthesize mPartsLabourLookupViewController_;
@synthesize mPartsLabourMainViewController_;
@synthesize mRONumber_;

- (id)init
{
    if (self = [super init])
    {
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        [self initialiseArrays];
    }
    return self;
}


//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** Method used to initialize arrays  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)initialiseArrays{
    self.mModelForCurrentPart_=[ModelForCurrentPart new];
    self.mAddedPartsArray_=[NSMutableArray array];
    self.mPartsLookupDict_=[NSMutableArray new];
}

@end
