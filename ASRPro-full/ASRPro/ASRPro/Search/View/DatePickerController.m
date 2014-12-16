//
//  DatePickerController.m
//  GSPSurveyor
//
//  Created by Pawan on 6/14/11.
//  Copyright 2011 ValueLabs Inc. All rights reserved.
//

#import "DatePickerController.h"
#define Select_Date @"Select Date"
#define KAnimationValue 150
#define KScreenHeight 523
#define kPickerHeight 216
#define kTabbarHeight 44
#define BLACK_COLOR [UIColor blackColor]
@implementation DatePickerController

@synthesize mDatePicker_;
@synthesize mDatePickerDelegate_;
@synthesize mSelectedTextField_;
@synthesize mTextDisplayedlb;
@synthesize mToolBar_;
@synthesize mPickerView_;
- (id)initWithFrame:(CGRect)frame {
    
	self = [super initWithFrame:frame];
    
    if (self) {
        [self setBackgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
        [self setUserInteractionEnabled:YES];
        width=frame.size.width;
        CGFloat lXCoord=0,lYCoord=frame.size.height-(kPickerHeight+kTabbarHeight),lWidth=width,lHeight=kPickerHeight+kTabbarHeight;
        mFrame_=CGRectMake(0, lYCoord, lWidth, lHeight);
        
        mPickerView_ = [[UIView alloc] initWithFrame:mFrame_];
        mPickerView_.backgroundColor=[UIColor whiteColor];
        [mPickerView_ setUserInteractionEnabled:YES];
        [self addSubview:mPickerView_];
        mDatePicker_ = [[UIDatePicker alloc] initWithFrame:CGRectMake(lXCoord, kTabbarHeight, lWidth,kPickerHeight)];
        mDatePicker_.datePickerMode = UIDatePickerModeDate;
		[mPickerView_ addSubview:mDatePicker_];
        
        mToolBar_= [[UIToolbar alloc] initWithFrame:CGRectMake(lXCoord, 0, lWidth, kTabbarHeight)];
        mToolBar_.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        [mToolBar_ setBackgroundColor:BLACK_COLOR];
		[mToolBar_ setTintColor:[UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:0.1]];
        [mPickerView_ addSubview:mToolBar_];
        UIBarButtonItem *lflexibleButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:    UIBarButtonSystemItemFlexibleSpace
                                                                                          target:self
                                                                                          action:nil];
        
        mTextDisplayedlb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0,160, kTabbarHeight)];
        mTextDisplayedlb.numberOfLines=0;
        mTextDisplayedlb.lineBreakMode=NSLineBreakByTruncatingTail;
        mTextDisplayedlb.tag=3;
        mTextDisplayedlb.backgroundColor = [UIColor clearColor];
        mTextDisplayedlb.textColor = [UIColor blackColor];
        // add your text here, using NSDateFormatter for example
        mTextDisplayedlb.text = Select_Date;
        
        // create the bar button item where we specify the label as a view to use to init with
        UIBarButtonItem *lTextBarButton = [[UIBarButtonItem alloc] initWithCustomView:mTextDisplayedlb];
        //-----  CANCEL BAR-BUTTON ITEM -----
        UIButton *lCancelToolbarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lCancelToolbarButton setTag:1];
        [lCancelToolbarButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
//        [lCancelToolbarButton setBackgroundImage:[UIImage imageWithColor:BLACK_COLOR] forState:UIControlStateNormal];
//        [lCancelToolbarButton setBackgroundImage:[UIImage imageWithColor:BLACK_COLOR] forState:UIControlStateSelected];
        [lCancelToolbarButton setTintColor:BLACK_COLOR];
        [lCancelToolbarButton setTitle:@"Cancel" forState:UIControlStateNormal];
        lCancelToolbarButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [lCancelToolbarButton.layer setMasksToBounds:YES];
        [[lCancelToolbarButton titleLabel] setTextColor:[UIColor ASRProBlueColor]];
//        [lCancelToolbarButton.layer setCornerRadius:4.0];
//        [lCancelToolbarButton.layer setBorderWidth:0.0f];
//        [lCancelToolbarButton.layer setBorderColor: [[UIColor grayColor] CGColor]];
        lCancelToolbarButton.frame = CGRectMake(70, 5, 60.0, 30.0);
        [lCancelToolbarButton addTarget:self action:@selector(evt_DateEvent:) forControlEvents:UIControlEventTouchUpInside];
        [lCancelToolbarButton sizeToFit];

        UIBarButtonItem *lCancelButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lCancelToolbarButton];
        [lCancelButtonItem setTag:2];
        //-----  DONE BAR-BUTTON ITEM -----
        UIButton *lDoneToolbarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [lDoneToolbarButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
        [lDoneToolbarButton setTag:2];
//        [lDoneToolbarButton setBackgroundImage:[UIImage imageWithColor:BLACK_COLOR] forState:UIControlStateNormal];
//        [lDoneToolbarButton setBackgroundImage:[UIImage imageWithColor:BLACK_COLOR] forState:UIControlStateSelected];
//        [lDoneToolbarButton setTintColor:BLACK_COLOR];
        [lDoneToolbarButton setTitle:@"Done" forState:UIControlStateNormal];
        lDoneToolbarButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [[lDoneToolbarButton titleLabel] setTextColor:[UIColor ASRProBlueColor]];
        [lDoneToolbarButton.layer setMasksToBounds:YES];
//        [lDoneToolbarButton.layer setCornerRadius:4.0];
//        [lDoneToolbarButton.layer setBorderWidth:0.0f];
//        [lDoneToolbarButton.layer setBorderColor: [[UIColor grayColor] CGColor]];
        lDoneToolbarButton.frame = CGRectMake(70, 5, 60.0, 30.0);
        [lDoneToolbarButton addTarget:self action:@selector(evt_DateEvent:) forControlEvents:UIControlEventTouchUpInside];
        [lDoneToolbarButton sizeToFit];
        UIBarButtonItem *lDoneButtonItem = [[UIBarButtonItem alloc] initWithCustomView:lDoneToolbarButton];
        [lDoneButtonItem setTag:2];
       
        [mToolBar_ setItems:[NSArray arrayWithObjects:lTextBarButton,lflexibleButtonItem,lCancelButtonItem,lDoneButtonItem,nil]];
    }
    return self;
}


//Action methods for toolbar buttons:

- (IBAction)evt_DateEvent:(id)sender {
	UIButton *lButton = sender;
    [lButton setSelected:YES];
    if (lButton.tag == 1) {
        [lButton setSelected:NO];
    }
    [mDatePickerDelegate_ datePickerController:self didPickDate:mDatePicker_.date isDone:lButton.selected];
}

- (void)showAnimation {
    
    CGFloat lXCoord=0,lYCoord,lWidth=width,lHeight=kPickerHeight+kTabbarHeight;
        lYCoord = KScreenHeight-kPickerHeight-kTabbarHeight;
    mFrame_=CGRectMake(lXCoord, lYCoord+KAnimationValue, lWidth, lHeight);
    // self.mPickerView_.frame=mFrame_;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.5];
    mFrame_=CGRectMake(lXCoord, lYCoord, lWidth, lHeight);
    // self.mPickerView_.frame=mFrame_;
    [UIView commitAnimations];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */


@end
