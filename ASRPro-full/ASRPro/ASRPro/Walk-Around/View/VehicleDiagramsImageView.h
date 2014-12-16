//
//  VehicleDiagramsImageView.h
//  ASRPro
//
//  Created by GuruMurthy on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImageView+DispatchLoad.h"

#import "AddDamageViewController.h"

#import "DamagePopupViewController.h"

#import "BuildInspectionDetailsViewController.h"

#import "WalkAroundSupportWebEngine.h"

@class BuildInspectionDetailsViewController;

@class DamagePopupViewController;

@class AddDamageViewController;

@interface  CustomButtonOnImageView: UIButton
@property (nonatomic, retain) NSString *mSeverityType_;
@property (nonatomic, retain) NSString *mDamageType_;
@property (nonatomic, retain) NSString *mID_;
@property (nonatomic, assign) NSString *mVehicleDamageDetailTypeID_;
@property (nonatomic, assign) NSString *mVehicleDamageSeverityID_;
@property (nonatomic, retain) NSString *mNotes_;
@property (nonatomic, retain) NSString *mImageURL_;

@end

@interface VehicleDiagramsImageView : AsyncCustImageView<UIGestureRecognizerDelegate,GetVehicleDamagepointOnImageView>
@property (nonatomic, retain) CustomButtonOnImageView *mOnTapPointButton_;

@property (nonatomic, retain) AddDamageViewController *mAddDamageViewController_;
@property (nonatomic, retain) DamagePopupViewController *mDamagePopupViewController_;

@property (nonatomic, retain) BuildInspectionDetailsViewController *mBuildInspectionDetailsViewController_;

- (void)setBorderForImageView;
- (void)handleLongPressOnImageView;
- (void)removeButtonFromImageView;
@end

