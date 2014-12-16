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
    /**
     * Bool stores type parts/ labor
     */
    BOOL isParts;
}

/**
 * label instance for partnumber/ hours
 */
@property (nonatomic,retain) UILabel *mHeaderLabel;

/**
 * label instance for description
 */
@property (nonatomic,retain) UILabel *mDescriptionLabel;

/**
 *  textfield instance for quantity
 */
@property (nonatomic,retain) UITextField *mTextFld;

/**
 *  button instance for plus
 */
@property (nonatomic,retain) UIButton *mPlusBtn;

/**
 * button instance for minus
 */
@property (nonatomic,retain) UIButton *mMinBtn;

/**
 * Method to store part/labor details
 */
@property (nonatomic,retain) NSMutableDictionary *mItemDict_;

/**
 * Method to store lineID
 */
@property (nonatomic,retain) NSString *mLineID_;

/**
 * Method to create part view
 */
-(void)initThePartView;

/**
 * Method to create labor view
 */
-(void)initTheLaborView;

/**
 * Method returns request dictionary for parts
 */
-(NSMutableDictionary*)getPartsDictionary;

/**
 * Method returns request dictionary for parts
 */
-(NSMutableDictionary*)getLaborDictionary;

@end
