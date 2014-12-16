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
    AppDelegate *mAppDelegate_;
    
       
        UIView *refreshHeaderView;
        UILabel *refreshLabel;
        UIImageView *refreshArrow;
        UIActivityIndicatorView *refreshSpinner;
        BOOL isDragging;
        BOOL isLoading;
        NSString *textPull;
        NSString *textRelease;
        NSString *textLoading;
    
    
}



@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;

- (void)setupStrings;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;

@property (strong, nonatomic) MasterViewController *mMasterViewController_;
@property (nonatomic, assign) int mselectedCustomerindex_;
@property (retain, nonatomic) NSIndexPath *mLastIndexPath_;

/**
 * This method is used for making the delegates of 'mSearchListTableview_' to be called in this class
 */
-(void)setDelegatesForSearchListTableview_;
- (void)onSelectionOfOpenRO:(int)index;

@end
