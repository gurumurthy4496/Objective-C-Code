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
@synthesize mServicesScheduledTotal;
@synthesize mShopCharges;
@synthesize mTax;

- (id)init
{
    if (self = [super init])
    {
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];

        mModelForSelectedService_=[ModelForSelectedService new];
        mAllServicesArray_=[NSMutableArray array];
        mRecommendedServicesArray_=[NSMutableArray new];
        mScheduledServicesArray_=[NSMutableArray new];
        mServicePackagesArray_=[NSMutableArray new];
    }
    
    return self;
    
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
            NSMutableArray* lTempChidSGIDs=[[[self removeUnnecessaycommas:[NSString stringWithFormat:@"%@",[lTempDictionary objectForKey:@"ChildrenIDs"]] ]componentsSeparatedByString:@","] mutableCopy];
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

-(NSString *)removeUnnecessaycommas:(NSString *)mString { //removes extra commas ex 1,2, returns 1,2
    return [mString stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@","]];
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

-(void)filterLines:(NSMutableArray*)lTempArray{
    [mScheduledServicesArray_ removeAllObjects];
    [mRecommendedServicesArray_ removeAllObjects];
    
    float lscheduletotal=0;
    float lrecommendedtotal=0;
    for(int i=0;i<[lTempArray count];i++){
        if([[NSString stringWithFormat:@"%@",[[lTempArray objectAtIndex:i] objectForKey:@"SGID"]] isEqualToString:@"3"]){
            [mScheduledServicesArray_ addObject:[lTempArray objectAtIndex:i]];
            if([[[lTempArray objectAtIndex:i] objectForKey:@"Approved"] boolValue])
                lscheduletotal+=[[[lTempArray objectAtIndex:i] objectForKey:@"Price"] floatValue];
        }
        else{
            [mRecommendedServicesArray_ addObject:[lTempArray objectAtIndex:i]];
            if([[[lTempArray objectAtIndex:i] objectForKey:@"Approved"] boolValue])
                lrecommendedtotal+=[[[lTempArray objectAtIndex:i] objectForKey:@"Price"] floatValue];
        }
        

    }
    mServicesScheduledTotal= [ NSString stringWithFormat:@"%.2f",lscheduletotal ];
    mRecommendedServicesTotal=[ NSString stringWithFormat:@"%.2f",lrecommendedtotal ];
    
}


@end
