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


@class CustomerAndVehicleInfoView;
@class ServicesBeingPerformedTodayView;
@class CustomerSignatureView;
@class CheckInRightView;

@interface CheckInViewController : UIViewController<OnsuccessProtocol>
@property (strong, nonatomic) IBOutlet CustomerAndVehicleInfoView *mCustomerAndVehicleInfoView_;
@property (strong, nonatomic) IBOutlet ServicesBeingPerformedTodayView *mServicesBeingPerformedTodayView_;
@property (strong, nonatomic) IBOutlet CustomerSignatureView *mCustomerSignatureView_;
@property (strong, nonatomic) IBOutlet CheckInRightView *mCheckInRightView_;

@property (strong, nonatomic) UIButton *mDoneButton_;

@end
