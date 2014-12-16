//
//  InspectionFormRadioButtonView.h
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InspectionFormRadioButtonView : UIView{
@public
    BOOL isMandatory;
    BOOL isAdded;
}
@property(nonatomic,retain)NSMutableDictionary* mItemDict_;
@property(nonatomic,retain)NSMutableDictionary* mValueDict_;
@property(nonatomic,retain)NSString* mRONumber_;
@property(nonatomic)gettformtype mFormtype;

-(void)initializeLaneInspectionView;
-(void)addViewToFinishInspection;
@end
