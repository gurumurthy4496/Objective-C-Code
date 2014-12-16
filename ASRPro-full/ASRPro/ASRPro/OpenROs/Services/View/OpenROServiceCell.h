//
//  OpenROServiceCell.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface OpenROServiceCell : UITableViewCell{
    @public
        /**
         * AppDelegate object creating
         */
        AppDelegate *mAppDelegate_;
        BOOL isCellSwipedRight,isCellSwipedLeft;

}

@property (nonatomic,retain)NSMutableDictionary* mServiceDictionary_;
@property(nonatomic)BOOL isPrimary;

-(void)addViewToCell;
-(void)resetCellView;
-(void)isCellSwipedRight:(BOOL)isTrue;
-(void)isCellSwipedLeft:(BOOL)isTrue;

@end
