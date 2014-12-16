//
//  ModelForFinishInspectionFromView.m
//  ASRPro
//
//  Created by Kalyani on 27/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForFinishInspectionFromView.h"

@implementation ModelForFinishInspectionFromView

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
    InspectionFormButtonView* lInspectionFormButtonView=[[InspectionFormButtonView alloc] initWithFrame:CGRectMake(0, yItemsPos, 329, 10)];
    [lInspectionFormButtonView setMItemDict_:anItemDict];
    [lInspectionFormButtonView setMValueDict_:aValueDict];
    [lInspectionFormButtonView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    [lInspectionFormButtonView setMFormtype:MAININSPECTION];
    [lInspectionFormButtonView addViewToFinishInspection];
    yItemsPos+= lInspectionFormButtonView.frame.size.height+10;
    if (([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])||(([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"])&&[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] !=3)) {
        [lInspectionFormButtonView setUserInteractionEnabled:NO];
    }
    return lInspectionFormButtonView;
}

-(UIView*)addInspectionCheckButtonView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormCheckButtonView* lInspectionFormCheckButtonView=[[InspectionFormCheckButtonView alloc] initWithFrame:CGRectMake(0, yTiresPos, 684, 10)];
    [lInspectionFormCheckButtonView setMItemDict_:anItemDict];
    [lInspectionFormCheckButtonView setMValueDict_:aValueDict];
    [lInspectionFormCheckButtonView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    [lInspectionFormCheckButtonView setMFormtype:MAININSPECTION];
    [lInspectionFormCheckButtonView addViewToFinishInspection];
    yTiresPos+= lInspectionFormCheckButtonView.frame.size.height+10;
    if (([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])||(([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"])&&[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] !=3)) {
        [lInspectionFormCheckButtonView setUserInteractionEnabled:NO];
    }

    return lInspectionFormCheckButtonView;
}

-(UIView*)addInspectionRadioButtonView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormRadioButtonView* lInspectionFormRadioButtonView=[[InspectionFormRadioButtonView alloc] initWithFrame:CGRectMake(0, yTiresPos, 684, 10)] ;
    [lInspectionFormRadioButtonView setMItemDict_:anItemDict];
    [lInspectionFormRadioButtonView setMValueDict_:aValueDict];
    [lInspectionFormRadioButtonView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    [lInspectionFormRadioButtonView setMFormtype:MAININSPECTION];
    [lInspectionFormRadioButtonView addViewToFinishInspection];
    yTiresPos+= lInspectionFormRadioButtonView.frame.size.height+10;
    if (([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])||(([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"])&&[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] !=3)) {
        [lInspectionFormRadioButtonView setUserInteractionEnabled:NO];
    }

    return lInspectionFormRadioButtonView;
}

-(UIView*)addInspectionSliderView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormSliderView* lInspectionFormSliderView=[[InspectionFormSliderView alloc] initWithFrame:CGRectMake(0, yTiresPos, 700, 10)] ;
    [lInspectionFormSliderView setMItemDict_:anItemDict];
    [lInspectionFormSliderView setMValueDict_:aValueDict];
    [lInspectionFormSliderView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    [lInspectionFormSliderView setMFormtype:MAININSPECTION];
   [lInspectionFormSliderView addViewToFinishInspection];
    yTiresPos+= lInspectionFormSliderView.frame.size.height+10;
    if (([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])||(([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"])&&[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] !=3)) {
        [lInspectionFormSliderView setUserInteractionEnabled:NO];
    }

    return lInspectionFormSliderView;
}

-(UIView*)addInspectionPickerView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormPickerView* lInspectionFormPickerView=[[InspectionFormPickerView alloc] initWithFrame:CGRectMake(0, yTiresPos, 684, 10)] ;
    [lInspectionFormPickerView setMItemDict_:anItemDict];
    [lInspectionFormPickerView setMValueDict_:aValueDict];
    [lInspectionFormPickerView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    [lInspectionFormPickerView setMFormtype:MAININSPECTION];
    [lInspectionFormPickerView initializeLaneInspectionView];
    yTiresPos+= lInspectionFormPickerView.frame.size.height+10;
    if (([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])||(([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"])&&[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] !=3)) {
        [lInspectionFormPickerView setUserInteractionEnabled:NO];
    }

    return lInspectionFormPickerView;
}

-(UIView*)addInspectionTextView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormTextView* lInspectionItemsTextBoxView=[[InspectionFormTextView alloc] initWithFrame:CGRectMake(0, yTiresPos, 684, 10)] ;
    [lInspectionItemsTextBoxView setMItemDict_:anItemDict];
    [lInspectionItemsTextBoxView setMValueDict_:aValueDict];
    [lInspectionItemsTextBoxView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    [lInspectionItemsTextBoxView setMFormtype:MAININSPECTION];
    [lInspectionItemsTextBoxView addViewToFinishInspection];
    yTiresPos+= lInspectionItemsTextBoxView.frame.size.height+10;
    if (([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])||(([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"])&&[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] !=3)) {
        [lInspectionItemsTextBoxView setUserInteractionEnabled:NO];
    }

    return lInspectionItemsTextBoxView;
}


-(UIView*)addInspectionTextFieldView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict{
    InspectionFormTextField* lInspectionItemsTextFieldView=[[InspectionFormTextField alloc] initWithFrame:CGRectMake(0, yTiresPos, 684, 10)] ;
    [lInspectionItemsTextFieldView setMItemDict_:anItemDict];
    [lInspectionItemsTextFieldView setMValueDict_:aValueDict];
    [lInspectionItemsTextFieldView setMRONumber_:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_.mOpenROString_];
    [lInspectionItemsTextFieldView setMFormtype:MAININSPECTION];
    [lInspectionItemsTextFieldView addViewToFinishInspection];
    yTiresPos+= lInspectionItemsTextFieldView.frame.size.height+10;
    if (([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])||(([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"])&&[[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] !=3)) {
        [lInspectionItemsTextFieldView setUserInteractionEnabled:NO];
    }

    return lInspectionItemsTextFieldView;
}

-(UIView*)addCategoryView:(NSString*)aCategoryName isTires:(BOOL)isTires{
    int height=  [[GenericFiles genericFiles] dynamiclabelHeightForText:[NSString stringWithFormat:@"%@",aCategoryName] :isTires?684:320:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
    UIView* lCategoryView=[[UIView alloc] initWithFrame:CGRectMake(0, isTires?yTiresPos:yItemsPos, isTires?684:320, 40)];
    [lCategoryView setBackgroundColor:[UIColor ASRProRGBColor:19.0 Green:124.0 Blue:252.0]];
    UILabel* lCategoryLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, isTires?684:320, height)];
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

