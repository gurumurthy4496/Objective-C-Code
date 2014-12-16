//
//  OpenROSupportWebEngine.h
//  ASRPro
//
//  Created by Kalyani on 25/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenROSupportWebEngine : NSObject{
/**
 * AppDelegate object creating
 */
AppDelegate *mAppDelegate_;
}

@property(nonatomic,retain) NSMutableDictionary* mRequestData_;
@property(nonatomic,retain) NSMutableArray* mImageAddArray_;
@property(nonatomic,retain) NSMutableArray* mImagedeleteArray_;
@property(nonatomic,retain) NSData* mImageData;

/**
 * Method used to initialize class
 */
- (id)init;

-(void)getRequestForServices:(NSObject *)myObject;
-(void) getRequestForROLines:(NSObject *)myObject;
-(void) putRequestToUpdateLine:(NSObject *)myObject;
-(void) deleteRequestForLine:(NSObject *)myObject;
-(void) postRequestForDisplayOrder:(NSObject *)myObject;
-(void) putRequestForCompletedLine:(NSObject *)myObject;
-(void) postRequestForAllWorkDone:(NSObject *)myObject;
-(void) putRequestForApprovedLine:(NSObject *)myObject;
-(void) putRequestFoPartStatus:(NSObject *)myObject;
-(void) postRequestToAddImages:(NSObject *)myObject;
-(void) postRequestToDeleteImages:(NSObject *)myObject;
-(void) getRequestForPDF:(NSObject *)myObject;
-(void) postRequestToAddLine:(NSObject *)myObject;


@end
