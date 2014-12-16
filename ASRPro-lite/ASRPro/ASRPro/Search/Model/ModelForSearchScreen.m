//
//  ModelForSearchScreen.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/10/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForSearchScreen.h"

@implementation ModelForSearchScreen

- (void)getInprocessListFromRepairOrders {

    int CurrentMode = 9;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.CurrentMode = %d",CurrentMode];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mInprocessListData_ = (NSMutableArray*)[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mRepairOrdersData_ filteredArrayUsingPredicate:predicate];
    DLog(@"Inprocess List : %@",[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mInprocessListData_);
    predicate = [NSPredicate predicateWithFormat:@"NOT SELF.CurrentMode = %d",CurrentMode];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListData_ = (NSMutableArray*)[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mRepairOrdersData_ filteredArrayUsingPredicate:predicate];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ = [[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListData_ mutableCopy];
}

- (NSString*)getAdvisorForOpenRO:(int)advisorID {
    NSString *lAdvisorStr;
        for (int j=0; j<[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] count]; j++) {
            if (advisorID == [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"ID"] intValue]) {
                    lAdvisorStr = [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"FirstName"];
            }
    }
    DLog(@"Advisors name %@",lAdvisorStr);
    lAdvisorStr = lAdvisorStr!=nil?lAdvisorStr:@"";
    return lAdvisorStr;
}

- (NSString*)getTechnicianForOpenRO:(int)technicianID {
    NSString *lTechnicianStr;
        for (int j=0; j<[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] count]; j++) {
            if (technicianID == [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"ID"] intValue]) {
                lTechnicianStr = [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"FirstName"];
            }
    }
    DLog(@"Technician name %@",lTechnicianStr);
    lTechnicianStr = lTechnicianStr!=nil?lTechnicianStr:@"";
    return lTechnicianStr;
}

- (void)setTopNavigationBarHiddenForOpenROScreen :(UIView *)aView Hidden:(BOOL)aHidden Button:(UIButton *)aButton {
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] setTempararyPRERONumber:@""];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] setPRERONumber:@""];
    [aView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *view = (UIView *)object;
        if (view.tag == 1) {
            __block UIImageView *imageView;
            [view.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
                UIButton *button = (UIButton *)object1;
                imageView = (UIImageView *)object1;
                if (button.hidden && aHidden) {
                    *stop = YES;
                    *stop1 = YES;
                    return ;
                }
                if (button.tag == 1 || button.tag == 2 || button.tag == 3 || button.tag == 4) {
                    [button setHidden:aHidden];
                }else if(imageView.tag == 9){
                    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]) {
                        [imageView setHidden:!aHidden];
                    }else {
                        [imageView setHidden:NO];
                        if (aHidden) {//Add TempButton(<Search) on the headerview
                            UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
                            CGRect frame = imageView.frame;
                            frame.size.width -= 30;
                            frame.origin.x -= 20;
                            [searchButton setFrame:frame];
                            UIImage *backArrowImage = nil;
                            backArrowImage = [UIImage imageNamed:@"back-arrow"];
                            [searchButton setTitle:@" Search" forState:UIControlStateNormal];
                            [searchButton setTitle:@" Search" forState:UIControlStateSelected];
                            [searchButton setImage:backArrowImage forState:UIControlStateNormal];
                            [searchButton setImage:backArrowImage forState:UIControlStateSelected];
                            [searchButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
                            [searchButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateSelected];
                            [searchButton.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameOpenSansKey]];
                            [searchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 2)];
                            [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                            [searchButton setTag:101];
//                            [view addSubview:searchButton];
                            [view.subviews enumerateObjectsUsingBlock:^(id object3, NSUInteger index3, BOOL *stop3) {
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

- (IBAction)searchButtonAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self setTopNavigationBarHiddenForOpenROScreen:button.superview.superview Hidden:NO Button:button];
    for (UIView *lview in [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.view.subviews) {
        if([lview isKindOfClass:[UIButton class]]) {
            if(((UIButton *)lview).tag==2){
                [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_->mselectedSegment_ = lview.tag;
                [(UIButton *)lview setSelected:YES];
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] segmentBtnAction:(UIButton *)lview];
                [(UIButton *)lview setBackgroundColor:[UIColor ASRProBlueColor]];
            } else {
                [(UIButton *)lview setSelected:NO];
                [(UIButton *)lview setBackgroundColor:[UIColor whiteColor]];
            }
            [(UIButton *)lview setEnabled:YES];
        }
    }
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_] setHidden:TRUE];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROFilterButton_] setHidden:TRUE];

    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mAppointmentAndInprocessTableView_] setHidden:FALSE];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mAppointmentAndInprocessTableView_] reloadData];
}

- (void)filterTheDataBasedOnmode :(int)aSelectedMode {
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mSearhBar_] setText:@""];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] resetAllData];
    if (aSelectedMode == 0) {
        [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ = [[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListData_ mutableCopy];
         [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_] reloadData];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] enableOrdisableEditCustomerOrVehiclebtn];
        return;
    }
    NSMutableArray *mRepairOrderCurrentModeListArray_ = [[NSMutableArray alloc] init];
    
    NSMutableArray * mRepairOrderListMutableCopy_ = [[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListData_ mutableCopy];
    
    NSPredicate *lCurrentModePredicate = [NSPredicate predicateWithFormat:@"CurrentMode=%d",aSelectedMode];
    
    NSArray *lTempArray = [mRepairOrderListMutableCopy_ filteredArrayUsingPredicate:lCurrentModePredicate];
    
    [mRepairOrderCurrentModeListArray_ addObjectsFromArray:lTempArray];
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ = mRepairOrderCurrentModeListArray_;
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_] reloadData];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] enableOrdisableEditCustomerOrVehiclebtn];
}

- (void)getSelectedModeName:(NSString *)aModename {
    int selectedMode;
   if ([aModename isEqualToString:@"Dispatch"]) {
        selectedMode = 2;
    }else if ([aModename isEqualToString:@"Inspection"]) {
        selectedMode = 3;
    }else if ([aModename isEqualToString:@"Approval"]) {
        selectedMode = 4;
    }else if ([aModename isEqualToString:@"Repair"]) {
        selectedMode = 6;
    }else if ([aModename isEqualToString:@"Review"]) {
        selectedMode = 7;
    }else {
        selectedMode = 0;
    }
    [self filterTheDataBasedOnmode:selectedMode];
}
@end
