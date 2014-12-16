//
//  InspectionCautionedOrFailedUITableView.h
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectionCautionedOrFailedUITableView : UITableView<UITableViewDataSource,UITableViewDelegate> {
    AppDelegate *mAppDelegate_;
}

/**
 * Method to set Delegates and DataSources For Inspection Cautioned Or Failed UITableView.
 */
-(void)setDelegatesAndDataSourcesForInspectionCautionedOrFailedUITableView;

@end
