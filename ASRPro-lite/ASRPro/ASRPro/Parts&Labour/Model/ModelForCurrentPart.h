//
//  ModelForCurrentPart.h
//  ASRPro
//
//  Created by Kalyani on 05/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForCurrentPart : NSObject{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
}


@property (nonatomic,retain) NSString* mQuality_;
@property (nonatomic,retain) NSString* mQuantity_;
@property (nonatomic,retain) NSString* mPartNumber_;
@property (nonatomic,retain) NSString* mDescription_;
@property (nonatomic,retain) NSString* mLocation_;
@property (nonatomic,retain) NSString* mPrice_;
@property (nonatomic,retain) NSString* mServiceName_;
@property (nonatomic,retain) NSString* mLineID_;
@property(nonatomic,retain) NSString* mPartID_;
@property(nonatomic,retain) NSMutableArray* mQualityArray_;
@property(nonatomic,retain) NSMutableArray* mLocationArray_;
@property(nonatomic,retain) NSMutableDictionary* mPartsDict_;


-(void)resetAllValues;
-(void)setDictToModel:(NSMutableDictionary*)aPartsDict;
-(NSMutableDictionary*)convertModelToDict;
-(NSString*)getLocationName:(int)anId;
@end
