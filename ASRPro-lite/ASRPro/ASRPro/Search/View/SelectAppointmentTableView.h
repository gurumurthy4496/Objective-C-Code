//
//  SelectAppointmentTableView.h
//  ASRPro
//
//  Created by Santosh Kvss on 2/27/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeginVehicleCheckInViewViewController.h"

@class BeginVehicleCheckInViewViewController;
@interface SelectAppointmentTableView : UITableView<UITableViewDelegate,UITableViewDataSource> {
    
    /**
     * Appdelegate parameter
     */
@public
    AppDelegate *mAppDelegate_;
}

@property (strong, nonatomic) BeginVehicleCheckInViewViewController *mBeginCheckInView_;
@property (nonatomic, assign) int mselectedAppointmentindex_;

/**
 * This method is used for making the delegates of 'mSearchListTableview_' to be called in this class
 */
-(void)setDelegatesForSearchListTableview_;
- (void)onSelectionOfCustomer;

@end
