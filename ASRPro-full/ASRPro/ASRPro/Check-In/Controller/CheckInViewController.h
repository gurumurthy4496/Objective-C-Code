//
//  CheckInViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 30/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerAndVehicleInfoView.h"
#import "ServicesBeingPerformedTodayView.h"
#import "CustomerSignatureView.h"
#import "CheckInRightView.h"
#import "EstimateVerbageView.h"


typedef enum {
    
    ClickedDone = 1,
    
} ISFronCheckInScreen;

@class CustomerAndVehicleInfoView;
@class ServicesBeingPerformedTodayView;
@class CustomerSignatureView;
@class CheckInRightView;
@class EstimateVerbageView;


@interface CheckInViewController : UIViewController<OnsuccessProtocol>
@property (strong, nonatomic) IBOutlet CustomerAndVehicleInfoView *mCustomerAndVehicleInfoView_;
@property (strong, nonatomic) IBOutlet ServicesBeingPerformedTodayView *mServicesBeingPerformedTodayView_;
@property (strong, nonatomic) IBOutlet CustomerSignatureView *mCustomerSignatureView_;
@property (strong, nonatomic) IBOutlet CheckInRightView *mCheckInRightView_;
@property (strong, nonatomic) EstimateVerbageView *mEstimateVerbageView_;

@property (strong, nonatomic) UIButton *mDoneButton_;
@property (assign, nonatomic) ISFronCheckInScreen mISFronCheckInScreen_;


-(void)pushToPDFView;
- (void)pushToPreROEstimatePDFView;
- (void)displayEditCustomerPopup;
- (void)displayEditVehiclePopup;
@end
