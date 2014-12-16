    //
//  UIView+CustomHeaderViewFull.m
//  ASRPro
//
//  Created by GuruMurthy on 29/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "UIView+CustomHeaderViewFull.h"
#import "VehicleHistorySupportWebEngine.h"
#import "WalkAroundSupportWebEngine.h"
#import "CheckInSupportWebEngine.h"

@implementation UIView (CustomHeaderViewFull)

UIView *mHeaderView_;
UIImageView *mASRProLogoImageView_;
UIButton *mSearchButton_;
UIButton *mWalkAroundButton_;
UIButton *mServicesButton_;
UIButton *mCheckInButton_;
UIButton *mLoginUserDetailsButton_;
UILabel *mUsernameLabel_;
UILabel *mAcronymLabel_;
UIButton *mNotificationButton_;
UIViewController *mViewController_;

#pragma mark --
#pragma mark CustomHeaderViewFull
- (void)customHeaderViewFull :(id)aViewController SelectedButton:(NSString *)aSelectedButton {
    mViewController_ = (UIViewController *)aViewController;
        // This block is for Lite.
        // Header View with the frame and set the tag to 1
        mHeaderView_ = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 1024, 63)];
        [mHeaderView_ setTag:1];
        // Set the Imageview with the ASR Pro Logo.
        UIImage *lASRProLogoImage = [UIImage imageNamed:@"ASRProIcon"];
        UIImageView *lASRProLogoImageView = [[UIImageView alloc] init];
        lASRProLogoImageView.tag = 9;
        [lASRProLogoImageView setFrame:CGRectMake(20, (mHeaderView_.frame.size.height - lASRProLogoImage.size.height)/2, 148, 45)];
        [lASRProLogoImageView setImage:lASRProLogoImage];
        mASRProLogoImageView_ = lASRProLogoImageView;
        // Search Button
        UIButton *lSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lSearchButton setFrame:CGRectMake((mHeaderView_.frame.size.width - (162 + 175 + 170))/2, 10, 162, 43)];
        [lSearchButton setTag:1];
        [lSearchButton setTitle:@"Search" forState:UIControlStateNormal];
        [lSearchButton setTitle:@"Search" forState:UIControlStateSelected];
        [lSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [lSearchButton.titleLabel setFont:[UIFont regularFontOfSize:15.0 fontKey:kFontNameHelveticaNeueKey]];
        [lSearchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        [lSearchButton setBackgroundImage:[UIImage imageNamed:@"searchbutton_inactive_lite"] forState:UIControlStateNormal];
        [lSearchButton setBackgroundImage:[UIImage imageNamed:@"searchbutton_active_lite"] forState:UIControlStateSelected];
        [lSearchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        mSearchButton_ = lSearchButton;
        // Walk-Around Button
        UIButton *lWalkAroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lWalkAroundButton setFrame:CGRectMake((mSearchButton_.frame.origin.x + mSearchButton_.frame.size.width) - 12, 10, 175, 43)];
        [lWalkAroundButton setTag:2];
        [lWalkAroundButton setTitle:@"Walk-Around" forState:UIControlStateNormal];
        [lWalkAroundButton setTitle:@"Walk-Around" forState:UIControlStateSelected];
        [lWalkAroundButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lWalkAroundButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [lWalkAroundButton.titleLabel setFont:[UIFont regularFontOfSize:15.0 fontKey:kFontNameHelveticaNeueKey]];
        [lWalkAroundButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [lWalkAroundButton setBackgroundImage:[UIImage imageNamed:@"walkaroundbutton_inactive_lite"] forState:UIControlStateNormal];
        [lWalkAroundButton setBackgroundImage:[UIImage imageNamed:@"walkaroundbutton_active_lite"] forState:UIControlStateSelected];
        [lWalkAroundButton addTarget:self action:@selector(walkAroundButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        mWalkAroundButton_ = lWalkAroundButton;
   
        // Check-IN Button
        UIButton *lCheckInButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lCheckInButton setFrame:CGRectMake((mWalkAroundButton_.frame.origin.x + mWalkAroundButton_.frame.size.width) - 12, 10, 170, 43)];
        [lCheckInButton setTag:3];
        [lCheckInButton setTitle:@"Check-In" forState:UIControlStateNormal];
        [lCheckInButton setTitle:@"Check-In" forState:UIControlStateSelected];
        [lCheckInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lCheckInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [lCheckInButton.titleLabel setFont:[UIFont regularFontOfSize:15.0 fontKey:kFontNameHelveticaNeueKey]];
        [lCheckInButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
        [lCheckInButton setBackgroundImage:[UIImage imageNamed:@"checkinbutton_inactive_lite"] forState:UIControlStateNormal];
        [lCheckInButton setBackgroundImage:[UIImage imageNamed:@"checkinbutton_active_lite"] forState:UIControlStateSelected];
        [lCheckInButton addTarget:self action:@selector(checkInButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        mCheckInButton_ = lCheckInButton;
        
        // Login Button
        UIImage *lLoginUserDetailsImage = [UIImage imageNamed:@"logout"];
        UIButton *lLoginUserDetailsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lLoginUserDetailsButton setFrame:CGRectMake(840, (mHeaderView_.frame.size.height - lLoginUserDetailsImage.size.height)/2, lLoginUserDetailsImage.size.width, lLoginUserDetailsImage.size.height)];
        [lLoginUserDetailsButton setTag:5];
        [lLoginUserDetailsButton.titleLabel setFont:[UIFont regularFontOfSize:15.0 fontKey:kFontNameHelveticaNeueKey]];
        [lLoginUserDetailsButton setBackgroundImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
        [lLoginUserDetailsButton setBackgroundImage:[UIImage imageNamed:@"LogoutSelected"] forState:UIControlStateSelected];
        [lLoginUserDetailsButton addTarget:self action:@selector(logoutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        mLoginUserDetailsButton_ = lLoginUserDetailsButton;
        // Username label
        UILabel *lUsernameLabel = [[UILabel alloc] init];
        [lUsernameLabel setFrame:CGRectMake(850, 15, 100, 21)];
        [lUsernameLabel setTag:6];
        [lUsernameLabel setText:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeName_];
        [lUsernameLabel setFont:[UIFont regularFontOfSize:12.0 fontKey:kFontNameHelveticaNeueKey]];
        [lUsernameLabel setTextColor:[UIColor ASRProBlueColor]];
        [lUsernameLabel setBackgroundColor:[UIColor clearColor]];
        mUsernameLabel_ = lUsernameLabel;
        // Acronym label
        UILabel *lAcronymLabel = [[UILabel alloc] init];
        [lAcronymLabel setFrame:CGRectMake(850, 30, 100, 21)];
        [lAcronymLabel setTag:7];
        [lAcronymLabel setText:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mUserRole_];
        [lAcronymLabel setFont:[UIFont regularFontOfSize:12.0 fontKey:kFontNameHelveticaNeueKey]];
        [lAcronymLabel setTextColor:[UIColor ASRProBlueColor]];
        [lAcronymLabel setBackgroundColor:[UIColor clearColor]];
        mAcronymLabel_ = lAcronymLabel;
        // Notification Button
        UIImage *lNotificationImage = [UIImage imageNamed:@"notificationbutton"];
        UIButton *lNotificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lNotificationButton setFrame:CGRectMake(980, (mHeaderView_.frame.size.height - lNotificationImage.size.height)/2, lNotificationImage.size.width, lNotificationImage.size.height)];
        [lNotificationButton setTag:8];
        [lNotificationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [lNotificationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [lNotificationButton setBackgroundImage:[UIImage imageNamed:@"notificationbutton"] forState:UIControlStateNormal];
        [lNotificationButton setBackgroundImage:[UIImage imageNamed:@"notificationbutton"] forState:UIControlStateSelected];
        [lNotificationButton addTarget:self action:@selector(notifiationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        mNotificationButton_ = lNotificationButton;
        
        
        
        
        // Adding controls to HeaderView
        [mHeaderView_ addSubview:mASRProLogoImageView_];
        [mHeaderView_ addSubview:mSearchButton_];
        [mHeaderView_ addSubview:mWalkAroundButton_];
        [mHeaderView_ addSubview:mServicesButton_];
        [mHeaderView_ addSubview:mCheckInButton_];
        [mHeaderView_ addSubview:mLoginUserDetailsButton_];
        [mHeaderView_ addSubview:mUsernameLabel_];
        [mHeaderView_ addSubview:mAcronymLabel_];
        [mHeaderView_ addSubview:mNotificationButton_];
        
        //Notifications count number button
        UIImage *lImage = [UIImage imageNamed:@"redcircle"];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] setMNotificationButton_:lNotificationButton];
        UIButton *lTempButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lTempButton setFrame:CGRectMake(lNotificationButton.frame.origin.x + 15, lNotificationButton.frame.origin.y - 5, lImage.size.width, lImage.size.height)];
        [lTempButton setBackgroundImage:lImage forState:UIControlStateNormal];
        [lTempButton setBackgroundImage:lImage forState:UIControlStateSelected];
        [lTempButton.titleLabel setFont:[UIFont regularFontOfSize:12 fontKey:kFontNameHelveticaNeueKey]];
        [lTempButton setTag:1001];
        [lTempButton setTitle:[NSString stringWithFormat:@"%d",[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_].mNotificationsCount_] forState:UIControlStateNormal];
        [lTempButton setTitle:[NSString stringWithFormat:@"%d",[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_].mNotificationsCount_] forState:UIControlStateSelected];
        [lTempButton addTarget:self action:@selector(notifiationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        lTempButton.layer.cornerRadius = 10; // this value vary as per your desire
        lTempButton.clipsToBounds = YES;
        DLog(@"IS NOTIFICAITON BUTTON HIDDEN :-%@",lTempButton);
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] setMNewNotificationCountButton_:lTempButton];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForNotifications_ methodToShowNotificationNumber];
        [mNotificationButton_.superview addSubview:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_].mNewNotificationCountButton_];
        [mNotificationButton_ bringSubviewToFront:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_].mNewNotificationCountButton_];
        
        // Adding HeaderView to ViewController
        [mHeaderView_ setBackgroundColor:[UIColor whiteColor]];
        [mViewController_.view addSubview:mHeaderView_];
        // Setting the selected button to YES
        if ([aSelectedButton isEqualToString:@"Search"]) {
            [mSearchButton_ setSelected:YES];
        }else if ([aSelectedButton isEqualToString:@"Walk-Around"]) {
            [mWalkAroundButton_ setSelected:YES];
        }else if ([aSelectedButton isEqualToString:@"Services"]) {
            [mServicesButton_ setSelected:YES];
        }else if ([aSelectedButton isEqualToString:@"Check-In"]) {
            [mCheckInButton_ setSelected:YES];
        }
}

#pragma mark --
#pragma mark CustomHeaderViewLight
- (void)customHeaderViewLight {
    
}

#pragma mark --
#pragma mark CustomHeaderViewMethods
- (IBAction)searchButtonAction:(id)sender {
    if ([mViewController_ isKindOfClass:[WalkAroundViewController class]] || [mViewController_ isKindOfClass:[ServicesViewController class]] || [mViewController_ isKindOfClass:[CheckInViewController class]]) {
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchViewController_];
        mViewController_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchViewController_;
    }else {
        return;
    }
}

- (IBAction)walkAroundButtonAction:(id)sender {
    if ([mViewController_ isKindOfClass:[SearchViewController class]] || [mViewController_ isKindOfClass:[FinishInspectionViewController class]] || [mViewController_ isKindOfClass:[CheckInViewController class]]) {
        // IF Condition :If the user doesn't click the row in IN-Process list then no action should perform.
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mTempPRE_RONumber length] == 0) {
            return;
        }
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mTempPRE_RONumber isEqualToString:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mPRE_RONumber]) {
            [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_->isROChanged=FALSE;
            if ([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_ == nil) {
                WalkAroundViewController *lViewController = [[WalkAroundViewController alloc] initWithNibName:@"WalkAroundViewController" bundle:nil];
                [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_ = lViewController;
           }
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_];
            mViewController_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_;
    
        }else {
            [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_->isROChanged=TRUE;

            [self getRODetails];

        }
        return;
    }else if ([mViewController_ isKindOfClass:[WalkAroundViewController class]]) {
        return;
    }else {
         mViewController_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_;
         [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_];
    }
}

- (IBAction)checkInButtonAction:(id)sender {
    if ([mViewController_ isKindOfClass:[WalkAroundViewController class]]) {
        [self getInspectionCautionedOrFailedDetails];
    }else if ([mViewController_ isKindOfClass:[CheckInViewController class]] || [mViewController_ isKindOfClass:[SearchViewController class]]) {
        return;
    }else {
        mViewController_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_;
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_];
    }
}

- (IBAction)logoutButtonAction:(id)sender {
    [[SharedUtilities sharedUtilities] appDelegateInstance].mChangeUsernameAndAcronymTextColor_ = self;
    [self changeTheTextForUsernameAndAcronymLabel:sender];
    [self showLogoutView];

}

- (IBAction)notifiationButtonAction:(id)sender {
    
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"]) {
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForNotifications_.mHasNotificationsForAdvisor_ = FALSE;
    }else  if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Manager"]) {
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForNotifications_.mHasNotificationsForManager_ = FALSE;
    }else {
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForNotifications_.mHasNotificationsForTechnician_ = FALSE;

    }
    
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForNotifications_] presentNotificationsViewController];
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
    
    if ([[[[[SharedUtilities sharedUtilities] appDelegateInstance] mECSlidingViewController_] topViewController] isKindOfClass:[SearchViewController class]]) {
        mViewController_ = [[[[SharedUtilities sharedUtilities] appDelegateInstance] mECSlidingViewController_] topViewController];
    }
    
    [mViewController_.view addSubview:[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view];
    [mViewController_.view bringSubviewToFront:[[SharedUtilities sharedUtilities] appDelegateInstance].mLogoutViewController_.view];
}

- (void)getRODetails {
    [[WalkAroundSupportWebEngine walkAroundSharedInstance] getRequestForRODetails];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mOnSuccessDelegate_ = self;
}

- (void)getInspectionCautionedOrFailedDetails {
    [[CheckInSupportWebEngine checkInSharedInstance] getRequestForInspectionCautionedOrFailed];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mOnSuccessDelegate_ = self;
}

-(void)OnsuccessResponseForRequest {
    if ([mViewController_ isKindOfClass:[SearchViewController class]] || [mViewController_ isKindOfClass:[FinishInspectionViewController class]] || [mViewController_ isKindOfClass:[CheckInViewController class]]) {
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_->isROChanged=TRUE;
        
        //  if ([[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_ == nil) {
        WalkAroundViewController *lViewController = [[WalkAroundViewController alloc] initWithNibName:@"WalkAroundViewController" bundle:nil];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_ = lViewController;
        // }
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_];
        mViewController_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_;
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_ setDataForSelectedVehicleTypes];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_ setMPRE_RONumber:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mTempPRE_RONumber];
    }
    else if ([mViewController_ isKindOfClass:[WalkAroundViewController class]]) {
        if ([[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_ == nil) {
            CheckInViewController *lViewController = [[CheckInViewController alloc] initWithNibName:@"CheckInViewController" bundle:nil];
            [[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_ = lViewController;
        }
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_];
        mViewController_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mCheckInViewController_;
    }else if ([mViewController_ isKindOfClass:[ServicesViewController class]]) {
    }
}


-(void)pushToOpenROs:(NSString*)aRONumber {
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchViewController_];
    mViewController_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchViewController_;
    for (UIView *lview in [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.view.subviews) {
        if([lview isKindOfClass:[UIButton class]]) {
            if (lview.tag == 3) {
                [[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_ segmentBtnAction:(UIButton *)lview];
                [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_->mselectedSegment_ = 3;
            }
        }
    }
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.mOpenROTableView_ reloadData];
    NSIndexPath *lSelectedIndexPath;
    for (int i=0; i<[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ count]; i++) {
        if ([aRONumber isEqualToString:[[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:i] objectForKey:@"RONumber"] ]) {
            lSelectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        }
    }
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.mOpenROTableView_ selectRowAtIndexPath:lSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.mOpenROTableView_ onSelectionOfOpenRO:lSelectedIndexPath.row];
}


@end
