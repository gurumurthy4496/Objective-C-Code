//
//  SearchCustomerInfoView.h
//  ASRPro
//
//  Created by Santosh Kvss on 2/13/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCustomerInfoView : UIViewController

@property (retain,nonatomic) UIButton *mEditButton_;
@property (retain,nonatomic) UIView *mCustomerInfoView_;

- (void)setCustomerInfomationLabelsTextFromModel;
@end
