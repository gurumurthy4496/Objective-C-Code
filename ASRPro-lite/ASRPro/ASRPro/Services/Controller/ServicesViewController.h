//
//  ServicesViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 30/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicesScheduleTableViewController.h"
#import "RecommendedServicesTableViewController.h"
#import "OpenROServicesTableViewController.h"
#import "AddServicesViewController.h"
#import "ServicesPackageTableViewController.h"
#import "ServicesNavigationController.h"




@interface ServicesViewController : UIViewController


@property(nonatomic,retain)ServicesScheduleTableViewController* mServicesScheduleTableViewController_;
@property(nonatomic,retain)RecommendedServicesTableViewController* mRecommendedServicesTableViewController_;
@property(nonatomic,retain) NSMutableArray* lTempArray;
@property(nonatomic,retain)AddServicesViewController* mAddServicesViewController_;
@property(nonatomic,retain) ServicesPackageTableViewController* mServicesPackageTableViewController_;
@property (strong, nonatomic) IBOutlet UIView *mServicePackageView_;
@property (strong, nonatomic) IBOutlet UILabel *mUpdateDateLabel_;
@property (strong, nonatomic) IBOutlet UIButton *mRefreshButton_;
@property (nonatomic, retain) UISearchBar *mSearchBar_;

- (IBAction)RefreshBtnClicked:(id)sender;
- (IBAction)getPartsAndLabour:(id)sender;
- (IBAction)CustomerPlanClicked:(id)sender;

- (void) initPopUpView;
-(void)showAddServicePopup;
-(void)calculateAllTotals;
-(void)pushToServicesList;
@end
