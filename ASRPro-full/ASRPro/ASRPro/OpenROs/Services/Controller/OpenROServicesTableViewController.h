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

/**
 * Method to get services
 */
-(void)getAddServicesList;

/**
 * Method to navigate to AddServicesView
 */
-(void)pushToAddServicesViewModal;

/**
 * Method to add gesture recognisers
 */
-(void)addSwipeGesturesToView;

/**
 * Method action when cell swiped right
 * @param recognizer returns gesture
 */
- (void)handleSwipeRight:(UISwipeGestureRecognizer *)recognizer;

/**
 * Method action when cell swiped left
  * @param recognizer returns gesture
 */
- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer;

@end
