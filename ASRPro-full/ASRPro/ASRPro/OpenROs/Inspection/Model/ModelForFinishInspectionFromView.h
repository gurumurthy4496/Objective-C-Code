//
//  ModelForFinishInspectionFromView.h
//  ASRPro
//
//  Created by Kalyani on 27/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForFinishInspectionFromView : NSObject{
    int mTag;
@public
    int yItemsPos,yTiresPos;
}

- (id)init;
-(UIView*)addInspectionButtonView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict;
-(UIView*)addInspectionCheckButtonView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict;
-(UIView*)addInspectionRadioButtonView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict;
-(UIView*)addInspectionTextFieldView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict;
-(UIView*)addInspectionTextView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict;
-(UIView*)addInspectionPickerView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict;
-(UIView*)addInspectionSliderView:(NSMutableDictionary*)anItemDict valueDict:(NSMutableDictionary*)aValueDict;
-(UIView*)addCategoryView:(NSString*)aCategoryName isTires:(BOOL)isTires;

@end
