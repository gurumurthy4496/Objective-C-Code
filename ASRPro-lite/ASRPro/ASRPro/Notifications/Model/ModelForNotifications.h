//
//  ModelForNotifications.h
//  ASRPro
//
//  Created by GuruMurthy on 05/11/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChangeUsernameAndAcronymTextColor.h"

@interface ModelForNotifications : NSObject <ChangeUsernameAndAcronymTextColor>
@property (nonatomic, retain) NSMutableArray *mAllDataForNotificationsArray_;
@property (nonatomic, readwrite) int mNotificationsCount_;
@property (nonatomic, retain) NSMutableArray *mNotificationsArray_;
@property (nonatomic, retain) UIButton *mNotificationButton_;
@property (nonatomic, retain) UIButton *mNewNotificationCountButton_;
@property (nonatomic, readwrite) BOOL mIsNotificationButtonClicked_;
@property (nonatomic, readwrite) BOOL mHasNotificationsForManager_;
@property (nonatomic, readwrite) BOOL mHasNotificationsForTechnician_;
@property (nonatomic, readwrite) BOOL mHasNotificationsForAdvisor_;
@property (nonatomic, readwrite) int mManagerNotificationCount_;
@property (nonatomic, readwrite) int mAdvisorNotificationCount_;
@property (nonatomic, readwrite) int mTechnicianNotificationCount_;


- (void)setTopNavigationBarHiddenForNotificationsScreen :(UIView *)aView Hidden:(BOOL)aHidden Button:(UIButton *)aButton;
- (void)methodToSetNewNotificationCount :(int)aNotificationCount;
- (void)initTheDataForNotifications;
- (void)presentNotificationsViewController;
- (void)dismissNotificationsViewController;
- (void)saveDataForNotifications;
- (void)methodToShowNotificationNumber;
@end
