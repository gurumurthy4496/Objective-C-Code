//
//  MasterViewController.h
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchedListTableView.h"
#import "OpenROTableView.h"
#import "AppDelegate.h"
#import "UISearchBar+CustomSearchBar.h"
#import "OpenRODropDownView.h"
#import "PullToRefresh.h"

@class AppDelegate;
@class OpenROTableView;
@class SearchedListTableView;
@class OpenRODropDownView;

@interface MasterViewController : PullToRefresh <OpenRODropDownDelegate> {
    @public
    int mselectedSegment_;
    BOOL isAppointmentSelected;
    BOOL isAnyAppointmentSelected;
    AppDelegate *mAppdelegate_;
}
@property (nonatomic, retain) UISearchBar *mSearhBar_;
@property (weak, nonatomic) IBOutlet UITableView *mAppointmentAndInprocessTableView_;
@property (strong, nonatomic) IBOutlet SearchedListTableView *mSearchedListTableView_;
@property (strong, nonatomic) IBOutlet OpenROTableView *mOpenROTableView_;
@property (strong, nonatomic) NSDate *mUpdatedDate_;
@property (retain, nonatomic) NSDateFormatter *mFormatter_;
@property (weak, nonatomic) IBOutlet UILabel *mUpdateDateLbl_;
@property (weak, nonatomic) IBOutlet UIButton *mBeginVehicleCheckInBtn_;
@property (strong, nonatomic) NSMutableArray *mAppointmentsData_;
@property (weak, nonatomic) IBOutlet UIButton *mRefreshBtn_;
@property (nonatomic, assign) int mselectedApptmentindex_;
@property (nonatomic, assign) int mselectedInprocessindex_;
@property (nonatomic) BOOL isFromLogin;
@property (strong, nonatomic) IBOutlet UIButton *mOpenROFilterButton_;
@property (nonatomic, strong) OpenRODropDownView *mOpenRODropDownView_;
@property (nonatomic,retain) UIButton *mBarCodeBtn_;
@property (nonatomic) BOOL isBeforeActualTime;
#pragma mark -
#pragma mark ButtonActions
- (IBAction)refreshBtnAction:(id)sender;
- (IBAction)BeginVehicleCheckInBtnAction:(id)sender;
- (IBAction)segmentBtnAction:(id)sender;
- (IBAction)OpenROFilterButtonAction:(id)sender;

#pragma mark -
#pragma mark GenericMethods
/**
 ----- Method is used to Reload Appointments
 */
-(void)reloadAppointmentData;
/**
 ----- Method is used to Reload Inprocess
 */
- (void)reloadInProcessData;
- (void)onSelectionOfInProcess;
- (void)onSelectionOfAppointment;
/**
 ----- Method will return actual date from JSON Date
 */
- (NSDate *)mfDateFromDotNetJSONString:(NSString *)string;
/**
 ----- Method will return a string which includes time,salutation, firstname,lastname and middlename
 */
- (NSString *)returnString1:(NSString *)apppoinmenttime salutaion:(NSString *)salutation firstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName;
/**
 ----- Method will return a string which includes year,make,model
 */
- (NSString *)returnString2:(NSString *)vehicleYear make:(NSString *)make model:(NSString *)model;
/**
 ----- Method to reset Customer and vehicle information
 */
- (void)resetAllData;
/**
 ----- Method to refresh Appointments and RepairOrders Data
 */
-(void)refreshAppointmentOrInprocessData;
/**
 ----- Method is used to hide search list
 */
- (void)showSearchlistViewOrHide:(int)showOrhide searchText:(NSString *)searchText;
/**
 ----- Method to request for customer search data
 */
- (void)requestForCustomerSearch:(NSString *)searchValue;
/**
 ----- Method is used to Reload Search Data
 */
- (void)reloadSearchData;
-(void)postRequestToGetAppointments;
- (void)postRequestToGetRepairOrders;
- (void)reloadOPenROTableViewAfterDoneCheckIn;
- (void)setRequestforVehicleHistory;
- (void)reloadOpenROData;
@end
