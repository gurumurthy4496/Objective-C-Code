//
//  ModelForSelectedService.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForSelectedService.h"
#import "ServicesConstants.h"

@implementation ModelForSelectedService

@synthesize mLineID_;
@synthesize mSGID_;
@synthesize mSGCID_;
@synthesize mDetails_;
@synthesize mHours_;
@synthesize mCause_;
@synthesize mColor_;
@synthesize mComplaint_;
@synthesize mCorrection_;
@synthesize mTechnicianNotes_;
@synthesize mManagerNotes_;
@synthesize mPartNotes_;
@synthesize mAdvisorNotes_;
@synthesize mPayTypeID_;
@synthesize mPrice_;
@synthesize mPriceLabor_;
@synthesize mPriceParts_;
@synthesize mServiceName_;
@synthesize mServiceDetailsDict_;
@synthesize mServiceImageArray_;
@synthesize mGroupID_;
@synthesize mRequireAttention_;
@synthesize mIsHoursChanged;
@synthesize mServiceHeadingArray_;
@synthesize mPayTypeDict_;
@synthesize mPayTypeCode_;

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        mServiceHeadingArray_=[[KSERVICESHEADINGARRAY componentsSeparatedByString:@","] mutableCopy];
        [self resetAllValues];
        mAppDelegate_.mServiceDataGetter_.mPayTypesArray_=[[FileUtils fileUtils] loadArrayFromFile:kPAYTYPESPATH];

    }
    return self;
}


-(void)resetAllValues{
    isAdd_=TRUE;
    
    self.mLineID_=@"";
    self.mSGID_=@"";
    self.mSGCID_=@"";
    self.mServiceName_=@"";
    self.mColor_=@"Red";
    self.mHours_=@"";
    self.mPrice_=@"";
    self.mPriceLabor_=@"";
    self.mPriceParts_=@"";
    self.mAdvisorNotes_=@"";
    self.mPartNotes_=@"";
    self.mManagerNotes_=@"";
    self.mTechnicianNotes_=@"";
    self.mComplaint_=@"";
    self.mCause_=@"";
    self.mCorrection_=@"";
    self.mPayTypeID_=@"";
    self.mPayTypeCode_=@"";
    self.mDetails_=@"";
    self.mGroupID_=@"";
    self.mRequireAttention_=FALSE;
    
}

-(void)saveDictToModel:(NSMutableDictionary*)aServiceLineDict{
    isAdd_=FALSE;

    
    NSString *str = [NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KSERVICENAME]!=nil)?[aServiceLineDict objectForKey:KSERVICENAME]:@"" ];
    const NSUInteger nFields = 2;
    
    NSScanner *myScanner = [NSScanner scannerWithString: str];
    NSMutableArray *lServiceLineArray  = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < nFields - 1; i++) {
        NSString *field;
        
        // The BOOLs here really ought to be checked
        [myScanner scanUpToString: @":" intoString: &field];
        [myScanner scanString: @":" intoString: NULL];
        
        [lServiceLineArray addObject: field ?: @"" ];
    }
    
    NSString *lastField = [[myScanner string] substringFromIndex:[myScanner scanLocation]];
    [lServiceLineArray addObject: lastField];
    [self setMServiceDetailsDict_:aServiceLineDict];
    self.mLineID_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KID]!=nil)?[aServiceLineDict objectForKey:KID]:@""];
    self.mSGID_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KSGID]!=nil)?[aServiceLineDict objectForKey:KSGID]:@""];
    self.mSGCID_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KSGCID]!=nil)?[aServiceLineDict objectForKey:KSGCID]:@""];
    self.mServiceName_=[NSString stringWithFormat:@"%@",([lServiceLineArray objectAtIndex:0]!=nil)?[lServiceLineArray objectAtIndex:0]:@""];
    self.mColor_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KCOLOR]!=nil)?[aServiceLineDict objectForKey:KCOLOR]:@""];
    self.mHours_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KHOURS]!=nil)?[aServiceLineDict objectForKey:KHOURS]:@""];
    self.mPrice_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KPRICE]!=nil)?[aServiceLineDict objectForKey:KPRICE]:@""];
    self.mPriceLabor_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KPRICELABOR]!=nil)?[aServiceLineDict objectForKey:KPRICELABOR]:@""];
    self.mPriceParts_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KPRICEPARTS]!=nil)?[aServiceLineDict objectForKey:KPRICEPARTS]:@""];
    self.mAdvisorNotes_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KADVISORNOTE]!=nil)?[aServiceLineDict objectForKey:KADVISORNOTE]:@""];
    self.mPartNotes_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KPARTSNOTE]!=nil)?[aServiceLineDict objectForKey:KPARTSNOTE]:@""];
    self.mManagerNotes_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KMANAGERNOTE]!=nil)?[aServiceLineDict objectForKey:KMANAGERNOTE]:@""];
    self.mTechnicianNotes_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KTECHNICIANNOTE]!=nil)?[aServiceLineDict objectForKey:KTECHNICIANNOTE]:@""];
    self.mComplaint_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KCOMPLAINT]!=nil)?[aServiceLineDict objectForKey:KCOMPLAINT]:@""];
    self.mCause_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KCAUSE]!=nil)?[aServiceLineDict objectForKey:KCAUSE]:@""];
    self.mCorrection_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KCORRECTION]!=nil)?[aServiceLineDict objectForKey:KCORRECTION]:@""];
    self.mGroupID_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KGROUPID]!=nil)?[aServiceLineDict objectForKey:KGROUPID]:@""];
    self.mPayTypeCode_=[NSString stringWithFormat:@"%@",([[aServiceLineDict objectForKey:KPAYTYPECODE] objectForKey:KPAYCODE]!=nil)?[[aServiceLineDict objectForKey:KPAYTYPECODE] objectForKey:KPAYCODE]:@""];
    self.mPayTypeID_=[NSString stringWithFormat:@"%@",([[aServiceLineDict objectForKey:KPAYTYPECODE] objectForKey:KID]!=nil)?[[aServiceLineDict objectForKey:KPAYTYPECODE] objectForKey:KID]:@""];
    self.mPayTypeDict_=[aServiceLineDict objectForKey:KPAYTYPECODE];
    if([lServiceLineArray count]>1)
        self.mDetails_=[NSString stringWithFormat:@"%@",([lServiceLineArray objectAtIndex:1]!=nil)?[lServiceLineArray objectAtIndex:1]:@""];
    self.mServiceImageArray_=[aServiceLineDict objectForKey:@"Images"]!=nil?[aServiceLineDict objectForKey:@"Images"]:nil;
    
    self.mRequireAttention_=[mColor_ isEqualToString:@"Red"]?TRUE:FALSE;
    isCustomHour_=[[aServiceLineDict objectForKey:KCUSTOMHOURS] boolValue];
    isCustomPrice_=[[aServiceLineDict objectForKey:KCUSTOMPRICE] boolValue];
    
    isCustomLabour_=[[aServiceLineDict objectForKey:KCUSTOMPRICELABOR] boolValue];
    
    isCustomParts_=[[aServiceLineDict objectForKey:KCUSTOMPRICEPARTS] boolValue];
//    isCustomHour_=FALSE;
//    isCustomPrice_=FALSE;
//    
//    isCustomLabour_=FALSE;
//    
//    isCustomParts_=FALSE;

}

-(void)saveAddDictToModel:(NSMutableDictionary*)aServiceLineDict{
    isAdd_=TRUE;
    isCustomHour_=FALSE;
    isCustomPrice_=FALSE;

    isCustomLabour_=FALSE;

    isCustomParts_=FALSE;

    self.mLineID_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KID]!=nil)?[aServiceLineDict objectForKey:KID]:@""];
    self.mSGID_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KSGID]!=nil)?[aServiceLineDict objectForKey:KSGID]:@""];
    self.mSGCID_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KSGCID]!=nil)?[aServiceLineDict objectForKey:KSGCID]:@""];
    self.mServiceName_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KSERVICENAME]!=nil)?[aServiceLineDict objectForKey:KSERVICENAME]:@""];
  self.mColor_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KCOLOR]!=nil)?[aServiceLineDict objectForKey:KCOLOR]:@"Red"];
//    self.mHours_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KHOURS]!=nil)?[aServiceLineDict objectForKey:KHOURS]:@""];
//    self.mPrice_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KPRICE]!=nil)?[aServiceLineDict objectForKey:KPRICE]:@""];
//    self.mPriceLabor_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KPRICELABOR]!=nil)?[aServiceLineDict objectForKey:KPRICELABOR]:@""];
//    self.mPriceParts_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KPRICEPARTS]!=nil)?[aServiceLineDict objectForKey:KPRICEPARTS]:@""];
//    self.mAdvisorNotes_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KADVISORNOTE]!=nil)?[aServiceLineDict objectForKey:KADVISORNOTE]:@""];
//    self.mPartNotes_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KPARTSNOTE]!=nil)?[aServiceLineDict objectForKey:KPARTSNOTE]:@""];
//    self.mManagerNotes_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KMANAGERNOTE]!=nil)?[aServiceLineDict objectForKey:KMANAGERNOTE]:@""];
//    self.mTechnicianNotes_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KTECHNICIANNOTE]!=nil)?[aServiceLineDict objectForKey:KTECHNICIANNOTE]:@""];
//    self.mComplaint_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KCOMPLAINT]!=nil)?[aServiceLineDict objectForKey:KCOMPLAINT]:@""];
//    self.mCause_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KCAUSE]!=nil)?[aServiceLineDict objectForKey:KCAUSE]:@""];
//    self.mCorrection_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KCORRECTION]!=nil)?[aServiceLineDict objectForKey:KCORRECTION]:@""];
//    self.mGroupID_=[NSString stringWithFormat:@"%@",([aServiceLineDict objectForKey:KGROUPID]!=nil)?[aServiceLineDict objectForKey:KGROUPID]:@""];
    self.mDetails_=@"";
    
    self.mRequireAttention_=[mColor_ isEqualToString:@"Red"]?TRUE:FALSE;
    
    self.mIsHoursChanged=FALSE;
    
    
}

-(NSMutableDictionary*)convertModelToDict:(BOOL)isApproved{
    if(!isAdd_){
    isCustomPrice_= [[NSString stringWithFormat:@"%@",[self.mServiceDetailsDict_ objectForKey:KPRICE]] isEqualToString:self.mPrice_]?[[self.mServiceDetailsDict_ objectForKey:KCUSTOMPRICE] boolValue]:TRUE;
    isCustomParts_= [[NSString stringWithFormat:@"%@",[self.mServiceDetailsDict_ objectForKey:KPRICEPARTS] ]isEqualToString:self.mPriceParts_]?[[self.mServiceDetailsDict_ objectForKey:KCUSTOMPRICEPARTS] boolValue]:TRUE;
    isCustomLabour_= [[NSString stringWithFormat:@"%@",[self.mServiceDetailsDict_ objectForKey:KPRICELABOR]] isEqualToString:self.mPriceLabor_]?[[self.mServiceDetailsDict_ objectForKey:KCUSTOMPRICELABOR] boolValue]:TRUE;
    isCustomHour_= [[NSString stringWithFormat:@"%@",[self.mServiceDetailsDict_ objectForKey:KHOURS]] isEqualToString:self.mHours_]?[[self.mServiceDetailsDict_ objectForKey:KCUSTOMHOURS] boolValue]:TRUE;
    }
    else{
        isCustomHour_=!([self.mHours_ isEqualToString:@""]||self.mHours_==nil)?TRUE:FALSE;
        isCustomParts_=!([self.mPriceParts_ isEqualToString:@""]||self.mPriceParts_==nil)?TRUE:FALSE;

        isCustomLabour_=!([self.mPriceLabor_ isEqualToString:@""]||self.mPriceLabor_==nil)?TRUE:FALSE;

        isCustomPrice_=!([self.mPrice_ isEqualToString:@""]||self.mPrice_==nil)?TRUE:FALSE;

    }

    NSMutableDictionary*lTempDetailsDict =[[NSMutableDictionary alloc] init];
    [lTempDetailsDict setObject:self.mDetails_ forKey:KSERVICEGUIDESPECIALITEMNAME];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@:%@",self.mServiceName_,self.mDetails_] forKey:KSERVICENAME];
    [lTempDetailsDict setObject:self.mColor_ forKey:KCOLOR];
    
    [lTempDetailsDict setObject:(!isCustomHour_|[self.mHours_ isEqualToString:@""])?@"-1":self.mHours_ forKey:KHOURS];
     [lTempDetailsDict setObject:(!isCustomPrice_||[self.mPrice_ isEqualToString:@""])?@"-1":self.mPrice_ forKey:KPRICE];
      if(mPayTypeDict_!=nil)
        [lTempDetailsDict setObject:self.mPayTypeDict_ forKey:KPAYTYPECODE];
    [lTempDetailsDict setObject:(!isCustomLabour_||[self.mPriceLabor_ isEqualToString:@""])?@"-1":self.mPriceLabor_ forKey:KPRICELABOR];
     [lTempDetailsDict setObject:(!isCustomParts_||[self.mPriceParts_ isEqualToString:@""])?@"-1":self.mPriceParts_ forKey:KPRICEPARTS];
     [lTempDetailsDict setObject:self.mAdvisorNotes_ forKey:KADVISORNOTE];
     [lTempDetailsDict setObject:self.mPartNotes_ forKey:KPARTSNOTE];
    [lTempDetailsDict setObject:self.mManagerNotes_ forKey:KMANAGERNOTE];
    [lTempDetailsDict setObject:self.mTechnicianNotes_ forKey:KTECHNICIANNOTE];
    [lTempDetailsDict setObject:self.mAdvisorNotes_ forKey:KADVISORNOTE];
     [lTempDetailsDict setObject:self.mComplaint_ forKey:KCOMPLAINT];
    [lTempDetailsDict setObject:self.mCause_ forKey:KCAUSE];
    [lTempDetailsDict setObject:self.mCorrection_ forKey:KCORRECTION];
    if(isApproved)
    [lTempDetailsDict setObject:@"true" forKey:KAPPROVED];
   

    [self setMServiceDetailsDict_:lTempDetailsDict];
    return mServiceDetailsDict_;
}


@end
