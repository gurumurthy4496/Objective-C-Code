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

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        mServiceHeadingArray_=[[KSERVICESARRAY componentsSeparatedByString:@","] mutableCopy];
        [self resetAllValues];
    }
    return self;
}


-(void)resetAllValues{
    isAdd_=TRUE;
    self.mLineID_=@"";
    self.mSGID_=@"";
    self.mSGCID_=@"";
    self.mServiceName_=@"";
    self.mColor_=@"";
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
    
    self.mPayTypeID_=[NSString stringWithFormat:@"%@",([[aServiceLineDict objectForKey:KPAYTYPECODE] objectForKey:KID]!=nil)?[[aServiceLineDict objectForKey:KPAYTYPECODE] objectForKey:KID]:@""];
    if([lServiceLineArray count]>1)
        self.mDetails_=[NSString stringWithFormat:@"%@",([lServiceLineArray objectAtIndex:1]!=nil)?[lServiceLineArray objectAtIndex:1]:@""];
    self.mServiceImageArray_=[aServiceLineDict objectForKey:@"Images"]!=nil?[aServiceLineDict objectForKey:@"Images"]:nil;
    
    self.mRequireAttention_=[mColor_ isEqualToString:@"Red"]?TRUE:FALSE;
    isCustomHour_=[[aServiceLineDict objectForKey:KCUSTOMHOURS] boolValue];
    isCustomPrice_=[[aServiceLineDict objectForKey:KCUSTOMPRICE] boolValue];
    
    isCustomLabour_=[[aServiceLineDict objectForKey:KCUSTOMPRICELABOR] boolValue];
    
    isCustomParts_=[[aServiceLineDict objectForKey:KCUSTOMPRICEPARTS] boolValue];
    
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
    
    self.mPayTypeID_=[NSString stringWithFormat:@"%@",([[aServiceLineDict objectForKey:KPAYTYPECODE] objectForKey:KID]!=nil)?[[aServiceLineDict objectForKey:KPAYTYPECODE] objectForKey:KID]:@""];
        self.mDetails_=@"";
    
    self.mRequireAttention_=[mColor_ isEqualToString:@"Red"]?TRUE:FALSE;
    
    self.mIsHoursChanged=FALSE;
    
    
}

-(NSMutableDictionary*)convertModelToDict{
    NSMutableDictionary*lTempDetailsDict =[[NSMutableDictionary alloc] init];
    [lTempDetailsDict setObject:self.mDetails_ forKey:KSERVICEGUIDESPECIALITEMNAME];
    [lTempDetailsDict setObject:[NSString stringWithFormat:@"%@:%@",self.mServiceName_,self.mDetails_] forKey:KSERVICENAME];
    [lTempDetailsDict setObject:self.mColor_ forKey:KCOLOR];
    
    [lTempDetailsDict setObject:!isCustomHour_?@"-1":self.mHours_ forKey:KHOURS];
     [lTempDetailsDict setObject:!isCustomPrice_?@"-1":self.mPrice_ forKey:KPRICE];
       [lTempDetailsDict setObject:[NSDictionary dictionaryWithObject:mPayTypeID_ forKey:KID] forKey:KPAYTYPECODE];
    [lTempDetailsDict setObject:!isCustomLabour_?@"-1":self.mPriceLabor_ forKey:KPRICELABOR];
     [lTempDetailsDict setObject:!isCustomParts_?@"-1":self.mPriceParts_ forKey:KPRICEPARTS];
     [lTempDetailsDict setObject:self.mAdvisorNotes_ forKey:KADVISORNOTE];
     [lTempDetailsDict setObject:self.mPartNotes_ forKey:KPARTSNOTE];
    [lTempDetailsDict setObject:self.mManagerNotes_ forKey:KMANAGERNOTE];
    [lTempDetailsDict setObject:self.mTechnicianNotes_ forKey:KTECHNICIANNOTE];
    [lTempDetailsDict setObject:self.mAdvisorNotes_ forKey:KADVISORNOTE];
     [lTempDetailsDict setObject:self.mComplaint_ forKey:KCOMPLAINT];
    [lTempDetailsDict setObject:self.mCause_ forKey:KCAUSE];
    [lTempDetailsDict setObject:self.mCorrection_ forKey:KCORRECTION];
    [self setMServiceDetailsDict_:lTempDetailsDict];
    return mServiceDetailsDict_;
}


@end
