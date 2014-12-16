//
//  ModelForEditCustomerScreen.h
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForEditCustomerScreen : NSObject {
    
    AppDelegate *mAppDelegate_;
}

@property (strong, nonatomic) NSString *mSalutation_;
@property (strong, nonatomic) NSString *mFirstName_;
@property (strong, nonatomic) NSString *mMiddleName_;
@property (strong, nonatomic) NSString *mLastName_;
@property (strong, nonatomic) NSString *mDOB_;
@property (strong, nonatomic) NSString *mAnniversaryDate_;
@property (strong, nonatomic) NSString *mHomePhone_;
@property (strong, nonatomic) NSString *mWorkPhone_;
@property (strong, nonatomic) NSString *mMobilePhone_;
@property (strong, nonatomic) NSString *mEmail_;
@property (strong, nonatomic) NSString *mAddress1_;
@property (strong, nonatomic) NSString *mAddress2_;
@property (strong, nonatomic) NSString *mCountry_;
@property (strong, nonatomic) NSString *mState_;
@property (strong, nonatomic) NSString *mCity_;
@property (strong, nonatomic) NSString *mZipCode_;
@property (strong, nonatomic) NSString *mCustomerNumber_;
@property (strong, nonatomic) NSString *mRONumber_;
@property (nonatomic) BOOL mSMS_;
@property (nonatomic) BOOL mContactEmail_;
@property (nonatomic) BOOL mPhone_;
@property (nonatomic) BOOL mIsBeginVehicle_;
/*
 * mCustomerID_ is used to hold the customer Id
 */
@property (nonatomic,retain)NSString *mCustomerID_;

-(void)resetallData;
- (void)setValues:(NSMutableDictionary*)aCustomerDictionary;
@end
