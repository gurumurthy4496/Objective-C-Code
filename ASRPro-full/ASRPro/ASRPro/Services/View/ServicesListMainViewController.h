//
//  ServicesListMainViewController.h
//  ASRPro
//
//  Created by Kalyani on 11/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesListMainViewController : UIViewController{
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
@public
    BOOL isCurrentservice;
    BOOL isInspection;
}
@property (nonatomic,readwrite) BOOL isSearching;
@property (retain, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic, retain) NSMutableArray *mSearchedDataArray;
@property (nonatomic, retain) UISearchBar *mSearhBar_;
@property (retain, nonatomic) IBOutlet UILabel *mNoServicesListtextLbl;

- (void)initDataInTableView :(NSMutableArray *)aServicesListArray;
@end
