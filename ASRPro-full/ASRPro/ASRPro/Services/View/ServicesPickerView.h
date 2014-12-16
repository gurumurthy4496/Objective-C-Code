//
//  ServicesPickerView.h
//  ASRPro
//
//  Created by Kalyani on 10/29/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesPickerView : UIView<UIPickerViewDelegate , UIPickerViewDataSource>
{
    NSString* lTempValue;
}

// class instance variables

@property (nonatomic,retain)UIPickerView *mPickerView;
@property (nonatomic,retain)UILabel* mHoursLabel;
@property (nonatomic,retain)UILabel* mMinutesLabel;


/**
 * method sets value for picker
 * @param name value of current checkbox
 **/
-(void)setValue:(NSString*)value;

-(NSString*)getValue;

@end