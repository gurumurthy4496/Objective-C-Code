//
//  ModelForNotifications.m
//  ASRPro
//
//  Created by GuruMurthy on 05/11/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ModelForNotifications.h"

@implementation ModelForNotifications
@synthesize mAllDataForNotificationsArray_;
@synthesize mNotificationsCount_;

@synthesize mNotificationsArray_;
@synthesize mNotificationButton_;


@synthesize mIsNotificationButtonClicked_;

@synthesize mHasNotificationsForManager_;
@synthesize mHasNotificationsForTechnician_;
@synthesize mHasNotificationsForAdvisor_;

@synthesize mManagerNotificationCount_;
@synthesize mAdvisorNotificationCount_;
@synthesize mTechnicianNotificationCount_;


- (void)initTheDataForNotifications {
    mAllDataForNotificationsArray_ = [[NSMutableArray alloc] init];
    mNotificationsArray_ = [[NSMutableArray alloc] init];
    mNotificationsCount_ = 0;
}

- (void)methodToSetNewNotificationCount :(int)aNotificationCount {
    if (aNotificationCount) {
        self.mNotificationsCount_++;
        [self.mNewNotificationCountButton_ setHidden:FALSE];
    }else {
        [self.mNewNotificationCountButton_ setHidden:TRUE];
    }
    [self.mNewNotificationCountButton_ setTitle:[NSString stringWithFormat:@"%d",self.mNotificationsCount_] forState:UIControlStateNormal];
}


- (void)saveDataForNotifications {
    [[SharedUtilities sharedUtilities] writeObjectToUserDefaults:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mAllDataForNotificationsArray_] forKey:kAllNotificationsArray_Key];
}

#pragma mark --
#pragma mark PublicMethods
- (void)methodToShowNotificationNumber {
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"]) {
        if ([self mIsNotificationButtonClicked_] && ![self mHasNotificationsForAdvisor_]) {
            [[self mNewNotificationCountButton_] setHidden:YES];
        }else {
            [[self mNewNotificationCountButton_] setHidden:NO];
        }
    }else if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]){
        if ([self mIsNotificationButtonClicked_] && ![self mHasNotificationsForTechnician_]) {
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:YES];
        }else {
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:NO];
        }
    }else {
        if ([self mIsNotificationButtonClicked_] && ![self mHasNotificationsForManager_]) {
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:YES];
        }else {
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] mNewNotificationCountButton_] setHidden:NO];
        }
    }
    
}

// ----------------------------;
// Method to Present & Dismiss "Notifications" veiew controller;
// ----------------------------;
- (void)presentNotificationsViewController {
    DLog(@"%@",[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController);
    NotificationsViewController *lNotificationsViewController = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
    [[[SharedUtilities sharedUtilities] appDelegateInstance] setMNotificationsViewController_:lNotificationsViewController];
//    [[SharedUtilities sharedUtilities] appDelegateInstance].mNotificationsViewController_.modalPresentationStyle = UIModalPresentationFormSheet;
    [[SharedUtilities sharedUtilities] appDelegateInstance].mNotificationsViewController_.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController presentViewController:[[[SharedUtilities sharedUtilities] appDelegateInstance] mNotificationsViewController_] animated:YES completion:nil];
}

- (void)dismissNotificationsViewController {
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)setTopNavigationBarHiddenForNotificationsScreen :(UIView *)aView Hidden:(BOOL)aHidden Button:(UIButton *)aButton {
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController.view.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *view = (UIView *)object;
        if (view.tag == 1) {
            
            NSData *tempArchiveView = [NSKeyedArchiver archivedDataWithRootObject:view];
            UIView *viewOfSelf = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveView];
            
            [aView addSubview:viewOfSelf];
            
            
            __block UIImageView *imageView;
            [viewOfSelf.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
                DLog(@"%@",object1);

                UIButton *button = (UIButton *)object1;
                imageView = (UIImageView *)object1;
//                if (button.hidden && aHidden) {
//                    *stop = YES;
//                    *stop1 = YES;
//                    return ;
//                }
                if (button.tag == 1 || button.tag == 2 || button.tag == 3 || button.tag == 4 || button.tag == 101) {
                    [button setHidden:aHidden];
                }else if(button.tag == 5) {
                    [button addTarget:self action:@selector(logoutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                }else if(button.tag == 8) {
                    [button setSelected:NO];
                }else if(imageView.tag == 9) {
                    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]) {
                        [imageView setHidden:aHidden];
                        if (aHidden) {//Add TempButton(<Search) on the headerview
                            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
                            CGRect frame = imageView.frame;
                            frame.size.width -= 30;
                            frame.origin.x -= 20;
                            [backButton setFrame:frame];
                            UIImage *backArrowImage = nil;
                            backArrowImage = [UIImage imageNamed:@"back-arrow"];
                            [backButton setTitle:@" Back" forState:UIControlStateNormal];
                            [backButton setTitle:@" Back" forState:UIControlStateSelected];
                            [backButton setImage:backArrowImage forState:UIControlStateNormal];
                            [backButton setImage:backArrowImage forState:UIControlStateSelected];
                            [backButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
                            [backButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateSelected];
                            [backButton.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameOpenSansKey]];
                            [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 2)];
                            [backButton addTarget:self action:@selector(backButtonActionForNotifications:) forControlEvents:UIControlEventTouchUpInside];
                            [backButton setTag:101];
                            [viewOfSelf addSubview:backButton];
                            [viewOfSelf.subviews enumerateObjectsUsingBlock:^(id object3, NSUInteger index3, BOOL *stop3) {
                                DLog(@"%@",object3);
                            }];
                        }else {
                            [aButton setHidden:YES];
                            [aButton removeFromSuperview];
                        }
                    }else {
                        [imageView setHidden:aHidden];
                        if (aHidden) {//Add TempButton(<Search) on the headerview
                            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
                            CGRect frame = imageView.frame;
                            frame.size.width -= 30;
                            frame.origin.x -= 20;
                            [backButton setFrame:frame];
                            UIImage *backArrowImage = nil;
                            backArrowImage = [UIImage imageNamed:@"back-arrow"];
                            [backButton setTitle:@" Back" forState:UIControlStateNormal];
                            [backButton setTitle:@" Back" forState:UIControlStateSelected];
                            [backButton setImage:backArrowImage forState:UIControlStateNormal];
                            [backButton setImage:backArrowImage forState:UIControlStateSelected];
                            [backButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
                            [backButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateSelected];
                            [backButton.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameOpenSansKey]];
                            [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 2)];
                            [backButton addTarget:self action:@selector(backButtonActionForNotifications:) forControlEvents:UIControlEventTouchUpInside];
                            [backButton setTag:101];
                            [viewOfSelf addSubview:backButton];
                            [viewOfSelf.subviews enumerateObjectsUsingBlock:^(id object3, NSUInteger index3, BOOL *stop3) {
                                DLog(@"%@",object3);
                            }];
                        }else {
                            [aButton setHidden:YES];
                            [aButton removeFromSuperview];
                        }
                    }
                }
            }];
        }
    }];
}

- (IBAction)backButtonActionForNotifications:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self setTopNavigationBarHiddenForNotificationsScreen:button.superview.superview Hidden:YES Button:button];
    [self dismissNotificationsViewController];

}

- (IBAction)logoutButtonAction:(id)sender {
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mChangeUsernameAndAcronymTextColor_ = self;
    [self changeTheTextForUsernameAndAcronymLabel:sender];
    [self showLogoutView];
}

#pragma mark --
#pragma mark Private Methods
/**
 * Change the text color for the username and acronym lables.
 */
-(void)changeTheTextForUsernameAndAcronymLabel:(id)aButton {
    UIButton *logoutbutton = aButton;
    UIView *lView = logoutbutton.superview;
    __block UIButton *lButton;
    __block UILabel *lUsername;
    __block UILabel *lAcronym;
    [lView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop){
        UIView *lTempView = object;
        if (lTempView.tag == 5) {
            lButton = (UIButton *)lTempView;
            lButton.selected = !lButton.selected;
        }else if (lTempView.tag == 6) {
            lUsername = (UILabel *)lTempView;
        }else if (lTempView.tag == 7) {
            lAcronym = (UILabel *)lTempView;
        }
    }];
    if (lButton.selected) {
        lUsername.textColor = [UIColor whiteColor];
        lAcronym.textColor = [UIColor whiteColor];
    }else {
        lUsername.textColor = [UIColor ASRProBlueColor];
        lAcronym.textColor = [UIColor ASRProBlueColor];
    }
}

/**
 * Show the Logout button.
 */
- (void)showLogoutView {
    if([[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view superview]){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view removeFromSuperview];
    }
    
    if ([[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_ == nil) {
        LogoutViewController *lViewController = [[LogoutViewController alloc]initWithNibName:@"LogoutViewController" bundle:nil];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_ =lViewController;
    }
    //If LogoutViewController is not a superview then add to Subview.
    
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view setBackgroundColor:[UIColor clearColor]];
    
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mNotificationsViewController_.view addSubview:[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mNotificationsViewController_.view bringSubviewToFront:[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view];
}

@end
