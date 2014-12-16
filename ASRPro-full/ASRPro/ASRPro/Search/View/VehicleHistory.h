//
//  VehicleHistory.h
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
#import "AppDelegate.h"

@class SearchViewController;
@class AppDelegate;
@interface  CustomButtonForAddServicesSearch: UIButton{
@public
    int section;
    int row;
}
@property (nonatomic,retain)NSMutableDictionary * mServicesDict;
@end
@interface VehicleHistory : UITableView<UITableViewDelegate,UITableViewDataSource> {
    
    /**
     * Appdelegate parameter
     */
@public
    AppDelegate *mAppDelegate_;
    BOOL isToday;
}

@property (strong, nonatomic) SearchViewController *mSearchViewController_;
@property (nonatomic, assign) int mselectedCustomerindex_;
@property (strong, nonatomic) NSArray *lServiceNames_;
/**
 * This method is used for making the delegates of 'mSearchListFromseverTableview_' to be called in this class
 */
-(void)setDelegatesVehicleHistoryTableview_;
- (void)initData;

@end
