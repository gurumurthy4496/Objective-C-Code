//
//  LogoutViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 31/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *mLogoutButton_;
- (IBAction)logoutButtonAction:(id)sender;
-(void)removeLogoutView;
@end
