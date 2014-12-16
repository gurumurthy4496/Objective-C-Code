//
//  CheckInRightView.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "CheckInRightView.h"

@implementation CheckInRightView
@synthesize mWalkAroundDetailsUITableView_;
@synthesize mInspectionCautionedOrFailedUITableView_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setBorderForCheckInRightView {
    [self.layer setBorderColor:[[UIColor ASRProGreenColor] CGColor]];
    [self.layer setBorderWidth:2];
    [self setHeaderLabelForCheckInRightView];
    [self setInitializingMemoryForWalkAroundDetailsTableView];
    [self setInitializingMemoryForInspectionCautionedOrFailedTableView];
}

- (void)setInitializingMemoryForWalkAroundDetailsTableView {
    WalkAroundDetailsUITableView *tableView = [[WalkAroundDetailsUITableView alloc] init];
    [tableView setFrame:CGRectMake(0, 35, self.frame.size.width, 315)];
    self.mWalkAroundDetailsUITableView_ = tableView;
    if (IOS_NEWER_OR_EQUAL_TO_7) {
        if ([self.mWalkAroundDetailsUITableView_ respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.mWalkAroundDetailsUITableView_ setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    [self addSubview:self.mWalkAroundDetailsUITableView_];
}

- (void)setInitializingMemoryForInspectionCautionedOrFailedTableView {
    InspectionCautionedOrFailedUITableView *tableView = [[InspectionCautionedOrFailedUITableView alloc] init];
    [tableView setFrame:CGRectMake(0, 378 + 5, self.frame.size.width, 305)];
    self.mInspectionCautionedOrFailedUITableView_ = tableView;
    if (IOS_NEWER_OR_EQUAL_TO_7) {
        if ([self.mInspectionCautionedOrFailedUITableView_ respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.mInspectionCautionedOrFailedUITableView_ setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    [self addSubview:self.mInspectionCautionedOrFailedUITableView_];
}

- (void)setFrameForCheckInRightView {
    
}

- (void)setHeaderLabelForCheckInRightView {
    UILabel *headerLabel = [[UILabel alloc] init];
    CGFloat x = 0, y = 0, width = self.frame.size.width, height = 35;
    [headerLabel setFrame:CGRectMake(x, y, width, height)];
    [headerLabel setText:@"Walk-Around Details"];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    [headerLabel setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [headerLabel setBackgroundColor:[UIColor ASRProGreenColor]];
    [self addSubview:headerLabel];
    
    UILabel *headerLabel2 = [[UILabel alloc] init];
    [headerLabel2 setFrame:CGRectMake(x, y + height + 315, width, height)];
    [headerLabel2 setText:@"Inspection Items Cautioned or Failed"];
    [headerLabel2 setTextColor:[UIColor whiteColor]];
    [headerLabel2 setTextAlignment:NSTextAlignmentCenter];
    [headerLabel2 setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [headerLabel2 setBackgroundColor:[UIColor ASRProGreenColor]];
    [self addSubview:headerLabel2];
}

@end
