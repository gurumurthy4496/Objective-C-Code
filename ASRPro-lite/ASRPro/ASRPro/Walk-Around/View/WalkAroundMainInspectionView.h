//
//  WalkAroundMainInspectionView.h
//  ASRPro
//
//  Created by Kalyani on 12/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForLaneInspectionFormView.h"

@interface WalkAroundMainInspectionView : UIScrollView{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    

}

@property(nonatomic,retain) UIScrollView *mTiremeasurementsView_;
@property(nonatomic,retain) UIScrollView* mInspectionDetailsView_;


-(void)initTheViews;
-(void)addInspectionItemsToView;
-(void)addServicePopupView:(int)xPos :(int)yPos :(NSMutableArray*)aArray :(int)tag :(int)type;
-(void)removeAddServicePopupView;
-(void)loadServices;
-(NSMutableArray*)getServiceLines;
@end
