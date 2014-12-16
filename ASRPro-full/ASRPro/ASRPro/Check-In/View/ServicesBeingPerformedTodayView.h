//
//  ServicesBeingPerformedTodayView.h
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicesBeingPerformedTodayUITableView.h"

@class ServicesBeingPerformedTodayUITableView;

@interface ServicesBeingPerformedTodayView : UIView
@property (nonatomic, retain) ServicesBeingPerformedTodayUITableView *mServicesBeingPerformedTodayUITableView_;

@property (nonatomic, retain) UILabel *mSubTotalOfServicesListedLabel_;
@property (nonatomic, retain) UILabel *mShopChargesAndTaxesLabel_;
@property (nonatomic, retain) UILabel *mTotalLabel_;
//@property (nonatomic, retain) UILabel *mSubTotalOfServicesListedLabel_;
//@property (nonatomic, retain) UILabel *mShopChargesAndTaxesLabel_;
//@property (nonatomic, retain) UILabel *mTotalLabel_;

- (void)setBorderForServicesBeingPerformedTodayView;
- (void)setTextForSubTotalOfServicesListedCost :(float)aSubTotalOfServicesListedCost ShopChargesAndTaxesCost :(float)aShopChargesAndTaxesCost TotalCost :(float)aTotalCost;
-(void)reloadData;
@end
