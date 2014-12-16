//
//  ModelForPartsSupportEngine.h
//  ASRPro
//
//  Created by Kalyani on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartsSupportWebEngine.h"

typedef enum {
    INPROCESSOPARTSVIEWCONTROLLER = 0,
    OPENROPARTSVIEWCONTROLLER = 1,
} getPartsReference;

@interface ModelForPartsSupportEngine : NSObject{
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
}


@property(nonatomic,retain)PartsSupportWebEngine* mPartsSupportWebEngine_;
@property (nonatomic,assign) getPartsReference mGetPartsReference_;


-(void)requestToGetParts:(NSString*)aRONumber;
-(void)requestToAddParts:(NSString*)aRONumber
                  LineID:(NSString*)aLineID
             RequestDict:(NSMutableDictionary*)aRequestDict;
-(void)requestToUpdateParts:(NSString*)aRONumber
                RequestDict:(NSMutableDictionary*)aRequestDict;
-(void)requestToDeleteParts:(NSString*)aRONumber
                     PartID:(NSString*)aPartID;
-(void)requestToAddLookup:(NSString*)aRONumber
              RequestDict:(NSMutableDictionary*)aRequestDict;
-(void)RequestFoGetPartsLines:(NSString*)aRepairOrderID;
-(void)RequestFoGetLocations;
@end
