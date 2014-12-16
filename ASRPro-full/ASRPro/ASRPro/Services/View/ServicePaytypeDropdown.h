//
//  ServicePaytypeDropdown.h
//  ASRPro
//
//  Created by Kalyani on 19/03/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicePaytypeDropdown : UIView<UIPickerViewDelegate , UIPickerViewDataSource>
{
}

// class instance variables

@property (nonatomic,retain)UIPickerView *mPickerView;

/**
 * method sets value for picker
 * @param name value of current checkbox
 **/
-(void)setValue:(NSString*)value;

-(NSString*)getValue;

@end