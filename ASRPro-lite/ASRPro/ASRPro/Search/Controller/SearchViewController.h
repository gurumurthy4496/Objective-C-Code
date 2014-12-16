//
//  SearchViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 28/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

typedef enum {
    
    SearchOpenRO = 1,
    SearchDMS,
    
} SearchCategory;


#import <UIKit/UIKit.h>
#import "VehicleHistory.h"
#import "OpenROServicesTableViewController.h"
#import "UIView+CustomHeaderViewFull.h"
@class VehicleHistory;
@interface SearchViewController : UIViewController{
    @public
    BOOL isFinishInspectionCompleted;
}
@property (assign, nonatomic) SearchCategory mSearchCategory_;

@property (weak, nonatomic) IBOutlet UIView *mCustomerInfoView_;
@property (weak, nonatomic) IBOutlet UIView *mVehicleInfoView_;
@property (weak, nonatomic) IBOutlet UILabel *mCustomerInfoTitleLbl_;
@property (weak, nonatomic) IBOutlet UILabel *mVehicleInfoTitleLbl_;
@property (weak, nonatomic) IBOutlet UILabel *ROHistoryTitleLbl_;
@property (weak, nonatomic) IBOutlet UIView *mVehicleHistoryView_;
@property (strong, nonatomic) IBOutlet VehicleHistory *mVehicleHistory_;
@property (weak, nonatomic) IBOutlet UIButton *mContinueBtn_;
@property (weak, nonatomic) IBOutlet UIButton *mEditCustomerBtn_;
@property (weak, nonatomic) IBOutlet UIButton *mEditVehicleBtn_;
@property (weak, nonatomic) IBOutlet UILabel *mVehicleHistoryLbl_;
@property (nonatomic) BOOL isCheckIn;
@property (nonatomic) BOOL isFromInProcess;
@property(nonatomic,retain)OpenROServicesTableViewController* mOpenROServicesTableViewController_;

@property (strong, nonatomic) IBOutlet UIButton *mGoToInspectionFormButton_;
@property (strong, nonatomic) IBOutlet UIButton *mGetPartsandLabour_;
@property (strong, nonatomic) IBOutlet UIButton *mPrintEmail_;
@property (strong, nonatomic) IBOutlet UIButton *mAllWorkDone_;

- (IBAction)customerEditBtnAction:(id)sender;
- (IBAction)vehicleEditBtnAction:(id)sender;
- (IBAction)continueBtnAction:(id)sender;
- (IBAction)allWorkDoneBtnAction:(id)sender;
- (IBAction)PrintEmailBtnAction:(id)sender;
- (IBAction)GetPartsLaborBtnAction:(id)sender;
- (IBAction)goToInspectionFormBtnAction:(id)sender;
-(void)pushToFinishServicesViewController;
- (void)displayEditCustomerPopup;
- (void)setCustomerInfomationLabelsTextFromModel;
-(void)setVehicleInfomationLabelsTextFromModel;
- (void)reloadVehicleHistory;
-(void)showServicesScreen;
-(void)showVehicleHistoryScreen;
-(void)onSuccesofCheckin;
- (void)enableOrdisableEditCustomerOrVehiclebtn;
-(void)pushToPDFView;
-(void)pushToPartsLabour;
-(BOOL)isAllServicesApproved;
-(BOOL)areAllCurrentServicesDone;
-(BOOL)areAllRecommendedServicesDone;
@end
