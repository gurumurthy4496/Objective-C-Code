//
//  VehicleDiagramSetsTableView.h
//  ASRPro
//
//  Created by GuruMurthy on 05/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SectionViewWalkAround.h"

#import "CategoryWalkAround.h"

#import "SectionInfoWalkAround.h"

@class SectionViewWalkAround;

@class CategoryWalkAround;

@class SectionInfoWalkAround;

@interface VehicleDiagramSetsTableView : UITableView<UITableViewDataSource,UITableViewDelegate,SectionViewWalkAround> {
    AppDelegate *mAppDelegate_;
}

#pragma mark --
#pragma mark Public Methods

/**
 * Method to set Delegates and DataSources For Services Being Performed TableView.
 */
-(void)setDelegatesAndDataSourcesForVehicleTypeTableView;

/**
 * Method to set border for tableview.
 */
- (void)setBorderForTableView;
@end
