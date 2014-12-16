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

/**
 * string to store part Quality
 */
@property (nonatomic,retain) NSString* mQuality_;

/**
 * string to store part Quantity
 */
@property (nonatomic,retain) NSString* mQuantity_;

/**
 * string to store part Number
 */
@property (nonatomic,retain) NSString* mPartNumber_;

/**
 * string to store part description
 */
@property (nonatomic,retain) NSString* mDescription_;

/**
 * string to store part Location
 */
@property (nonatomic,retain) NSString* mLocation_;

/**
 * string to store part Price
 */
@property (nonatomic,retain) NSString* mPrice_;

/**
 * string to store Service Bame
 */
@property (nonatomic,retain) NSString* mServiceName_;

/**
 * string to store part Line ID
 */
@property (nonatomic,retain) NSString* mLineID_;

/**
 * string to store part ID
 */
@property(nonatomic,retain) NSString* mPartID_;

/**
 * array consists of quality types
 */
@property(nonatomic,retain) NSMutableArray* mQualityArray_;

/**
 * array consists of quality types
 */
@property(nonatomic,retain) NSMutableArray* mPartNumbersArray_;

/**
 * array consists of Locations
 */
@property(nonatomic,retain) NSMutableArray* mLocationArray_;

/**
 * dictionary to store part details
 */
@property(nonatomic,retain) NSMutableDictionary* mPartsDict_;
/**
 * dictionary consists of quality types
 */
@property(nonatomic,retain) NSMutableDictionary* mQualityDict_;
/**
 * dictionary consists of quality types
 */
@property(nonatomic,retain) NSMutableDictionary* mPartNumberDict_;
/**
 * dictionary consists of quality types
 */
@property(nonatomic,retain) NSMutableDictionary* mLocationDict_;


/**
 * method to set empty strings to modal
 */
-(void)resetAllValues;

/**
 * method to set dictionary values to modal
 */
-(void)setDictToModel:(NSMutableDictionary*)aPartsDict;

/**
 * method to convert modal values to dictionary
 */
-(NSMutableDictionary*)convertModelToDict;

/**
 * returns Location name for LocationID
 */
-(NSMutableDictionary*)getLocationDict:(int)anId;
-(NSMutableDictionary*)getQualityDict:(int)anId;
-(NSMutableArray*)getPartArray:(NSString*)aLineID;
@end
