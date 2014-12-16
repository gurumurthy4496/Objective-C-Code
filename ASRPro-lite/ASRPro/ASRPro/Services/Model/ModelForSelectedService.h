//
//  ModelForSelectedService.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForSelectedService : NSObject{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
        BOOL isAdd_;
        BOOL isCustomHour_;
    BOOL isCustomPrice_;
    BOOL isCustomParts_;

    BOOL isCustomLabour_;

}
@property(nonatomic,retain) NSMutableDictionary* mServiceDetailsDict_;
@property(nonatomic,retain) NSString* mLineID_;
@property(nonatomic,retain) NSString* mSGCID_;
@property(nonatomic,retain) NSString* mSGID_;
@property(nonatomic,retain) NSString* mAdvisorNotes_;
@property(nonatomic,retain) NSString* mManagerNotes_;
@property(nonatomic,retain) NSString* mPartNotes_;
@property(nonatomic,retain) NSString* mTechnicianNotes_;
@property(nonatomic,retain) NSString* mHours_;
@property(nonatomic,retain) NSString* mPayTypeID_;
@property(nonatomic,retain) NSString* mDetails_;
@property(nonatomic,retain) NSString* mPriceLabor_;
@property(nonatomic,retain) NSString* mPriceParts_;
@property(nonatomic,retain) NSString* mPrice_;
@property(nonatomic,retain) NSString* mComplaint_;
@property(nonatomic,retain) NSString* mCause_;
@property(nonatomic,retain) NSString* mCorrection_;
@property(nonatomic,retain) NSString* mColor_;
@property(nonatomic,retain) NSString* mServiceName_;
@property(nonatomic,retain) NSString* mGroupID_;
@property(nonatomic,retain) NSString* mRONumber_;
@property(nonatomic,retain) NSMutableArray * mServiceImageArray_;
@property(nonatomic) BOOL mRequireAttention_;
@property(nonatomic) BOOL mIsHoursChanged;
@property(nonatomic,retain) NSMutableArray* mServiceHeadingArray_;

/**
 * Method used to initialize class
 */
- (id)init;
-(void)saveAddDictToModel:(NSMutableDictionary*)aServiceLineDict;
-(void)saveDictToModel:(NSMutableDictionary*)aServiceLineDict;
-(NSMutableDictionary*)convertModelToDict;
-(void)resetAllValues;


@end
