//
//  PopOverViewControllerForDatePickerView.m
//  ASRPro
//
//  Created by GuruMurthy on 22/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PopOverViewControllerForDatePickerView.h"
#import "CheckInSupportWebEngine.h"


@interface PopOverViewControllerForDatePickerView ()

@end

@implementation PopOverViewControllerForDatePickerView
@synthesize mDummyTextField_;
@synthesize mDateFormatType_;
@synthesize mDateFormatter_;
@synthesize mTodayDate_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    mDateFormatter_=[[NSDateFormatter alloc]init];
    NSTimeZone *gmtZone = [NSTimeZone systemTimeZone];
    [self.mDateFormatter_ setTimeZone:gmtZone];
    NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    self.mDateFormatter_.locale = enLocale;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ********** method for Date picker controller **********

- (void)datePickerController:(DatePickerController *)controller
                 didPickDate:(NSDate *)date
                      isDone:(BOOL)isDone {
    if(isDone)
    {
		NSDateFormatter *lDateFormat_ = [[NSDateFormatter alloc] init];
        if (mDateFormatType_ == DATE_FORMAT) {
            [lDateFormat_ setDateFormat:@"dd/MM/yyyy"];
        }else if (mDateFormatType_ == TIME_FORMAT){
            [lDateFormat_ setDateFormat:@"hh:mm a"];
        }
        NSTimeZone *gmtZone = [NSTimeZone systemTimeZone];
        [lDateFormat_ setTimeZone:gmtZone];
        NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
        lDateFormat_.locale = enLocale;
		mDummyTextField_.text = [NSString stringWithFormat:@"%@", [lDateFormat_ stringFromDate:date]];
		if (mDateFormatType_ == DATE_FORMAT) {
            mAppDelegate_.mModelForCheckIn_.mPromisedDate_ = mDummyTextField_.text;
        }else if (mDateFormatType_ == TIME_FORMAT){
            mAppDelegate_.mModelForCheckIn_.mPromisedTime_ = mDummyTextField_.text;
        }
		if([controller superview]){
			[controller removeFromSuperview];
		}
        [self.mPopOverDatePIckerDelegate_ didClickDoneButton];
        [[CheckInSupportWebEngine checkInSharedInstance] putRequestForChangingPromiseDateAndTime];
    }
    else
    {
        if([controller superview]){
            [controller removeFromSuperview];
        }
        [self.mPopOverDatePIckerDelegate_ didClickDoneButton];
    }
}

- (void)displayDatePicker {
    DatePickerController *screen = [[DatePickerController alloc] initWithFrame:CGRectMake(0, 0, 320, 260)];
    NSString *tempString = mDummyTextField_.text;
    //set the minimum date
    
    if ([tempString isEqualToString:@""]||tempString == nil)
    {
        self.mTodayDate_ = [NSDate date];
        if (mDateFormatType_ == DATE_FORMAT) {
            [[screen mDatePicker_] setMinimumDate:[NSDate date]];
        }else if (mDateFormatType_ == TIME_FORMAT) {
            [[screen mDatePicker_] setMaximumDate:[NSDate date]];
        }
    }else {
        if (mDateFormatType_ == DATE_FORMAT) {
            [[screen mDatePicker_] setMinimumDate:[NSDate date]];
            [self getDateFromString:tempString :@"dd/MM/yyyy"];
        }else if (mDateFormatType_ == TIME_FORMAT) {
            [[screen mDatePicker_] setMaximumDate:[NSDate date]];
            [self getDateFromString:tempString :@"hh:mm a"];
        }
    }
    // Set the date current in the textField
    if (mTodayDate_)
    {
        [[screen mDatePicker_]setDate:mTodayDate_ animated:YES];
        if (mDateFormatType_ == DATE_FORMAT) {
            [screen.mTextDisplayedlb setText:@"Select Promise Date"];
            [[screen mDatePicker_] setDatePickerMode:UIDatePickerModeDate];
        }else if (mDateFormatType_ == TIME_FORMAT) {
            [screen.mTextDisplayedlb setText:@"Select Promise Time"];
            [[screen mDatePicker_] setDatePickerMode:UIDatePickerModeTime];
        }
        
    }
    // screen.mTextDisplayedlb.text=@"Select Date of Birth";
    [screen setMDatePickerDelegate_:self];
    [screen setMSelectedTextField_:mDummyTextField_];
    [self.view addSubview:screen];
    //[screen showAnimation];
}

- (void)getDateFromString:(NSString *)string :(NSString *)dateFormatter_ {
    NSString * dateString = [NSString stringWithFormat: @"%@",string];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatter_];
    self.mTodayDate_ = [dateFormatter dateFromString:dateString];
}


@end
