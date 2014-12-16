//
//  InspectionFormPickerView.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InspectionConstantsFile.h"

@interface InspectionFormPickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>
{
@public
    BOOL isMandatory;
    BOOL isAdded;
    
}
@property(nonatomic,retain)NSMutableDictionary* mItemDict_;
@property(nonatomic,retain)NSMutableDictionary* mValueDict_;
@property(nonatomic,retain)NSString* mRONumber_;
@property(nonatomic)gettformtype mFormtype;

// class instance variables
@property (nonatomic,retain)UIPickerView *mpickerview;

//array declarations
@property (nonatomic, retain) NSMutableArray *mPickerMonths;
@property (nonatomic, retain) NSMutableArray *mPickerYears;


/**
 * method sets value for picker
 * @param name value of current checkbox
 **/
-(void)setValue:(NSString*)value;
-(void)initializeLaneInspectionView;

@end