//
//  ServicesPickerView.m
//  ASRPro
//
//  Created by Kalyani on 10/29/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ServicesPickerView.h"

#define HOUR 0
#define MINUTE 1
@interface ServicesPickerView(){
    int lHourValue,lMinuteValue ;

}
-(void)initTheViews;
@end

@implementation ServicesPickerView

@synthesize mPickerView;
@synthesize mHoursLabel;
@synthesize mMinutesLabel;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    //    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        [self initTheViews];
    }
    return self;
}


-(void)initTheViews{
    mPickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0,600,200)];
    mPickerView.delegate=self;
    mPickerView.dataSource=self;
    [mPickerView setUserInteractionEnabled:YES];
    mPickerView.showsSelectionIndicator = YES;
    [self addSubview:mPickerView];
    UILabel *lHoursLabel=[UILabel new];
    [self setMHoursLabel:lHoursLabel];
  //  if (IOS_NEWER_OR_EQUAL_TO_7) {
        [mHoursLabel setFrame:CGRectMake(280,75,60,30)];
//    }else
//        [mHoursLabel setFrame:CGRectMake(90,75,60,30)];
    [mHoursLabel setText:@"hours"];
    [mHoursLabel setFont:[UIFont regularFontOfSize:18 fontKey:kFontNameHelveticaNeueKey]];
    [mHoursLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:mHoursLabel];
    RELEASE_NIL(lHoursLabel);
    UILabel *lMinsLabel=[UILabel new];
    [self setMMinutesLabel:lMinsLabel];
    //if (IOS_NEWER_OR_EQUAL_TO_7) {
        [mMinutesLabel setFrame:CGRectMake(370,75,60,30)];
//    }else
//        [mMinutesLabel setFrame:CGRectMake(190,75,60,30)];
    [mMinutesLabel setText:@"/10th"];
    [mMinutesLabel setFont:[UIFont regularFontOfSize:18 fontKey:kFontNameHelveticaNeueKey]];
    [mMinutesLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:mMinutesLabel];
    RELEASE_NIL(lMinsLabel);

}
//-------------------------------------- ************** ----------------------------------------
//                         *** sets value for picker  ***
//-------------------------------------- ************** ----------------------------------------
-(void)setValue:(NSString*)value // reloads the component to previous values
{
    NSString *hours = [NSString stringWithFormat:@"%00.1f",[value floatValue]]; //.2f
    NSRange replaceRange = [hours rangeOfString:@"."];
    if (replaceRange.location ==NSNotFound)
    {
        hours = [NSString stringWithFormat:@"%00.1f",[value floatValue]]; //.2f
    }
    NSArray *lArr_=[hours componentsSeparatedByString:@"."];
    DLog(@"HOURS ARRAY :-%@",lArr_);
    lHourValue = [[lArr_ objectAtIndex:0] integerValue];
    lMinuteValue = [[lArr_ objectAtIndex:1] integerValue];
    [mPickerView selectRow:lHourValue inComponent:0 animated:YES];
    [mPickerView selectRow:lMinuteValue inComponent:1 animated:YES];
   lTempValue= [NSString stringWithFormat:@"%d.%d",lHourValue,lMinuteValue];

    if([value intValue]>2)
        [ mHoursLabel setText:@"hours"];
    else
        [ mHoursLabel setText:@"hour"];
}

#pragma mark - ****************** UIPickerViewDelegate *********************

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if(component==HOUR)
        return 100;
    if(component==MINUTE)
        return 100;
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component==HOUR)
        return [NSString stringWithFormat:@"%d",row];
    if(component==MINUTE)
        return [NSString stringWithFormat:@"%d",row];
    return @"";
}


//-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
//    return 30;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component ==HOUR){
        lHourValue = row;
        if(row<=1)
            [mHoursLabel setText:@"hour"];
        else
            [mHoursLabel setText:@"hours"];
    }
    else if(component ==MINUTE) {
        lMinuteValue = row;
        [mMinutesLabel setText:@"/10th"];
     }
//    int lPickerTime = (lHourValue*60)+lMinuteValue;
//    float lTotalHours = lPickerTime/60.0;
    NSString *lStr = [NSString stringWithFormat:@"%d.%d",lHourValue,lMinuteValue];
    DLog(@"Total Hours : %@",lStr);
    if(![lTempValue isEqualToString:lStr]){
   [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMHours_:lStr];
    [[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] ->isCustomHour_=TRUE;
       // lTempValue=lStr;
    }
}

#pragma mark -  ****************** UIPickerViewDataSource *****************
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == HOUR)
    {
        return 100;
    }
    else if(component == MINUTE)
    {
        return 10;
    }
    return 1;
}

-(NSString*)getValue{
   return @"";
}


@end
