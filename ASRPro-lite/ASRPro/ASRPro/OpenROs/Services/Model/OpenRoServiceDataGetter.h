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


@property(nonatomic,retain)NSMutableArray* mSelectedServicesArray_;


@property(nonatomic,retain)NSMutableArray* mRecommendedServicesArray_;

@property(nonatomic,retain)NSMutableArray* mScheduledServicesArray_;
@property (nonatomic,strong)ModelForSelectedService* mModelForSelectedService_;

@property(nonatomic,retain)AddServicesViewController* mAddServicesViewController_;
@property(nonatomic,retain)NSString * mPdfTitle;
@property(nonatomic,retain)NSString * mPdfURL;
@property(nonatomic,retain)NSString * mPartStatusID_;
-(void)AlphabeticalStaffNames:(NSMutableArray *)anArray ;
-(void)filterLines:(NSMutableArray*)lTempArray;
@end
