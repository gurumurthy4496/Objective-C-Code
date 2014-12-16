//
//  ServicesBeingPerformedTodayUITableView.h
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesBeingPerformedTodayUITableView : UITableView<UITableViewDataSource,UITableViewDelegate>{
    AppDelegate *mAppDelegate_;
}

-(void)setDelegatesAndDataSourcesForServicesBeingPerformedTableView;
@end
