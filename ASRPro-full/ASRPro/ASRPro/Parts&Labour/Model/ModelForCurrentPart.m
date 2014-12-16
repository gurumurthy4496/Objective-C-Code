//
//  ModelForCurrentPart.m
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForCurrentPart.h"


@implementation ModelForCurrentPart
@synthesize mDescription_;
@synthesize mLineID_;
@synthesize mLocation_;
@synthesize mPartNumber_;
@synthesize mPrice_;
@synthesize mQuality_;
@synthesize mQuantity_;
@synthesize mServiceName_;
@synthesize mPartID_;
@synthesize mLocationArray_;
@synthesize mQualityArray_;
@synthesize mPartsDict_;
@synthesize mLocationDict_;
@synthesize mPartNumberDict_;
@synthesize mQualityDict_;
@synthesize mPartNumbersArray_;


- (id)init
{
    if (self = [super init])
    {
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        NSMutableArray* lTempArray_=[[KQUALITYVALUES componentsSeparatedByString:@","] mutableCopy];
        mQualityArray_=[[NSMutableArray alloc] init];
        for(int i=0;i<[lTempArray_ count];i++){
            NSMutableDictionary* lTempDict =[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[lTempArray_ objectAtIndex:i]],kPART_QUALITY, [NSString stringWithFormat:@"%i",i+1],kPART_QUALITY_ID,nil];
            [mQualityArray_ addObject:lTempDict];
        }
    }
    
    return self;
    
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                            *** Method to set empty strings to modal  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)resetAllValues{
    self.mPartID_=@"";
    self.mDescription_ = @"";
    self.mLineID_ = @"";
    self.mLocation_ = @"";
    self.mPartNumber_ = @"";
    self.mPrice_ = @"";
    self.mQuality_ = @"";
    self.mQuantity_ = @"";
    self.mServiceName_ = @"";
}


//--------------------------------------------------- ************** ------------------------------------------------------
//                                      *** Method to set empty strings to modal  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)setDictToModel:(NSMutableDictionary*)aPartsDict{
   
    self.mPartID_=[NSString stringWithFormat:@"%@",[aPartsDict objectForKey:kPART_ID]] ;
    self.mDescription_ = [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:kPART_DESCRIPTION]];
    self.mLineID_ =  [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:kPART_LINE_ID]];
    self.mLocationDict_=[self getLocationDict:[[aPartsDict objectForKey:kPART_LOCATION_ID] intValue] ];
    self.mLocation_ = mLocationDict_!=nil?[NSString stringWithFormat:@"%@",[mLocationDict_ objectForKey:kPART_LOCATION]]:@"";
    self.mPartNumber_ = [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:kPART_NUMBER]];
    self.mPartNumberDict_=[self getPartsDict:self.mPartNumber_ ];
    self.mPrice_ =  [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:kPART_PRICE]];
    self.mQualityDict_=[self getQualityDict:[[aPartsDict objectForKey:kPART_QUALITY_ID] intValue] ];
    self.mQuality_ = mQualityDict_!=nil?[NSString stringWithFormat:@"%@",[mQualityDict_ objectForKey:kPART_QUALITY]]:@""; ;
    self.mQuantity_ =  [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:kPART_QUANTITY]];
    self.mPartNumbersArray_=[self getPartArray:self.mLineID_];
    
}


//--------------------------------------------------- ************** ------------------------------------------------------
//                                        *** method to convert modal values to dictionary  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(NSMutableDictionary*)convertModelToDict{
    NSMutableDictionary*lTempDetailsDict =[[NSMutableDictionary alloc] init];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mPartID_] forKey:kPART_ID];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mLineID_] forKey:kPART_LINE_ID];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mPartNumber_] forKey:kPART_NUMBER];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mQuantity_] forKey:kPART_QUANTITY];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mDescription_] forKey:kPART_DESCRIPTION];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mPrice_] forKey:kPART_PRICE];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",[self.mLocationDict_ objectForKey:kPART_ID]!=nil?[self.mLocationDict_ objectForKey:kPART_ID]:@""] forKey:kPART_LOCATION_ID];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",[self.mQualityDict_ objectForKey:kPART_QUALITY_ID]!=nil?[self.mQualityDict_ objectForKey:kPART_QUALITY_ID]:@""] forKey:kPART_QUALITY_ID];

    [self setMPartsDict_:lTempDetailsDict];
    return lTempDetailsDict;
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** returns Location name for LocationID ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(NSMutableDictionary*)getLocationDict:(int)anId{
    for(int i=0;i<[mLocationArray_ count];i++){
        if([[[mLocationArray_ objectAtIndex:i] objectForKey:kPART_ID] intValue]==anId)
            return [mLocationArray_ objectAtIndex:i];
    }
return nil;
}

-(NSMutableDictionary*)getQualityDict:(int)anId{
    for(int i=0;i<[mQualityArray_ count];i++){
        if([[[mQualityArray_ objectAtIndex:i] objectForKey:kPART_QUALITY_ID] intValue]==anId)
            return [mQualityArray_ objectAtIndex:i];
    }
    return nil;
}


-(NSMutableDictionary*)getPartsDict:(NSString*)aPartNumber{
    for(int i=0;i<[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_  count];i++){
        for(int j=0;j<[[[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:i] objectForKey:@"RepairOrderLines"] count];j++){
            for(int k=0;k<[[[[[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:i] objectForKey:@"RepairOrderLines"] objectAtIndex:j] objectForKey:@"PartItems"] count];k++)
                if( [aPartNumber isEqualToString:[NSString stringWithFormat:@"%@",[[[[[[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:i] objectForKey:@"RepairOrderLines"] objectAtIndex:j] objectForKey:@"PartItems"] objectAtIndex:k]objectForKey:kPART_NUMBER_DICT]]])
                return [[[[[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:i] objectForKey:@"RepairOrderLines"] objectAtIndex:j] objectForKey:@"PartItems"] objectAtIndex:k];
        }
    }
    return nil;

}

-(NSMutableArray*)getPartArray:(NSString*)aLineID{
    NSMutableArray * lTempArray=[[NSMutableArray alloc] init];
    for(int i=0;i<[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_  count];i++){
       for(int j=0;j<[[[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:i] objectForKey:@"RepairOrderLines"] count];j++){
        if( [[[[[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:i] objectForKey:@"RepairOrderLines"] objectAtIndex:j] objectForKey:@"ID"] intValue]==[aLineID intValue])
            [lTempArray addObjectsFromArray:[[[[mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_ objectAtIndex:i] objectForKey:@"RepairOrderLines"] objectAtIndex:j] objectForKey:@"PartItems"]];
    }
    }
    return [lTempArray mutableCopy] ;
}

@end
