//
//  ModelForVehicleHistoryTableView.m
//  ASRPro
//
//  Created by GuruMurthy on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForVehicleHistoryTableView.h"
#import "VehicleHistorySupportWebEngine.h"

@implementation ModelForVehicleHistoryTableView
@synthesize mVehicleHistoryArray_;
@synthesize mOpenROString_;
@synthesize mToshowVehicleHistoryViewOrNot_;

// ----------------------------;
// Method to fill data into mCategoryList_ array;
// ----------------------------;
- (void) setVehicleHistoryCategoryArray {
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    
    
    [self.mVehicleHistoryArray_ enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        VehicleHistoryCategory *category = [[VehicleHistoryCategory alloc] init];
        category.mRONumber = [object objectForKey:@"RONumber"];
        category.mCurrentMode = [[object objectForKey:@"CurrentMode"] integerValue];
        if ([object objectForKey:@"CreateDate"] != nil) {
            NSDate * lDate = [[SharedUtilities sharedUtilities]dateFromDotNetJSONString:[object objectForKey:@"CreateDate"]];
            NSDateFormatter *lDateFormatter = [[NSDateFormatter alloc] init];
            [lDateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
            NSString *dateString = [lDateFormatter stringFromDate:lDate];
            
            RELEASE_NIL(lDateFormatter);
            category.mCreateDate = dateString;
        }
        __block NSMutableArray *lTempROServiceLinesListArray = [[NSMutableArray alloc] init];
        [[object objectForKey:@"RepairOrderLines"] enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
            [lTempROServiceLinesListArray addObject:object1];
        }];
        category.mROServiceLinesListArray = lTempROServiceLinesListArray;
        RELEASE_NIL(lTempROServiceLinesListArray);
        [categoryArray addObject:category];
        RELEASE_NIL(category);
    }];
    
    self.mVehicleHistoryCategoryList_ = categoryArray;
    RELEASE_NIL(categoryArray);
    [[SharedUtilities sharedUtilities] appDelegateInstance].mVehicleHistoryViewController_.mTableView_.sectionHeaderHeight = 35;
    [[SharedUtilities sharedUtilities] appDelegateInstance].mVehicleHistoryViewController_.mTableView_.sectionFooterHeight = 0;
    self.mVehicleHistoryOpenSectionIndex_ = NSNotFound;
}

// ----------------------------;
// Method to fill data into mSectionInfoArray_ array;
// ----------------------------;
- (void) setVehicleHistorysectionInfoArray {
    self.mVehicleHistorySectionInfoArray_ = nil;
    if ((self.mVehicleHistorySectionInfoArray_ == nil)|| ([self.mVehicleHistorySectionInfoArray_ count] != [[[SharedUtilities sharedUtilities] appDelegateInstance].mVehicleHistoryViewController_.mTableView_.dataSource numberOfSectionsInTableView:[[SharedUtilities sharedUtilities] appDelegateInstance].mVehicleHistoryViewController_.mTableView_])) {
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (VehicleHistoryCategory *cat in self.mVehicleHistoryCategoryList_) {
            VehicleHistorySectionInfo *section = [[VehicleHistorySectionInfo alloc] init];
            section.category = cat;
            section.open = NO;
            NSNumber *defaultHeight = [NSNumber numberWithInt:44];
            NSInteger count = [[section.category mROServiceLinesListArray] count];
            for (NSInteger i= 0; i<count; i++) {
                [section insertObject:defaultHeight inRowHeightsAtIndex:i];
            }
            [array addObject:section];
        }
        
        self.mVehicleHistorySectionInfoArray_ = array;
        
    }
}

// ----------------------------;
// Method to present "Vehicle History" veiew controller;
// ----------------------------;
- (void)presentVehicleHistoryViewController :(UIViewController *)aViewController {
    DLog(@"%@",[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController);
    VehicleHistoryViewController *lVehicleHistoryViewController = [[VehicleHistoryViewController alloc] initWithNibName:@"VehicleHistoryViewController" bundle:nil];
    [[[SharedUtilities sharedUtilities] appDelegateInstance] setMVehicleHistoryViewController_:lVehicleHistoryViewController];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mVehicleHistoryViewController_.modalPresentationStyle = UIModalPresentationFormSheet;
    [[SharedUtilities sharedUtilities] appDelegateInstance].mVehicleHistoryViewController_.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController presentViewController:[[[SharedUtilities sharedUtilities] appDelegateInstance] mVehicleHistoryViewController_] animated:YES completion:nil];
}

- (void)dismissVehicleHistoryViewController :(UIViewController *)aViewController {
    [aViewController dismissViewControllerAnimated:YES completion:nil];
}

// ----------------------------;
// Method to show Custom Alert or VehicleHistory;
// ----------------------------;
- (void)methodToShowAlertOrVehicleHistory:(NSUInteger)aSection {
    [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:0.0f];

    DLog(@"%@",mOpenROString_);
    self.mOpenROString_ = [[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:aSection] valueForKey:@"RONumber"];
    self.mCurrentMode_ = [[[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:aSection] valueForKey:@"CurrentMode"] integerValue];
    if((([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mUserRole_ isEqualToString:@"Technician"]) && ([[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:aSection] valueForKey:@"TechnicianID"] == nil)) && self.mCurrentMode_ == 2) {
     [[[[SharedUtilities sharedUtilities]appDelegateInstance] mSearchViewController_ ] hideallview:YES];
        [self showAlertView];
        return;
        
    }else if((([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mUserRole_ isEqualToString:@"Technician"]) && ([[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:aSection] valueForKey:@"TechnicianID"] != nil)) && self.mCurrentMode_ == 2) {
        self.mToshowVehicleHistoryViewOrNot_ = YES;
        [[VehicleHistorySupportWebEngine sharedInstance] putRequestForAssigningROToTechnicianOrAdvisor];

        [[[[SharedUtilities sharedUtilities]appDelegateInstance] mSearchViewController_ ] setcurrentRO:YES];
   //     [[VehicleHistorySupportWebEngine sharedInstance] getRequestForVehicleHistory];
        return;
        
    } else if(self.mCurrentMode_ == 3 || self.mCurrentMode_ == 4 || self.mCurrentMode_ == 6 || self.mCurrentMode_ == 7 ||(([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mUserRole_ isEqualToString:@"Advisor"]) || ([[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ objectAtIndex:aSection] valueForKey:@"AdvisorID"] == nil))) {
        [[[[SharedUtilities sharedUtilities]appDelegateInstance] mSearchViewController_ ] setcurrentRO:NO];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] setButtonState];
        [[VehicleHistorySupportWebEngine sharedInstance] putRequestForAssigningROToTechnicianOrAdvisor];
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelforOpenROSupportEngine_ setMGetServiceReference_:OPENROMAINVIEWCONTROLLER];
        [[[SharedUtilities sharedUtilities]appDelegateInstance].mModelforOpenROSupportEngine_  RequestForGetROLines:self.mOpenROString_];
        if ([[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.topViewController isKindOfClass:[SearchViewController class]]) {
            [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.topViewController.view addGestureRecognizer:[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.panGesture];
            [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:340.0f];
            if ([[SharedUtilities sharedUtilities]appDelegateInstance].mWalkAroundLeftViewController_ == nil) {
                WalkAroundLeftViewController *lViewControler = [[WalkAroundLeftViewController alloc] init];
                [[[SharedUtilities sharedUtilities]appDelegateInstance] setMWalkAroundLeftViewController_:lViewControler];
                [[[SharedUtilities sharedUtilities]appDelegateInstance].mWalkAroundLeftViewController_.view setBackgroundColor:[UIColor ASRProRGBColor:66 Green:66 Blue:68]];
                
            }
            if (![[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.underLeftViewController isKindOfClass:[WalkAroundLeftViewController class]]) {
                [[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.underLeftViewController  = [[SharedUtilities sharedUtilities]appDelegateInstance].mWalkAroundLeftViewController_;
            }
            
        }
    }else {
        [[VehicleHistorySupportWebEngine sharedInstance] putRequestForAssigningROToTechnicianOrAdvisor];
        [[VehicleHistorySupportWebEngine sharedInstance] getRequestForVehicleHistory];
        if ([[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.topViewController isKindOfClass:[SearchViewController class]]) {
            [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.topViewController.view addGestureRecognizer:[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.panGesture];
            [[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_ setAnchorRightRevealAmount:340.0f];
            if ([[SharedUtilities sharedUtilities]appDelegateInstance].mWalkAroundLeftViewController_ == nil) {
                WalkAroundLeftViewController *lViewControler = [[WalkAroundLeftViewController alloc] init];
                [[[SharedUtilities sharedUtilities]appDelegateInstance] setMWalkAroundLeftViewController_:lViewControler];
                [[[SharedUtilities sharedUtilities]appDelegateInstance].mWalkAroundLeftViewController_.view setBackgroundColor:[UIColor ASRProRGBColor:66 Green:66 Blue:68]];
                
            }
            if (![[[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.underLeftViewController isKindOfClass:[WalkAroundLeftViewController class]]) {
                [[SharedUtilities sharedUtilities]appDelegateInstance].mECSlidingViewController_.underLeftViewController  = [[SharedUtilities sharedUtilities]appDelegateInstance].mWalkAroundLeftViewController_;
            }
            
        }
    }
}

#pragma mark --
#pragma mark Show AlertView Method

// ----------------------------;
// Method for showing custom AlertView;
// ----------------------------;

- (void)showAlertView {
    NSString *string = [NSString stringWithFormat:@"Do you want to accept \n RO %@",self.mOpenROString_];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:string delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.mToshowVehicleHistoryViewOrNot_ = buttonIndex;
    if (buttonIndex == 0) {
    }else {
        [[VehicleHistorySupportWebEngine sharedInstance] putRequestForAssigningROToTechnicianOrAdvisor];
    //    [[VehicleHistorySupportWebEngine sharedInstance] getRequestForVehicleHistory];
        [[[[SharedUtilities sharedUtilities]appDelegateInstance] mSearchViewController_ ] setcurrentRO:YES];
    }
}


@end
