//
//  AdvancedSearchTextField.h
//  ASRPro
//
//  Created by Santosh Kvss on 4/4/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvancedSearchTextField : UITextField <UITextFieldDelegate>

- (void)showCheckInLabels:(UITextField*)textField;
- (void)removeCheckInLabels:(UITextField*)textField;
@end
