//
//  DatePickerController.h
//  GSPSurveyor
//
//  Created by Ramsh Muthe on 6/14/12.
//  Copyright 2011 ValueLabs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerController;

@protocol DatePickerControllerDelegate

/**
 * Method used to pick date from datepickercontroller when done is presses
 @param controller refers to DatePickerController instance
 @param date refers to date of DatePickerController
 @param isDone refers to BOOL value weather done is pressed or not
 */
- (void) datePickerController:(DatePickerController *)controller
                  didPickDate:(NSDate *)date
                       isDone:(BOOL)isDone;
@end

@interface DatePickerController : UIView {
    
    /**
     * CGRect variable  declaration
     */
    CGRect mFrame_;
    int height,width;
}

@property (strong,nonatomic) UIDatePicker *mDatePicker_;
@property (strong, nonatomic)     UILabel *mTextDisplayedlb;
/**
 * DatePickerControllerDelegate object creating
 */

@property (nonatomic, assign) NSObject <DatePickerControllerDelegate> *mDatePickerDelegate_;
@property (strong, nonatomic) UITextField *mSelectedTextField_;
@property (strong, nonatomic) UIToolbar *mToolBar_;
@property (strong, nonatomic)   UIView *mPickerView_;
- (void)showAnimation;
@end
