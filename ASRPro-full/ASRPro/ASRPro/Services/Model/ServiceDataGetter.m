//
//  ServiceDataGetter.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServiceDataGetter.h"

@implementation ServiceDataGetter
@synthesize mScheduledServicesArray_;
@synthesize mAllServicesArray_;
@synthesize mRecommendedServicesArray_;
@synthesize mModelForSelectedService_;
@synthesize mServicePackagesArray_;
@synthesize mAddServicesViewController_;
@synthesize mFinalServicesTotall;
@synthesize mRecommendedServicesTotal;
@synthesize mSelectedServicesArray_;
@synthesize mPayTypesArray_;
@synthesize mServicesScheduledTotal;
@synthesize mShopCharges;
@synthesize mTax;
@synthesize mApprovedServicesTotal;
@synthesize mTaxandShopChargesApproved;
@synthesize mCheckinFinalTotal;

- (id)init
{
    if (self = [super init])
    {
        [self initTheObjects];
    }
    
    return self;
    
}

-(void)initTheObjects{
    isROChanged_=FALSE;
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    self.mModelForSelectedService_=[ModelForSelectedService new];
    self.mAllServicesArray_=[NSMutableArray array];
    self.mRecommendedServicesArray_=[NSMutableArray new];
    self.mScheduledServicesArray_=[NSMutableArray new];
    self.mServicePackagesArray_=[NSMutableArray new];
    self.mTempServicePackagesArray_=[NSMutableArray new];

    
}

-(void)loadServicePackages{
    NSMutableArray * lTempArray=[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPACKAGE];
    mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPATH];
    if(lTempArray==nil)
    {
        [mAppDelegate_.mModelForServiceRequestWebEngine_ setMGetServiceReference_:MAINVIEWCONTROLLER];
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForServiceLines];
    }
    else{
        [mAppDelegate_.mModelForServiceRequestWebEngine_ setMGetServiceReference_:MAINVIEWCONTROLLER];
        [mAppDelegate_.mServiceDataGetter_ setMServicePackagesArray_:lTempArray];
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForGetROLines:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_ ];
    }
}

-(void)filterServicepackages{
    self.mServicePackagesArray_=[NSMutableArray new];
    mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ =[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPATH];
    [mServicePackagesArray_ addObject:[self addFastmoversDict]];
    [self getParentswithChildSGID];
    [mServicePackagesArray_ addObject:[self getAllNoParentSGIDs]];
    [[FileUtils fileUtils] saveArrayInToFile:mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_ Path:kALLSERVICESPACKAGE];
}

-(NSMutableDictionary*)addFastmoversDict{
    NSMutableDictionary* lTempDict= [[NSMutableDictionary alloc] init];
    NSString *predFormat2=[NSString stringWithFormat:@"SELF.IsFastMover=%@",[NSNumber numberWithInt:1 ]];//gets all the non parents
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:predFormat2];
    NSArray *tempData = [mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ filteredArrayUsingPredicate:predicate2];
    [lTempDict setValue:tempData forKey:@"ChildrenServices"];
    [lTempDict setValue:@"FastMovers" forKey:@"ServiceName"];
    return lTempDict;
}

-(NSMutableDictionary*)getAllNoParentSGIDs{
    NSMutableDictionary* lTempDict= [[NSMutableDictionary alloc] init];
    NSString *predFormat2=[NSString stringWithFormat:@"(NOT SELF.IsFastMover=%@) AND (NOT SELF.HasChildren=%@) AND (NOT SELF.HasParents=%@)",[NSNumber numberWithInt:1 ],[NSNumber numberWithInt:1 ],[NSNumber numberWithInt:1 ]];//gets all the child sgids without parents
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:predFormat2];
    NSArray *tempData = [mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ filteredArrayUsingPredicate:predicate2];
    [lTempDict setValue:tempData forKey:@"ChildrenServices"];
    [lTempDict setValue:@"NoParents" forKey:@"ServiceName"];
    return lTempDict;
}

-(void)getParentswithChildSGID{
    NSString *predFormat2=[NSString stringWithFormat:@"(NOT SELF.IsFastMover=%@) AND (SELF.HasChildren=%@)",[NSNumber numberWithInt:1 ],[NSNumber numberWithInt:1]];//gets all the non parents
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:predFormat2];
    NSArray *lParentsArray = [mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ filteredArrayUsingPredicate:predicate2 ];
    NSString *predFormat3=[NSString stringWithFormat:@"(NOT SELF.IsFastMover=%@) AND (SELF.HasParents=%@)",[NSNumber numberWithInt:1 ],[NSNumber numberWithInt:1]];//gets all the non parents
    NSPredicate *predicate3 = [NSPredicate predicateWithFormat:predFormat3];
    NSMutableArray* lChildSGIDSArray=[[mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ filteredArrayUsingPredicate:predicate3] mutableCopy];
    for(int i=0;i<[lParentsArray count];i++){
        if([[lParentsArray objectAtIndex:i] objectForKey:@"ChildrenIDs"]!=nil){
            NSMutableDictionary* lTempDictionary=[NSMutableDictionary new];
            [lTempDictionary setDictionary:[lParentsArray objectAtIndex:i]];
            NSMutableArray* lTempChidSGIDs=[[[[GenericFiles genericFiles] removeUnnecessaycommas:[NSString stringWithFormat:@"%@",[lTempDictionary objectForKey:@"ChildrenIDs"]] ]componentsSeparatedByString:@","] mutableCopy];
            NSMutableArray* lTempChildService=[NSMutableArray new];
            for(int j=0;j<[lTempChidSGIDs count];j++){
                NSString *predFormat4=[NSString stringWithFormat:@"(SELF.SGID=%@)",[NSString stringWithFormat:@"%@",[lTempChidSGIDs objectAtIndex:j]]];
                NSPredicate *predicate4 = [NSPredicate predicateWithFormat:predFormat4];
                NSArray *lTempArray=[lChildSGIDSArray filteredArrayUsingPredicate:predicate4];
                [lTempChildService addObjectsFromArray:lTempArray];
            }
            [lTempDictionary setValue:lTempChildService forKey:@"ChildrenServices"];
            [mServicePackagesArray_ addObject:lTempDictionary];
        }
    }
}

-(void)AlphabeticalStaffNames:(NSMutableArray *)anArray {
    NSMutableArray  *mAlphabetIndexArray_=[[NSMutableArray alloc]init];
    [mAlphabetIndexArray_ addObject:@"{search}"];
    [mAlphabetIndexArray_ addObject:@"#"];
    
    for (char c= 'A'; c <= 'Z'; c++) {
        [mAlphabetIndexArray_ addObject:[NSString stringWithFormat:@"%c",c]];
    }
    NSMutableArray *lOrdreredArray = [[NSMutableArray alloc] init];
	for(int i=0;i<[mAlphabetIndexArray_ count];i++) {
        NSArray *states;
        if([[mAlphabetIndexArray_ objectAtIndex:i] isEqualToString:@"#"]) {
            
            NSString *predFormat;
            NSMutableArray *localArrayForListOfElements = [[NSMutableArray alloc] initWithArray:anArray];
            for(char c = 'A';c<='Z';c++) {
                predFormat=[NSString stringWithFormat:@"NOT SELF.ServiceName beginswith[c] '%c'",c];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:predFormat];
                NSArray *arrayForFilteredWords = [localArrayForListOfElements filteredArrayUsingPredicate:predicate]  ;
                [localArrayForListOfElements removeAllObjects];
                
                [localArrayForListOfElements addObjectsFromArray:arrayForFilteredWords];
            }
            states = [NSArray arrayWithArray:localArrayForListOfElements];
        }
        else {
            NSString *predFormat=[NSString stringWithFormat:@"SELF.ServiceName beginswith[c] '%@'",[mAlphabetIndexArray_ objectAtIndex:i]];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:predFormat];
            states =[anArray filteredArrayUsingPredicate:predicate];
        }
        if (0!=[states count]) {
            [lOrdreredArray addObjectsFromArray:states];
        }else {
            [lOrdreredArray addObjectsFromArray:states];
        }
    }
    
    [anArray removeAllObjects];
    [anArray addObjectsFromArray:lOrdreredArray];
}

-(void)filterLines:(NSMutableArray*)aServicesArray {
    [self.mScheduledServicesArray_ removeAllObjects];
    [self.mRecommendedServicesArray_ removeAllObjects];
    
    float lscheduletotal=0;
    float lrecommendedtotal=0;
    float lApprovedTotal=0;
    
    for(int i=0;i<[aServicesArray count];i++){
        if([[[aServicesArray objectAtIndex:i] objectForKey:KSGID]integerValue]==4){
            [self.mScheduledServicesArray_ addObject:[aServicesArray objectAtIndex:i]];
            if([[[aServicesArray objectAtIndex:i] objectForKey:KAPPROVED] boolValue])
                lApprovedTotal+=[[NSString stringWithFormat:@"%.2f",[[[aServicesArray objectAtIndex:i] objectForKey:KPRICE] floatValue ]] floatValue];
            lscheduletotal+=[[NSString stringWithFormat:@"%.2f",[[[aServicesArray objectAtIndex:i] objectForKey:KPRICE] floatValue ]] floatValue];
        }
        else{
            [self.mRecommendedServicesArray_ addObject:[aServicesArray objectAtIndex:i]];
            if([[[aServicesArray objectAtIndex:i] objectForKey:KAPPROVED] boolValue])
                lApprovedTotal+=[[NSString stringWithFormat:@"%.2f",[[[aServicesArray objectAtIndex:i] objectForKey:KPRICE] floatValue ]] floatValue];
            lrecommendedtotal+=[[NSString stringWithFormat:@"%.2f",[[[aServicesArray objectAtIndex:i] objectForKey:KPRICE] floatValue ]] floatValue];
        }
        
        
    }
    
    
    //Services
    self.mServicesScheduledTotal= [ NSString stringWithFormat:@"%.2f",lscheduletotal ];
    self.mRecommendedServicesTotal=[ NSString stringWithFormat:@"%.2f",lrecommendedtotal ];
    self.mShopCharges= [mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"ShopCharges"];
    self.mTax= [mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"Tax"];
    float total=0, shopchargesTotal=0;
    total=lscheduletotal+lrecommendedtotal+[mAppDelegate_.mServiceDataGetter_.mShopCharges floatValue]+[mAppDelegate_.mServiceDataGetter_.mTax floatValue];
    self.mFinalServicesTotall=[NSString stringWithFormat:@"%.2f",total];
    
    //Checkin
    shopchargesTotal=[[mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"ShopChargesApproved"] floatValue]+[[mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"TaxApproved"] floatValue];
    self.mTaxandShopChargesApproved=[NSString stringWithFormat:@"%.2f",shopchargesTotal];
    self.mApprovedServicesTotal=[NSString stringWithFormat:@"%.2f",lApprovedTotal];
    self.mCheckinFinalTotal=[NSString stringWithFormat:@"%.2f",lApprovedTotal+shopchargesTotal];
    
}

-(BOOL)isAllowZeroHours:(NSString*)aSGID{
    NSString *predFormat2=[NSString stringWithFormat:@"(SELF.SGID=%@)",[NSString stringWithFormat:@"%@",aSGID]];//gets all the non parents
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:predFormat2];
    NSArray *lParentsArray = [mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ filteredArrayUsingPredicate:predicate2 ];
    for(int i=0;i<[lParentsArray count];i++){
        return [[[lParentsArray objectAtIndex:i] objectForKey:@"AllowZeroHours"] boolValue];
    }
    return FALSE;
}

-(BOOL)isEnableGBB:(NSString*)aSGID{
    NSString *predFormat2=[NSString stringWithFormat:@"(SELF.SGID=%@)",[NSString stringWithFormat:@"%@",aSGID]];//gets all the non parents
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:predFormat2];
    NSArray *lParentsArray = [mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ filteredArrayUsingPredicate:predicate2 ];
    for(int i=0;i<[lParentsArray count];i++){
        return [[[lParentsArray objectAtIndex:i] objectForKey:@"EnableGBB"] boolValue];
    }
    return FALSE;
}
@end
