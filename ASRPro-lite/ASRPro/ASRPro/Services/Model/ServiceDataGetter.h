//
//  ServiceDataGetter.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelForSelectedService.h"
#import "AddServicesViewController.h"

@interface ServiceDataGetter : NSObject{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
}


@property(nonatomic,retain)NSMutableArray* mAllServicesArray_;
@property(nonatomic,retain)NSMutableArray* mSelectedServicesArray_;


@property(nonatomic,retain)NSMutableArray* mRecommendedServicesArray_;

@property(nonatomic,retain)NSMutableArray* mScheduledServicesArray_;
@property (nonatomic,strong)ModelForSelectedService* mModelForSelectedService_;

@property(nonatomic,retain)NSMutableArray* mServicePackagesArray_;
@property(nonatomic,retain)AddServicesViewController* mAddServicesViewController_;

@property(nonatomic,retain)NSString* mTax;
@property(nonatomic,retain)NSString* mShopCharges;
@property(nonatomic,retain)NSString* mServicesScheduledTotal;
@property(nonatomic,retain)NSString* mRecommendedServicesTotal;
@property(nonatomic,retain)NSString* mFinalServicesTotall;


-(void)AlphabeticalStaffNames:(NSMutableArray *)anArray ;
//-(void)FilterRecommendedCurrentServices;
-(void)loadServicePackages;
-(void)filterServicepackages;
-(void)filterLines:(NSMutableArray*)lTempArray;
@end
