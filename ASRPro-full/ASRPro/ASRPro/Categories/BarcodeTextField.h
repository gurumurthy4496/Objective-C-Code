//
//  BarcodeTextField.h
//  ASRPro
//
//  Created by Guru Murthy Pulipati on 15/12/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarcodeTextField : UITextField<UITextFieldDelegate>
- (void)initializeTextField;
- (void)showOrHideTextField:(BOOL)aBool;
@end
