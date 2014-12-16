//
//  NotificationsViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 28/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *mNotificationTableView_;
@property (strong, nonatomic) IBOutlet UILabel *mNotifiationLabel_;
@property (strong, nonatomic) IBOutlet UIButton *mCloseButton_;
@property (strong, nonatomic) IBOutlet UIButton *mclearAllButton_;
@property (strong, nonatomic) IBOutlet UIView *mView_;

- (void)reloadNotificationDataInTableView;
- (IBAction)closeButtonAction:(id)sender;
- (IBAction)clearallButtonAction:(id)sender;
@end
