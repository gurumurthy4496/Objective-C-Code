//
//  OpenROInspectionWebEngine.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenROInspectionWebEngine : NSObject

{
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    
@public
    int mFormCount_;
}
@property(nonatomic,retain) NSMutableDictionary* mRequestData;

- (id)init;
-(void)getRequestForInspectionFormList:(NSObject *)myObject;
-(void)getRequestForInspectionForm:(NSObject *)myObject;
-(void)getRequestForInspectionFormIndividual:(NSObject *)myObject;
-(void)getInspectionFormID:(NSObject *)myObject;
-(void)postRequestForAddInspectionItem:(NSObject *)myObject;
-(void)putRequestForUpdateInspectionItem:(NSObject *)myObject;
-(void)putRequestForChangeInspectionForm:(NSObject *)myObject;
-(void)PutRequestToChangeRoModeFromDispatchToInspection:(NSObject *)myObject;

@end
