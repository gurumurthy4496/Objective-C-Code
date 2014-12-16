//
//  PartsLaborSubview.h
//  ASRPro
//
//  Created by Kalyani on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServicesTextField.h"

@interface PartsLaborSubview : UIView<UITextFieldDelegate>{
    @public
    BOOL isParts;
}

@property (nonatomic,retain) UILabel *mHeaderLabel;
@property (nonatomic,retain) UILabel *mDescriptionLabel;
@property (nonatomic,retain) UITextField *mTextFld;
@property (nonatomic,retain) UIButton *mPlusBtn;
@property (nonatomic,retain) UIButton *mMinBtn;
@property (nonatomic,retain) UIButton *mSelectBtn;
@property (nonatomic,retain) NSMutableDictionary *mItemDict_;
@property (nonatomic,retain) NSString *mLineID_;
-(void)initThePartView;
-(void)initTheLaborView;
-(NSMutableDictionary*)getPartsDictionary;
-(NSMutableDictionary*)getLaborDictionary;

@end
