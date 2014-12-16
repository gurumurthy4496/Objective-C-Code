//
//  PopOverViewControllerForDatePickerView.m
//  ASRPro
//
//  Created by GuruMurthy on 22/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PopOverViewControllerForDatePickerView.h"
#import "CheckInSupportWebEngine.h"

#define kDateFormat @"MM/dd/yyyy"
#define kDateTimeFormat @"MM/dd/yyyy HH:mm:ss"
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
            [lDateFormat_ setDateFormat:kDateFormat];
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


- (NSDate*) dateFormat : (NSString*)date currentFormat:(NSString*) currentFormat newFormat : (NSString*) newFormat
{
    NSString *dateStr = date;
    NSDateFormatter *dtF = [[NSDateFormatter alloc] init];
    [dtF setDateFormat:currentFormat];
    NSDate *d = [dtF dateFromString:dateStr];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:newFormat];
    NSString * strFinalDate = [dateFormat stringFromDate:d];
    DLog(@"%@",strFinalDate);
    return d;
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
            NSString *time = (mAppDelegate_.mModelForCheckIn_.mPromisedDate_ != nil || [mAppDelegate_.mModelForCheckIn_.mPromisedDate_ length] > 0) ?mAppDelegate_.mModelForCheckIn_.mPromisedDate_:@"";
            if ([mAppDelegate_.mModelForCheckIn_.mPromisedDate_ length] > 0) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:kDateTimeFormat];

                NSTimeZone *gmtZone = [NSTimeZone systemTimeZone];
                [formatter setTimeZone:gmtZone];
                NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
                formatter.locale = enLocale;
                
                NSString *time2 = [formatter stringFromDate:[NSDate date]];
                
                NSDate *date1 = [self dateFormat:time currentFormat:kDateFormat newFormat:@"MM/dd/yyyy hh:mm:ss Z"];
                NSDate *date2 = [formatter dateFromString:time2];
                
                NSComparisonResult result = [date1 compare:date2];
                if(result == NSOrderedDescending)
                {
                     DLog(@"date1 is later than date2");
                    [[screen mDatePicker_] setDate:[NSDate date]];
                }
                else if(result == NSOrderedAscending)
                {
                    DLog(@"date2 is later than date1");
                    [[screen mDatePicker_] setMinimumDate:[NSDate date]];
                }
                else
                {
                    DLog(@"date1 is equal to date2");
                    [[screen mDatePicker_] setMaximumDate:[NSDate date]];
                }
            }else {
                [[screen mDatePicker_] setDate:[NSDate date]];
            }
            
        }
    }else {
        if (mDateFormatType_ == DATE_FORMAT) {
            [[screen mDatePicker_] setMinimumDate:[NSDate date]];
            [self getDateFromString:tempString :kDateFormat];
        }else if (mDateFormatType_ == TIME_FORMAT) {
//            [[screen mDatePicker_] setDate:[NSDate date]];
            NSString *time = (mAppDelegate_.mModelForCheckIn_.mPromisedDate_ != nil || [mAppDelegate_.mModelForCheckIn_.mPromisedDate_ length] > 0) ?mAppDelegate_.mModelForCheckIn_.mPromisedDate_:@"";
            if ([mAppDelegate_.mModelForCheckIn_.mPromisedDate_ length] > 0) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:kDateTimeFormat];
                
                NSTimeZone *gmtZone = [NSTimeZone systemTimeZone];
                [formatter setTimeZone:gmtZone];
                NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
                formatter.locale = enLocale;
                
                NSString *time2 = [formatter stringFromDate:[NSDate date]];
                
                NSDate *date1 = [self dateFormat:time currentFormat:kDateFormat newFormat:@"dd/MM/yyyy hh:mm:ss Z"];
                NSDate *date2 = [formatter dateFromString:time2];
                
                NSComparisonResult result = [date1 compare:date2];
                if(result == NSOrderedDescending)
                {
                    DLog(@"date1 is later than date2");
                    [[screen mDatePicker_] setDate:[NSDate date]];
                }
                else if(result == NSOrderedAscending)
                {
                    DLog(@"date2 is later than date1");
                    [[screen mDatePicker_] setMinimumDate:[NSDate date]];
                }
                else
                {
                    DLog(@"date1 is equal to date2");
                    [[screen mDatePicker_] setMaximumDate:[NSDate date]];
                }
            }else {
                [[screen mDatePicker_] setDate:[NSDate date]];
            }
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
