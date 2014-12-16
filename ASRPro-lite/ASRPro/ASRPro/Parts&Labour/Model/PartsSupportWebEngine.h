//
//  PartsSupportWebEngine.h
//  ASRPro
//
//  Created by Kalyani on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartsSupportWebEngine : NSObject{
/**
 * AppDelegate object creating
 */
AppDelegate *mAppDelegate_;
}

@property(nonatomic,retain) NSMutableDictionary* mRequestData_;


/**
 * Method used to initialize class
 */
- (id)init;
-(void)getRequestForPartsLookup:(NSObject *)myObject;
-(void)postRequestForPartsLookup:(NSObject *)myObject;
-(void)putRequestForPartsLookup:(NSObject *)myObject;
-(void)deleteRequestForPartsLookup:(NSObject *)myObject;
-(void)postRequestForAddLookup:(NSObject *)myObject;
-(void)getRequestForAddParts:(NSObject *)myObject;
-(void)getRequestForLocationID:(NSObject *)myObject;


@end
