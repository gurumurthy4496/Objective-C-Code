//
//  SearchVehicleInfoView.h
//  ASRPro
//
//  Created by Santosh Kvss on 2/13/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVehicleInfoView : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (retain,nonatomic) UIButton *mAddVehicleButton_;
@property (retain, nonatomic) NSIndexPath *mLastIndexPath_;
@property (retain, nonatomic) NSMutableArray *mVehicleDetailsArray_;
@property (retain, nonatomic) UITableView *mVehiclesTableView_;

@end
