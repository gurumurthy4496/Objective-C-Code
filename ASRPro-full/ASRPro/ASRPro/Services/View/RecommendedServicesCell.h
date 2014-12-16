//
//  RecommendedServicesCell.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicesApproveButton.h"

@interface RecommendedServicesCell : UITableViewCell{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    
}

/**
 * Dictionary to store Line details.
 */
@property(nonatomic,retain) NSMutableDictionary * mServicesDict;

/**
 * Method to create custom cellview
 */
-(void)addViewToCell;

/**
 * Method to display delete button
 * @param bool to set delete button hidden state.
 */
-(void)isCellSwipedLeft:(BOOL)isTrue;

/**
 * Method to remove all subviews in cell content view
 */
-(void)resetCellView;
-(void)addNoServicesLabel;

@end