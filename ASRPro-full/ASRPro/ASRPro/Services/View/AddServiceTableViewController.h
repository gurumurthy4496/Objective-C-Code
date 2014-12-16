//
//  AddServiceTableViewController.h
//  ASRPro
//
//  Created by Kalyani on 07/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceImageView.h"



@interface AddServiceTableViewController : UITableViewController{
    @public
        int selectedsection;

        /**
         * AppDelegate object creating
         */
        AppDelegate *mAppDelegate_;

}

@property(nonatomic,retain) ServiceImageView* mServiceImageView;


-(void)saveData;
-(void)saveOpenROdata;

@end
