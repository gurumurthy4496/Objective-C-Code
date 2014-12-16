//
//  CustomerSignatureView.h
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerSignatureUIImageView.h"
@class CustomerSignatureUIImageView;

@interface CustomerSignatureView : UIView

@property (nonatomic, retain) CustomerSignatureUIImageView *mCustomerSignatureUIImageView_;
@property (nonatomic, retain) UIButton *mClearButton_;
@property (nonatomic, retain) UIButton *mSaveButton_;
- (void)setBorderForCustomerSignatureView;
- (void)codeToHideClearButton;
@end
