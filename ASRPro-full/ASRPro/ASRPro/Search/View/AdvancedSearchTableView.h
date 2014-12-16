//
//  AdvancedSearchTableView.h
//  ASRPro
//
//  Created by Santosh Kvss on 4/4/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeginVehicleCheckInViewViewController.h"

@class BeginVehicleCheckInViewViewController;
@interface AdvancedSearchTableView : UITableView<UITableViewDelegate,UITableViewDataSource> {
    
    /**
     * Appdelegate parameter
     */
@public
    AppDelegate *mAppDelegate_;
}

@property (strong, nonatomic) BeginVehicleCheckInViewViewController *mBeginCheckInView_;
@property (nonatomic, assign) int mselectedCustomerindex_;

/**
 * This method is used for making the delegates of 'mSearchListTableview_' to be called in this class
 */
-(void)setDelegatesForAdvancedSearchTableview_;
- (void)onSelectionOfAdvancedSearchCustomer;

@end
