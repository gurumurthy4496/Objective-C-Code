//
//  ServicesScheduledCell.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicesScheduledCell.h"
#import "ServicesApproveButton.h"


@interface ServicesScheduledCell : UITableViewCell{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    
}


@property (nonatomic,retain) NSMutableDictionary* mServicesDict_;

-(void)addViewToCell;

@end