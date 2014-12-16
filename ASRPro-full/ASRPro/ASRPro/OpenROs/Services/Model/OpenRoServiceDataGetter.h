//
//  OpenRoServiceDataGetter.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenRoServiceDataGetter : NSObject{
@public
/**
 * AppDelegate object creating
 */
AppDelegate *mAppDelegate_;
}

/**
 * array instance to store all lines added to a array
 */
@property(nonatomic,retain)NSMutableArray* mSelectedServicesArray_;

/**
 *array instance to store recommended lines added to a array
 */
@property(nonatomic,retain)NSMutableArray* mRecommendedServicesArray_;

/**
 * array instance to store primary lines added to a array
 */
@property(nonatomic,retain)NSMutableArray* mScheduledServicesArray_;

/**
 * instance for ModelForSelectedService class
 */
@property (nonatomic,strong)ModelForSelectedService* mModelForSelectedService_;

/**
 * instance for AddServicesViewController class
 */
@property(nonatomic,retain)AddServicesViewController* mAddServicesViewController_;

/**
 * string for storing PDF view Title for print
 */
@property(nonatomic,retain)NSString * mPdfTitle;

/**
 * string for storing PDF URL for print
 */
@property(nonatomic,retain)NSString * mPdfURL;

/**
 * string for storing parts status for an RO
 */
@property(nonatomic,retain)NSString * mPartStatusID_;

/**
 * Method to initialise objects
 */
-(void)initTheObjects;

/**
 * Method to filter recommended and primary lines
 * @param array to be filtered
 */
-(void)filterLines:(NSMutableArray*)aServicesArray;

@end
