//
//  CheckInRightView.h
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalkAroundDetailsUITableView.h"
#import "InspectionCautionedOrFailedUITableView.h"

@class WalkAroundDetailsUITableView;
@class InspectionCautionedOrFailedUITableView;

@interface CheckInRightView : UIView


@property (nonatomic, retain) WalkAroundDetailsUITableView *mWalkAroundDetailsUITableView_;
@property (nonatomic, retain) InspectionCautionedOrFailedUITableView *mInspectionCautionedOrFailedUITableView_;

- (void)setBorderForCheckInRightView;
@end
