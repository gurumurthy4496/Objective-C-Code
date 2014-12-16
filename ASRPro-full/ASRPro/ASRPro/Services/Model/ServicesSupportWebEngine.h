//
//  ServicesSupportWebEngine.h
//  ASRPro
//
//  Created by Kalyani on 10/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelForServiceRequestWebEngine.h"

@interface ServicesSupportWebEngine : NSObject{
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
-(void)getRequestForServicesPackage:(NSObject *)myObject;
-(void)putRequestForPartsNotNeededLine:(NSObject*)myObject;
-(void)getRequestForRODetails:(NSObject *)myObject;
-(void)getRequestForServicesForPullToRefresh:(NSObject *)myObject;

@end
