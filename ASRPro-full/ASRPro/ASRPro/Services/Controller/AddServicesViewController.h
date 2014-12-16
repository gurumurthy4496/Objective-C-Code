//
//  AddServicesViewController.h
//  ASRPro
//
//  Created by Kalyani on 07/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddServiceTableViewController.h"
#import "ServicesListMainViewController.h"
#import "ServicesConstants.h"

@interface AddServicesViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *mHeadingLabel_;
@property (strong, nonatomic) IBOutlet UIButton *mSaveButton_;
@property (strong, nonatomic) IBOutlet UIButton *mCancelButton;
@property (nonatomic,assign) getservicereference mGetServiceReference_;
@property (strong,nonatomic) AddServiceTableViewController* mAddServiceTableViewController_;
@property(nonatomic,retain) ServicesListMainViewController* mServicesListTableViewController_;

- (IBAction)CancelButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;
-(void)pushToServicesListTableViewController;
-(void)pushtoAddServicesTable;


@end
