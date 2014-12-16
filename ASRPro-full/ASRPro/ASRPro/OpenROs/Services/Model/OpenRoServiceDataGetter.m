//
//  OpenRoServiceDataGetter.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "OpenRoServiceDataGetter.h"

@implementation OpenRoServiceDataGetter
@synthesize mScheduledServicesArray_;
@synthesize mRecommendedServicesArray_;
@synthesize mModelForSelectedService_;
@synthesize mAddServicesViewController_;
@synthesize mSelectedServicesArray_;
@synthesize mPdfTitle;
@synthesize mPdfURL;

- (id)init
{
    if (self = [super init])
    {
        [self initTheObjects];
    }
    return self;
}

#pragma mark -  ********************** Generic Methods **************************

//--------------------------------------------------- ************** ------------------------------------------------------
//                                              *** Method to initialise objects  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)initTheObjects{
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    self.mModelForSelectedService_=[ModelForSelectedService new];
    self.mRecommendedServicesArray_=[NSMutableArray new];
    self.mScheduledServicesArray_=[NSMutableArray new];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                      *** Method to filter lines  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)filterLines:(NSMutableArray*)aServicesArray {
    [self.mScheduledServicesArray_ removeAllObjects];
    [self.mRecommendedServicesArray_ removeAllObjects];
    for(int iterate=0; iterate<[aServicesArray count]; iterate++){
        if([[[aServicesArray objectAtIndex:iterate] objectForKey:KISPRIMARY] boolValue])
            [self.mScheduledServicesArray_ addObject:[aServicesArray objectAtIndex:iterate]];
        else
            [self.mRecommendedServicesArray_ addObject:[aServicesArray objectAtIndex:iterate]];
    }
}

@end
