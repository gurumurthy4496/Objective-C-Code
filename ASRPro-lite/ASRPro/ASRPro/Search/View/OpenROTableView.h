//
//  OpenROTableView.h
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "AppDelegate.h"

@class MasterViewController;
@class AppDelegate;

@interface OpenROTableView : UITableView<UITableViewDelegate,UITableViewDataSource> {
    
    /**
     * Appdelegate parameter
     */
@public
    AppDelegate *mAppDelegate_;
}

@property (strong, nonatomic) MasterViewController *mMasterViewController_;
@property (nonatomic, assign) int mselectedCustomerindex_;
@property (retain, nonatomic) NSIndexPath *mLastIndexPath_;

/**
 * This method is used for making the delegates of 'mSearchListTableview_' to be called in this class
 */
-(void)setDelegatesForSearchListTableview_;
- (void)onSelectionOfOpenRO:(int)index;

@end
