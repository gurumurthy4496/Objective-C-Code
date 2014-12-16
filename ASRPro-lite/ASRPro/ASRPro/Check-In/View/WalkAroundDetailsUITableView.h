//
//  WalkAroundDetailsUITableView.h
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalkAroundDetailsUITableView : UITableView <UITableViewDataSource,UITableViewDelegate>{
    AppDelegate *mAppDelegate_;
}

/**
 * Instance For NSDateFormatter.
 */
@property (retain, nonatomic) NSDateFormatter *mFormatter_;
/**
 * Instance For DamageType.
 */
@property (nonatomic, retain) NSString *mvehicleAngleName_;
/**
 * Instance For Severity Type.
 */
@property (nonatomic, retain) NSString *mvehicleSeverityName_;
/**
 * Instance For VehicleAngle.
 */
@property (nonatomic, retain) NSString *mvehicleDamageName_;
/**
 * Instance For CreatedDate.
 */
@property (nonatomic, retain) NSString *mvehicleName_;

/**
 * Method to set Delegates and DataSources For Services Being Performed TableView.
 */
-(void)setDelegatesAndDataSourcesForWalkAroundTableView;

@end
