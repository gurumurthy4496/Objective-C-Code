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


- (id)init
{
    if (self = [super init])
    {
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        mQualityArray_=[[KQUALITYVALUES componentsSeparatedByString:@","] mutableCopy];
    }
    
    return self;
    
}


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


-(void)setDictToModel:(NSMutableDictionary*)aPartsDict{
   
    self.mPartID_=[NSString stringWithFormat:@"%@",[aPartsDict objectForKey:@"ID"]] ;
    self.mDescription_ = [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:@"Description"]];
    self.mLineID_ =  [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:@"LineID"]];
    self.mLocation_ = [self getLocationName:[[aPartsDict objectForKey:@"LocationID"] intValue]];
    self.mPartNumber_ = [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:@"PartNumber"]];
    self.mPrice_ =  [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:@"Price"]];
    self.mQuality_ = [NSString stringWithFormat:@"%@",[mQualityArray_ objectAtIndex:[[aPartsDict objectForKey:@"QualityID"] intValue]]] ;
    self.mQuantity_ =  [NSString stringWithFormat:@"%@",[aPartsDict objectForKey:@"Quantity"]];
}


-(NSMutableDictionary*)convertModelToDict{
    NSMutableDictionary*lTempDetailsDict =[[NSMutableDictionary alloc] init];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mPartID_] forKey:@"ID"];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mLineID_] forKey:@"LineID"];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mPartNumber_] forKey:@"PartNumber"];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mQuantity_] forKey:@"Quantity"];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mDescription_] forKey:@"Description"];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@",self.mPrice_] forKey:@"Price"];
    [self setMPartsDict_:lTempDetailsDict];
    return lTempDetailsDict;
}

-(NSString*)getLocationName:(int)anId{
    for(int i=0;i<[mLocationArray_ count];i++){
        if([[[mLocationArray_ objectAtIndex:i] objectForKey:KID] intValue]==anId)
            return [NSString stringWithFormat:@"%@",[[mLocationArray_ objectAtIndex:i] objectForKey:@"Location"]];
    }
return @"";
}

@end
