//
//  ModelForLaneInspectionFormView.m
//  ASRPro
//
//  Created by Kalyani on 13/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForLaneInspectionFormView.h"

@implementation ModelForLaneInspectionFormView

- (id)init
{
    if (self = [super init])
    {
        yTiresPos=0;
        yItemsPos=0;
        mTag=0;
        
    }
    return self;
}


-(UIView*)addInspectionButtonView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormButtonView* lInspectionFormButtonView=[[InspectionFormButtonView alloc] initWithFrame:CGRectMake(0, yItemsPos, 280, 10)];
    [lInspectionFormButtonView setMItemDict_:anItemDict];
    [lInspectionFormButtonView setMValueDict_:aValueDict];
    [lInspectionFormButtonView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_];
    [lInspectionFormButtonView setMFormtype:LANEINSPECTION];
    [lInspectionFormButtonView initializeLaneInspectionView];
    yItemsPos+= lInspectionFormButtonView.frame.size.height+10;
    return lInspectionFormButtonView;
}

-(UIView*)addInspectionCheckButtonView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormCheckButtonView* lInspectionFormChechButtonView=[[InspectionFormCheckButtonView alloc] initWithFrame:CGRectMake(0, yTiresPos, 700, 10)];
    [lInspectionFormChechButtonView setMItemDict_:anItemDict];
    [lInspectionFormChechButtonView setMValueDict_:aValueDict];
    [lInspectionFormChechButtonView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_];
    [lInspectionFormChechButtonView setMFormtype:LANEINSPECTION];
    [lInspectionFormChechButtonView initializeLaneInspectionView];
    yTiresPos+= lInspectionFormChechButtonView.frame.size.height+10;
    return lInspectionFormChechButtonView;
}

-(UIView*)addInspectionRadioButtonView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormRadioButtonView* lInspectionFormRadioButtonView=[[InspectionFormRadioButtonView alloc] initWithFrame:CGRectMake(0, yTiresPos, 700, 10)] ;
    [lInspectionFormRadioButtonView setMItemDict_:anItemDict];
    [lInspectionFormRadioButtonView setMValueDict_:aValueDict];
    [lInspectionFormRadioButtonView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_];
    [lInspectionFormRadioButtonView setMFormtype:LANEINSPECTION];
    [lInspectionFormRadioButtonView initializeLaneInspectionView];
    yTiresPos+= lInspectionFormRadioButtonView.frame.size.height+10;
    return lInspectionFormRadioButtonView;
}

-(UIView*)addInspectionSliderView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormSliderView* lInspectionFormSliderView=[[InspectionFormSliderView alloc] initWithFrame:CGRectMake(0, yTiresPos, 700, 10)] ;
    [lInspectionFormSliderView setMItemDict_:anItemDict];
    [lInspectionFormSliderView setMValueDict_:aValueDict];
    [lInspectionFormSliderView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_];
    [lInspectionFormSliderView setMFormtype:LANEINSPECTION];
    [lInspectionFormSliderView initializeLaneInspectionView];
    yTiresPos+= lInspectionFormSliderView.frame.size.height+10;
    return lInspectionFormSliderView;
}

-(UIView*)addInspectionPickerView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormPickerView* lInspectionFormPickerView=[[InspectionFormPickerView alloc] initWithFrame:CGRectMake(0, yTiresPos, 700, 10)] ;
    [lInspectionFormPickerView setMItemDict_:anItemDict];
    [lInspectionFormPickerView setMValueDict_:aValueDict];
    [lInspectionFormPickerView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_];
    [lInspectionFormPickerView setMFormtype:LANEINSPECTION];
    [lInspectionFormPickerView initializeLaneInspectionView];
    yTiresPos+= lInspectionFormPickerView.frame.size.height+10;
    return lInspectionFormPickerView;
}

-(UIView*)addInspectionTextView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormTextView* lInspectionItemsTextBoxView=[[InspectionFormTextView alloc] initWithFrame:CGRectMake(0, yTiresPos, 700, 10)] ;
    [lInspectionItemsTextBoxView setMItemDict_:anItemDict];
    [lInspectionItemsTextBoxView setMValueDict_:aValueDict];
    [lInspectionItemsTextBoxView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_];
    [lInspectionItemsTextBoxView setMFormtype:LANEINSPECTION];
    [lInspectionItemsTextBoxView initializeLaneInspectionView];
    yTiresPos+= lInspectionItemsTextBoxView.frame.size.height+10;
    return lInspectionItemsTextBoxView;
}


-(UIView*)addInspectionTextFieldView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormTextField* lInspectionItemsTextFieldView=[[InspectionFormTextField alloc] initWithFrame:CGRectMake(0, yTiresPos, 700, 10)] ;
    [lInspectionItemsTextFieldView setMItemDict_:anItemDict];
    [lInspectionItemsTextFieldView setMValueDict_:aValueDict];
    [lInspectionItemsTextFieldView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mRONumber_];
    [lInspectionItemsTextFieldView setMFormtype:LANEINSPECTION];
    [lInspectionItemsTextFieldView initializeLaneInspectionView];
    yTiresPos+= lInspectionItemsTextFieldView.frame.size.height+10;
    return lInspectionItemsTextFieldView;
}

-(UIView*)addCategoryView:(NSString*)aCategoryName isTires:(BOOL)isTires{
 int height=  [[GenericFiles genericFiles] dynamiclabelHeightForText:[NSString stringWithFormat:@"%@",aCategoryName] :320:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
    UIView* lCategoryView=[[UIView alloc] initWithFrame:CGRectMake(0, isTires?yTiresPos:yItemsPos, isTires?700:280, 40)];
    [lCategoryView setBackgroundColor:[UIColor ASRProRGBColor:19.0 Green:124.0 Blue:252.0]];
    UILabel* lCategoryLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, isTires?700:280, height)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lCategoryLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:aCategoryName labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [lCategoryView addSubview:lCategoryLabel];
    if(isTires)
    yTiresPos+= lCategoryView.frame.size.height+10;
    else
        yItemsPos+= lCategoryView.frame.size.height+10;

    [lCategoryView setTag:1000+mTag];
    mTag++;
    
    return lCategoryView;
    
}

@end
