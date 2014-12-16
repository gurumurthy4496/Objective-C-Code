//
//  WalkAroundViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 29/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VehicleDiagramSetsTableView.h"
#import "VehicleDiagramsImageView.h"
#import "WalkAroundMainInspectionView.h"

#import "VehicleTypesDropDownView.h"
#import "VehicleAngleDropDownView.h"
#import "ChangeVehicleImageAndNameColor.h"
#import "DamageTypeView.h"

@class VehicleDiagramSetsTableView;
@class VehicleDiagramsImageView;

@class VehicleAngleDropDownView;
@class VehicleTypesDropDownView;

@interface WalkAroundViewController : UIViewController<UIGestureRecognizerDelegate,VehicleTypesDropDownViewDelegate,VehicleAngleDropDownViewDelegate,ChangeVehicleImageAndNameColor>
@property (strong, nonatomic) IBOutlet UIButton *mVehicleTypeButton_;
@property (strong, nonatomic) IBOutlet UIButton *mVehicleAngleButton_;
@property (strong, nonatomic) VehicleAngleDropDownView *mVehicleAngleDropDownView_;
@property (strong, nonatomic) VehicleTypesDropDownView *mVehicleTypesDropDownView_;
@property (assign, nonatomic) id<ChangeVehicleImageAndNameColor> mChangeVehicleImageAndNameColor_;
@property (strong, nonatomic) IBOutlet UIView *mView_;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (assign, nonatomic) int nextCount;
- (IBAction)previousButtonAction:(id)sender;
- (IBAction)nextButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet DamageTypeView *damageTypeView;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet VehicleDiagramsImageView *mVehicleDiagramsImageView_;
@property (retain, nonatomic) IBOutlet VehicleDiagramSetsTableView *mVehicleDiagramSetsTableView_;
@property (strong, nonatomic) IBOutlet UIScrollView *mWalkAroundScrollview_;
@property (strong, nonatomic) IBOutlet WalkAroundMainInspectionView *mWalkAroundLaneInspectionView;
-(void)pushToServicesList;
- (IBAction)vehicletypeButtonAction:(id)sender;
- (IBAction)vehicleangleButtonAction:(id)sender;
- (void)setNextPreviousButtons;
@end
