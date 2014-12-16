//
//  OpenROServicesTableViewController.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenROServicesTableViewController : UITableViewController <UIGestureRecognizerDelegate>{
@public
/**
 * AppDelegate object creating
 */
AppDelegate *mAppDelegate_;
}

-(void)pushToAddServicesView;
-(void)loadAddServicesView;

@end
