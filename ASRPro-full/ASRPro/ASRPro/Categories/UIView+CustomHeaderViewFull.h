//
//  UIView+CustomHeaderViewFull.h
//  ASRPro
//
//  Created by GuruMurthy on 29/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeUsernameAndAcronymTextColor.h"
@interface UIView (CustomHeaderViewFull)<ChangeUsernameAndAcronymTextColor,OnsuccessProtocol>
- (void)customHeaderViewFull :(id)aViewController SelectedButton:(NSString *)aSelectedButton;
- (void)customHeaderViewLight;
- (void)getRODetails;
-(void)pushToOpenROs:(NSString*)aRONumber;
@end
