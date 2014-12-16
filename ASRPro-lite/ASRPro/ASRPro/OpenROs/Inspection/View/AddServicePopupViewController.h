//
//  AddServicePopupViewController.h
//  ASRPro
//
//  Created by Santosh Kvss on 11/9/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddServicePopupViewController : UIViewController
@property(nonatomic,retain)NSString* mRONumber_;
@property(nonatomic) gettformtype mFormtype;

- (IBAction)AddServicePopupButtonAction:(id)sender;

@end
