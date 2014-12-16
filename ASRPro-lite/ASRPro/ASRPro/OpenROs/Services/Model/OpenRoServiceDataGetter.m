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
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        
        mModelForSelectedService_=[ModelForSelectedService new];
        mRecommendedServicesArray_=[NSMutableArray new];
        mScheduledServicesArray_=[NSMutableArray new];
    }
    
    return self;
    
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
    
    for(int i=0;i<[lTempArray count];i++){
        if([[NSString stringWithFormat:@"%@",[[lTempArray objectAtIndex:i] objectForKey:@"SGID"]] isEqualToString:@"3"])
            [mScheduledServicesArray_ addObject:[lTempArray objectAtIndex:i]];
        else
            [mRecommendedServicesArray_ addObject:[lTempArray objectAtIndex:i]];
    }
}


@end
