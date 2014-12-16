//
//  ServicePaytypeDropdown.m
//  ASRPro
//
//  Created by Kalyani on 19/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicePaytypeDropdown.h"

@interface ServicePaytypeDropdown(){
    int lHourValue,lMinuteValue ;
    
}
-(void)initTheViews;
@end

@implementation ServicePaytypeDropdown
@synthesize mPickerView;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
        [self initTheViews];
    //    [self setValue:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mPayTypeID_]];
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
    
}
//-------------------------------------- ************** ----------------------------------------
//                         *** sets value for picker  ***
//-------------------------------------- ************** ----------------------------------------
-(void)setValue:(NSString*)value // reloads the component to previous values
{
    for(int i=0;i<[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mPayTypesArray_] count];i++){
        if([value isEqualToString:[NSString stringWithFormat:@"%@",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mPayTypesArray_] objectAtIndex:i] objectForKey:KPAYCODE]]]){
    [mPickerView selectRow:i inComponent:0 animated:YES];
        break;
        }
    }
    
}

#pragma mark - ****************** UIPickerViewDelegate *********************

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 300;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
        return [NSString stringWithFormat:@"%@",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mPayTypesArray_] objectAtIndex:row] objectForKey:KPAYCODE]];
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
 
     NSString *lStr = [NSString stringWithFormat:@"%@",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mPayTypesArray_] objectAtIndex:row] objectForKey:KPAYCODE]];
    [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMPayTypeCode_:lStr];
    [[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] setMPayTypeDict_:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mPayTypesArray_] objectAtIndex:row]];
    
}

#pragma mark -  ****************** UIPickerViewDataSource *****************
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
   
    return [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mPayTypesArray_] count];
}

-(NSString*)getValue{
    return @"";
}


@end
