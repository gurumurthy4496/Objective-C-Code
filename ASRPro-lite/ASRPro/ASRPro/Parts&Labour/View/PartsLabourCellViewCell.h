//
//  PartsLabourCellViewCell.h
//  ASRPro
//
//  Created by Kalyani on 06/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartsLabourCellViewCell : UITableViewCell
{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    PartsLaborMainSubview* mPartsLaborMainSubview_;
}

@property(nonatomic,retain) NSMutableDictionary * mServicesDict;

-(void)addViewToCell;
@end
