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

@property(nonatomic,retain) NSMutableDictionary * mServicesDict;

-(void)addViewToCell;
-(void)isCellSwipedLeft:(BOOL)isTrue;
-(void)resetCellView;
@end