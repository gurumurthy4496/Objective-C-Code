//
//  PopOverViewControllerForDatePickerView.h
//  ASRPro
//
//  Created by GuruMurthy on 22/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerController.h"
@class DatePickerController;

typedef enum {
    DATE_FORMAT=1,
    TIME_FORMAT
} dateFormatType;

@protocol PopOverViewControllerForDatePickerDelegate <NSObject>

-(void)didClickDoneButton;

@end

@interface PopOverViewControllerForDatePickerView : UIViewController<DatePickerControllerDelegate> {
    AppDelegate *mAppDelegate_;
}

@property (nonatomic, strong) NSDateFormatter *mDateFormatter_;
@property (nonatomic, assign) id<PopOverViewControllerForDatePickerDelegate>mPopOverDatePIckerDelegate_;
@property (nonatomic, strong) UITextField *mDummyTextField_;
@property (nonatomic, assign) dateFormatType mDateFormatType_;
@property (nonatomic, strong) NSDate *mTodayDate_;
/**
 * PUBLIC METHOD TO DISPLAY DATE_PICKER.
 */
- (void)displayDatePicker;

@end
